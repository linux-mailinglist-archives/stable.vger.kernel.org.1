Return-Path: <stable+bounces-98255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F669E356B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 09:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82B92814B8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5229194147;
	Wed,  4 Dec 2024 08:31:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA582745E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301101; cv=none; b=c4oANFazgnM43sw/15SstRZz9XnPQNA7y/TIIRxPDIyYhjvwVCTxvZN2Pj2onhHWuIdd6WXfC/V9gcUObnP6f16YLGAv+6paH6O1yDv2955yDXEqSlHXJ/swtOfmRVdGXVc/zLUrmVV6GJZQ12a3Fra4CdKdpbJ37kFZiuNb9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301101; c=relaxed/simple;
	bh=FWSC+FagW43R9lwFiD2yPVXD4kOmjZmVhuyhLPS/Img=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VYMSh3LOeFLWsq1UwYlGhIT+ic5hyofsq2Wc1bkDEdZhK197qVuzU2MUBkYePDW4YqaHCXsYCgWRYoFxV9g03bHKLl1jqOXh5YOxL195HcUN8qYeUV/LnMcTjT6rqC0fMT8KQ/xFTitRR50X6NmjaWPnWuoyeIvJLIY048byFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y39jh3wJTz1yrGq;
	Wed,  4 Dec 2024 16:31:52 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id E510C1A016C;
	Wed,  4 Dec 2024 16:31:36 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Dec
 2024 16:31:36 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <stable@vger.kernel.org>, <kevinyang.wang@amd.com>,
	<alexander.deucher@amd.com>, <liuyongqiang13@huawei.com>,
	<zhangzekun11@huawei.com>
Subject: [PATCH 5.4] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed, 4 Dec 2024 16:25:25 +0800
Message-ID: <20241204082525.2140-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

This reverts commit 7ccd781794d247589104a791caab491e21218fba.

The origin mainline patch fix a buffer overflow issue in
amdgpu_debugfs_gprwave_read(), but it has not been introduced in kernel
6.1 and older kernels. This patch add a check in a wrong function in the
same file.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index fa42b3c7e1b3..48b8b5600402 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -395,7 +395,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (!adev->smc_rreg)
 		return -EOPNOTSUPP;
 
-	if (size > 4096 || size & 0x3 || *pos & 0x3)
+	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
 	while (size) {
-- 
2.17.1


