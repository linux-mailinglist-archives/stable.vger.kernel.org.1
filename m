Return-Path: <stable+bounces-142085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA6AAE484
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A504E7FB7
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC028A417;
	Wed,  7 May 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMvmVCCn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B7289E3E;
	Wed,  7 May 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631410; cv=none; b=L7ZKoCEj1SGC/1DfYkEmnpjvDgrfK+o7HKwdNyNKrHiLbSJ3z4RtpSn6D0Z3jTEFpvws49PD7AV0ukNKHLJpap+P/CsVRAk394bftedmm0W7DScMkgHXG7BzL4Cqe1eEvG6bt476ukRSdMb//qYVvbM52HkaM/hCjKMg2ch1wxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631410; c=relaxed/simple;
	bh=h36C8gizKwyGSI3YJ2TR+N9OhKaR+u1FY/uS9APPblc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTHdbGeLjOOO89/hZay8muGTxL2GcQa1n1sayrKFJKjPv+gK8fPOSal6/rq2fSgLgOgV5sP4Ymcubpig48H2HISTLH6tv8wlO3/KbY7bh84jYOg0mtP9hzgslzrWGmSnYTAVIQ+ecq7K8wNuCFUwdIlWAGExeT00y6BQU0fXQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMvmVCCn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so14235941a12.1;
        Wed, 07 May 2025 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746631407; x=1747236207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu+V95WZmuevBWrYtl8nXKNY0WPBNalcqPNhN8Y1Gbc=;
        b=cMvmVCCn6KyilzSe5d8lfITUeUdKSpCTuFQhoOCc1Ay7gh3j1ys6db6MpBDh8Psb4v
         s5xXeTO0CGCpF8PdYE1QG6DTj3ZoGJmsuZDk344v4prz2Fy/5+eQRDmlToIhA9tWZlY0
         op+v7zldKxYkrmdo6Djs0SDZ8bg+GjhGVMcjuu+6OjNq2eu+FFonfF5wYDvGnjvXn8Rb
         Qv9m2YPjhqkIDHJZThj+zroR1ZOYnbZkUuHYU43AnXGIIx+OsXDbxgIVD8XoOJ7a8dLt
         N6iXEONtOAjnGxgeRMcRmp6VdaPD30K5MUVhlzor2JkgvhfuZwQsVRinJcXUvKGimFby
         rzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746631407; x=1747236207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu+V95WZmuevBWrYtl8nXKNY0WPBNalcqPNhN8Y1Gbc=;
        b=p8OVzzGUiMnywbBNpJYmdHiyh1a6IXp2Uvge8DczHQUVMnCafXEZVgCPmcfe/zTzXy
         tMod6i4PVekiZh2eZX+S6+i3GijX3nVnAoPOWdfgkZsk8O/twosLZuyf5FM69mbF8Ln+
         2xmWPYWhl43TyHu/F3G2m+8BdMnENMA/SH/E+8MiXvfx0nOgE+p/5rzW/fS/GYi+us86
         Ou2BO00W2Cp5rN6issRhl0txnr3b+xMLKnLIbn1+ZL0Uzj4xh8OuNo3ZjVcKjbM5j2js
         kYHtK6rxiqMAIWFG7VlMEiLcWDB6JW8E1bD0FlQS5/T4A7nlXSdN52EcmpgdjYoDImtJ
         8aHA==
X-Forwarded-Encrypted: i=1; AJvYcCUxuJt2q7eAWN6+oZE4iUUik10TW2NiNOBftq9g14iIsszfMomErxC6rN+XWfdRSeKPJewPKMpr@vger.kernel.org, AJvYcCWDBGupNSm4ZzePu+5SW6v0CvRZ7OzOWw1irkQJocQdLz8Pp5flacEB+h/oyqXITj1qoJWwNQwG0E2bUvE=@vger.kernel.org, AJvYcCWidy56Wz367HMkziso8ajBy6ciIyyYIipQDTxRg7cufzmIn71jfz/tKDdIjBDUham7TJyD0xfXVHbRYnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsgn1IUveDTTYzH+eOCiElTT7QmfFzhXAbtf+oFwBJ1OGhI2wE
	HyR24oKGSwvzx52D75y/Vf/l0i+PItf0HlrV8IiSUpumXEhubEWTtQcY2g==
