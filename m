Return-Path: <stable+bounces-46077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826588CE76F
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121CC1F211D4
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67812CDB2;
	Fri, 24 May 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpPwofG2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB212CDB6
	for <stable@vger.kernel.org>; Fri, 24 May 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562589; cv=none; b=ZZD2H7VsUf+AoUj/ZZViyYsYPmLiQJSBwO5vb32ZnMR8CnCKABXlNMNkorh4o8cUsnRJU6YmPj272RUVmYa88DoLlZ8ChZDEEaHhVYcd0FBCwEbnTwdorBUaHZCbtGOKouOk6TyD9voNj8vxKQy7xkypz0zDRfkcobQg5oqY2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562589; c=relaxed/simple;
	bh=OYw8Cg1eCDv4d2lRRfYHRk0lfNtBpolIkz/iSx2vZqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLfz19KaXYzJd+Z9r8JzmQfYlynzpTag9BP/oIvWwSFC84SLJ/+zpyNapJB3UtJMGDcBoiUjcY5aoSgaG1dMd3JcQBNV49ukUxAsQn/hLDhSgJ31Nj0K5nVecKAIVeDfX5O4XzoKYzUBhzOz+chfdV5WwNQrvk1UpjrW06+Bt68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NpPwofG2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-420180b59b7so31134655e9.0
        for <stable@vger.kernel.org>; Fri, 24 May 2024 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716562586; x=1717167386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFd4NSwhfGGM0dkHfawikZtgqzn4xojK3Pqv6CdYZAo=;
        b=NpPwofG2YFaIMPOzgmeWLIZcM84n/mpwjjXkpYeeSfe8k96Cmvqsi3ruBpQghEd9Nz
         ZgZLop6umYPTQFhfunXW0JumlW1XeURH1wRC6XcapR2RvnS7mal1TJThzMSocwDuVTuO
         I4oyL8f9dBCgEWNzNbndfwktCXBsUhRRvT7QZcFVzxNm9FT8KJkQAC1IOiLf0fpKqfrR
         bkEt7L5gTw74PcU8Ojc/jzwedVwcDfNY8SFH9T+Q3I2qdxeqyNTK+EYSmu5564iVXQLj
         i6v2cjd5zLKI3URicA6lgNV2BmIpQE2BphgRBbG/FzhNv2uWQOtikFUHGiWjHneGWSer
         eBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562586; x=1717167386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFd4NSwhfGGM0dkHfawikZtgqzn4xojK3Pqv6CdYZAo=;
        b=bWdkRKD2tw8kUwwpe6yqEfnCdpfzwOZu81S32PL7qYjPFX4lceRsq06Wr8SVbCIIGv
         cNxOjLq/9JPChGu+D/wPEV/X59IE+sGBxP4+pGBsphHETHmBveyUCyZXuqi0duZ6gp+V
         A6NdRhpN0x+wskk0O51kzJKPlIkA2B8X9MWpOzCJMfS6/bt4lyzG5+vT9rwWeG4yB9HJ
         2SKjYU9jL4bcHhZQLmZ+aNRs6UXRQybxekvMPyy6G5AyZdILJbDQQLH/dqiPy0SkpPtK
         XukqsdLHWLedT2k/u86t1XwwV/f+DWpQMsS2AA6tRC8FfC5tbK3/0oiPPmWl7Wi+Olk2
         qRUA==
X-Forwarded-Encrypted: i=1; AJvYcCUQrfiGCfxby4cZOhMWz6nWrC4CVc0T3B/P0tyD+pQeJ8ZThvMLBLLQ3uLVArV8npVoUvxFc484AJD/uP2fn+Xbyb0R1r4E
X-Gm-Message-State: AOJu0YyEgGOndZo1H44KyQvRl15sDYQYnUbjURmSWRfbc3kVT0FFCXWy
	WMAZlQ0Sj/HR++RIS3fGc01fpYo3Wlbn5/4yQ7p4R56u+Ci6xLqGpEPIXc5Cp8o=
X-Google-Smtp-Source: AGHT+IFzhnwidECh45iEEjkgcSjoxnXJokt/Bwq6KmtAyfAEk5qpNjP3Kf0y8Ah4BCe9mjKHHw/9IA==
X-Received: by 2002:a05:600c:6b04:b0:41f:f053:edb4 with SMTP id 5b1f17b1804b1-421089ebea3mr21345815e9.23.1716562585592;
        Fri, 24 May 2024 07:56:25 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fc82c4e0sm74313045e9.0.2024.05.24.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:56:25 -0700 (PDT)
Date: Fri, 24 May 2024 17:56:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: [PATCH v3 2/7] PCI: xilinx-nwl: Fix off-by-one in IRQ handler
Message-ID: <c2e1d87c-14e2-4efd-a5cd-f173b52dad35@moroto.mountain>
References: <20240522222834.GA101664@bhelgaas>
 <9299ee92-a32b-4b82-aa37-c7087a5c1376@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9299ee92-a32b-4b82-aa37-c7087a5c1376@linux.dev>

On Thu, May 23, 2024 at 11:21:52AM -0400, Sean Anderson wrote:
> On 5/22/24 18:28, Bjorn Helgaas wrote:
> > On Mon, May 20, 2024 at 10:53:57AM -0400, Sean Anderson wrote:
> >> MSGF_LEG_MASK is laid out with INTA in bit 0, INTB in bit 1, INTC in bit
> >> 2, and INTD in bit 3. Hardware IRQ numbers start at 0, and we register
> >> PCI_NUM_INTX irqs. So to enable INTA (aka hwirq 0) we should set bit 0.
> >> Remove the subtraction of one. This fixes the following UBSAN error:
> > 
> > Thanks for these details!
> > 
> > I guess UBSAN == "undefined behavior sanitizer", right?  That sounds
> > like an easy way to find this but not the way users are likely to find
> > it.
> 
> It's pretty likely they will find it this way, since I found it this way
> and no one else had ;)
> 
> > I assume users would notice spurious and missing interrupts, e.g.,
> > a driver that tried to enable INTB would have actually enabled INTA,
> > so we'd see spurious INTA interrupts and the driver would never see
> > the INTB it expected.
> > 
> > And a driver that tried to enable INTA would never see that interrupt,
> > and we might not set any bit in MSGF_LEG_MASK?
> 
> And yes, this would manifest as INTx interrupts being broken.
> 

It's so weird that it's been broken for seven years and no one reported
it.  :/

regards,
dan carpenter


