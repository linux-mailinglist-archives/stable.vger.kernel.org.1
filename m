Return-Path: <stable+bounces-65198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF302943FA4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4231C21BFC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2691757D;
	Thu,  1 Aug 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8LjcMnB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B5D272;
	Thu,  1 Aug 2024 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472841; cv=none; b=K9aRyVYmRGNBfT6AFJHIGJBNtGKOwyOmaYA2rzAf9LgKw6Bx9OIPi/QfFqmYVsCUqzPpaLabetgWo5wFJnubFqHX3eg3DoE8Gybqs+l3XwJkRIREu1YuGGFj6uD/No75GnSPSk5Elhspmlr0rRpPqoQ5dy+boUS+/3v2mFOWAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472841; c=relaxed/simple;
	bh=mHrDZThkia9FZr8QpjrKs8MvCfX8yJX7rXP9HOV+t94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uGtKh31bWb1c10LndapkZNmpaHc++2k1upS3YNIm5lrJxtLNWO19SpB019VusLr/coRRznquypzjTh4afQVIvyDTUiKN8xJpi3TMHBgq/6q2xqzIb0l5OlHp1BLDzWM1MvNksdAWJWSDx4Y3wzqhos789nkqlUv7YwrgNsoRqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8LjcMnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6D0C116B1;
	Thu,  1 Aug 2024 00:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472840;
	bh=mHrDZThkia9FZr8QpjrKs8MvCfX8yJX7rXP9HOV+t94=;
	h=From:To:Cc:Subject:Date:From;
	b=G8LjcMnBkHmCpMTrhW3HqgMu/gNZ+4iTXdcYgEvO0Nl928W28eywJ1GlHKk0AKOC9
	 y3eM08ZfrgEOkIRQNh9QFQBHY7WhgbvdT+bs11djqWAvvPkUeWqpnoRjLlfuVT/8yd
	 kpFvCn63t944i/MAjGe2tj1H1BNDPDWaU2D8vK/DhFSUKDXTWfaoZkz0JWnJ42MRMJ
	 zWxC6ArAyPtcxJXd2mfc5UIYrIhLOACwuBabir5Ue71WMK9AUz9jq+IxKweZ7Lw0CQ
	 z7eaQWHenHRXkDnyMq8BeP/V85FcBbkmCaHtjKRGcXraeoEkQ93PR9Im6jFEQsDfch
	 N8/x+71NmrwXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Jun.Ma2@amd.com,
	hannes@cmpxchg.org,
	vitaly.prosyak@amd.com,
	shashank.sharma@amd.com,
	andrealmeid@igalia.com,
	friedrich.vock@gmx.de,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 01/14] drm/amdgpu: fix overflowed array index read warning
Date: Wed, 31 Jul 2024 20:40:09 -0400
Message-ID: <20240801004037.3939932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit ebbc2ada5c636a6a63d8316a3408753768f5aa9f ]

Clear overflowed array index read warning by cast operation.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 93794a85f83d8..d1efab2270340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -497,8 +497,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	int r, i;
 	uint32_t value, result, early[3];
+	loff_t i;
+	int r;
 
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
-- 
2.43.0


