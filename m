Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C07552C9
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjGPULz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGPULz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:11:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4726B9B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D987F60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8054C433C8;
        Sun, 16 Jul 2023 20:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538313;
        bh=AcWtZuvJMBQWsl+Hq4xNLyPtoh7RARy/BYNDpaEPaFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7i7ZcyTH4eW1dLAyYI5kUCBT4AkKDGSjT/Y7dDY967PULBW2QEFliMJnKslBx0UD
         8KFRw4SSWTrkofW6uk8OxubvK9+spN1zAkyjR3G+b7HdSgHJEmUJfiHF4kCiDK+fUX
         eng7Sr0bGUpr7MMFXLSZkHD2M3XqJIaEHDFxM02E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tao Zhou <tao.zhou1@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 407/800] drm/amdgpu: Fix usage of UMC fill record in RAS
Date:   Sun, 16 Jul 2023 21:44:20 +0200
Message-ID: <20230716194958.525742080@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Luben Tuikov <luben.tuikov@amd.com>

[ Upstream commit 71344a718a9fda8c551cdc4381d354f9a9907f6f ]

The fixed commit listed in the Fixes tag below, introduced a bug in
amdgpu_ras.c::amdgpu_reserve_page_direct(), in that when introducing the new
amdgpu_umc_fill_error_record() and internally in that new function the physical
address (argument "uint64_t retired_page"--wrong name) is right-shifted by
AMDGPU_GPU_PAGE_SHIFT. Thus, in amdgpu_reserve_page_direct() when we pass
"address" to that new function, we should NOT right-shift it, since this
results, erroneously, in the page address to be 0 for first
2^(2*AMDGPU_GPU_PAGE_SHIFT) memory addresses.

This commit fixes this bug.

Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 400013b268cb ("drm/amdgpu: add umc_fill_error_record to make code more simple")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Link: https://lore.kernel.org/r/20230610113536.10621-1-luben.tuikov@amd.com
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3ab8a88789c8f..dcca63019ea76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -171,8 +171,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
 	err_data.err_addr = &err_rec;
-	amdgpu_umc_fill_error_record(&err_data, address,
-			(address >> AMDGPU_GPU_PAGE_SHIFT), 0, 0);
+	amdgpu_umc_fill_error_record(&err_data, address, address, 0, 0);
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
-- 
2.39.2