X-Gm-Gg: ASbGncvWhXPGLOCTOzz/qumhjZVdaKRbuQ1cY0o0yUGwkXKhuI9YqdsBVkv/cm5E0VT
	L0gtVVxmvE2veUDFh5OtXU6MTd/YcXiRckcv5X/FFJz1MFDB/89ZM3ZVnILEmfDlYYbI5eX7hde
	L2qk4W5CMi7pnNHBTjI53CkZckuVPdlOaXaI8UTRkqTF3d06DoYSBcehAXuUlEW1Di92bOC9HEz
	O2GSMTYAVPLEFKpHKmL72gQk5UuLc3WL6QN5N+nENhECF/+sSXtOV5gzLvwBgp09n0L8+FivESz
	Qih6K22ByAMcahJVvHtZDO5QI/RAPaOSLA9mSDugDksKZuHMlLlIwfdUKYR5hidDsbISYwHYNWk
	5OyPUbtR423Htor8DQgn2LUjUHOE=
X-Google-Smtp-Source: AGHT+IGjfHXnrpEUYevTUWlZNdlZY2K76cUxolllBKTvZC9lPWbiy+bz6X7MHwmtyPjAegiT6kqLtg==
X-Received: by 2002:a5d:5887:0:b0:3a0:9fe1:c298 with SMTP id ffacd0b85a97d-3a0b4a161b7mr3182648f8f.18.1746630987926;
        Wed, 07 May 2025 08:16:27 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0f125sm17160004f8f.72.2025.05.07.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:16:26 -0700 (PDT)
Date: Wed, 7 May 2025 17:16:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: webgeek1234@gmail.com
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/tegra: Assign plane type before registration
Message-ID: <6nnklsiik7cwgmul2ygy7zayenybarmikfgl2hogryo7r2vtd3@vgksl6swjrxm>
References: <20250421-tegra-drm-primary-v2-1-7f740c4c2121@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yzkzi6i556e7c47u"
Content-Disposition: inline
In-Reply-To: <20250421-tegra-drm-primary-v2-1-7f740c4c2121@gmail.com>


--yzkzi6i556e7c47u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/tegra: Assign plane type before registration
MIME-Version: 1.0

On Mon, Apr 21, 2025 at 11:13:05AM -0500, Aaron Kling via B4 Relay wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Changes to a plane's type after it has been registered aren't propagated
> to userspace automatically. This could possibly be achieved by updating
> the property, but since we can already determine which type this should
> be before the registration, passing in the right type from the start is
> a much better solution.
>=20
> Suggested-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Cc: stable@vger.kernel.org
> Fixes: 473079549f27 ("drm/tegra: dc: Add Tegra186 support")
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v2:
> - Fixed signoff in commit message
> - Added fixes to commit message
> - Link to v1: https://lore.kernel.org/r/20250419-tegra-drm-primary-v1-1-b=
91054fb413f@gmail.com
> ---
>  drivers/gpu/drm/tegra/dc.c  | 12 ++++++++----
>  drivers/gpu/drm/tegra/hub.c |  4 ++--
>  drivers/gpu/drm/tegra/hub.h |  3 ++-
>  3 files changed, 12 insertions(+), 7 deletions(-)

Applied to drm-misc-next, thanks.

Thierry

--yzkzi6i556e7c47u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbeUgACgkQ3SOs138+
s6E8shAAimUEuugWp3icnj7eXRj2vOg3BUz/p6I7LDUlHLc1/oumW7zSeXpRUMpb
o9tfQ7CDoApO3BOBxWjJh1g5Me8nKoQwWxANkJ0O/QGqYcKOdNaeeeHLjN3veQEe
E/LfkIpFTEuSIV56GypmQUjp10+lgU/BcgKu3uw8lEoHJdR8RYZqdtjpRRT3ey8D
pNMFQJ6CgruF5VqVSS1Z1xcE7hBTuLnqJmZ1w1v+r2klt3uiivpxE8zbOOiHjyoR
XERgg+wWM5MLVjRvPdkdNOXlOMO85quLmr8WeV0SE6plBOSQAETgqATj4BchuBkc
cvN1pYwtghCKLD/Z9xikAxxfh+p+W87+bZY4TUdr7QzQ62S7SyHKwye0ORtUdZnC
XP0+fHXVb2qOmSpGVtlP53MWGbLCVsy1vjb1sg1N/J5CIHprgTeGRWJVCqgUPjZS
jQLrKV3Y54MDV4XAA5HpzmbaFhABZ1H/PdAy08mwPsc/shHbD+p/6m26NR0elNRS
CaDicCDmX6oIE3sEYRBjKNcAkW9DqDrJWIaNH+qDpywO/JVa4Khb2W0CNyw4UY74
qY+YttsGD2/M6Ym3/yZRQ5zzgVn81nkD38RHIFQUvhgt0Moarp9zDMeBKBlHzjeG
L8A+IW7WldrGcxMDWkmXArTyZeSbkpnDGisHNvr/CbZ7PH9AsTg=
=NqSH
-----END PGP SIGNATURE-----

--yzkzi6i556e7c47u--

