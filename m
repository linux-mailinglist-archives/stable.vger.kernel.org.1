Return-Path: <stable+bounces-116429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D778A3625D
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3972616A7B8
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463D8267391;
	Fri, 14 Feb 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkmGpmH1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF9267387;
	Fri, 14 Feb 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548559; cv=none; b=RaKfRq9Cfr+3JtCurlnqGW4NvhSwhhA0nSuowQlbtZWm3ehv2aLXQ0iUsEgnCwj9pNX8Hr/q5jIxslRnwPMYCUcL12HEb2ytTSzZVcZnWEeryxZ0+zYZpJDvgS7TIGDHJS85dN79yRYkU06vzeVCub4xtSJsaAt9FNFkXP9G1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548559; c=relaxed/simple;
	bh=p/kPHut2qHfzfKzb7Xznt3VAJj0sGjrRew/U5IZb5kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTAL/X/kbquyamFS9f6h60/zGASpWLefiJkjEUf7sF2rMOOJCYG0D3pMTQWdw1MBJGiH+McHlqttC3ZLFExmLFqBIRwtdBBj+UncMMnQfLuHQpmoigxklWOjqCTKdze5HuXoyV9iGe1YnCpjAMVkHFKvZ7SK4B8zdHw+FBuSb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkmGpmH1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso23491215e9.2;
        Fri, 14 Feb 2025 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739548555; x=1740153355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BabzqMVj2y+OlBwwIhPLHmR51YcJ8bOgLXov4FeaX8M=;
        b=mkmGpmH109p1dW14LFwUHKOzdxAcdKYYZ9G2FUnODRNguguxxHj6kXw9punxyTUmcr
         R2MMns61Laf/diDdN+gTvP6AToPV/DEwmHxL6UpfRtSKtW0U17ydLbH00juUCKssCBdV
         bCIIxsEg4vfDw1uYMyki38gsdDZF9syg0RtWm3p/DU2ppZpotFyOPWo+vF+4jSeBqfSo
         artRNA7oUDymTJtZGJWfQWMf04pdSlEW3wTMIeovjzXB1Atf1csn+/stLuVaGGygivae
         UHFrpE5lxDYSOot3bZHL9+tiAsnurayoCJJWjt+pBLnWbJhD/zN2L35XmQFsBn8qY0F1
         0w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548555; x=1740153355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BabzqMVj2y+OlBwwIhPLHmR51YcJ8bOgLXov4FeaX8M=;
        b=hHhyQreGghRTM54ZyZ1DsjI314fvsbykshWIu2NUNqTwIeaXbC25R0BGUw7KME31P7
         m2qXPW4jzjH80P2FJH1Dlm/+rnUkMMGVCMVWOKjNcr1Ck2Q4gRgct1eGo9hUkXTn0Bzx
         ubsh695PP2TWxEJ55nWVIP2kb1LMnietiFfcGjM2/A8Wy1xY5yK9Wlrqns/D+AM6JRgE
         dE27OHLfZfqWu04RPJo+x2Ow/fCgDAC8H7FMScF9VeNyIstnLUYOh+Hz71w6m0kfP6We
         NW1rHwbgz0ClShZM9DpN+j5yAlgl8Ts9LZr7EvdIfP3/vOKWL1VJA/VRLkKkE5PsJHk1
         WNNA==
X-Forwarded-Encrypted: i=1; AJvYcCU2i9TV5ccUD3MIV27sgFEpBieqPnYBuNN1KtKFFsnLCnqPmOT4AOUjXOpIVnU18WJoohLTwK9CwcA=@vger.kernel.org, AJvYcCWxmoRt+wiqUkiFt845/CkSEMEUsG7s8ofcRwYy1zGWh9B2WuGfH12A7Fhj8mprdy4I0MmfncIN@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/0CP4D+T9ST4AJ85XFV7PSgdgiQ6nnZHdA8BdJ7C6AR/YQHy
	l0EJmJ1Qq5XgOW3fftgEJD7FB5xCjfVt/VzUrfPkHzP+59YRJ5b0
