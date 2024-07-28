Return-Path: <stable+bounces-62155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD4D93E631
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6CC1C20E49
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0473478;
	Sun, 28 Jul 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k44i63x2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A273466;
	Sun, 28 Jul 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181407; cv=none; b=MpHK39Y5oUW3qmfRsVNuVtItFRd6nQdpoq8jgV6JnsdkVlAEZ/TM+eCU6p/O024xCblKLGZfENqc2+deO9jugZCz1NleUI9N8aR2p9opX07Mti3ojPxjrsnTekbE8HPoJyqAWjq4FARD6sb4MiVBcUUJlZv3SSYRUe9d6oWjrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181407; c=relaxed/simple;
	bh=btrlw5K7Y/17sQ+h9eMqp5vAXw/5OjknoCfIgQbwb70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpHHyPQFhCr61iv9n9JM0agOEHMe1BnFwIn3MXQrL0UjciBRQ/mVreQ+rMsbKmqDu71HCjovPQ8/OxHyw8friGS87Xv54Cd12tyd5dZl4+Nl0v90O8mcNJzCACbUYO358uDdp3/bn3QulokPn6mZkLJFAuYe2773MckAvf7YZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k44i63x2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461F8C4AF0B;
	Sun, 28 Jul 2024 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181407;
	bh=btrlw5K7Y/17sQ+h9eMqp5vAXw/5OjknoCfIgQbwb70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k44i63x2hNEz+frknLt0zdynP0sKuq/RBj/HoVZo6sBrZc/ge7JODo9nFh1Vo6O1e
	 t4mRL2HaXq1KFdBWgBOeAe72YoSCOzK6Y5mVlQ7qPlDxAdK9APyjjOgkgSDfBPTUDI
	 9Pd4PbUnvHL0Fj/VXR8Ugy0c5Cd8taB0hClKpQoZvDCGSTb8wd4H9LjL4/oST7y1pu
	 B2pta9P8lo6QJv3pMOtqYDEOTNyOGBW3F5Vonrb4zi36bjVX0IxpZ5QxzMZD2ZJ2zZ
	 T44Pn4VZl80/KYWRAfvwanA8MJXluvL8hSRSn5mY6ANpWcnS5tF26eMfbpi9DEBnim
	 vGfC1upIB8FUA==
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
Subject: [PATCH AUTOSEL 6.10 11/34] drm/admgpu: fix dereferencing null pointer context
Date: Sun, 28 Jul 2024 11:40:35 -0400
Message-ID: <20240728154230.2046786-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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


