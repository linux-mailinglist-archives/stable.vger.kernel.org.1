Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E843E7014FD
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEMHip (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMHio (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882C59FD
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212266178D
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C06C433EF;
        Sat, 13 May 2023 07:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963522;
        bh=WAFy4ex6wcTliVUUGzMUFeemueni4ebRR8TOjAoiHRQ=;
        h=Subject:To:Cc:From:Date:From;
        b=Ev4Xc4GknpqxRL92wWuVTp0fA4oa+RiEvNFWvZAWtTdr73I8PhESS6ptWwPv8QJA+
         tfTIgPSU/gg5yP6FpiPVo430w8ttKoahe98ZxZVZXmrGxDJ62/Ff4ss70mIMQ9dvdy
         U7SlevLroF8z9YxuCDj6TgoSCEm/3AsPyo2f0XkY=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix wrong index used in" failed to apply to 6.1-stable tree
To:     hersenxs.wu@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com,
        qingqing.zhuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:20:02 +0900
Message-ID: <2023051302-evasion-backless-8601@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2fedafc7ef071979b07fe9e9ccb7af210b65da0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051302-evasion-backless-8601@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

2fedafc7ef07 ("drm/amd/display: fix wrong index used in dccg32_set_dpstreamclk")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fedafc7ef071979b07fe9e9ccb7af210b65da0e Mon Sep 17 00:00:00 2001
From: Hersen Wu <hersenxs.wu@amd.com>
Date: Thu, 9 Mar 2023 16:14:08 -0500
Subject: [PATCH] drm/amd/display: fix wrong index used in
 dccg32_set_dpstreamclk

[Why & How]
When merging commit 9af611f29034
("drm/amd/display: Fix DCN32 DPSTREAMCLK_CNTL programming"),
index change was not picked up.

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Fixes: 9af611f29034 ("drm/amd/display: Fix DCN32 DPSTREAMCLK_CNTL programming")
Reviewed-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 5dbef498580b..ffbb739d85b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -293,8 +293,7 @@ static void dccg32_set_dpstreamclk(
 	dccg32_set_dtbclk_p_src(dccg, src, otg_inst);
 
 	/* enabled to select one of the DTBCLKs for pipe */
-	switch (otg_inst)
-	{
+	switch (dp_hpo_inst) {
 	case 0:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL,
 			     DPSTREAMCLK0_EN,

