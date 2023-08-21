Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8037832BD
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjHUUBD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjHUUBB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC814188
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB8664785
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C67C433C7;
        Mon, 21 Aug 2023 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648057;
        bh=POhrlz74d5AhMhScF/ZcwkAXH48XfSYgao8Qh3SusVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rvnZsS2dVVi0C/aftoWbTYSr4C+ZRp0xgi+xIdpTU+S8yG8tYe8AkVulWBTlQOxV
         J3PXqE+XonvY7FToq+R7HOmk1BHCbJpn6i31fVW3XbbZ/fRH0oSKEhqe1pdVYHCrK0
         XQSC5Je34pZwMa3maBUV82stoCnFJdUAm6tX2LfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stylon Wang <stylon.wang@amd.com>,
        Daniel Miess <daniel.miess@amd.com>, Jun Lei <jun.lei@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 040/234] drm/amd/display: Enable dcn314 DPP RCO
Date:   Mon, 21 Aug 2023 21:40:03 +0200
Message-ID: <20230821194130.494616080@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Miess <daniel.miess@amd.com>

[ Upstream commit 17fbdbda9cc87ff5a013898de506212d25323ed7 ]

[Why and How]
Add back debug bits enabling RCO for dcn314 as underflow
associated with this change has been resolved

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn314/dcn314_resource.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index abeeede38fb39..049fafd3d908c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -921,6 +921,22 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
+
+	.root_clock_optimization = {
+			.bits = {
+					.dpp = true,
+					.dsc = false,
+					.hdmistream = false,
+					.hdmichar = false,
+					.dpstream = false,
+					.symclk32_se = false,
+					.symclk32_le = false,
+					.symclk_fe = false,
+					.physymclk = false,
+					.dpiasymclk = false,
+			}
+	},
+
 	.seamless_boot_odm_combine = true
 };
 
-- 
2.40.1



