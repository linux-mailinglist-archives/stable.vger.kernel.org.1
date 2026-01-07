Return-Path: <stable+bounces-206132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E5CFD852
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 13:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0BE3072EAD
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8D2FFDEB;
	Wed,  7 Jan 2026 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2/Us6rQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3B13D539
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786858; cv=none; b=bg/oRJh3xAyRQFhy/WRwBYkUEgyH/c3GAe4AI6MyujNiAIogDrOa9oGFCM3I7nBn1bDU8YkKvoPrUv0kpK+xtH701N627lDkcVIvxY4cSZ2zR/PcKBlTJRtqX9v5UK13o+39GLr7wnlzQ/b2E9xuLsBCWb9lKWW4qEYxbt366m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786858; c=relaxed/simple;
	bh=1fZChTHC8g/43AKyeuP2EU5o3WHb/AJoalO3rv8PSIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtRyCy4BAA01AAZGBfjJxGfnjdP8/dGGp8+f7a1EiabXHvM0aQhwh/kkWY45+8vVVfeNfrukCKZy8/D93Nt4Xh9gMw45F4VaivhdJo60YVSZqTmSDzlKVPnDleMD1AfYdu4Wnqf4sXZHZMUVo5WyoCqin25MrQEEBNZ1FAtqLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2/Us6rQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB068C4CEF7;
	Wed,  7 Jan 2026 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767786857;
	bh=1fZChTHC8g/43AKyeuP2EU5o3WHb/AJoalO3rv8PSIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2/Us6rQgxjhTD5eK9FfecRWkr3aRmUEt7zpWVgZh23FiYd6CM6wWTBw7Xnx30g0V
	 OhyM4ssS6crda65+dI8rRAEQkFDHylx31whsjjL3Ol4/f9nxliIwy9hPeomwlG476Z
	 s/NMQESHsIMYDGFvR5M/OSdKxD0G+LhltrURCpa39F1FoKxunhBoWSMj73TuWRAwne
	 fTtsKRwlB0ufuqDPuMy8/jsyti0slSUadVeuQDNmNuAWfBLvzoNE5kqSQD68JzVBWZ
	 I61pW7f47e0aE6KpnVpoVkERsIhjzIIKOR0iOWoMjKfxYZBi5VkjlAUBHfAjmJYF7h
	 1Lwp048rN+/lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: Forward VMID reservation errors
Date: Wed,  7 Jan 2026 06:54:14 -0500
Message-ID: <20260107115414.3985195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010550-duke-justly-8832@gregkh>
References: <2026010550-duke-justly-8832@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Natalie Vock <natalie.vock@gmx.de>

[ Upstream commit 8defb4f081a5feccc3ea8372d0c7af3522124e1f ]

Otherwise userspace may be fooled into believing it has a reserved VMID
when in reality it doesn't, ultimately leading to GPU hangs when SPM is
used.

Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process isolation between graphics and compute")
Cc: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ adapted 3-argument amdgpu_vmid_alloc_reserved(adev, vm, vmhub) call to 2-argument version and added separate error check to preserve reserved_vmid tracking logic. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2992ce494e00..dc860544e6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2496,10 +2496,12 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
 		if (!fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
-			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
+			int r = amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
+
+			if (r)
+				return r;
 			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = true;
 		}
-
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		if (fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
-- 
2.51.0


