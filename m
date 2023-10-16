Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB67CAB65
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjJPOZc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjJPOZc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:25:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312649B
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:25:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446D7C433C7;
        Mon, 16 Oct 2023 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466330;
        bh=0DXoca8GYb+lgJOMB5Qdbk71DJaBaAeIPen+wRTfSMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VD9GX2RnyjvBeDpB9mS/4qB00Yt23hUpAZaq+gcWILaggJtKwuIH9ofnaeK8v/Igu
         eWCDQ6r4Q8OU07dNEdASEEMTnGtNdJfl9GbWWpQmj1G2MqAuNibaRQH6yONQ3jsjcy
         dfWrBa4ADaFNaUSQBXocLdVwy25oqYsZHZUfMkNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Deucher <Alexander.Deucher@amd.com>,
        Yang Wang <kevinyang.wang@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 008/191] drm/amdgpu: Fix a memory leak
Date:   Mon, 16 Oct 2023 10:39:53 +0200
Message-ID: <20231016084015.596605581@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luben Tuikov <luben.tuikov@amd.com>

[ Upstream commit 5d061675b7538e25d060d13310880c01160207c4 ]

Fix a memory leak in amdgpu_fru_get_product_info().

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Reported-by: Yang Wang <kevinyang.wang@amd.com>
Fixes: 0dbf2c562625 ("drm/amdgpu: Interpret IPMI data for product information (v2)")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 4620c4712ce32..1005edeea39e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -169,6 +169,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		csum += pia[size - 1];
 	if (csum) {
 		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
+		kfree(pia);
 		return -EIO;
 	}
 
-- 
2.40.1



