Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6600713DF3
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjE1Ta2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjE1TaY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31F0A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6811C61D4A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87685C4339B;
        Sun, 28 May 2023 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302222;
        bh=7xFwNCjNfnSz8Oi433LP+2xgTQ/2cwcCMAeC0k9Ndao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJAwr7pHVQbFiWNfPr2LVWHcht3izqMVDKV4BIRyoLwprBXlH1lC5eokpi5T1KKLS
         cgLGrhlWmRKpscPmSlNYJdytLgOp/8eUyn09HnKprL4EnoQkcp8voo4yw0qng8p5mG
         FYb9crTn+pkSVfY2ehEe9gAo7DtBssaPAMiMXIwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Jonatas Esteves <jntesteves@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 049/127] drm/amd/pm: Fix output of pp_od_clk_voltage
Date:   Sun, 28 May 2023 20:10:25 +0100
Message-Id: <20230528190837.949321802@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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