X-Gm-Gg: ASbGncuTKeZoCxCJmGnAOZzOmT/31FhjS/ptg82+P2KproKSa+Vw6rdXRDdeXunlhUk
	+GLNeVLw44J6ZSyX40OGzUQcDg4uU3PzF9euZYD2mxGphfWU7WW1edClV1OVw3Brrf0/yT62kpU
	xQLDIcK3UMoqf7tY+eFtt5Z41GGLwyutO+QQC+Wrvc4YnP7/7XMlH3RmqxUkJH9DeJ7FWQCHinC
	CC22pJiHkIvJFJ7qVEVpy2wm3gll2AuHrUpGhKIdXG8C1lrwIVDph/ld+ymowbV0QpL2Qzv5eHV
	FCYHQgEUtaIfNihJRIquSrK7PZeqTrgSoPOanwDwOFTSc1d2
X-Google-Smtp-Source: AGHT+IG9jRk9cmkBRz1ehmcym8NWsRSbA5wy5EE6+AQlwQIxNX7/S/c6g7lrbNl80HdHwNFwZDlONw==
X-Received: by 2002:a05:600c:5950:b0:439:5b4d:2b2e with SMTP id 5b1f17b1804b1-4395b4d2cfcmr115326695e9.19.1739548555157;
        Fri, 14 Feb 2025 07:55:55 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396180f199sm47311355e9.15.2025.02.14.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:55:54 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 6E025BE2EE7; Fri, 14 Feb 2025 16:55:53 +0100 (CET)
Date: Fri, 14 Feb 2025 16:55:53 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Forest <forestix@nom.one>, linux-usb@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke
 fastboot android bootloader utility
Message-ID: <Z69nif2-5Q5p8Wkv@eldamar.lan>
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net>
 <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
 <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net>
 <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
 <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net>
 <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
 <2tq7pj5g33d76j2uddbv5k8iiuakchso16@sonic.net>
 <ee229b33-2082-4e03-8f2b-df5b4a86a77d@linux.intel.com>
 <Z65U9rZrZUjofo02@eldamar.lan>
 <f2563e57-1982-4a64-a655-236dd4fff208@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2563e57-1982-4a64-a655-236dd4fff208@linux.intel.com>

Hi,

On Fri, Feb 14, 2025 at 02:29:29PM +0200, Mathias Nyman wrote:
> On 13.2.2025 22.24, Salvatore Bonaccorso wrote:
> > Hi Mathias,
> > 
> > On Wed, Jan 29, 2025 at 01:01:58PM +0200, Mathias Nyman wrote:
> > > On 24.1.2025 21.44, Forest wrote:
> > > > On Mon, 13 Jan 2025 17:05:09 +0200, Mathias Nyman wrote:
> > > > 
> > > > > I'd recommend a patch that permanently adds USB_QUIRK_NO_LPM for this device.
> > > > > Let me know if you want to submit it yourself, otherwise I can do it.
> > > > 
> > > > It looks like I can't contribute a patch after all, due to an issue with my
> > > > Signed-off-by signature.
> > > > 
> > > > So, can you take care of the quirk patch for this device?
> > > > 
> > > > Thank you.
> > > 
> > > Sure, I'll send it after rc1 is out next week
> > 
> > Not something superurgent, but wanted to ask is that still on your
> > radaar? I stumpled over it while looking at the current open bugs
> > reported in Debian, reminding me of https://bugs.debian.org/1091517
> 
> Yes, patch was here:
> https://lore.kernel.org/linux-usb/20250206151836.51742-1-mathias.nyman@linux.intel.com/
> 
> Greg applied it to his tree today:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-linus&id=159daf1258227f44b26b5d38f4aa8f37b8cca663

Thank you Matthias.

Regards,
Salvatore

