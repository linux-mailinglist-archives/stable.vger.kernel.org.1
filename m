Return-Path: <stable+bounces-183452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8005BBBEA40
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4909E3A1322
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3482DC780;
	Mon,  6 Oct 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK4m8H8d"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED72DC77A
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767919; cv=none; b=UC4tkHuRkFLLNPLuNR/l+gGd1jcLkcAew2yUtYy/BjSPg8T0rkzneOKZ1ESsN15SWq0cDuQeKOW8XA0wzK3Q3FmAp4hWLWidoZ/rbdFg7vuAraQwjDwTmzr6SWsm9zfIUWFMRdXbQo7pzhFlq0Emj3GC1qL7ZWCvOmOqUcM62Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767919; c=relaxed/simple;
	bh=jBYax2wAYW+F+axem1AqE4EDxeEWy61Irb34BoS1Eyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CJR8gTfN3PSo+TLfxMn/rPBKYigk1rO3VS/aluadmDEWSH27GZRj3S5+/ig1uQhOnFnTd3xeYPHlhe4qNnKu9NVJ3ag+FpF2WcbZ8dNEyPFdImJ035r6KsJ/pXRabsRMtpvONlHi5zM+nxendUA7CKyZstAoLbE8R9Qxh8s/M5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK4m8H8d; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so3054616f8f.0
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759767915; x=1760372715; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBYax2wAYW+F+axem1AqE4EDxeEWy61Irb34BoS1Eyo=;
        b=LK4m8H8dwbfiPLbMBKsVX8DTeVbSejqkkJFic6IvuyPAL6ApivDZFBANcGCUg8SYIt
         3+VCnKUBnWjKICnwIt01QHxLLr4eJ3Puv9okmbOLWzItN4uebONoZ1R3HuV21tdSQ/6+
         10i5km1QOOY9RZ1owCARag78FfCtOERhTf8j0M6psSCFsuyhaDQbedMFLZ+GxsS7lcId
         5GeZhYRDEz2sIcRJc+Xo0yVx2qmwWbePWWjFQashAlEVAgjou28HYP/4doxUddSvpEaZ
         egA62hIIMdxLpfvGQJ49uO2VXWkY49o7z4+iBUIbFKs0wGoBhFWv9qWgtioih0AsyNjt
         pcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767915; x=1760372715;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBYax2wAYW+F+axem1AqE4EDxeEWy61Irb34BoS1Eyo=;
        b=c6lVJ2LLtpM/1633UynXGAW0Q7YGunNbie+kXnjM/tcMrS1n1jOkQ8rSm5ukUlb6Z4
         9fSlimVwLnUCgqdsbH9ogQOJxVdTvG/0v0IqwJPmxnXLQWoHTuF0Qut76hI3Imv6GNxe
         xW4O++h8ob0um/EJ+rsv7rw5YsRN4B0ygSKg4YlwNl7iGCXEeBa9tj6wW+OrsWgwzNVr
         bkfe44aAMMGag9tgOZGnGnl/SkFgNOItIw03JuQ8Azpl2xVxTggcowXsuViYf8hL5BGK
         BLc5Lv4r+y/ChqO+BxpqgztMsOe48ZhGy0Y9C9kYdWQe1k2mBp4GvKIaur+ZOpuYFX6K
         LosQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTrLnem5mn9ozpZ8JLbXORp02lVflMOSduMjYqunNUgFR0yG7XGEbMV4U4zlMa97AUpIDCF3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5Xxp0ittxZcUyBxt1zWZzPeJdfHA/1nW5CzyWjJfZlic6VbF
	PwtmKSE71UZI38m2VviAwAypWSwq3O3EJn1bL53EQrj1KibSpG1tJK23
