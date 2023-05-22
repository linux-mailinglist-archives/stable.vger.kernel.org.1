Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7256E70C4B8
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjEVR4D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEVR4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E691FF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E81E1621A6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2E0C433EF;
        Mon, 22 May 2023 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778160;
        bh=3kDdHVfuzIFKXhUR2+F4cMN+Hs0nqd/t8h4hYYph7nQ=;
        h=Subject:To:Cc:From:Date:From;
        b=vSVRGMqAwMi806cEipK/qPNCuECP5Wo6JJsJCjRdo7q/Oo5dkAn7nlED8qVFFlC7E
         JxNoXFvRdr2AyKsDsrcHiBLaXxiQFw/6TS9CN5UR+bk535zi7fhJ3wXyJg21D8Prje
         kW63f47X6AsUhYwPp9A2nWDoXYgtdKvNHPvpc31o=
Subject: FAILED: patch "[PATCH] drm/amdgpu/gfx10: Disable gfxoff before disabling" failed to apply to 5.15-stable tree
To:     bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
        gpiccoli@igalia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:55:57 +0100
Message-ID: <2023052257-kiwi-level-12a2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
git cherry-pick -x 8173cab3368a13cdc3cad0bd5cf14e9399b0f501
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052257-kiwi-level-12a2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8173cab3368a ("drm/amdgpu/gfx10: Disable gfxoff before disabling powergating.")
fabe1753851c ("drm/amdgpu: enable gfx power gating for GC 10.3.7")
874bfdfa4735 ("drm/amdgpu: add gc 10.3.6 support")
a65dbf7cded7 ("drm/amdgpu/gfx10: Add GC 10.3.7 Support")
35c27d957835 ("drm/amdgpu: update vcn/jpeg PG flags for VCN 3.1.1")
b67f00e06f36 ("drm/amdgpu: set new revision id for 10.3.7 GC")
dfcc3e8c24cc ("drm/amdgpu: make cyan skillfish support code more consistent")
212021297eaf ("drm/amdgpu: set APU flag based on IP discovery table")
e8a423c589a0 ("drm/amdgpu: update RLC_PG_DELAY_3 Value to 200us for yellow carp")
a61794bd2f65 ("drm/amdgpu: remove grbm cam index/data operations for gfx v10")
b05b9c591f9e ("drm/amdgpu: clean up set IP function")
1d789535a036 ("drm/amdgpu: convert IP version array to include instances")
5c3720be7d46 ("drm/amdgpu: get VCN and SDMA instances from IP discovery table")
2cbc6f4259f6 ("drm/amd/display: fix error case handling")
75a07bcd1d30 ("drm/amdgpu/soc15: convert to IP version checking")
0b64a5a85229 ("drm/amdgpu/vcn2.5: convert to IP version checking")
96b8dd4423e7 ("drm/amdgpu/amdgpu_vcn: convert to IP version checking")
50638f7dbd0b ("drm/amdgpu/pm/amdgpu_smu: convert more IP version checking")
61b396b91196 ("drm/amdgpu/pm/smu_v13.0: convert IP version checking")
6b726a0a52cc ("drm/amdgpu/pm/smu_v11.0: update IP version checking")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8173cab3368a13cdc3cad0bd5cf14e9399b0f501 Mon Sep 17 00:00:00 2001
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Tue, 9 May 2023 18:49:46 +0200
Subject: [PATCH] drm/amdgpu/gfx10: Disable gfxoff before disabling
 powergating.

Otherwise we get a full system lock (looks like a FW mess).

Copied the order from the GFX9 powergating code.

Fixes: 366468ff6c34 ("drm/amdgpu: Allow GfxOff on Vangogh as default")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2545
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f5b5ce1051a2..1ec076517c96 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8152,8 +8152,14 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
+		if (!enable)
+			amdgpu_gfx_off_ctrl(adev, false);
+
 		gfx_v10_cntl_pg(adev, enable);
-		amdgpu_gfx_off_ctrl(adev, enable);
+
+		if (enable)
+			amdgpu_gfx_off_ctrl(adev, true);
+
 		break;
 	default:
 		break;

