Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691097831C4
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjHUUKT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHUUKS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FA12A
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7DE264AD9
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E42C433C8;
        Mon, 21 Aug 2023 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648615;
        bh=y0MFn0lr0muEPKcbddg3uyxZmALuWIwA5pkCWJGaQbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Slm4UK6nHvwmNxEiGgl8F0SsRaSDZ2e53OARKAC7lxJ0m7Ba7AkXoaK6Qs2tVreXv
         krKE/a0sFpQIECMsOX+hvnXBDDZP9hikmUv8TgiIDcumhjEXAcguwrVIBXOSGgGXXe
         Lu7hWsMFWKNMEUuxitQJliEbSdcfnaGz/IY1SIo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 222/234] Revert "Revert "drm/amdgpu/display: change pipe policy for DCN 2.0""
Date:   Mon, 21 Aug 2023 21:43:05 +0200
Message-ID: <20230821194138.710139983@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 6ecc10295abb2fdd9c21dd17b34e4cacfd829cd4 upstream.

This reverts commit 27dd79c00aeab36cd7542c7a4481a32549038659.

It appears MPC_SPLIT_DYNAMIC still causes problems with multiple
displays on DCN2.0 hardware.  Switch back to MPC_SPLIT_AVOID_MULT_DISP.
This increases power usage with multiple displays, but avoids hangs.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2475
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.4.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 4cc8de2627ce..9f2e24398cd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -712,7 +712,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.41.0



