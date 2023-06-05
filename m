Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62750722433
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjFELJK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjFELJJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 07:09:09 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E4EB8
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YEyQtuDHS4+i+VQAQ91wnvUTYq/JJ08xWAvtW5HdbgA=; b=MBuzSkGOKW/lczsnSLzvxIcXeg
        KzQwWT6/5ji43HsVKzUmvLXR0Rph2SuN0ualTDdeFSO3RQIB7Jdpo2Wh90qk1XEqCyLpvWZFETUiF
        /Nv+eUb62FTJg3bJWHcCtt/Q+wzTXpWELDG5sloMoE0wUn4KQAJnSsQKKnORwNTTw2a0ecg7wAOqi
        263iHwWbEHEuBc22DXP9Y8tc0RMfEDO9NUpMdtn66mwEvXx/HRifj4IdMDChoLNMNeCrrtfPhr6bZ
        1CJ/1StBKyMU3lbRHmqlRntvNw2WhRZ+qCq3FZleZR2M8qiGrp90NmU1JBr2HU3xnmKOMPXP09oCK
        7C/KhrBA==;
Received: from ip177.dynamic.igalia.com ([192.168.10.177] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1q685B-008rDc-C5; Mon, 05 Jun 2023 13:09:05 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     stable@vger.kernel.org
Cc:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15.y] drm/amdgpu/gfx10: Disable gfxoff before disabling powergating.
Date:   Mon,  5 Jun 2023 13:08:47 +0200
Message-Id: <20230605110847.77517-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023052257-kiwi-level-12a2@gregkh>
References: <2023052257-kiwi-level-12a2@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

commit 8173cab3368a13cdc3cad0bd5cf14e9399b0f501 upstream.

Otherwise we get a full system lock (looks like a FW mess).

Copied the order from the GFX9 powergating code.

Fixes: 366468ff6c34 ("drm/amdgpu: Allow GfxOff on Vangogh as default")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2545
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
[gpiccoli: adjusted to 5.15, before amdgpu changes from chip names to numbers.]
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 970d59a21005..9da0d5d6d73d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8422,8 +8422,14 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 		break;
 	case CHIP_VANGOGH:
 	case CHIP_YELLOW_CARP:
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
-- 
2.40.1

