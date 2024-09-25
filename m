Return-Path: <stable+bounces-77487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6B985DB8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2406F2858C3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1778E21C18E;
	Wed, 25 Sep 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K26F6Yt7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCE18C358;
	Wed, 25 Sep 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265995; cv=none; b=oZ1+ELjtFL0G7SBI+tvMLMx8YEejxXWc0lTHxFgDwQvnSbivPiG7zo+vqVbU2nbDkRbdMAIzyhpfzH5Bt7QR1u3ChTjqAQsOS8NP9R4Jne358MGWgZOZe2RaDzlaIhBLHYHj2PJy4Rsql88Ne8Cvz2jNSPK38cM2p139wF0qRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265995; c=relaxed/simple;
	bh=R0kmDpRDwTEs05FuFvg4811FdfzPzdJ0EYwzIMG7mzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2WKdn2hKAEGm/6l/5O5nY1izhvfvROO9djm2oQefPyTfPE0+gWwZ97k8sgOaa0LV8JA84nJ894u3N7EdhrJ1sDnei3QlbHwpVUWW/JxvMJhes44JJdDtcKhQ8oVm+fdLMbznV48khwFl+8TS3rlbvPih46FujMDmqxS0XbqADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K26F6Yt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD4C4CEC7;
	Wed, 25 Sep 2024 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265995;
	bh=R0kmDpRDwTEs05FuFvg4811FdfzPzdJ0EYwzIMG7mzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K26F6Yt7tJP1p46SkOWM2qEb8us9rMac7Uve11bXV9M+9JQbQTPEoJjWrENrnOBik
	 vAMU14BL83RQwO6+dbhTohDkLRqrs9TVF1dyq21lQOyA9ugtTz5wlQ0NOxfzLEvuv5
	 Bq5UcPqLSNdU8c0XASVaxB3fAsYAho7W/Un/abE/VHuFQkdxItt7hlPpeo0o2T4Cph
	 qVUDywaPAIGofrCf89RhCCw7QOwFjCT4/2Nxvufj8nDswwcsx79IxqYvMlwSV5pwiA
	 6n4YtM3ddP8SHs2u8Oxh9wXGKba+xfqKfDMuzAl+TyGInvquTY7AoKW9/powrjdFvi
	 TUresH8wnNrHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng01@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunil.khatri@amd.com,
	Prike.Liang@amd.com,
	Tim.Huang@amd.com,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 142/197] drm/amdgpu: add raven1 gfxoff quirk
Date: Wed, 25 Sep 2024 07:52:41 -0400
Message-ID: <20240925115823.1303019-142-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng01@kylinos.cn>

[ Upstream commit 0126c0ae11e8b52ecfde9d1b174ee2f32d6c3a5d ]

Fix screen corruption with openkylin.

Link: https://bbs.openkylin.top/t/topic/171497
Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3c8c5abf35abd..c86a6363b2c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1172,6 +1172,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	/* https://bbs.openkylin.top/t/topic/171497 */
+	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.43.0


