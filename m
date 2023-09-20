Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0177A7AEE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjITLrd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjITLrb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:47:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F5CA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:47:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D89C433C7;
        Wed, 20 Sep 2023 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210445;
        bh=eMOcv7+FigV8v7J1M7u5sICV+lrZn8sYYpdYa8MG1Xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mK4i5WLniU/vEjs+lM6IHExZAoVeew1Vmde3RGVtVod/cF5pnn8ZafSpIcA3HCLXQ
         hWrr2Ej4526SNYJGdngOgWftZtvNH6lD3O7RG8HC6vB6LSOPxBH7PZGen9hDaWBYXf
         DH9lNXr4lNuPR0glnwmA6X1X32dAXneH0Z5hfi5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Leo Chen <sancchen@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 080/211] drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31
Date:   Wed, 20 Sep 2023 13:28:44 +0200
Message-ID: <20230920112848.286128019@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Chen <sancchen@amd.com>

[ Upstream commit 026a71babf48efb6b9884a3a66fa31aec9e1ea54 ]

[Why & How]
HDMI TMDS does not have ODM support. Filtering 420 modes that
exceed the 4096 FMT limitation on DCN31 will resolve
intermittent corruptions issues.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 43016c462251f..9d996d5fc3ffa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4135,7 +4135,9 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN31_MAX_FMT_420_BUFFER_WIDTH
 						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
-					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
+					if (v->Output[k] == dm_hdmi) {
+						FMTBufferExceeded = true;
+					} else if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
 
-- 
2.40.1



