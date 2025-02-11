Return-Path: <stable+bounces-114853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E417DA30587
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7EB3A7721
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8B1E500C;
	Tue, 11 Feb 2025 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oo90Feak"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D41EDA2B
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261802; cv=none; b=nYZCcMo5NrlAUZj0YA0Y2JYKVqSBlBWAxEskkZTBV9wTQRpX1MKsqqogwu7N5ReLECYDBDltE4kMkOAexhGOrPo/HXLSOF2p51Bwc8C80KwGV1XLE0DKwSTLR/eW7w6plOwhMrIWnWRDghss71D9S7BOT3JLYC2JkvrhORTlXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261802; c=relaxed/simple;
	bh=bhj3UkJ67NAieUxfmbWehnY+OPHutg5oP5s3obPlNnY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Uerxn7dzlXipRC8hwQORj2J3OMl1zTXwfY9uMVDhh4XY2wfVmigWejPeyA6m1VrQ5bvGBpDmlH8GIxQ7lLcZnrB1WuUsnp9zQEP4v4fnfKpJpDyhARqxWe9k4fbFdvJ9t7rif0TVFNkMKcGcql7+H0Ey+zR4R8bYyKo4MptxTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oo90Feak; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739261492; bh=VWqdQlnphsdOpSdg0bzqf1vv9TvXg7qf3k7wiINt9G0=;
	h=From:To:Cc:Subject:Date;
	b=oo90FeakehfKIoWw/H55R6yhqwKx5HYyIWzSHHdzJTwchFkGxI4EW0VLcF57D2fha
	 M15rAXKcq/SbhCcgiaNdTldra9aTmUqOa3BcUA3Or4Np140FHNnxZt/IlrYGImEyg5
	 M6obHaeJY8R0Lez9cminb4ksnwxvuG2BRnnpzk8Y=
Received: from public ([120.244.194.25])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 2B188ACF; Tue, 11 Feb 2025 16:10:49 +0800
X-QQ-mid: xmsmtpt1739261449tb2l3m9nz
Message-ID: <tencent_2482389C30F90D58B47435111FAE922BD608@qq.com>
X-QQ-XMAILINFO: OKVons9G7XvhgTPUAJNaoTuYDc5OTs+fWWi+rH3VZr4wUWa+TJ2dzoTHKlyNIx
	 1uDJaandGck6IpxfNlzOxT+YA4ShCgEuqfahpKCB+2jG9iCgOzXAzEKdxqT+IjFVfoE9PNepphCt
	 nct4CqaYCIVGyUNf2AKZMi4LssHQFRa+tiicduwMeoCfRFw1Wc1j2UdVF11SWUW298opGEwEKYD2
	 ydU9sWiCxJyh1E/67EHnmKuIFk2rrWUkxa0ohqKfwP17LA9fDVwoTFd6BkczptEuiVSFEA2ZNUFU
	 lbqb25zPjVW9zHG+KdsShWrF/7ZeNNCac7lJZZ8K9c3wARDt4t1yOIj5/mdo07Z2Ss2GuQH3dP0t
	 ZVnvkUwo5ml8RSenbzZKuab6TIhKjfo5WbMUI91qynroYPEZxrDjIVbh0ezC/XphSNi8Um9Lcq+q
	 dXpYjRt3FGZHWwHs3eHdYMM+/CP9kmn2go86wUwoc0nmu5CL2AHGIX7AKj+zUXRT1BpXPPeNeIDL
	 egsZuwV/zu6E843EvFlinrkz+oEvX7x3yVzK14+9w5a/T+tNpomD3OAbi03YXG8Yqq9HWpBQZ03I
	 xojuZc6q0IphinepyXqyr4cVCDNgzSSiJU/zmpzhHPYna+wgZsd+R0mDDKP150VzmxrUKwok3Q4o
	 OSTmWl3VhfYkWjTGIARp7XjuNNF6yGCWB9MAqyFLyXdf2OawGT3klWor9QjaKpVhFWkE9fer7Pih
	 uclms/t6kQ+ePw+/UpFGCJbHW8aB1Ua2qoZj02D7P1OkrmJmTL2doLdxrWXWX4ruf63gB9BLZGym
	 4cxcdxpsyd15CBAm0pBlPKFprdzKES2f2ytB2qGT1oo5aoGBK1HE5QhzwzgItucFYZ3DTNJ4l32D
	 cRhb+mTbWf+0vPkKRZvay0VHDg/2OMyk3aLMlfZWIPQZ9fBTTFppwDxyzN6SOwhyGwq386n3Qdt7
	 BU8IgwiUvRNcwtr918hiMn2zKbhB+U3Vlnp5ro4gw=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 6.1.y] iommu: Return right value in iommu_sva_bind_device()
Date: Tue, 11 Feb 2025 16:10:48 +0800
X-OQ-MSGID: <20250211081048.1093-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

commit 89e8a2366e3bce584b6c01549d5019c5cda1205e upstream.

iommu_sva_bind_device() should return either a sva bond handle or an
ERR_PTR value in error cases. Existing drivers (idxd and uacce) only
check the return value with IS_ERR(). This could potentially lead to
a kernel NULL pointer dereference issue if the function returns NULL
instead of an error pointer.

In reality, this doesn't cause any problems because iommu_sva_bind_device()
only returns NULL when the kernel is not configured with CONFIG_IOMMU_SVA.
In this case, iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) will
return an error, and the device drivers won't call iommu_sva_bind_device()
at all.

Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20240528042528.71396-1-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9d87090953bc..2bfa9611be67 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -999,7 +999,7 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
-- 
2.43.0


