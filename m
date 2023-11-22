Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161A7F50A1
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbjKVTeO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 14:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbjKVTeN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 14:34:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E719D
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 11:34:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5C4C433C8;
        Wed, 22 Nov 2023 19:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700681649;
        bh=BcNE7XEe0+77TacLgsCeKZSpJ9lWMcqx5smD1uiFN0w=;
        h=Subject:To:Cc:From:Date:From;
        b=NpW4q4dGGLRlclmeUguXS0skUTrdyW7zQsjEHW55eyP4ayKYMB9RhjevKgf3RjqIQ
         uIEoACeAIDPJZ5gcl2vx5SH0kbblzPAY5pPEaVnTNO16Gb5QnJWRkcFUWEVOuBStsA
         Ts8LgXBUqIQwOciEP9NzkJdcl3z3kKnVwdMpFG20=
Subject: FAILED: patch "[PATCH] cpufreq: stats: Fix buffer overflow detection in" failed to apply to 5.15-stable tree
To:     ansuelsmth@gmail.com, rafael.j.wysocki@intel.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 19:33:59 +0000
Message-ID: <2023112259-willpower-movable-0aa9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ea167a7fc2426f7685c3735e104921c1a20a6d3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112259-willpower-movable-0aa9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ea167a7fc242 ("cpufreq: stats: Fix buffer overflow detection in trans_stats()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea167a7fc2426f7685c3735e104921c1a20a6d3f Mon Sep 17 00:00:00 2001
From: Christian Marangi <ansuelsmth@gmail.com>
Date: Tue, 24 Oct 2023 20:30:14 +0200
Subject: [PATCH] cpufreq: stats: Fix buffer overflow detection in
 trans_stats()

Commit 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential
buffer overflow") switched from snprintf to the more secure scnprintf
but never updated the exit condition for PAGE_SIZE.

As the commit say and as scnprintf document, what scnprintf returns what
is actually written not counting the '\0' end char. This results in the
case of len exceeding the size, len set to PAGE_SIZE - 1, as it can be
written at max PAGE_SIZE - 1 (as '\0' is not counted)

Because of len is never set to PAGE_SIZE, the function never break early,
never prints the warning and never return -EFBIG.

Fix this by changing the condition to PAGE_SIZE - 1 to correctly trigger
the error.

Cc: 5.10+ <stable@vger.kernel.org> # 5.10+
Fixes: 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential buffer overflow")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index a33df3c66c88..40a9ff18da06 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -131,23 +131,23 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	len += sysfs_emit_at(buf, len, "   From  :    To\n");
 	len += sysfs_emit_at(buf, len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 		len += sysfs_emit_at(buf, len, "%9u ", stats->freq_table[i]);
 	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
 	len += sysfs_emit_at(buf, len, "\n");
 
 	for (i = 0; i < stats->state_num; i++) {
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 
 		len += sysfs_emit_at(buf, len, "%9u: ", stats->freq_table[i]);
 
 		for (j = 0; j < stats->state_num; j++) {
-			if (len >= PAGE_SIZE)
+			if (len >= PAGE_SIZE - 1)
 				break;
 
 			if (pending)
@@ -157,12 +157,12 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 
 			len += sysfs_emit_at(buf, len, "%9u ", count);
 		}
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 		len += sysfs_emit_at(buf, len, "\n");
 	}
 
-	if (len >= PAGE_SIZE) {
+	if (len >= PAGE_SIZE - 1) {
 		pr_warn_once("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
 		return -EFBIG;
 	}

