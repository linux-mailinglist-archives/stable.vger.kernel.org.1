Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394AF7ECBE7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjKOTZM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjKOTZL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B90B19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3566C433C7;
        Wed, 15 Nov 2023 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076308;
        bh=wDFZbvGg9CPg6Rvz2YLqQ7nyqSSv1LvEYLfNo2rXcIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wq0OZh6TOV+VUsk/XasIDU41YhkdzGeT9V/y5Hu/6YB128OZTr7/0RBUZeAV3kXmd
         +i5WTUaaTGsxo1y/0OdPs2zz1XX+LehvkFbpI6uZGIoaKkkegfHc/LiTFu3Du4bnKC
         Q8bH8w6ad/V1nuhvvb/KPA8ka5eIf1HHTcsKReaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: [PATCH 6.5 209/550] drm/radeon: possible buffer overflow
Date:   Wed, 15 Nov 2023 14:13:13 -0500
Message-ID: <20231115191615.264589174@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

[ Upstream commit dd05484f99d16715a88eedfca363828ef9a4c2d4 ]

Buffer 'afmt_status' of size 6 could overflow, since index 'afmt_idx' is
checked after access.

Fixes: 5cc4e5fc293b ("drm/radeon: Cleanup HDMI audio interrupt handling for evergreen")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/evergreen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 4f06356d9ce2e..f0ae087be914e 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -4821,14 +4821,15 @@ int evergreen_irq_process(struct radeon_device *rdev)
 			break;
 		case 44: /* hdmi */
 			afmt_idx = src_data;
-			if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRIG))
-				DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
-
 			if (afmt_idx > 5) {
 				DRM_ERROR("Unhandled interrupt: %d %d\n",
 					  src_id, src_data);
 				break;
 			}
+
+			if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRIG))
+				DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
+
 			afmt_status[afmt_idx] &= ~AFMT_AZ_FORMAT_WTRIG;
 			queue_hdmi = true;
 			DRM_DEBUG("IH: HDMI%d\n", afmt_idx + 1);
-- 
2.42.0



