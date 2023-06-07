Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27AF727002
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjFGVD6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjFGVDj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF92705
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E82664981
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3CBC433D2;
        Wed,  7 Jun 2023 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171793;
        bh=nWRd9A0QqN0dca2ZUipSd+A8s4jl7a7f1n3vUpuk5kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHVFyYBCePQQOYbvBVhMzsINd0SDxPXBQbSPioxO6/zhBRDD+uXYYDkfQ/vyPiARo
         A83M/JVW4UqJuAB4ZWfxtdzvAf+vRTembmtKCro/2RPQpAP26ADbmbG2+YgpdtSL0C
         eqU3Q1ln+JloYKGvLSalO9pJYNz/07NTaWx0BA4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 152/159] drm/amdgpu/gfx10: Disable gfxoff before disabling powergating.
Date:   Wed,  7 Jun 2023 22:17:35 +0200
Message-ID: <20230607200908.638917788@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8422,8 +8422,14 @@ static int gfx_v10_0_set_powergating_sta
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


