Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDFD701517
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEMHm3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjEMHm2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18FE196
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DD1361C17
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAB6C433EF;
        Sat, 13 May 2023 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963746;
        bh=Z1eVKNCA58wk3+vyebxw8yCNurdy/XVhnsXPq4JIlSI=;
        h=Subject:To:Cc:From:Date:From;
        b=o52USVug8Jieh6KSdKum+VTeCb2xRmFWmy2W25leV2GDjbbjiWXtYTiryXVpdo9Zy
         1osfj88ncobYZtZXxgNWFphJYMlNG9f/HyhtzsrhdAkG0K+mNUAFWGZCHMi5x/bx/f
         DZyJcgxe35es2OG5MVK0FyEdMH39O4DhWBZAplsI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Lowering min Z8 residency time" failed to apply to 6.3-stable tree
To:     sancchen@amd.com, Nicholas.Kazlauskas@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:21:45 +0900
Message-ID: <2023051345-wifi-these-ff01@gregkh>
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


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x d893f39320e1248d1c97fde0d6e51e5ea008a76b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051345-wifi-these-ff01@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

d893f39320e1 ("drm/amd/display: Lowering min Z8 residency time")
0215ce9057ed ("drm/amd/display: Update minimum stutter residency for DCN314 Z8")
0db13eae41fc ("drm/amd/display: Add minimum Z8 residency debug option")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d893f39320e1248d1c97fde0d6e51e5ea008a76b Mon Sep 17 00:00:00 2001
From: Leo Chen <sancchen@amd.com>
Date: Tue, 11 Apr 2023 10:49:38 -0400
Subject: [PATCH] drm/amd/display: Lowering min Z8 residency time

[Why & How]
Per HW team request, we're lowering the minimum Z8
residency time to 2000us. This enables Z8 support for additional
modes we were previously blocking like 2k>60hz

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 50ed7e09d5ba..2f7df8d34a91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -885,7 +885,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
-	.minimum_z8_residency_time = 3080,
+	.minimum_z8_residency_time = 2000,
 	.psr_skip_crtc_disable = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,

