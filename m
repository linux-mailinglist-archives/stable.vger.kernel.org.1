Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08A775D211
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGUSzw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGUSzv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230763A84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5A861D5E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99DAC433C7;
        Fri, 21 Jul 2023 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965738;
        bh=iLFiMCJg5rFUmeEVsbIK7/PBTZMTgdEfXNRayrJxWPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZsfiNECT6YD3piIksdj+3BDGTk1Pn7zKwiUJEcSQsORQK5JokbY9kTNwF+OfJb4Z6
         lQxjglEWaQ5gWsZDIy2t05ZqQHjqbHuGzvWqAFSZxSxG/D3/sn3I3+s04RGAbntxNj
         HJdM5o7NuInpSX2cRJMACMH+w+0OtJa3ruv+YU3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        Natalia Petrova <n.petrova@fintech.ru>
Subject: [PATCH 5.15 096/532] radeon: avoid double free in ci_dpm_init()
Date:   Fri, 21 Jul 2023 18:00:00 +0200
Message-ID: <20230721160619.782071409@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 20c3dffdccbd494e0dd631d1660aeecbff6775f2 ]

Several calls to ci_dpm_fini() will attempt to free resources that
either have been freed before or haven't been allocated yet. This
may lead to undefined or dangerous behaviour.

For instance, if r600_parse_extended_power_table() fails, it might
call r600_free_extended_power_table() as will ci_dpm_fini() later
during error handling.

Fix this by only freeing pointers to objects previously allocated.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
Co-developed-by: Natalia Petrova <n.petrova@fintech.ru>
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index f0cfb58da4672..4f93cc81ca7a0 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5520,6 +5520,7 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	u8 frev, crev;
 	u8 *power_state_offset;
 	struct ci_ps *ps;
+	int ret;
 
 	if (!atom_parse_data_header(mode_info->atom_context, index, NULL,
 				   &frev, &crev, &data_offset))
@@ -5549,11 +5550,15 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
-		if (!rdev->pm.power_state[i].clock_info)
-			return -EINVAL;
+		if (!rdev->pm.power_state[i].clock_info) {
+			ret = -EINVAL;
+			goto err_free_ps;
+		}
 		ps = kzalloc(sizeof(struct ci_ps), GFP_KERNEL);
-		if (ps == NULL)
-			return -ENOMEM;
+		if (ps == NULL) {
+			ret = -ENOMEM;
+			goto err_free_ps;
+		}
 		rdev->pm.dpm.ps[i].ps_priv = ps;
 		ci_parse_pplib_non_clock_info(rdev, &rdev->pm.dpm.ps[i],
 					      non_clock_info,
@@ -5593,6 +5598,12 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	}
 
 	return 0;
+
+err_free_ps:
+	for (i = 0; i < rdev->pm.dpm.num_ps; i++)
+		kfree(rdev->pm.dpm.ps[i].ps_priv);
+	kfree(rdev->pm.dpm.ps);
+	return ret;
 }
 
 static int ci_get_vbios_boot_values(struct radeon_device *rdev,
@@ -5681,25 +5692,26 @@ int ci_dpm_init(struct radeon_device *rdev)
 
 	ret = ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = r600_get_platform_caps(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = r600_parse_extended_power_table(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = ci_parse_power_table(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
+		r600_free_extended_power_table(rdev);
 		return ret;
 	}
 
-- 
2.39.2



