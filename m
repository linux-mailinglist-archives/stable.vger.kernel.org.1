Return-Path: <stable+bounces-77528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577EF985E18
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890D01C25105
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1EE20B896;
	Wed, 25 Sep 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEdG8A7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5520B862;
	Wed, 25 Sep 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266125; cv=none; b=lku4UZIPYvqYrVNNVDyDPe/bH8VXnhN4Le729GOeWajlpzGhY2Qb8NTTawI4ddwG7q54XvIzjnYxaJqaqsB3ETg5mAIR8V+XHwHU2odT2DxVb0AMfpe7QAAl3lpqUiFNPlGe+0U1OWqLF/2RfXiOTV3KqEHv+NsfXpH7vHeT41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266125; c=relaxed/simple;
	bh=FrGcnH+AqSW+gEtvpji9vy6tqrQ7FtAImu5Ymo00N3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+lCpcdRRlK97GLDCTuounMIXRwRECgUBILfd+/umX/TSygq5PgfLj6F2SyaiTLV7jIBtkeQMFgYCuuRPLOWIzKIZLHwq8LIl+0yQHvELRrexiET3t61d8Su8G/IDN0GUZK2D0MQ4hsDlViE23DzrMDs32nurpQJ+UvYZEge2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEdG8A7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F25C4CEC7;
	Wed, 25 Sep 2024 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266125;
	bh=FrGcnH+AqSW+gEtvpji9vy6tqrQ7FtAImu5Ymo00N3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEdG8A7ochpWfwn4TVi9WtyVyXTkleWHGjFUQFpM38i7RfXHtYSJ/eho8vCQ9m7Ly
	 YX8/DysG6wqLP/NGXksSiB61lmtDw3NBNQjon+9/HpdUtflD3xV6+3vhDEdWXdCusu
	 nX5BwKvsnkHBou2rC7wdo4UmAgxQgnFMew6x8qDuE3GyaFxzZXcM9cexNNybtm8lBd
	 76yYD25T2kIltAEOPY9yuIwXu4C7h9v/IqsQZD+RvAERc/YQApUpnFzUJ+WP3NuO7F
	 FdjzmDhI9FaV52D6sBouigLRhnjPRN6csolN9PEC0nAqbKsEEvggKSRa1z+hsIWx+w
	 rakL7tsCJG8Ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	yifan1.zhang@amd.com,
	sunil.khatri@amd.com,
	Tim.Huang@amd.com,
	zhenguo.yin@amd.com,
	Jack.Xiao@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 180/197] drm/amdgpu/gfx11: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 07:53:19 -0400
Message-ID: <20240925115823.1303019-180-sashal@kernel.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 3f2d35c325534c1b7ac5072173f0dc7ca969dec2 ]

Protect the MMIO access with safe mode.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0bcdcb2101577..6b5cd0dcd25f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5792,7 +5792,9 @@ static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, regSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
-- 
2.43.0


