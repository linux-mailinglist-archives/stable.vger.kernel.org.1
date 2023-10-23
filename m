Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5519A7D357A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjJWLss (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjJWLsr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:48:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1619AF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:48:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F6EC433C9;
        Mon, 23 Oct 2023 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061725;
        bh=K78yTwosjl+f86KbOQghVYkEyD68bZIqMJQI2dyzOUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scpoaqm0cHSQjJzVX/v+eVut4TPGWstNScZSf38JBJFoGee6MfWJ9DziIbkWNy6Ke
         qliA2D7tiVCBNvdmi3slR9RB9uIknRVT8SDJBSoFNbkDK90Btsp6ZSADPXCw08VPMO
         REX4Cvx7HiK0P5D2/dcgIqOC/4uRAM7HzH5T0FP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yongqiang Sun <yongqiang.sun@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 143/202] drm/amd/display: only check available pipe to disable vbios mode.
Date:   Mon, 23 Oct 2023 12:57:30 +0200
Message-ID: <20231023104830.718209216@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongqiang Sun <yongqiang.sun@amd.com>

[ Upstream commit 850d2fcf3e346a35e4e59e310b867e90e3ef8e5a ]

[Why & How]
1. only need to check first ODM pipe.
2. Only need to check eDP which is on.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 23645bca9830 ("drm/amd/display: Don't set dpms_off for seamless boot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 099542dd31544..9cf287124fe4c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -862,12 +862,16 @@ static void disable_vbios_mode_if_required(
 		if (stream == NULL)
 			continue;
 
+		// only looking for first odm pipe
+		if (pipe->prev_odm_pipe)
+			continue;
+
 		if (stream->link->local_sink &&
 			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 			link = stream->link;
 		}
 
-		if (link != NULL) {
+		if (link != NULL && link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			unsigned int enc_inst, tg_inst = 0;
 			unsigned int pix_clk_100hz;
 
-- 
2.40.1



