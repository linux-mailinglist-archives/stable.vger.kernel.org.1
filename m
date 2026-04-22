Return-Path: <stable+bounces-240331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPnBLdTW6GlJQwIAu9opvQ
	(envelope-from <stable+bounces-240331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:10:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8F9447186
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E813024967
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB23EBF02;
	Wed, 22 Apr 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzP41FT9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AB3002D8
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866645; cv=none; b=K+iuD2mktl0syHL5k/S6uBl8klwgU652COBBFF2hE7nRyW62mXvXFilHuAN52/UKm85ZLwY/hPHEUWvkFD1BLbx7RPVBMK4CiGyVt5kOXkuVkKM5BSpjOnMXNrRBaes8zQRDQjE2OAgNoqmAU21kZ4fKNo+o+UH4n0E0S1gmCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866645; c=relaxed/simple;
	bh=zjUNf2f+yvcdfDY+OJ4ThjIQCQ1TDt4unpRoum0dLrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiF2lURpiz4QEJQ+w1TQOIDc1X/boIPJme0i6tPMPGJP98P18EsTULIUxOUz0txFq+vWNSN/aMW1ZxV5kBNptFYKybfj2uFm4U9vgbqajrpQ7PlGOc90ptoYB+1Mh8bvJGkanbNjYJU9jzWFy7CNAeKHSWEmm34dvGq7pjr4dr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzP41FT9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48896199cbaso55395235e9.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776866642; x=1777471442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB2D5LFDJfWK+z/VNsomGx4bgTK6cIcOio7NwwAtJ5A=;
        b=CzP41FT9R0GngPQZBlrkWWk/aLHhXzD8LeWsy5SiHJtIn6z+8NIYZT3uwxOo0MmsiG
         cef/O7Ie7u3XgupmObvzaGnP0/JoHpJt9fbUGzSN5wivueqsZhBDsDCLWe1ydwDfHkX/
         F2qOKkKUCzF2I87JaM1Ci2Yu/PkyC9kQlIwmtskAFtLBX2KMyhTAcx7yx0q9YbgRYIPT
         0QaHbTxNQfBCEipino0YO7DRjrrVlGYUOZaeoxtQWK/zKH6w+r4F8+tgJAzCd1a0mHqE
         Qt3S6CcOTyf/DjCT9Zw5zos3+bC46HjsMyM2hbjX7s63YB5D2m9r7ezeYz9okx0d9QE3
         i7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776866642; x=1777471442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MB2D5LFDJfWK+z/VNsomGx4bgTK6cIcOio7NwwAtJ5A=;
        b=EuIa0NC70e43VA04c27PzKbw0UB7wr8EcH7z1/XwhEUhgZi+DmAgiVl3Z8c4/n6DXt
         7WqFGjcaRSl+wmda//8CW1ozJ0G0LCG/Mv9sUY8CfgbPNIcSxu4eqYr1rSNO+/HMvh6e
         pipeOn54a2MutxP20UbdCo9Wxfd/8YEVZZiikMgd9PSbYxthFXE+UTgqRJ80oyetcQwk
         8v7Qhh3Kwc6AGxVWfZ0mWbdRkvM86hFn9UoKPXNSdDBvlMqrt9VO1fiE1kcEOwf5mQEP
         yWF0G4mJhCbZQX1ea4rl4x70EHr6WbK9aXshXflNCWI6e8po4miQ0csw1wgAXW5YxqrI
         JrGw==
X-Gm-Message-State: AOJu0YyHjMnNAh4KmIU9KmlFdGCLXlX4SRfbVpSMIqLZzIkCQ74aHnir
	UOAbaBUWVFGtS7DLRYSvRVDejLbos5lvwHaQLDR26qoT5FYi5CdkwM802U1TZtoc
X-Gm-Gg: AeBDievomI6sIcfU0vGgrj49EOJveznPJDv3TdlQVcAypXRHFsLNogiKiSccxz+QdGH
	ieZAkIfH29hmWbmiys25v6hSuVE/7spat/v08yKiKbEdzYvJg0UpUMXDoI3vb2wzCV8QECnmM8s
	AEXmPELPU5N4RjSRXfV+7D3CVeCzJe/g6d+NNKyDi5LDZEAOWTKjhKSmT87ccrqEH/kiur6hOSD
	34zlohRvQKdhKBJMjCWCYQqHzqOlie7ubKrGqXwjvNlKZQqV/ZegtUarEQ4elSUHcGcpuy1M/qY
	z/WWYTKuCf4vWtwBFZfcFlYmTS+7ydKSXYqXBTylg5962vcDgQRaNxgiAa9vr/fUwoHNs+fII+c
	TVfADVcE6nXTC6Xt7Lm2VO5RXG7bdU1ZZ6DvUMeXyfmWPuMgmNIIMGlTJ+6ziuRp4NgNc6Z42GW
	R8W7qgp4mJqw+vItigirhLKqnA0GtdhMGdnt0UWeANxdqvJCD9PsKhaWKe3QDn/YzgC0ChzrYEU
	Gn3WhhTy3A=
X-Received: by 2002:a05:600c:4f92:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48a0f18edf7mr147574885e9.24.1776866641781;
        Wed, 22 Apr 2026 07:04:01 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu. [94.27.152.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489393ddd69sm64867095e9.10.2026.04.22.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:04:00 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: stable@vger.kernel.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Robert Garcia <rob_garcia@163.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 Robert Garcia <rob_garcia@163.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Date: Wed, 22 Apr 2026 16:03:59 +0200
Message-ID: <7260936.9J7NaK4W3v@timur-hyperion>
In-Reply-To: <20260417074010.1607496-1-rob_garcia@163.com>
References: <20260417074010.1607496-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240331-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,amd.com,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[amd.com,163.com,gmail.com,ffwll.ch,linuxfoundation.org,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timurkristof@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B8F9447186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

In my opinion, this BUG_ON should NOT be removed.

Using the CE was never well-supported by amdgpu and can lead to serious=20
issues, so we are planning to remove it entirely. Userspace isn't using it,=
 so=20
there is no loss of functionality here.

Mesa (the official userspace drivers) have never used CE and never will.

Best regards,
Timur

On Friday, April 17, 2026 9:40:10=E2=80=AFAM Central European Summer Time R=
obert=20
Garcia wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> [ Upstream commit 5d55ed19d4190d2c210ac05ac7a53f800a8c6fe5 ]
>=20
> Those can be triggered trivially by userspace.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [ Modified to gfx_v11_0.c only. ]
> Signed-off-by: Robert Garcia <rob_garcia@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c index 37f793f7d4d2..6e3a32779168
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5380,8 +5380,6 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct
> amdgpu_ring *ring, unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
>  	u32 header, control =3D 0;
>=20
> -	BUG_ON(ib->flags & AMDGPU_IB_FLAG_CE);
> -
>  	header =3D PACKET3(PACKET3_INDIRECT_BUFFER, 2);
>=20
>  	control |=3D ib->length_dw | (vmid << 24);





