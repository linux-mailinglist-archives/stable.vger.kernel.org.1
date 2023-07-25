Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC87612ED
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjGYLGj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjGYLGW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA2A44BD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38E416168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4441EC433C7;
        Tue, 25 Jul 2023 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283077;
        bh=sNXPb5slujqSqPOR4yKkjmPejgyWY7Hcin+bsBsYoMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijUzBMs7828hT68tADaCS5/3niMXE8nNqZj7psVE2iQDKBvpMK6cdmCutSACTeKmS
         adsOYqBAi3HccFXypugDykCvh0Pry5Hr8IRlDUMf/VU7hBBJwCxRbaCR5ogEn5qCHH
         1M/bX0j6/nwnkQnR/VJ1Q0vXC414IEXx737yQzGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 101/183] kallsyms: Improve the performance of kallsyms_lookup_name()
Date:   Tue, 25 Jul 2023 12:45:29 +0200
Message-ID: <20230725104511.586697269@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 60443c88f3a89fd303a9e8c0e84895910675c316 ]

Currently, to search for a symbol, we need to expand the symbols in
'kallsyms_names' one by one, and then use the expanded string for
comparison. It's O(n).

If we sort names in ascending order like addresses, we can also use
binary search. It's O(log(n)).

In order not to change the implementation of "/proc/kallsyms", the table
kallsyms_names[] is still stored in a one-to-one correspondence with the
address in ascending order.

Add array kallsyms_seqs_of_names[], it's indexed by the sequence number
of the sorted names, and the corresponding content is the sequence number
of the sorted addresses. For example:
Assume that the index of NameX in array kallsyms_seqs_of_names[] is 'i',
the content of kallsyms_seqs_of_names[i] is 'k', then the corresponding
address of NameX is kallsyms_addresses[k]. The offset in kallsyms_names[]
is get_symbol_offset(k).

Note that the memory usage will increase by (4 * kallsyms_num_syms)
bytes, the next two patches will reduce (1 * kallsyms_num_syms) bytes
and properly handle the case CONFIG_LTO_CLANG=y.

Performance test results: (x86)
Before:
min=234, max=10364402, avg=5206926
min=267, max=11168517, avg=5207587
After:
min=1016, max=90894, avg=7272
min=1014, max=93470, avg=7293

The average lookup performance of kallsyms_lookup_name() improved 715x.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Stable-dep-of: 8cc32a9bbf29 ("kallsyms: strip LTO-only suffixes from promoted global functions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kallsyms.c          | 86 +++++++++++++++++++++++++++++++++-----
 kernel/kallsyms_internal.h |  1 +
 scripts/kallsyms.c         | 37 ++++++++++++++++
 3 files changed, 113 insertions(+), 11 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 60c20f301a6ba..ba351dfa109b6 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -187,26 +187,90 @@ static bool cleanup_symbol_name(char *s)
 	return false;
 }
 
+static int compare_symbol_name(const char *name, char *namebuf)
+{
+	int ret;
+
+	ret = strcmp(name, namebuf);
+	if (!ret)
+		return ret;
+
+	if (cleanup_symbol_name(namebuf) && !strcmp(name, namebuf))
+		return 0;
+
+	return ret;
+}
+
+static int kallsyms_lookup_names(const char *name,
+				 unsigned int *start,
+				 unsigned int *end)
+{
+	int ret;
+	int low, mid, high;
+	unsigned int seq, off;
+	char namebuf[KSYM_NAME_LEN];
+
+	low = 0;
+	high = kallsyms_num_syms - 1;
+
+	while (low <= high) {
+		mid = low + (high - low) / 2;
+		seq = kallsyms_seqs_of_names[mid];
+		off = get_symbol_offset(seq);
+		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
+		ret = compare_symbol_name(name, namebuf);
+		if (ret > 0)
+			low = mid + 1;
+		else if (ret < 0)
+			high = mid - 1;
+		else
+			break;
+	}
+
+	if (low > high)
+		return -ESRCH;
+
+	low = mid;
+	while (low) {
+		seq = kallsyms_seqs_of_names[low - 1];
+		off = get_symbol_offset(seq);
+		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
+		if (compare_symbol_name(name, namebuf))
+			break;
+		low--;
+	}
+	*start = low;
+
+	if (end) {
+		high = mid;
+		while (high < kallsyms_num_syms - 1) {
+			seq = kallsyms_seqs_of_names[high + 1];
+			off = get_symbol_offset(seq);
+			kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
+			if (compare_symbol_name(name, namebuf))
+				break;
+			high++;
+		}
+		*end = high;
+	}
+
+	return 0;
+}
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
-	char namebuf[KSYM_NAME_LEN];
-	unsigned long i;
-	unsigned int off;
+	int ret;
+	unsigned int i;
 
 	/* Skip the search for empty string. */
 	if (!*name)
 		return 0;
 
-	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
-		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-
-		if (strcmp(namebuf, name) == 0)
-			return kallsyms_sym_address(i);
+	ret = kallsyms_lookup_names(name, &i, NULL);
+	if (!ret)
+		return kallsyms_sym_address(kallsyms_seqs_of_names[i]);
 
-		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
-			return kallsyms_sym_address(i);
-	}
 	return module_kallsyms_lookup_name(name);
 }
 
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 2d0c6f2f0243a..a04b7a5cb1e3e 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -26,5 +26,6 @@ extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
+extern const unsigned int kallsyms_seqs_of_names[] __weak;
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03fa07ad45d95..dcb744a067e5e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -49,6 +49,7 @@ _Static_assert(
 struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
+	unsigned int seq;
 	unsigned int start_pos;
 	unsigned int percpu_absolute;
 	unsigned char sym[];
@@ -410,6 +411,35 @@ static int symbol_absolute(const struct sym_entry *s)
 	return s->percpu_absolute;
 }
 
+static int compare_names(const void *a, const void *b)
+{
+	int ret;
+	char sa_namebuf[KSYM_NAME_LEN];
+	char sb_namebuf[KSYM_NAME_LEN];
+	const struct sym_entry *sa = *(const struct sym_entry **)a;
+	const struct sym_entry *sb = *(const struct sym_entry **)b;
+
+	expand_symbol(sa->sym, sa->len, sa_namebuf);
+	expand_symbol(sb->sym, sb->len, sb_namebuf);
+	ret = strcmp(&sa_namebuf[1], &sb_namebuf[1]);
+	if (!ret) {
+		if (sa->addr > sb->addr)
+			return 1;
+		else if (sa->addr < sb->addr)
+			return -1;
+
+		/* keep old order */
+		return (int)(sa->seq - sb->seq);
+	}
+
+	return ret;
+}
+
+static void sort_symbols_by_name(void)
+{
+	qsort(table, table_cnt, sizeof(table[0]), compare_names);
+}
+
 static void write_src(void)
 {
 	unsigned int i, k, off;
@@ -495,6 +525,7 @@ static void write_src(void)
 	for (i = 0; i < table_cnt; i++) {
 		if ((i & 0xFF) == 0)
 			markers[i >> 8] = off;
+		table[i]->seq = i;
 
 		/* There cannot be any symbol of length zero. */
 		if (table[i]->len == 0) {
@@ -535,6 +566,12 @@ static void write_src(void)
 
 	free(markers);
 
+	sort_symbols_by_name();
+	output_label("kallsyms_seqs_of_names");
+	for (i = 0; i < table_cnt; i++)
+		printf("\t.long\t%u\n", table[i]->seq);
+	printf("\n");
+
 	output_label("kallsyms_token_table");
 	off = 0;
 	for (i = 0; i < 256; i++) {
-- 
2.39.2



