Return-Path: <stable+bounces-124457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD3A61590
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 17:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C4C3AFC37
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEFA202F64;
	Fri, 14 Mar 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbdD17BP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E09201032
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967989; cv=none; b=i/zHK/8Fyr8hhXREBjWs9rFX6z37vIwupCbt2htdmRO2lwOiE4CkPneOwpnIERSDOD1scHixQaF1ktjq6AHcnODZDlV4uNAUrcxctVsxegIS2W4FliDFL9V7y4OHN9IMPWDRTWoyGRZ6nbfueUBm60HQt82OfEbGRdxMAq/48Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967989; c=relaxed/simple;
	bh=qbAf7RLJv6RsTwMHx91Z6PJ5PYNVMVgiR3uOKlVTE8s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEJoRdKzGDALB3r7+ijqDq4xiEcD6ze2iDZTRxPcAOrAh3RoeasO3d7Y6xN6H31H74c6Y4gfQcJKvfPnmRMBJo55sGPlERWIXbVvBtoUSmDqI++Rgvxb54mBSKg4icdskrUeya5YmtQE8FqyoNRXk0wGvu9nUA6eOh9yxssfFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbdD17BP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso15875235e9.1
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741967985; x=1742572785; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qbAf7RLJv6RsTwMHx91Z6PJ5PYNVMVgiR3uOKlVTE8s=;
        b=pbdD17BPKnXsMKsBtrq1RoP+o6fqRqO8bb5yu7ddTufgEuzYwiuIDowaw7504uNHPb
         Wfd4KSKMBcZjA7vr/GwlLg3vyrgB3DDzphXemPHz6+1Hgah13e7Eoa24wka11cjXGp2g
         f1J861OMCg/JyjPY0RSm4tWuKsS0JcSCygPtLFJ+E+FJXhV8OkgpTkeWPNyvWUnSpZk5
         2mh+CitzJ3vUXhyhaSkLtIyDlXRe073Kuug7k8HwPyQrhS0+3DnGqkI1QXtap1VlAmnz
         V7B4aM6HX6hVGIIbROJuMM1pIUQGmGEirmEQJS8vG/bQI2XEbK799RoDOi+vxKmjP1VE
         CbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741967985; x=1742572785;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbAf7RLJv6RsTwMHx91Z6PJ5PYNVMVgiR3uOKlVTE8s=;
        b=SHws+FhuK8KO4PrMyQOyz+c/Mmym5ReRng39T9AomiB4/tVPVqK/pmtdfxJk1c//wi
         isEoB4b/I0Hf4HefzS9e32Dgh42OTXCmsZ1UU2kwn++0sOqXYUHhSRbhlsssn3QjLgGn
         xySbFZomrVj4hWJrND0Sf2w+X0Seh5yPZlbSoKBH5RGtl3PJBzoPfZmEL9nvAK5A25UT
         k7fWix0FbAFv3BVWQ1Lj5b2Ck0O/odiaFo3/Dexpzv0YhKtT8O3vpDSBDAyhYDeFJFsO
         MN0cwHEPDlHm3bFLh0NPBgfO0Ky2shNWhPG/gXp1OFwlyMCQMT+JXAsEGlbeK+kEJ9Dl
         PgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQLA4UWEE28ftsdB+zFO0fML2s1klLczZxs7fIJHlIJkBTiYRfl5GuvFwViC9HHQWoMHcKQDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOLCIL9UCkjJgbPWBVzBz59WAYUBf5hdEVBq6KNr6TH7IPsx6
	dj6GdELhwJDPut8RvjnfH8cL9LGfcyWiTzwbKqnLteqhGZ8SHDihWskbm1usjkQ=
X-Gm-Gg: ASbGnctPm0c57N1toFpU2MrDaCkr6jjFPdWiRGhN/5XGDYOzX3OzJ9N9YJOItSnQltw
	1kVWzdo1V4SCCtgFsXpy5omgcXRI+U4P8Mvl/UuvQsGXTTnNy3sxxz4pOSe9yULYhAIKvte8ImR
	+ri6WBG5tt9HnLhQWJaxJ0HnhFauXNQAjVEuXU9cU2APCa2l1Jse0kEWyD2H1PRZ6rIAbMRg3hf
	Kanw56JP2Q1b+o3ZYa3oveolDMxHXi+PuPw7QTEIXbTRIpmQgQEIqIvnUqeaN0pQPSVU0pSevv3
	pnDJ3jjTl/h/UdfX4gMwaBI9/egSNr432NJKBrSz0trEBxEO
X-Google-Smtp-Source: AGHT+IHxwHHx6Fb/u1dWZbQ1qTy60BcLwUz4P4SvmS/UEUbzjpP8/AFJeuPq9qAxmx2U4YpAhe3Dbw==
X-Received: by 2002:a05:600c:41d3:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-43d20e467c7mr27073105e9.19.1741967985037;
        Fri, 14 Mar 2025 08:59:45 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fac7asm21846905e9.28.2025.03.14.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:59:44 -0700 (PDT)
Message-ID: <931e5e0b07d598912712b091d99a636b796fe19f.camel@linaro.org>
Subject: Re: [PATCH 2/2] scsi: ufs: dt-bindings: exynos: add dma-coherent
 property for gs101
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim
 Akhtar	 <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart
 Van Assche	 <bvanassche@acm.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, 	stable@vger.kernel.org
Date: Fri, 14 Mar 2025 15:59:43 +0000
In-Reply-To: <20250314-ufs-dma-coherent-v1-2-bdf9f9be2919@linaro.org>
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
	 <20250314-ufs-dma-coherent-v1-2-bdf9f9be2919@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pete,

On Fri, 2025-03-14 at 15:38 +0000, Peter Griffin wrote:
> dma-coherent property is required for gs101 as ufs-exynos enables
> sharability.
>=20
> Fixes: 438e23b61cd4 ("scsi: ufs: dt-bindings: exynos: Add gs101 compatibl=
e")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> =C2=A0Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 2 +=
+
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yam=
l b/Documentation/devicetree/bindings/ufs/samsung,exynos-
> ufs.yaml
> index 720879820f6616a30cae2db3d4d2d22e847666c4..5dbb7f6a8c354b82685c521e7=
0655e106f702a8d 100644
> --- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> @@ -96,6 +96,8 @@ allOf:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 6
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-coherent: true
> +

This is allowed globally already in this file. Did you meant to make it 're=
quired'?

Cheers,
Andre'

> =C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
>=20


