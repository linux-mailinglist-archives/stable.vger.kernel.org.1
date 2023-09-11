Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E279B546
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbjIKVM1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbjIKPDW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:03:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC07F125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:03:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2D7C433C8;
        Mon, 11 Sep 2023 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444597;
        bh=BefLa8fgleMB0/aUIB7Pm3kl1kHxI8ieG7oxkhIojZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwxwUvdi/EtJpUNs7rELcX/oNUU1weeBc4iIE4d2YLy5FSvRpjr5bHH8tyrqz94a7
         FzAQm4O/WTrumu3BzASI9LXcsgSY8JQAfcfhHSeOLiGtZorDrjTCm2F8m7vqbEOBjn
         GVHVjY9FQ+w2HtO3WDI54t0EP7g/DDi9Zvu9m6u0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 047/600] kprobes: Prohibit probing on CFI preamble symbol
Date:   Mon, 11 Sep 2023 15:41:20 +0200
Message-ID: <20230911134634.985642721@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit de02f2ac5d8cfb311f44f2bf144cc20002f1fbbd ]

Do not allow to probe on "__cfi_" or "__pfx_" started symbol, because those
are used for CFI and not executed. Probing it will break the CFI.

Link: https://lore.kernel.org/all/168904024679.116016.18089228029322008512.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 00e177de91ccd..3da9726232ff9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1545,6 +1545,17 @@ static int check_ftrace_location(struct kprobe *p)
 	return 0;
 }
 
+static bool is_cfi_preamble_symbol(unsigned long addr)
+{
+	char symbuf[KSYM_NAME_LEN];
+
+	if (lookup_symbol_name(addr, symbuf))
+		return false;
+
+	return str_has_prefix("__cfi_", symbuf) ||
+		str_has_prefix("__pfx_", symbuf);
+}
+
 static int check_kprobe_address_safe(struct kprobe *p,
 				     struct module **probed_mod)
 {
@@ -1563,7 +1574,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
-	    find_bug((unsigned long)p->addr)) {
+	    find_bug((unsigned long)p->addr) ||
+	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.40.1



