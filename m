Return-Path: <stable+bounces-119807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D39AA476EC
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3823AE2BE
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC5225409;
	Thu, 27 Feb 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n5wJoWo7"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C432253BB;
	Thu, 27 Feb 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642941; cv=none; b=YYqx0ysrVrP2GMmkdJTl4JRuj9hvXmO6aTQ2K7Ln3ytXHKET3SFIjkau3bdM6jlu2Mv9qZtkGYgtzDesBZBULJTVohZCYkIl6TESSolPYQYqXgEMH3MLzBsUciLKBnQrOSpmnuts4SoyayTt/7JMxe7SNdLakq1/uLSELKB0G+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642941; c=relaxed/simple;
	bh=G9CqUFNdUNUfzrYHmH4LKSH1/0fyY3uGBpsl530tWRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEJgdYa56yCI5gD9AJbNJOcnQvrEhRkRoq9RE1HUMHheVpnHP/tpkX0xUuif9IUREK30xjr1CvN0M3tkrLRPbWuEnlVMD3d8JGAP9yD3uqiUEjK9R9lFRaK9nmEr1OkugTLuEXw9JgHwNq4U5pe4XkyByyqGOLLZAorBtmD/PBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=n5wJoWo7; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=G9CqUFNdUNUfzrYHmH4LKSH1/0fyY3uGBpsl530tWRY=; b=n5wJoWo76NUAcVvkT+YSgZ3Tp5
	7aj7m+zy5wUhO58FEqKsamkS1uiFe3SSRV9843uGt4OjDLnJ7OkTQZ6xBSFJ17BLwVAZXA0mezzsF
	K1DrlIIuIuyz53/LUVWIigDcTwvj+zFJsh2co/vlordfjoOW/EWN+3YR9TMD2yXUsjUOFGob6Bz1e
	4f0UGXi2eJh+W2p1TDg0Rl62gSlmApPRjLx/Rj8ge7J2Zw40pbbX01yGJbuZWjo3KTfq0+QZy84EP
	UrgNKmeEa9B7R0iAUW/UCUTmpj1rN+uj9/j7ofX82qLo3ZlEXPwFxWCWIRgpeJsKNvm95nbthq53D
	pUCO0Dmw==;
Received: from [192.168.12.229]
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnYjw-001UK9-CM; Thu, 27 Feb 2025 08:55:34 +0100
Message-ID: <75c3d6bc5e020868faf0fd91525cd75b497ac8dc.camel@igalia.com>
Subject: Re: [PATCH 0/6] drm/v3d: Fix GPU reset issues on the Raspberry Pi 5
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
	 <mwen@igalia.com>, Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
 stable@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 devicetree@vger.kernel.org
Date: Thu, 27 Feb 2025 08:55:34 +0100
In-Reply-To: <20250226-v3d-gpu-reset-fixes-v1-0-83a969fdd9c1@igalia.com>
References: <20250226-v3d-gpu-reset-fixes-v1-0-83a969fdd9c1@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Ma=C3=ADra, all patches but 4 are:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

I hope someone else can can look at the remaining DT patch.

Iago

El mi=C3=A9, 26-02-2025 a las 16:58 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> This series addresses GPU reset issues reported in [1], where running
> a
> long compute job would trigger repeated GPU resets, leading to a UI
> freeze.
>=20
> Patches #1 and #2 prevent the same faulty job from being resubmitted
> in a
> loop, mitigating the first cause of the issue.
>=20
> However, the issue isn't entirely solved. Even with only a single GPU
> reset, the UI still freezes on the Raspberry Pi 5, indicating a GPU
> hang.
> Patches #3 to #5 address this by properly configuring the V3D_SMS
> registers, which are required for power management and resets in V3D
> 7.1.
>=20
> Patch #6 updates the DT maintainership, replacing Emma with the
> current
> v3d driver maintainer.
>=20
> [1] https://github.com/raspberrypi/linux/issues/6660
>=20
> Best Regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Don't run jobs that have errors f=
lagged in its fence
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Set job pointer to NULL when the =
job's fence has an
> error
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Associate a V3D tech revision to =
all supported devices
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: gpu: v3d: Add SMS to the regi=
sters' list
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Use V3D_SMS registers for power o=
n/off and reset on
> V3D 7.x
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: gpu: Add V3D driver maintaine=
r as DT maintainer
>=20
> =C2=A0.../devicetree/bindings/gpu/brcm,bcm-v3d.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 8 +--
> =C2=A0drivers/gpu/drm/v3d/v3d_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 58
> ++++++++++++++++++++--
> =C2=A0drivers/gpu/drm/v3d/v3d_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 18 +++++++
> =C2=A0drivers/gpu/drm/v3d/v3d_gem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 17 +++++++
> =C2=A0drivers/gpu/drm/v3d/v3d_regs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 26 ++++++++++
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 23 +++++++--
> =C2=A06 files changed, 140 insertions(+), 10 deletions(-)
> ---
> base-commit: 099b79f94366f3110783301e20d8136d762247f8
> change-id: 20250224-v3d-gpu-reset-fixes-2d21fc70711d
>=20
>=20


