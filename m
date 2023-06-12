Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB01D72C091
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjFLKx0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjFLKxF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726834C3A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53550612F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683DAC433D2;
        Mon, 12 Jun 2023 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566259;
        bh=D407yoHy8k15nn4A+GJw2lD3h6C6R2U50/wzyNSiIwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzAMxJUMZyZNDUyC/ChxijGsVywPXULM5RzHmCS/pDEhDG/NMTYncEZOdEQ4jHcx2
         UNUwDfh/rECf/bCcwuodIPnV8f4uJARdJYud9deggW1NbDpaZFahEFIuLWEnXWHdb4
         id0J/i447J9VhCHzA/0ya75XpBGmKmiP8sOgF/K8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chia-I Wu <olvaffe@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 56/91] drm/amdgpu: fix xclk freq on CHIP_STONEY
Date:   Mon, 12 Jun 2023 12:26:45 +0200
Message-ID: <20230612101704.399010539@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chia-I Wu <olvaffe@gmail.com>

commit b447b079cf3a9971ea4d31301e673f49612ccc18 upstream.

According to Alex, most APUs from that time seem to have the same issue
(vbios says 48Mhz, actual is 100Mhz).  I only have a CHIP_STONEY so I
limit the fixup to CHIP_STONEY

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/vi.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -542,8 +542,15 @@ static u32 vi_get_xclk(struct amdgpu_dev
 	u32 reference_clock = adev->clock.spll.reference_freq;
 	u32 tmp;
 
-	if (adev->flags & AMD_IS_APU)
-		return reference_clock;
+	if (adev->flags & AMD_IS_APU) {
+		switch (adev->asic_type) {
+		case CHIP_STONEY:
+			/* vbios says 48Mhz, but the actual freq is 100Mhz */
+			return 10000;
+		default:
+			return reference_clock;
+		}
+	}
 
 	tmp = RREG32_SMC(ixCG_CLKPIN_CNTL_2);
 	if (REG_GET_FIELD(tmp, CG_CLKPIN_CNTL_2, MUX_TCLK_TO_XCLK))


