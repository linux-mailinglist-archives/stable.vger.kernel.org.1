Return-Path: <stable+bounces-3953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF66803FD2
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9B21C20BF5
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6FF35F06;
	Mon,  4 Dec 2023 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWWiYarf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30E35F0B
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50C2C433A9;
	Mon,  4 Dec 2023 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722159;
	bh=TH9fsU6XpX3JgdLmNZ6kChi406IFUeueRSBsiRsWiQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWWiYarfOuadyLTSxsLD10hhAV5tbELj2fYu0hRr5NXxD3MN9jwSNyB8DlhFl49R5
	 4oJEQMQ7OZ75oGs91/cHsI9izfRf3+yy/+nesgkEHw3/eqCvgXh4+gK06Xm50wbi5D
	 orC0lT9F8LUPZlOu+4nm84u8CyC94x9IaDFZhEWrDIkcFdCeDdcbV07OAYJkUc4ORz
	 pp/RvdEwgjwajhaAje03qCUwatfHSvyxq9eWC42jkmBqhjcwpCScvL88WkQrTws+d3
	 bnq6PGIUrzs7eHSlx5DoyLHfjpRSZg34R59wNknDYYLWGLLikDjnHKwrawb7CPN7jI
	 IWqhSUZ/bcH3g==
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
	dan.carpenter@linaro.org,
	victorchengchi.lu@amd.com,
	tom.stdenis@amd.com,
	andrealmeid@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 14/17] drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null pointer
Date: Mon,  4 Dec 2023 15:34:59 -0500
Message-ID: <20231204203514.2093855-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
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
index fd796574f87a5..8123feb1a1161 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -479,6 +479,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_rreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -535,6 +538,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
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


