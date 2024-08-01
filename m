Return-Path: <stable+bounces-65092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B6943E4B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE61C21AAB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2891A01DF;
	Thu,  1 Aug 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyP+l0Eh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95114A4E2;
	Thu,  1 Aug 2024 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472384; cv=none; b=TwA4MxJzCX7ybZYgPdXvjJk/IoVpe7/J/MZBOvZ/SkOp7TqnM2XahCXpfBdg8+RczD09QpeTEecTmcHHpWjinC9FpQxG9xUhidBDUVyYUzVx013yBXs0r9QcS+bq7GPud0h77rRsvHwARplEojun1/wycAuT0TQG9+j5WhMYapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472384; c=relaxed/simple;
	bh=ZqKEc39YFhoWD54/kaUgO51Cm6xlpU/CG2KoYBY0aLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHLMH3OtjG1TS0sBHrjt+/h8bY8nVmOhE3eBQSsNPiirLM0JmDFncZgsWNp+tK3oLXv4xQ4Wufaj0uZQKkHxZlLNIvkaiw7+CxhhoPfYy0gRebHtwNlh9FcIR4DYGxDD1Us9emWMisGSiv12o030C/+yb8HymNmlU1qLn6PFD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyP+l0Eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4C0C116B1;
	Thu,  1 Aug 2024 00:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472384;
	bh=ZqKEc39YFhoWD54/kaUgO51Cm6xlpU/CG2KoYBY0aLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyP+l0Ehso6VUFF1OebxguYlY2To3gz7XruVb74sNO+FO/QzAhn5s3PdfC0XyCfVv
	 v+ecRtxtDCv4NOweOeRQs+4omQhoh7Cmw6rOPmI4cMJHJkAPvyn3m3AOO8E3J245g6
	 /g9TxroADZWj/3+4LsxluUfXuEhzJa3GyhwiRSJ23XtzyFOzcNUmuDlMqhyaxSI0AU
	 G59kK74h5T5cX7wyhqloq4K0Sa/gjXwTuo7HEfO+BkK3g3HYVrqiTHWpAoACkFt27h
	 5h1T6ixAUV9nbXlgUmqkyydoFq4LfWiya1CeMl31cELsfHJOwYCib6Ir0fxtAb3e3Z
	 d+k/c940O85MQ==
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
	shashank.sharma@amd.com,
	hannes@cmpxchg.org,
	friedrich.vock@gmx.de,
	andrealmeid@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 02/47] drm/amdgpu: fix overflowed array index read warning
Date: Wed, 31 Jul 2024 20:30:52 -0400
Message-ID: <20240801003256.3937416-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 0554576d36955..294ad29294859 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -367,8 +367,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
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


