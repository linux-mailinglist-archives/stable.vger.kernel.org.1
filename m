Return-Path: <stable+bounces-231447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN5VHtXoy2myMQYAu9opvQ
	(envelope-from <stable+bounces-231447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:31:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961B36BB67
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA20C3046435
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C153F9F59;
	Tue, 31 Mar 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUdHl5Oi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79640FDB3
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970800; cv=none; b=s+uWet3IxRtJnbRsLeIxaFPHpwhAn/XpN8ySAl3XsfGISZ4W8CdAvb6kXp5fxf31KfyLwdqQQ3d3LAmazgHTDLuitz5A3hcolRiXzbeSgUNy7+qyaVzhFhArM9hHs4iTY+tpG/J34MlOb1VDnI6wnPZVn1IDwbtWfhPQL+zc/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970800; c=relaxed/simple;
	bh=2lcMVU8JNhR0Rzve2wLo96oqxT19Z5alWu7tDoe1xKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kre3BAc05S8y6znaP+2EHGiCeex7WqFCRtJPM10pxjh0Q29Q6OWSwrNpmr25tEpb8UAaOSbUUAFy6nRPJAI8AAsegccgqPSUcTdWyyLi9VlvhExyCVkhMr+4k/KwOeb4mdm8kUSTFTAB7QXz149rY+sTFc2qLn4qbpgLwxN2ntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUdHl5Oi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so2933830f8f.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774970797; x=1775575597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO5FPDdY/LQ+4ZadBlm+77MhRqH3b4TUifZXGA4guso=;
        b=FUdHl5OikCI/hacFGfex0H0mwCbAFtiTz04Y+tvRDzL+m92M7NQ35fH+kn1aZ65yXR
         e3pe6AQcxGomklpYfg7E7qfppqypETXtmAQOs6G9eIIIDCZOrPI9aH/r1cUPDmTDpOjQ
         uYoQmWtXb5dDISY/ygGV1hnx+taAG9qJyh4YY1T88HF6sTU7Vmw1U2Ya1syBTizDqBAW
         l4So11v4GQIkdLjDNxQ2aXP01AdkhOrFOM668F8qv4nD0NbTOJmSutHeVFTEKuJOo/hZ
         4FeG/+xFGLo/yn1BvVME8M5RlxONDutmHho0MVO0v90s8j117qy/g06Q6BeX0NxpeQqN
         0ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970797; x=1775575597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO5FPDdY/LQ+4ZadBlm+77MhRqH3b4TUifZXGA4guso=;
        b=EOdWSvgz5nHyXuVPpildv1dRp7aDZ1wLfdWbXoR61fm6JBvRXdJwu3sN/MHc1RrUyY
         oS/03R2pZ97GVMeSrhfPhp20EZ1xfXUAObM6yB3494SSF3Cgj73//udcKYaqXslnZNy6
         1BR7CABe3cE/Q6d8W/h4yty5AsPNCVDLXMeCCUEBIUBiFmAWG3o2YBeVq2Ns2HXOow+C
         acJHH4rNt5d4jf05VbjRw6JTnF4t0bhw8bkOCQL3H/voyy0PHwDORPZRCN67lnyFcF94
         60Bf6YWagsEphGDuYIYAa1DmaRuo9z+tzR9NAM3r6/cjzLaEHbhGeIKE6mpzq+sVV33e
         KGeg==
X-Forwarded-Encrypted: i=1; AJvYcCUW1PAX0b0lxnoYHwxUrC3toY6LnuMx2H3JsL1RpLfHlpJlBsLAkRQoyjCDFjAG7toDbTI8ZHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWuiBsK88cHsnj5jpuu5ZHkkWq0iQ7+K8HcBx+03BW9Gv71Jq
	dx7aChpr0FbNnnki58pq+e0Wn+FT/C+Q52JVGqsOBxoyrO6Nwz4QNkA3
X-Gm-Gg: ATEYQzzBj8jfTQ2Txe2rmw2IWb6bwlcvdS9zKLv4LoCmJjIeLwCDOQuwrtNwiqsBk5w
	PBTLjMm/KZl8l1rCBjRyLgBGG921TM9uz0m4iVmw08EEXNd6AOSYs7b521ctr4kR3ATp7JpQasV
	I8KzurT3kIhqS+FNuPelm+f9RcYWf6O4qxBbMEa2oLYfxoGYI8b1vvypxh3JfF7nZFei/yfYlCM
	mAL/S8Et2W0CCjRaOlKid196OERzrC0wr8Y+92s2Pq+4Bci91u7DEFx+4C9xrj4JVCIWyTGO+fl
	OClY3+xh2htrFJ5ajbT++RqV14LFtRRVzV375+nS6FaPZRLDD0mI0Yrdjgj94nXH0phlAoDXaX8
	JnyhHK0QzQ2Xm/Pfk6DIu/5K0pE1uCRdZeYg2ad70DbKlpeLFVqyzjryOod9Ds9GEgEwb6Ml/H/
	ca5zCsiByA++tbGoD38nehsp50d5PzG1XbJApbA1clML5BhEeMkjTB/szsj+A+
X-Received: by 2002:a05:6000:1a8c:b0:43b:43ae:8c2e with SMTP id ffacd0b85a97d-43d1512fc2amr5749f8f.51.1774970796917;
        Tue, 31 Mar 2026 08:26:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm29303248f8f.1.2026.03.31.08.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:26:36 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:26:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: Avoid risky abs() usage in
 iio_multiply_value()
Message-ID: <20260331162635.2d8c7f70@pumpkin>
In-Reply-To: <acuT8oTnaYujC0k6@ashevche-desk.local>
References: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
	<acuT8oTnaYujC0k6@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231447-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 1961B36BB67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 12:29:22 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 31, 2026 at 10:49:59AM +0200, Romain Gantois wrote:
> > iio_multiply_value() passes integers val and val2 directly to abs(). This
> > is problematic because if a signed argument to abs is the lowest value for
> > its type, then the result is undefined due to overflow.
> > 
> > Cast val and val2 to s64 before passing them to abs() to avoid this issue.  
> 
> ...
> 
> > Fixes: 0f85406bf830 ("iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()")  
> 
> Doesn't fix any know issue for now.
> 
> ...
> 
> > -		*result = multiplier * abs(val);
> > -		*result += div_s64(multiplier * abs(val2), denominator);
> > +		*result = multiplier * abs((s64)val);
> > +		*result += div_s64(multiplier * abs((s64)val2), denominator);  
> 
> Right, but here we get val and val2 from either static values from the driver
> (when it is SCALE channel), or when channel has PROCESSED support.
> In the latter one it might theoretically be possible to go till the INT_MIN,
> but practically I don't know how, except for the broken driver code in the
> first place. With that being said, I think it's better to validate somewhere
> the multipliers (when it's SCALE or PROCESSED channel). I also noted that
> for the _PROCESSED some drivers keep a garbage in val2. That probably needs
> to be addressed as well (exempli gratia: bmi270_read_raw() does that).
> 

I've just looked at the 'work of art' that is abs().
What is wrong with:
#define abs(x) (sizeof(x) == sizeof(long long) ? __abs(long long, x) : \
		__abs(int, x))
#define __abs(type, x) \
	({ type __abs_x = (x); __abs_x < 0 ? -__abs_x : __abs_x;})

It is just as broken for u128.
It will use the correct signedness for char (but it is unsigned now).
It doesn't cast back to char, but that is entirely pointless unless code
looks at the type of the expression, the return value itself is always
promoted to int before being used.

Actually replace the -__abs_x (UB for INT_MIN) with the safe:
	(unsigned type)-(__abs_x + 1) + 1
and the return type will be unsigned with a correct value for -INT_MIN.
(Oh and the compiler sees through the mess.)

	David


