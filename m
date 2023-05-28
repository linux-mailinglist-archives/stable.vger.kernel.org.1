Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FAB713E93
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjE1Tgv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjE1Tgu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AD2D8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AFF161E50
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574C8C433EF;
        Sun, 28 May 2023 19:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302606;
        bh=7xFwNCjNfnSz8Oi433LP+2xgTQ/2cwcCMAeC0k9Ndao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiPSFZUI/y/syvGQtLnRecj6S6RfgG7OY4djnTN/XOFhaGojwKmfeKFcy0tc2rHPQ
         cpaMT4+CqA4SPlnQg/fzEsmVwQxj6neY1dMb553IyGAuVva6qgJoqFhj0Awp3bUuz0
         EfFb5Skf2kcoAtSjy9lu1YwR0SdoXMbadWIGP1HE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Jonatas Esteves <jntesteves@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 044/119] drm/amd/pm: Fix output of pp_od_clk_voltage
Date:   Sun, 28 May 2023 20:10:44 +0100
Message-Id: <20230528190836.859089696@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonatas Esteves <jntesteves@gmail.com>

commit 40baba5693b9af586dc1063af603d05a79e57a6b upstream.

Printing the other clock types should not be conditioned on being able
to print OD_SCLK. Some GPUs currently have limited capability of only
printing a subset of these.

Since this condition was introduced in v5.18-rc1, reading from
`pp_od_clk_voltage` has been returning empty on the Asus ROG Strix G15
(2021).

Fixes: 79c65f3fcbb1 ("drm/amd/pm: do not expose power implementation details to amdgpu_pm.c")
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Jonatas Esteves <jntesteves@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -869,13 +869,11 @@ static ssize_t amdgpu_get_pp_od_clk_volt
 	}
 	if (ret == -ENOENT) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
-		if (size > 0) {
-			size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf + size);
-		}
+		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf + size);
 	}
 
 	if (size == 0)