X-Gm-Gg: ASbGncuSc/QFOhVwqYMAjgE9Opj8mSWkAUCOCpwC/VRt/vA16auQKHuDYo/b/LM9sfg
	P7gd7HwOFORaPZo2JSxt3fLxgEA25rLcbt2DyIQQs1TVqZ2FPgbgxYOLwwxbIEfI4dZ+RnmPvUS
	Y6R3v+m3AClgYPV+sGygdAIffCaAxCDuRLGjm9B/3O4Q92VTqxFwSkbCVKewxoQUiVZZpT/8PtZ
	eWIE+G9o0Xqi8CCJQwDkILypIqLDAppekr/czU4S9op/6+tAbHW1UM3okQm7MTeF++/GLnNE2tw
	eUzzohxX33ZBnm2D8xr2uE4ZjYUCtrBXUUoTti4Lkw7B22vzqNBXLb4+PtsgArkO5WZ8oKW5yvJ
	IlJM7rIX+h8kjf7A+G9wdfOqyNfzi0lalCQlMF3kpiu5AEpUY/WHT5Pk=
X-Google-Smtp-Source: AGHT+IG2xrQKr0WMPxw//a+T9W1FJSFFpq+oFwpBvL4mODap+XSIH58WzexWACPYCKiXtle2wPVJUw==
X-Received: by 2002:a05:6000:2386:b0:3ee:1357:e191 with SMTP id ffacd0b85a97d-425671a92f2mr7017976f8f.30.1759767915344;
        Mon, 06 Oct 2025 09:25:15 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0853sm21919779f8f.50.2025.10.06.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:25:15 -0700 (PDT)
Message-ID: <2fe00df37ad75591e437813f1c618c3decbdf2cb.camel@gmail.com>
Subject: Re: [PATCH v2 0/3] iio: buffer: Fix DMABUF mapping in some systems
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 06 Oct 2025 17:25:45 +0100
In-Reply-To: <7eeb3072-b54e-46c7-9fb2-c4d2422188d8@baylibre.com>
References: 
	<20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
	 <7eeb3072-b54e-46c7-9fb2-c4d2422188d8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 11:18 -0500, David Lechner wrote:
> On 10/6/25 11:06 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > This series fixes an issue with DMABUF support in the IIO subsystem whe=
re
> > the wrong DMA device could be used for buffer mapping operations. This
> > becomes critical on systems like Xilinx/AMD ZynqMP Ultrascale where mem=
ory
> > can be mapped above the 32-bit address range.
> >=20
> > Problem:
> > --------
> > The current IIO DMABUF implementation assumes it can use the parent dev=
ice
> > of the IIO device for DMA operations. However, this device may not have
> > the appropriate DMA mask configuration for accessing high memory addres=
ses.
> > On systems where memory is mapped above 32-bits, this leads to the use =
of
> > bounce buffers through swiotlb, significantly impacting performance.
> >=20
> > Solution:
> > ---------
> > This series introduces a new .get_dma_dev() callback in the buffer acce=
ss
> > functions that allows buffer implementations to specify the correct DMA
> > device that should be used for DMABUF operations. The DMA buffer
> > infrastructure implements this callback to return the device that actua=
lly
> > owns the DMA channel, ensuring proper memory mapping without bounce buf=
fers.
> >=20
> > Changes:
> > --------
> > 1. Add .get_dma_dev() callback to iio_buffer_access_funcs and update co=
re
> > =C2=A0=C2=A0 DMABUF code to use it when available
> > 2. Implement the callback in the DMA buffer infrastructure
> > 3. Wire up the callback in the dmaengine buffer implementation
> >=20
> > This ensures that DMABUF operations use the device with the correct DMA
> > configuration, eliminating unnecessary bounce buffer usage and improvin=
g
> > performance on high-memory systems.
> >=20
> > (AI generated cover. I would not be this formal but I guess is not
> > that bad :))
> >=20
> > ---
> > Changes in v2:
> > - Dropped Fixes tags on the first two patches and Cc stable them instea=
d
> > =C2=A0 (as prerequisites for the third patch).=20
> > - Link to v1:
> > https://lore.kernel.org/r/20251002-fix-iio-dmabuf-get-dma-device-v1-0-c=
1c9945029d0@analog.com
>=20
> Did you not care for my other suggestions in v1?

Completely missed them, sorry! I kind of stop reading in the stable stuff. =
I'm
ok with the helper function. For the clarification I feel it's redundant. T=
he
field is called .get_dma_dev() and the description "called to get the DMA
channel associated with this buffer" already implies is for DMA buffer. Sam=
e as
ops like .enqueue_dmabuf().

- Nuno S=C3=A1

