Return-Path: <stable+bounces-143078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E0DAB218E
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 08:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6373B5BB2
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE61DF277;
	Sat, 10 May 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVXIBFaN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8042E401
	for <stable@vger.kernel.org>; Sat, 10 May 2025 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746858697; cv=none; b=KWpyjHsa9D9Tu3FldkWnZ3mkS++e1NdtaNHHJQ6hpNJIBnX/ghGzsAAl4FQFKZZkdsnqmWiaCV8+FAwjEpNZzvJf2QT8/hdCcvt1ok8V8Xl6FlLdrrmrvU+b22+IyW4Y3FF2W5DPFD689tix5bJXqgaAozovNGXsvTFfmvUR2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746858697; c=relaxed/simple;
	bh=/CUWNCKJLlL2ZUz9MqaxNPY5UPyrCzuEVCDqSKKaiwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1aSyl9jGEg9bISqhGMNPrUt/O3NfPrSTZE8Q9ExF3HbM6LZ+jVTBAUhKxR11Ed4FfHJ2Nt3fOSur//BSnvvK5qkYzNwJ00L4wE578tElrn9L4dvkV5WKcGX3M+tTbnTIN4Roi+THQv/rDuJB8kaWLyBqeW/LxOQVD9NegIpdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVXIBFaN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a1fa0d8884so764729f8f.3
        for <stable@vger.kernel.org>; Fri, 09 May 2025 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746858694; x=1747463494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=al12x7untsw9gT40SLDOdxEjze2k19FQIlHKuwT2kqQ=;
        b=MVXIBFaNTzcJH/anR5qym88MwkABM+Zj7KoL7uATZcH+BcrAecC9frL5VeS0sVdzdi
         hUJv3H9ojh1IGvebhzIZkbD1w/6ZixvlV4Qdke2ddT52SO8kUrjsCP0L+sbHUuMy8TPq
         OBLL8tROouoczzulH4wuBAmedzNO3y1XAiQes2ZVN4UmKsvhAns6yiyH9zNA5Y7xWcPy
         6NHTOR3EB4XXbB4UwUVIrXFzK2zEPnVyWg+8b/S3HHkmOxwDIHsLOIeJcExhv5WjdvEm
         2RcvTRvBZxupHzftBZLBo2042CXYaCwZXXcKWUj+CSvLlBgMUTBWrKI/zRN15cBJrU01
         Pl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746858694; x=1747463494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=al12x7untsw9gT40SLDOdxEjze2k19FQIlHKuwT2kqQ=;
        b=E3fV+QHcZjWcrTAD8v+aaBLE2BlkQ+ZcpS7FCxsmK/amiqKgx49iK4bFEh1iOIiUYQ
         BAmOooO007IerN8em2YkW+cDW0WIDJoIoHef+iq5MZW4OJzDyxwdyZo5IZ6uaNtLOfg8
         h3MRn6NF2VTP00Aq4hn7jQABv2ACJbPHEgNy1kFgUqi5Ur98jFN7WDloQDskOMQW4xsF
         gaJHsL8MVprSLx3bF8dKH/KRBedX02RdksLkd4RBh0EDz0xURfMTRfvNWOdkmaCZgEL+
         lGTWCAmjrl1MD4FMYcfIHuvCz0FFxP92h1OJcZ9uvsXSYFIOd8d/q0LHxI7K0zBw2YJi
         qw5A==
X-Forwarded-Encrypted: i=1; AJvYcCU4Jmw0aPBNJpkeWxLw3sq2+EpzN9YmCoheRKAtz5LyfhpWLcyHNjjKdPpQNy9ydHlwYakw2Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXMisFnkfxRYEoiJneXQs/98xjx9N6elVeXlviY+VMUTqSAma
	f+m98O/n0jEo4bVSDnY5mSyAO19q4AT86K9aT9SwzPusVAN/TXDDYOE4KZzyfA==
X-Gm-Gg: ASbGncuJSP0yCgTDF4tYSwAIJFCShSzP+JTjZVFBfmORTrUYsUzLFkj8CzFR3F34M0b
	Ch2Tv9olFyG/hS1dApoMR283kQgFQiiC6xCBAQ+nKZwh+UezCl4Og+/LPfTvISwhnQr5xHj1t/G
	xxYjQAgcdYl1y2msEr4w6M0fp86xk6Reado7As/mTjd0mZxGYDODN87k8V9WLkAnoQQZHa/Wvzm
	tD9eqEFsPOJ8MFYiDYV3mWGSSclGYMmpL5u1ai171t4gGSJjM//ZZVQV5kGmZlKfMEHwrc0QZpU
	bleaW482JRYZccGx6/JbxGcsMbu/UEzteqVTPBlshe+moMT8d1AhdHcFBow39zPb8HLp9pON5gE
	j7DHlKHh2+9Qat/rwIWboQbwOOmWQGujXNQ==
X-Google-Smtp-Source: AGHT+IETPcny+oJkB2S2QRPRO7MBeUeS+pHJgVEZyOPsrPJBO7sk8jq/SJTSNUR5nO2ekoZ3PrRZwg==
X-Received: by 2002:a05:6000:22ca:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-3a1f64b5c99mr4768988f8f.48.1746858693887;
        Fri, 09 May 2025 23:31:33 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c583sm5351182f8f.84.2025.05.09.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 23:31:33 -0700 (PDT)
Date: Sat, 10 May 2025 12:01:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 382/642] PCI/pwrctrl: Move
 pci_pwrctrl_unregister() to pci_destroy_dev()
Message-ID: <tfil3k6pjl5pvyu5hrhnoq7bleripyvdpcimuvjrvswpqrail3@65t65y2owbpw>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-382-sashal@kernel.org>
 <aBnDI_40fX7SM4tp@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBnDI_40fX7SM4tp@wunner.de>

On Tue, May 06, 2025 at 10:06:59AM +0200, Lukas Wunner wrote:
> On Mon, May 05, 2025 at 06:09:58PM -0400, Sasha Levin wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > [ Upstream commit 2d923930f2e3fe1ecf060169f57980da819a191f ]
> > 
> > The PCI core will try to access the devices even after pci_stop_dev()
> > for things like Data Object Exchange (DOE), ASPM, etc.
> > 
> > So, move pci_pwrctrl_unregister() to the near end of pci_destroy_dev()
> > to make sure that the devices are powered down only after the PCI core
> > is done with them.
> 
> The above was patch [2/5] in this series:
> 
> https://lore.kernel.org/r/20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org/
> 
> ... so I think the preceding patch [1/5] is a prerequisite and would
> need to be cherry-picked as well.  Upstream commit id is:
> 957f40d039a98d630146f74f94b3f60a40a449e4
> 

Yes, thanks for spotting it Lukas, appreciated!

> That said, I'm not sure this is really a fix that merits backporting
> to stable.  Mani may have more comments whether it makes sense.
> 

Both this commit and the one corresponding to patch 1/5 are not bug fixes that
warrants backporting. So please drop this one from the queue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

