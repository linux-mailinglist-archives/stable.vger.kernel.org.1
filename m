Return-Path: <stable+bounces-98253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321D9E354A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 09:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9B4169064
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0491192D8B;
	Wed,  4 Dec 2024 08:28:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A81922E8
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300928; cv=none; b=fPZ9RFdQMh8mgmaTaZ7DQMY70/UmaiKSVqGsFe1vM4krP5uMICV7qX0INjWnSgqZnbCBZijmpJzQCtVXoBf/ZlCAgWNXBJQp6S9zFER+/PtwFuXWpdpgnVlanBxg3oW/p1C9RBn3/nBrjPIOu9rqUJY33FrPlczJqsVI+TjQu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300928; c=relaxed/simple;
	bh=yDqv68dLn7RbA42lfe+HuK2b+5yWOZ6sb0Gs7Q+1l/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/BMql2ab+igEk1dwqm6A+iGkQYFIiuvejD9b+vlFh96Mv6dGlGvgbXvXaugsuad/pDvE8vla6JYjotFwLFAHD60wLyJNV/yquv1tBoWtqM2tY5+At5WiGTcW8uOtHENdqAjqAI00qBaC3aD4WDUhabJlwQ3evY2fhuyaA1UuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y39bQ2Xvzz1kvFn;
	Wed,  4 Dec 2024 16:26:26 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id D857B1400D2;
	Wed,  4 Dec 2024 16:28:42 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Dec
 2024 16:28:42 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <stable@vger.kernel.org>, <kevinyang.wang@amd.com>,
	<alexander.deucher@amd.com>, <liuyongqiang13@huawei.com>
Subject: [PATCH 4.19] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed, 4 Dec 2024 16:22:31 +0800
Message-ID: <20241204082231.129924-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500003.china.huawei.com (7.202.181.241)

This reverts commit 673bdb4200c092692f83b5f7ba3df57021d52d29.

The origin mainline patch fix a buffer overflow issue in
amdgpu_debugfs_gprwave_read(), but it has not been introduced in kernel
6.1 and older kernels. This patch add a check in a wrong function in the
same file.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 4776196b2021..98bd8a23e5b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -394,7 +394,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (!adev->smc_rreg)
 		return -EOPNOTSUPP;
 
-	if (size > 4096 || size & 0x3 || *pos & 0x3)
+	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
 	while (size) {
-- 
2.17.1


