Return-Path: <stable+bounces-197917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF47C97C23
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D288341FA2
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA830E0D4;
	Mon,  1 Dec 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="h2G0EMP2"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A12F068F
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597676; cv=none; b=TIIm6OD65YLR11jX+j8kqq8n/qZJLl+GmvNEENdLUmHBvQjS4L7r9skIlmAoJawGNLxFe4HCHKTQ6Laa5j0y7xOQnrvAiLlgqNATJX8VsVSkLqGaC39gglHEBd3c7N7bH2sKiOQg4wKPDW6rL75lUjHTBFRi+XViMPxFaT/H9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597676; c=relaxed/simple;
	bh=54NEJw7W6teh94sawrzngsmJTwk9r59N9TB3hvjEoFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6exSppr6Zpxp3slrTpwM7mUXcVzOa84Jvaoi7DeS9YDkRhJhQp0SL6V97oxqLAl+ScnHV7iJdAWPmKjQpneAMaIC/1eP4ITiqc0q7N+NWechZ+QwBBkBTSDxcwTEoYKNtHWWYqxvMW7eT5E8vLJQec1HkUZ+H1aAMpHso3qVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=h2G0EMP2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764597672; x=1765202472; i=natalie.vock@gmx.de;
	bh=TE5UvJPsHO/mp9YU51R8AuxEgaopNphO0d0Qi6KcXR0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h2G0EMP2UmsjEDe/H9DAQ46ADJlsUkjjWRcdwXVq6CqOnbqJ44i3vEYUwhVfWeeD
	 M2jb39STi0Ou62yfi2OElPKAm2nV6sU0HJXx0k6P7ZCHaynC8vZVV9AOXX4VrRzmU
	 wXL902KoI7njR2qzJaoTE1X3G4bQCFj8ECXt6cIPHqt99iDDBmtUqQbQbc2GKEZb6
	 sFs+oSlDnNaWqv3GPto//OX+/3B0s5tZHsOgaTo1rAJBaBMjRx2jYR5nUXjKPdCcj
	 j1wG1Hysux39+HfgQpYX4gvNP1cAXo4YuQBtnVSB0XuPr6HE6j62eUzGw3rcsNkjL
	 pTGgBNQ20c0GVX0lbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rizzler ([80.187.64.159]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1viHpy26La-00KonC; Mon, 01
 Dec 2025 15:01:12 +0100
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: Forward VMID reservation errors
Date: Mon,  1 Dec 2025 15:00:47 +0100
Message-ID: <20251201140047.12403-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pBl9JZsA5qOcKduo0N7FcKAX1/hWtfz1261lyaesCpQnf9+syvM
 q7nA/++5s+MmvkU+w/RSOCVkFcNz5rlquojyfqUFimUhtQekrpoWg1OQag7prqXibAM2NRL
 f6ibRGy+0dYctOsTAWt4KYa+ExEC7V7BscuVy60I24LHfdJXnxNiZ8GhjAG8pg+wjo9HeXP
 FdnIFqBPGmwIOfX3WxeWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:daCik707fCk=;MwuhaUhql4EIZ8wxv1bLxPq37He
 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

Otherwise userspace may be fooled into believing it has a reserved VMID
when in reality it doesn't, ultimately leading to GPU hangs when SPM is
used.

Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process iso=
lation between graphics and compute")
Cc: stable@vger.kernel.org
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index 61820166efbf6..1479742556991 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2921,8 +2921,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *da=
ta, struct drm_file *filp)
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
-		amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
-		break;
+		return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
=2D-=20
2.51.2


