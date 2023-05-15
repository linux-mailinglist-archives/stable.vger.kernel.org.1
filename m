Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F75703422
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbjEOQpL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242933AbjEOQpK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86D4C2E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FE53628E6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7361AC433A1;
        Mon, 15 May 2023 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169107;
        bh=rkLi82hoc9vS2XBuYep+bI3rnWOekOzyTbJKroaBa2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JS+MlIcFsHMue4oAUZCUJkzcpDV7bjLIGBvczHlr8jIsj8tWtK34xgBbBkno5oYkM
         MrEa/4b1LAKkhxN+F8whN8nGb70pfoTZZcAyY+yg1KEGDytgGbP+ux2UsaNEG8NBKE
         /Z1KZZn04srMjbEBKAzeoPpZqDIuqYPAtu6pmt8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        Corey Minyard <minyard@acm.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 144/191] ipmi: fix SSIF not responding under certain cond.
Date:   Mon, 15 May 2023 18:26:21 +0200
Message-Id: <20230515161712.644538387@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>

[ Upstream commit 6d2555cde2918409b0331560e66f84a0ad4849c6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_ssif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 566be60fa1377..34c5b287c4125 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -801,9 +801,9 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
 			   || data[1] != IPMI_GET_MSG_FLAGS_CMD) {
 			/*
-			 * Don't abort here, maybe it was a queued
-			 * response to a previous command.
+			 * Recv error response, give up.
 			 */
+			ssif_info->ssif_state = SSIF_IDLE;
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			pr_warn(PFX "Invalid response getting flags: %x %x\n",
 				data[0], data[1]);
-- 
2.39.2



