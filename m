Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89906F8F90
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 08:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjEFG7h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 02:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjEFG7g (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 02:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC62727
        for <stable@vger.kernel.org>; Fri,  5 May 2023 23:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648DC60B40
        for <stable@vger.kernel.org>; Sat,  6 May 2023 06:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5421C433D2;
        Sat,  6 May 2023 06:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683356374;
        bh=6p3co+vuhNHBXG0SckgHhPqMM+q/NtRHUJyCfxXJFKk=;
        h=Subject:To:Cc:From:Date:From;
        b=rXFkGuUM7cAKoZpUbFqY3W56SkgPfg0AXQyloiffm3/PHPN1avn+9VnUpYiP9qFCU
         GPGuk9xdN6UkMbmbft4pQ/TPviPR2EDPZRNGKSb7gJlkxB6gUl66dxB+BSsd0/UeGB
         z/M4yT3MwE8su87eTSz3VvEYxAZ6CEyKrtN5VoOk=
Subject: FAILED: patch "[PATCH] ipmi: fix SSIF not responding under certain cond." failed to apply to 4.14-stable tree
To:     zhangyuchen.lcr@bytedance.com, minyard@acm.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 15:25:40 +0900
Message-ID: <2023050640-art-jumbo-6ff0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 6d2555cde2918409b0331560e66f84a0ad4849c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050640-art-jumbo-6ff0@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

6d2555cde291 ("ipmi: fix SSIF not responding under certain cond.")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d2555cde2918409b0331560e66f84a0ad4849c6 Mon Sep 17 00:00:00 2001
From: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Date: Wed, 12 Apr 2023 15:49:07 +0800
Subject: [PATCH] ipmi: fix SSIF not responding under certain cond.

The ipmi communication is not restored after a specific version of BMC is
upgraded on our server.
The ipmi driver does not respond after printing the following log:

    ipmi_ssif: Invalid response getting flags: 1c 1

I found that after entering this branch, ssif_info->ssif_state always
holds SSIF_GETTING_FLAGS and never return to IDLE.

As a result, the driver cannot be loaded, because the driver status is
checked during the unload process and must be IDLE in shutdown_ssif():

        while (ssif_info->ssif_state != SSIF_IDLE)
                schedule_timeout(1);

The process trigger this problem is:

1. One msg timeout and next msg start send, and call
ssif_set_need_watch().

2. ssif_set_need_watch()->watch_timeout()->start_flag_fetch() change
ssif_state to SSIF_GETTING_FLAGS.

3. In msg_done_handler() ssif_state == SSIF_GETTING_FLAGS, if an error
message is received, the second branch does not modify the ssif_state.

4. All retry action need IS_SSIF_IDLE() == True. Include retry action in
watch_timeout(), msg_done_handler(). Sending msg does not work either.
SSIF_IDLE is also checked in start_next_msg().

5. The only thing that can be triggered in the SSIF driver is
watch_timeout(), after destory_user(), this timer will stop too.

So, if enter this branch, the ssif_state will remain SSIF_GETTING_FLAGS
and can't send msg, no timer started, can't unload.

We did a comparative test before and after adding this patch, and the
result is effective.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Message-Id: <20230412074907.80046-1-zhangyuchen.lcr@bytedance.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index e4f6ecc12ed7..0eca46eea35c 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -786,9 +786,9 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
 			   || data[1] != IPMI_GET_MSG_FLAGS_CMD) {
 			/*
-			 * Don't abort here, maybe it was a queued
-			 * response to a previous command.
+			 * Recv error response, give up.
 			 */
+			ssif_info->ssif_state = SSIF_IDLE;
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			dev_warn(&ssif_info->client->dev,
 				 "Invalid response getting flags: %x %x\n",

