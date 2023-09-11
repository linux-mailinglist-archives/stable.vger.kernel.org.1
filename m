Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEAB79B687
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbjIKVEb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbjIKOJa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:09:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F1CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:09:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B5CC433C9;
        Mon, 11 Sep 2023 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441365;
        bh=a7ioAVMhEO8/9/IRZLrG7UM6xp9bBKtb3ZX8UD1/bV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8TjORi+uHhWKkl638KeOP8w2lkFuHK4PQs1s58ZTpx7JR3rfcVWhUNKah5H3QzgE
         yaFAGTORcCr8JUDJsuJmclHfAFmv/zp/vdget0wWuqbxxDyYX9o4Y2oDzIPlddfu/M
         qrNT25/f9cHw57Aobr/LKK6HCsidYmwVNiAuSXy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 388/739] iommufd: Fix locking around hwpt allocation
Date:   Mon, 11 Sep 2023 15:43:07 +0200
Message-ID: <20230911134702.029132666@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 31422dff187b243c58f3a97d16bbe9e9ada639fe ]

Due to the auto_domains mechanism the ioas->mutex must be held until
the hwpt is completely setup by iommufd_object_abort_and_destroy() or
iommufd_object_finalize().

This prevents a concurrent iommufd_device_auto_get_domain() from seeing
an incompletely initialized object through the ioas->hwpt_list.

To make this more consistent move the unlock until after finalize.

Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for physical devices")
Link: https://lore.kernel.org/r/11-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ed2937a4e196f..2e43ebf1a2b5c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -298,8 +298,8 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 	hwpt->auto_domain = true;
 
-	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
+	mutex_unlock(&ioas->mutex);
 	return 0;
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-- 
2.40.1



