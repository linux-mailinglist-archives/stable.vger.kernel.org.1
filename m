Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DECE7D3335
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjJWL1y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjJWL1x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155CDC
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:27:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA2BC433C8;
        Mon, 23 Oct 2023 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060469;
        bh=ANLp9EHGumIP9oIrUFxJjW7FxaJ7tKmmnrwnzPdJhOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hoL0iwMq+akAeV4lvjIS1TSkM+kigqjl7P7EbLK/VVa2Mgv71NxaqNRY6cpf7QTT
         dGoxVVd4efHeWyEAsNq2fw6dWZ0+GxI1wnu9oGu8ZTUXFjhx/GStLUJmKLN38me/wX
         mZtOipFDEpTNpzmk8LQivqx4A3DvDZh5TNMAbX6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 183/196] kallsyms: Reduce the memory occupied by kallsyms_seqs_of_names[]
Date:   Mon, 23 Oct 2023 12:57:28 +0200
Message-ID: <20231023104833.563121736@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 19bd8981dc2ee35fdc81ab1b0104b607c917d470 ]

kallsyms_seqs_of_names[] records the symbol index sorted by address, the
maximum value in kallsyms_seqs_of_names[] is the number of symbols. And
2^24 = 16777216, which means that three bytes are enough to store the
index. This can help us save (1 * kallsyms_num_syms) bytes of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Stable-dep-of: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kallsyms.c          | 18 ++++++++++++++----
 kernel/kallsyms_internal.h |  2 +-
 scripts/kallsyms.c         |  5 ++++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index ad3cccb0970f8..32cba13eee6c4 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -197,6 +197,16 @@ static int compare_symbol_name(const char *name, char *namebuf)
 	return strcmp(name, namebuf);
 }
 
+static unsigned int get_symbol_seq(int index)
+{
+	unsigned int i, seq = 0;
+
+	for (i = 0; i < 3; i++)
+		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
+
+	return seq;
+}
+
 static int kallsyms_lookup_names(const char *name,
 				 unsigned int *start,
 				 unsigned int *end)
@@ -211,7 +221,7 @@ static int kallsyms_lookup_names(const char *name,
 
 	while (low <= high) {
 		mid = low + (high - low) / 2;
-		seq = kallsyms_seqs_of_names[mid];
+		seq = get_symbol_seq(mid);
 		off = get_symbol_offset(seq);
 		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
 		ret = compare_symbol_name(name, namebuf);
@@ -228,7 +238,7 @@ static int kallsyms_lookup_names(const char *name,
 
 	low = mid;
 	while (low) {
-		seq = kallsyms_seqs_of_names[low - 1];
+		seq = get_symbol_seq(low - 1);
 		off = get_symbol_offset(seq);
 		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
 		if (compare_symbol_name(name, namebuf))
@@ -240,7 +250,7 @@ static int kallsyms_lookup_names(const char *name,
 	if (end) {
 		high = mid;
 		while (high < kallsyms_num_syms - 1) {
-			seq = kallsyms_seqs_of_names[high + 1];
+			seq = get_symbol_seq(high + 1);
 			off = get_symbol_offset(seq);
 			kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
 			if (compare_symbol_name(name, namebuf))
@@ -265,7 +275,7 @@ unsigned long kallsyms_lookup_name(const char *name)
 
 	ret = kallsyms_lookup_names(name, &i, NULL);
 	if (!ret)
-		return kallsyms_sym_address(kallsyms_seqs_of_names[i]);
+		return kallsyms_sym_address(get_symbol_seq(i));
 
 	return module_kallsyms_lookup_name(name);
 }
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index a04b7a5cb1e3e..27fabdcc40f57 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -26,6 +26,6 @@ extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
-extern const unsigned int kallsyms_seqs_of_names[] __weak;
+extern const u8 kallsyms_seqs_of_names[] __weak;
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 80aab2aa72246..ff8cce1757849 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -602,7 +602,10 @@ static void write_src(void)
 	sort_symbols_by_name();
 	output_label("kallsyms_seqs_of_names");
 	for (i = 0; i < table_cnt; i++)
-		printf("\t.long\t%u\n", table[i]->seq);
+		printf("\t.byte 0x%02x, 0x%02x, 0x%02x\n",
+			(unsigned char)(table[i]->seq >> 16),
+			(unsigned char)(table[i]->seq >> 8),
+			(unsigned char)(table[i]->seq >> 0));
 	printf("\n");
 
 	output_label("kallsyms_token_table");
-- 
2.42.0



