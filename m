Return-Path: <stable+bounces-98254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8759E355B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 09:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E8282360
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BEE19007D;
	Wed,  4 Dec 2024 08:30:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8ED1865FA
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301012; cv=none; b=IznI6FcsEgMq1sjqmEcyBBJFsJXCi40OaN8MZ9KRUtonY4N4FrsIPXMHm+ezCNmPafWu25EbMwdC8NvyNDhFKIVTWMscSaAUzFH/shalad3XPqIG0XiiJyokCyqkSyPfkncw1k2dLkDcMnc7vEiarVRm1X8sgh+8QDuB4Ollh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301012; c=relaxed/simple;
	bh=YusYe5CWhtlKbMSTNAjtGRT81PJ8ckjywzHfu/PJDIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bbrHW+vyDONretjxcPxb6gvjVakOtckAKq5XGbmQ4QWBEGWrGUjsJ4AtaPm8/04iBC6HQ2/Q1jwNlXJDYHNlZDVJTH8cPuK6BbbBUjCz8V9rGXQWo/DnkcQjniUiM1ise6cyuY1BTV54KQbwS1tAgL1mfm1CcqhBCBIR6iybGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y39d369j6z1kvGh;
	Wed,  4 Dec 2024 16:27:51 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 62B121400D2;
	Wed,  4 Dec 2024 16:30:08 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Dec
 2024 16:30:07 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <stable@vger.kernel.org>, <kevinyang.wang@amd.com>,
	<alexander.deucher@amd.com>, <liuyongqiang13@huawei.com>
Subject: [PATCH 5.10] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed, 4 Dec 2024 16:23:56 +0800
Message-ID: <20241204082356.1048-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)

This reverts commit 17f5f18085acb5e9d8d13d84a4e12bb3aff2bd64.

The origin mainline patch fix a buffer overflow issue in
amdgpu_debugfs_gprwave_read(), but it has not been introduced in kernel
6.1 and older kernels. This patch add a check in a wrong function in the
same file.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3cca007a0cd0..8a1cb1de2b13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -396,7 +396,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	ssize_t result = 0;
 	int r;
 
-	if (size > 4096 || size & 0x3 || *pos & 0x3)
+	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-- 
2.17.1


