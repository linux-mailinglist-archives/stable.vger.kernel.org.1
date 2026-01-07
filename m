Return-Path: <stable+bounces-206119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB95CFD4D8
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D68DC30BE3BF
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01432470A;
	Wed,  7 Jan 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shbiay5I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C13246E4
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783201; cv=none; b=D15r1tleAlOh2TaY+kNrGor6xUClig05wnNOdNoeGYLaGgt75Kr1UkRea87O5QAaIWbhRsw3lNUWOH/5UEknn/Ed4RL/t7ZA3N08O3CaqT5qyenFuOe5kHaMRrzundbeijfRlzRcbXC/+zPqYAeYn97vTi/UkRXkAiL2ihQDr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783201; c=relaxed/simple;
	bh=9AoUpIw9SBJ5wk6JstdvxjKBWOgdXZangbiwCh1xMnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8da6DkYSH/QtdE236zfXbleU3ZONDlQRuG1L6Unsrbe5IhJh89hMmdRv1gQtaqOrz9oCKRDNlVaiMzc3c+L8/OZTSf7OzSyCIpMKEM11A4FHsYKuvlrYAhZx4j/HDgx9VH0fFYUaxI2hH600JFJyUpyfSqbFtmbxBF3tORzwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Shbiay5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BFEC16AAE;
	Wed,  7 Jan 2026 10:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767783200;
	bh=9AoUpIw9SBJ5wk6JstdvxjKBWOgdXZangbiwCh1xMnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Shbiay5IP8CY8aYNbTx8dXxxdr02n7p2ZAOk/enXo7L9R3AWNm4MQDVnJHuVCSABW
	 jFmurOXM5ZbLQGO0PzrIcRzdAgdshuve33Dm0t6o+xrAJA7ESD2b1vC8QAmryYv+Lb
	 HnN2OgEsQzMuzafSIiAiTTofXaATVQ0UrUYkddZ8dZmp2aUO1+fb/6QJzXagPr0MZC
	 IQiHW2ZvjEXjaDpZGRF84WcVGPJ90DfoGjQCX9f1B/6i8LLupftMmTFX/GH9yTIMbh
	 4h3U3s3OnoA+iXo17JrNT8F095gqTWuVA1Bs21J8vJQ44C7Cw1HQuS1TPn4AfXtMta
	 jgf33IH5gttzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: Forward VMID reservation errors
Date: Wed,  7 Jan 2026 05:53:17 -0500
Message-ID: <20260107105317.3610258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010549-ensnare-embassy-d32e@gregkh>
References: <2026010549-ensnare-embassy-d32e@gregkh>
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
index 37d53578825b..211d67a2e48d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2747,10 +2747,12 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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


