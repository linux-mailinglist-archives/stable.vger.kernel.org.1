Return-Path: <stable+bounces-62185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD94493E6B6
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798D92811A8
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F413C814;
	Sun, 28 Jul 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeL1bYP+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3677F10;
	Sun, 28 Jul 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181604; cv=none; b=ijvkmNjSeUu/rxDQK4GZB2Qe/m0so1xYrudUBbOgJ9q+YdSSy3RTKKlO5N/0b6r7y4BgcWfyFWC79vNkordBv5yfhD6VloMgqJBfPkpnI+2vByTZudIzcoyjK2DidmJ+TMNdkc9xcSK2sFIxuwCrUAtRil/Rlh63lDekkUGdNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181604; c=relaxed/simple;
	bh=btrlw5K7Y/17sQ+h9eMqp5vAXw/5OjknoCfIgQbwb70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/BvM4EPGXXpYTTwtGU+8SXQiG4jRdzIIeTsZFMcTaiTUWuBxJADy/vX6ZYqjsDrOQ8+jMINh/MvNdTBeFZcT19ep9+q/HAUz5QkfV3CzNNDHQthL3JpjdouAsRFamShlOO6gWOCOCSMdYIrfeSFpxS/cVM74WtPFQyEXcDkFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeL1bYP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3216DC32782;
	Sun, 28 Jul 2024 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181604;
	bh=btrlw5K7Y/17sQ+h9eMqp5vAXw/5OjknoCfIgQbwb70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeL1bYP+d1drnLb+bkH+rgScJAlR3Sw8t/45tmM901jjgb+FJeL8/5/4RzPd9rWM7
	 SHI+VFX4OmTzb7NdTXVxKPUaGE3ql0cJ7jZ6buOrXX8FSeIe7RhBk19wosXDRCM/hp
	 Jx8I2E94vQtSbWrnnMQ9XO8IV26uo/3vl+nTbGLQ8aWSHeNErw2wa9ouq3a9riDOB0
	 n/9pqY9lcURLCpy8+mnoiBBKri0ObJUo7mdwfGz6reboZSBY2bdURM5LDoH/yU+8Ne
	 Ny7BTKpDO87+FNAieEGAFpWIvbgX8knvE3V95YokHesLPig2Gq+HaMQgoTrpbUZItg
	 9iJJqigSupvAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	Stanley.Yang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 07/20] drm/admgpu: fix dereferencing null pointer context
Date: Sun, 28 Jul 2024 11:45:05 -0400
Message-ID: <20240728154605.2048490-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 030ffd4d43b433bc6671d9ec34fc12c59220b95d ]

When user space sets an invalid ta type, the pointer context will be empty.
So it need to check the pointer context before using it

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index ca5c86e5f7cd6..8e8afbd237bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -334,7 +334,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 
 	set_ta_context_funcs(psp, ta_type, &context);
 
-	if (!context->initialized) {
+	if (!context || !context->initialized) {
 		dev_err(adev->dev, "TA is not initialized\n");
 		ret = -EINVAL;
 		goto err_free_shared_buf;
-- 
2.43.0


