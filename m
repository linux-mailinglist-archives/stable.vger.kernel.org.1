Return-Path: <stable+bounces-135195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3587A97888
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 23:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7021189F6B0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F22D29C4;
	Tue, 22 Apr 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="Zj90dd+H"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896EB29CB50
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357388; cv=none; b=tXB0oVrJM52qoq9oZkHW4sYmFb30Y5OwpZtOSznVA59cMA9Z+a0+AFZQGSvLe443l8NELIj7vEPfRO9SHNfrCSqfyuqKg7V5QUKKtyhWz/xZ9zyDEtsD1sAY58L84lamgwGfIGKYGf5M3AjD0yX8SZTW2IbwUTGaaUItRXM6Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357388; c=relaxed/simple;
	bh=EKtCtAuhLcs4sGX+RF26ap3SrjbSFFY5SSfTUUZu/ek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nbarmG45qCuh9DHZlV8/5e3JxrMBywSf3e3E+f4fAdxqf3NzCYAPXYJ5J0W9ohfrX0eXadCRgSg1DB3Bk+NxzN/NZbsx/+uSDknjCk7ziuEmEG3XDoiaiMCfmNaJd7PJkjN8WMC2SRUyWP5yakxkHZvxYUvBxXrxNtUlT1AFDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=Zj90dd+H; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c08fc20194so326187685a.2
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1745357384; x=1745962184; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bQ7hnAfM9mT8cvOTYYkSndmUDqaTFrAy5uSIolG4TJ8=;
        b=Zj90dd+H+e+sogdtpZsAG7IVmpbyXFndkwAiq/Y0J5yq4w20J2oYrAcCZq6JxbCmRv
         AfAQdevlDrhX1vXEXPaC2mGmgzsgT3ZXh9/HwCxSsFLTR+/NA1brpRI5m7S/kS06xjG+
         ZuuBd6Lnv/N6BGSB6NSPXRLaM0Rl3KdJMEB5KiAykt2XSozRtkpwGr4v5B+CDbgNpiM+
         bbXR8nloCl0Ad4hO0JMgUaGENI1pOOD2Vc6bZGz1r8CB8tYyDR4Qt1P1SquuWFKg+seg
         mbVcC9z8DfIEVtnS53GKABOViDNFR/pgpkwMCF0N9bHilfmskOzT2yVMgY3cpi3B9daS
         8dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745357384; x=1745962184;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQ7hnAfM9mT8cvOTYYkSndmUDqaTFrAy5uSIolG4TJ8=;
        b=ofoQkFzQwHaAVa8ouWbpu9UTUTksjCeyGcnNRyMiiGdEIFjFwNFFQaV1wJRvomyWbp
         XI4X6UUvyneoiqc2lsbdrMD0ekXJoj1UDWitJP4MIFWsGtcCB7OFo5inuw/NtO4aEV+h
         UBUzEFOUh+S1HuAgt5ue244WVVHumm6W1IrVPtfeTBxDxvSWXcTGbzTjXkkqm/wOd6Bn
         u2m6BDG8eBX9ssOzdqmkDgp33FiKi3gsVv4w/vm39xjzai9mF3c6tHPjuO2xI2E7K5+7
         qOqNeaJquGNE/9YdBRVt9ZqVI8ymIGt8W2jCK8KayJpJi3ZWvX0jt5gu8cGPhdWt4DPA
         Us+w==
X-Forwarded-Encrypted: i=1; AJvYcCXPhjF+zUweJjpG/P8lkaBqsWaV7WYklDtOmefaoPczbfAihe63GJshpRWXdKFxFxFJXYG1MR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDspculGLm37/Cox2gHRwYp+LTYzLZAlshQhUA3ob3hrJj6Kw
	NL0SKdInG2r0KneXHsbur8EGAxQwxmspWdgIlEHi5HoJETsDqMZ7G24dmDY446g=
X-Gm-Gg: ASbGncspbAD/R7PVWg/yH6l4GC6g/c8SCdsCEhI26nQE/bu4zwNKCTgaE9Y7S/MjzFS
	lfEaWFwZILb6pwlB4u1UZW9R2MjPlxiIgUSlZPVi5dW8c9/+gXf2jl1BUxoXcz1g/Swxq5MCi0V
	7YVDswzPp5b7RycoLzMVzPaQfk/6veJUN39Z6NOPcyRArvMNI1wxjAOKW5UueDqaeBGy2SLT8LC
	GvbvJVeypVsjqDmMy8r5AYRagPw3JXFJxcpFo/RJS4KafO/XOlbKbN2lXUBlqRHN6w+sV2IX9WO
	9EXbv6siAIREAPSlvVlm9srEZES5DAa3wFW/wMkpqHyghw==
X-Google-Smtp-Source: AGHT+IG+GFwZZxv704jjuJ+UMxKBzXxKfdBa96OxMVcUIavMW/wfmnEA6eFn6KpitkGT6G9+BB2t0g==
X-Received: by 2002:a05:620a:f15:b0:7c5:97ca:3ea0 with SMTP id af79cd13be357-7c927e365bamr2195214385a.0.1745357384440;
        Tue, 22 Apr 2025 14:29:44 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:9913::5ac? ([2606:6d00:15:9913::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b778c0sm601921985a.112.2025.04.22.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:29:44 -0700 (PDT)
Message-ID: <ac48df7034ce695363daae2e5d87e00d6d41b038.camel@ndufresne.ca>
Subject: Re: [PATCH] media: imagination: fix a potential memory leak in
 e5010_probe()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Haoxiang Li <haoxiang_li2024@163.com>, devarsht@ti.com,
 mchehab@kernel.org, 	hverkuil@xs4all.nl, d-huang@ti.com,
 benjamin.gaignard@collabora.com, 	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 22 Apr 2025 17:29:42 -0400
In-Reply-To: <20250226124922.3601755-1-haoxiang_li2024@163.com>
References: <20250226124922.3601755-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 (3.56.0-1.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mercredi 26 f=C3=A9vrier 2025 =C3=A0 20:49 +0800, Haoxiang Li a =C3=A9cr=
it=C2=A0:
> Add video_device_release() to release the memory allocated by
> video_device_alloc() if something goes wrong.
>=20
> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/platform/imagination/e5010-jpeg-enc.c | 9 +++++++--
> =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/driver=
s/media/platform/imagination/e5010-jpeg-enc.c
> index c194f830577f..53e501b5ac0a 100644
> --- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
> +++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> @@ -1057,8 +1057,11 @@ static int e5010_probe(struct platform_device *pde=
v)
> =C2=A0	e5010->vdev->lock =3D &e5010->mutex;
> =C2=A0
> =C2=A0	ret =3D v4l2_device_register(dev, &e5010->v4l2_dev);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to register v4l2 device\n");
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to register v4l2 device\n");
> +		goto fail_after_video_device_alloc;
> +	}
> +
> =C2=A0
> =C2=A0	e5010->m2m_dev =3D v4l2_m2m_init(&e5010_m2m_ops);
> =C2=A0	if (IS_ERR(e5010->m2m_dev)) {
> @@ -1118,6 +1121,8 @@ static int e5010_probe(struct platform_device *pdev=
)
> =C2=A0	v4l2_m2m_release(e5010->m2m_dev);
> =C2=A0fail_after_v4l2_register:
> =C2=A0	v4l2_device_unregister(&e5010->v4l2_dev);
> +fail_after_video_device_alloc:
> +	video_device_release(e5010->vdev);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0

