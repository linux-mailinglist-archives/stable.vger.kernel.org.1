Return-Path: <stable+bounces-124643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8213A65484
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 15:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684FC170B9B
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E524BBEC;
	Mon, 17 Mar 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKvuc1Dr"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2B248896
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223331; cv=none; b=AO+Wo8TyQ3r0GBD4D+puyfe0MXpgXZCkoUesEyfWIJr6RIsT9JsYDyH5uqiFCY7yiCde0fPlhQxddoVw90BMcNl6A7UBrwscvORcmDLFPx0d0e2sZfOIqSXHh1HhRY/qxAn+179q6PiD0RylEiSU8uDTviffRTfarwVelBtHV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223331; c=relaxed/simple;
	bh=17UdANjAVTcelMOQ4DNlejZ2Ce9FcJpH2K+ozwWVPTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIny8hZj3E0Kru549vaf/IyGUyra3eivLnrz17sYydUY/332KkB8JawqzmkNMQtZKy7gLSPdM84HN9hcwczbeiPgB1IB8rj/Nmsi3QCosLxV7kmNlz6QFBciOQ7RG0aCcb0/h9Jrld5X6PGMnfaGQ/pYR1+usAulx14jxPuTyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKvuc1Dr; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f682a2c3c8so2585722b6e.1
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742223327; x=1742828127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jNzh4wPsc/2+sERlQmcDT54HRK5zRLKBArFjwQQ8DQ=;
        b=kKvuc1DryQCbSVaBGLaDhiimzifPA1/+vWy5Oidkrz6z37iZQfnZhJR5IksOTb6bL7
         toTwPj10SzvDwgmRUHhOlYXCJkfenGjgr61NjdUH4Fft6zEhNIRV4U0NmYNzmA6eptYP
         ZkbtLa+0hyJEqzZqMM6dhXqfO3CH7gtQqx0lzVhIugTZc7jW+5z/r73CXfNwnmrmOitH
         dykwAqTiUn6wv1eBlpWafYpH+qeiSlfouu+rQpdIFP4DFC5sXI+k0BhJ+RS3O2LjlhxK
         oUZGPAL900MWZiRBKBGSFKDeHp1lfq1aHNNvtU7hhj9pSyXVhgHNlj5VMQRUe7UHY0Do
         0ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223327; x=1742828127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jNzh4wPsc/2+sERlQmcDT54HRK5zRLKBArFjwQQ8DQ=;
        b=saSh5j3hf9X3eDL5De3T7Y0A0h7iU2mTqKVi38Ixm+qDRt78Bs4d/SPPW8MjZOukw/
         AUSQH/kIIU0yLac5GQCeywaU4VurfzFuGdQXjrnBv0SxOA27nn0BXQHIpukPd5MQc5Ag
         CHbd6xoqga6ArcLSWLCLjTAtq35sD98EZC8PCVLCdp6yAz/eZBENSDCrqkbYf/XfY9DJ
         xoWuaVo/Y7l7wFvC88yEF96LekNt/RQvyIHSSxm3Gmage7ooSRyOV/0VLOHpLvlUULMS
         ETozdDuWfS1h4zSvUsWYfzLvNBZqbc9s43I8MaAz2i2l86OpYGbRyLwCF5J8P/ykQEkq
         NTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzLHQItwysGU3TDMSHpOBH0Wj/rRLevuoRTY6+LZJUA9VyhokV6EmQJfOKQ92N2DGNpwmF0Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8Uk89nxsVAfZSZhyIew2MXtnY9Xq6mdv17fcw37B60s/6wgr
	F/JXt+rYw9cSYJpnZX2dVBZzVbHTc4YHjgmB4D7g6yVWw4JzrdJ39carKQKNzg4MyioPYOW5Z1K
	mcWhf4S3G1K7/4k27FaR0b5k2LRjmRqf8j+UdoQ==
X-Gm-Gg: ASbGncuLJalElljfinzz4P9Z9ELHkCi4ffnWx6YkeSoBetGeynkDjN3SzMxqyb84+fD
	NIcvV0xX5MRTgtW0ZyGiOBXfCS9PUNRky0+JU8praVxHgq6+dhM5B+CjBEBohhNUZ2zE8s/O2O3
	bbeueECitug1ZTntdWPFFu//wYazPlXQvJJzOoTu4=
X-Google-Smtp-Source: AGHT+IG7IjY16t5eI+Uq4mhx6crav2fOJBQfWeSG630jb10M49QIM1vSar09EM0x1tUf2BaE+e0vaoly2VXwdW756V0=
X-Received: by 2002:a05:6808:999:b0:3fa:c549:cfee with SMTP id
 5614622812f47-3fdee27903emr4770583b6e.6.1742223327241; Mon, 17 Mar 2025
 07:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
 <20250314-ufs-dma-coherent-v1-2-bdf9f9be2919@linaro.org> <931e5e0b07d598912712b091d99a636b796fe19f.camel@linaro.org>
In-Reply-To: <931e5e0b07d598912712b091d99a636b796fe19f.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 17 Mar 2025 14:55:15 +0000
X-Gm-Features: AQ5f1Jq4uxqhD4QuKFFVh-mTPnz4ZIKWFOQ5G2m93FuUYrfiK5B9xukpdzF4pCI
Message-ID: <CADrjBPoESd7D4H80prCtFXTGaWOg-HV_ovNdwZ4G7Y8n-hFdsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: ufs: dt-bindings: exynos: add dma-coherent
 property for gs101
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	kernel-team@android.com, willmcvicker@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9

On Fri, 14 Mar 2025 at 15:59, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Hi Pete,
>
> On Fri, 2025-03-14 at 15:38 +0000, Peter Griffin wrote:
> > dma-coherent property is required for gs101 as ufs-exynos enables
> > sharability.
> >
> > Fixes: 438e23b61cd4 ("scsi: ufs: dt-bindings: exynos: Add gs101 compati=
ble")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.y=
aml b/Documentation/devicetree/bindings/ufs/samsung,exynos-
> > ufs.yaml
> > index 720879820f6616a30cae2db3d4d2d22e847666c4..5dbb7f6a8c354b82685c521=
e70655e106f702a8d 100644
> > --- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> > @@ -96,6 +96,8 @@ allOf:
> >          clock-names:
> >            minItems: 6
> >
> > +        dma-coherent: true
> > +
>
> This is allowed globally already in this file. Did you meant to make it '=
required'?

I hadn't noticed it was already handled further up in the yaml. In
which case this patch can be dropped entirely.

Thanks,

Peter

