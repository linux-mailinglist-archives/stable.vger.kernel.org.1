Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424DC7B889C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbjJDSRw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244101AbjJDSRw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:17:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5799E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:17:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546A2C433C7;
        Wed,  4 Oct 2023 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443466;
        bh=Cg69uMwxYz9CRI/S+B8pXtQARvk87MJpd+6sxoV65Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTBKq41QsHtbut7dG5ZYwtkWIBw+7PfizlScnhKmcWJ43FrBW6VNCU3kAlVR3cw/G
         7eNtUuYknZtWa/XDnc4WnLTuJcVoeDIQlIuKXA7ZYmMtRzV8AB/yeylyj0a0lgRavt
         DKMBVncGTwwXt/41MH56sZfc4R4vVigpPSd4VvV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Timmy Tsai <timmtsai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 167/259] drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for SR-IOV
Date:   Wed,  4 Oct 2023 19:55:40 +0200
Message-ID: <20231004175224.936209095@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit ab43213e7afd08ac68d4282060bacf309e70fd14 ]

Needed for HDP flush to work correctly.

Reviewed-by: Timmy Tsai <timmtsai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 09fdcd20cb919..c52a378396af1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -344,6 +344,9 @@ static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
 		data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
 	}
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
-- 
2.40.1



