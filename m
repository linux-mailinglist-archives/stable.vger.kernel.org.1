Return-Path: <stable+bounces-197915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA92C97A83
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 14:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B54E158A
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 13:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2B30E837;
	Mon,  1 Dec 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="j32w8pVI"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC62DAFC1
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596547; cv=none; b=FTwaTC3WssLPaMJV0jBV2S1I4YURTJBFnS/xFLt9I58eimQNy8qZimWVA0v0A5o73eoFsMkiJPIm1uPSltJLrGllVk0PQ1ZN0NnfMqzUtx3FFPArfIHi39f29hPUpIQ7eNYyylkNLIlsY7TXRaHYjPEySVbCbn9o6RlhY6iaFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596547; c=relaxed/simple;
	bh=SkC/RcVrFmuhVEkr0bUXdiXJDdopi6aF2rrGPd0JDLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnDMS0JuIdklXxb20hGhynX742ud6gpucjqg/1F2bbmrS2mh26MyFoDBkLZ7l3rcUCzrjz3EklRz+qTyRU4d8ytYGh5YAt9mHYbu8QVDbKB6OIBNJGTYFh0Kqp4gy8whDimb3oonUUhAgIvl3rwiMdFzv7pgkStWQWLqEKP9KW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=j32w8pVI; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764596535; x=1765201335; i=natalie.vock@gmx.de;
	bh=txtTrzHJym24K0gyb1mF5doofizsESMhalFu5YxWezc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j32w8pVIw0cUJIkKoBUfcWNsQKlwYlnvxlxAvxXFPh81JnpirTu0VbLsQIjYIwhz
	 OSb05JeYXnyKLuhIjMJa8eqs+T2c4ehBUqpaUKQqCAOYtxB4FZR2LQ0OtqXGWwkaV
	 MMFyEvmBFyubqHyPnaj5ksa/VKnKKU3O8njJw9vJ38q3yJRxtUWhaW4nG/HvbJ7fP
	 r7QUX52QNGgcPEZdOp7uPLOo+4IbPm+wCmR4r+Y+yfriGI0M5mYgr44ocsfa89b5+
	 syg5UJPtg7fhSfmrxBNA+oAcTIB+IBzxlyrKnI3uWACHQLGWzVTBDZLEMPVeSUjIb
	 PL2eCdCSuVGUQ9+swg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rizzler ([80.187.64.159]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oBr-1wJo0s2PdF-00yXBg; Mon, 01
 Dec 2025 14:42:11 +0100
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Forward VMID reservation errors
Date: Mon,  1 Dec 2025 14:41:47 +0100
Message-ID: <20251201134147.10026-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I6w7hhtdkB6c8nQvtl2nUrjWqzgcEm3srW6JkP+4tvDUAKW1bcB
 zSmFGe7LvIZcaw8DapwWc6n3ofzqAuLm+vTNmSVqJ2cBYx3ILTv2Vanvf4Cgo8fLZp8t6ux
 oU1rNjycmUPf6DZV6GbeLaC5JMk7sLC6zElNJwLSiSmBEN1fs7E2CMDaUAcAtdWg38LgDeI
 XgUZFplRxLfA5aRaodtDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H/dX7pewufk=;RoqYFdzo2Q0soHol4v+VID1CM0i
 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

Otherwise userspace may be fooled into believing it has a reserved VMID
when in reality it doesn't, ultimately leading to GPU hangs when SPM is
used.

Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process iso=
lation between graphics and compute")
Cc: stable@vger.kernel.org
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index 61820166efbf6..52f8038125530 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2913,6 +2913,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *da=
ta, struct drm_file *filp)
 	struct amdgpu_device *adev =3D drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
 	struct amdgpu_vm *vm =3D &fpriv->vm;
+	int r =3D 0;
=20
 	/* No valid flags defined yet */
 	if (args->in.flags)
@@ -2921,16 +2922,16 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
-		amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
+		r =3D amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
 	default:
-		return -EINVAL;
+		r =3D -EINVAL;
 	}
=20
-	return 0;
+	return r;
 }
=20
 /**
=2D-=20
2.51.2


