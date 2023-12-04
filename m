Return-Path: <stable+bounces-3972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922A4803FFF
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF17B20763
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B935EE5;
	Mon,  4 Dec 2023 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5pIZjRk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005B35EFC
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEF5C433C7;
	Mon,  4 Dec 2023 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722238;
	bh=Psb9RTZFuE/U1pj2kV4Ja+LRykSEd4btKLMZAtk5CkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5pIZjRkQ9rib2vSnlMKC6E+BzFIxi1+bXKGcW5fkmeHgmW9n9hoWrS26cY3l/C9K
	 KTNeOszjSoWyk84cRbKV2Z7nlYHY5Aqzu7Dsbj5vMwhU7ACy9qdpn7f6MYN7q8BhNn
	 64xtXpjF5tkIzaeTCAihpSJ1gg4yfwVlNJZEmsiAnfJQodkmaf1xo3U8HOEC9jD16o
	 yCXXqWe+m+aY6Qn1zxELA8tbG3jwHSECwsTRkKHwffZ3lFRrMC34decI05ciY7Hv7G
	 3nUGG5btWegQbx0gfqoA6PlIgZWIa6dxEjcONT6uxOxptKLA4zB8Q5i0SZVauMYSce
	 /CK3UdSm7gAzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Yao <yaolu@kylinos.cn>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	shashank.sharma@amd.com,
	Hawking.Zhang@amd.com,
	le.ma@amd.com,
	andrealmeid@igalia.com,
	qu.huang@linux.dev,
	tom.stdenis@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 6/7] drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null pointer
Date: Mon,  4 Dec 2023 15:36:49 -0500
Message-ID: <20231204203656.2094777-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203656.2094777-1-sashal@kernel.org>
References: <20231204203656.2094777-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
Content-Transfer-Encoding: 8bit

From: Lu Yao <yaolu@kylinos.cn>

[ Upstream commit 2161e09cd05a50d80736fe397145340d2e8f6c05 ]

For 'AMDGPU_FAMILY_SI' family cards, in 'si_common_early_init' func, init
'didt_rreg' and 'didt_wreg' to 'NULL'. But in func
'amdgpu_debugfs_regs_didt_read/write', using 'RREG32_DIDT' 'WREG32_DIDT'
lacks of relevant judgment. And other 'amdgpu_ip_block_version' that use
these two definitions won't be added for 'AMDGPU_FAMILY_SI'.

So, add null pointer judgment before calling.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 48df32dd352ed..3e573077368b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -459,6 +459,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_rreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -518,6 +521,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_wreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.42.0


