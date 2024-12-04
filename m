Return-Path: <stable+bounces-98256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A69E3575
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 09:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A745161641
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580B192D7E;
	Wed,  4 Dec 2024 08:32:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9817DFEC
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301164; cv=none; b=EPAuOA0I1m6YQjizOJuVmXhepeYlhldwpc+UG6hrC0ZLQOfY7c9ITUAKP5qsHSVMOiKc1bNxEXqK9xYUPVx0qAY55fB92tqnqJdPNMIEAZ7KPsAF3AykvBA68W+HiqvUqEIgiT4COlt9279YHOWpZ5CNtNBG+pbmpoZVwuVl/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301164; c=relaxed/simple;
	bh=1/TDCXED/CZyBwgJdMDUc9bWIy37cJoKFf68WsTwHzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Foync1MJDSGn1zeyn3Ic45bL96kSqdLDbwF6le0Gdx2lV4hCXPiORKsG7o5NuxlsW38N9x19ykoubZNsaqjpG9yZwKJvPVR1k8372GuBIuQ9S7YWG+kLRduCFHzMa/zCZFw0hIp/1qhb2vM+kSOMPy73R28EnqajTY9yx4HhMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y39hk0nFPzRhqQ;
	Wed,  4 Dec 2024 16:31:02 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FEF814037D;
	Wed,  4 Dec 2024 16:32:39 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Dec
 2024 16:32:38 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <stable@vger.kernel.org>, <kevinyang.wang@amd.com>,
	<alexander.deucher@amd.com>, <liuyongqiang13@huawei.com>,
	<zhangzekun11@huawei.com>
Subject: [PATCH 5.15] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed, 4 Dec 2024 16:26:27 +0800
Message-ID: <20241204082627.3756-1-zhangzekun11@huawei.com>
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

This reverts commit aaf6160a4b7f9ee3cd91aa5b3251f5dbe2170f42.

The origin mainline patch fix a buffer overflow issue in
amdgpu_debugfs_gprwave_read(), but it has not been introduced in kernel
6.1 and older kernels. This patch add a check in a wrong function in the
same file.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2ca7a5d5ea64..49711776b351 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -401,7 +401,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	ssize_t result = 0;
 	int r;
 
-	if (size > 4096 || size & 0x3 || *pos & 0x3)
+	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
 	if (!adev->didt_wreg)
-- 
2.17.1


