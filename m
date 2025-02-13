Return-Path: <stable+bounces-116333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B9A34F4E
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE947A43C6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC5266181;
	Thu, 13 Feb 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk4xsaPI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94E24BBFC;
	Thu, 13 Feb 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478268; cv=none; b=srTlp6sqgBFgmPUEihXKjunpmT5lKAO0vXTBmKbC4QXxQ1lt/RlH5uB6RK0QUW4OwKF8BR2wwbITzK4Is0Dwx5hqyWJ08yYj8s3Txu+jeR3433/H6Ic4jxcOxbmDkc+xSPHVkWKFG6wk8VPi+PF6rvsh1oVvELxuCfYwyZPRW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478268; c=relaxed/simple;
	bh=lRoN299yI/fhws0lmPKx7+Fl34Rlx/oBOztj9Ak103A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKStWoMr0wwgo33/TypvfkJ7VYft+mrnhan97GrPMh45/764j1TMPQxsIsBiuZqLZSM9E0YOC1XWTXvgMI3SnqLeKICv+Pwm2RXms/KjxryQN5TTX6z0jvMaX3Ykbm1NbkLCR8+2/UVa1ymCwH2z6a9tGtL53jfZI8PanUC2IME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk4xsaPI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439585a067eso13786275e9.3;
        Thu, 13 Feb 2025 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739478265; x=1740083065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1p2D48k2Z+ZfCl15svcbQqI9e1in0l2JmLLcSGv3Uw=;
        b=Fk4xsaPIi/8hjqcd4ZAbtk3S7XlcqjUd+gM+9f6VU1dIsAFvf6SSETm5U/k4sRGrB3
         2Mo9lIC/WUHGntbZHEW+SOnWaZKwBFCJAbDpZL7bcu6NvyzCI53qxY+DMfv2C0eczwPe
         dFpPPpQbX0WKqjt/+ZqWpCj39kxXPPWsvQQOTvsN3zc2jb/VC5z0UFxPxukimK1IiLL8
         exMWFPeSmu25HHcQ0cto3AcG9Pa/VfvkT4VFk3NISKMCQYqWbNiw0lrWUC2hkrDK9t8R
         Am/pZk4Ks19nruZQF6IvNqZzZbvxak4reEsZlSiWQ60n6yna0p5W4J/GF+5GuqTtfqFZ
         XauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739478265; x=1740083065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1p2D48k2Z+ZfCl15svcbQqI9e1in0l2JmLLcSGv3Uw=;
        b=FEIfYMS2MRUFIqgr+Qgd20KtlnaKk9M/Mv8so6Kb1OTXgQgtwNgkEd049zUBEfqQUc
         GcpjWgsmYlwtBQLRQBCWfAsu0DODTiymCCFT/iM1eQTi8VS7+Et+3+hZZd9IX/kbT/0T
         x0Ppqm6Yg9w6J9sTrqCc7siIRNsNJKuIQIL1keOU2g9kL2By8nJhCz9w3gYQyjFpJOj/
         Uloeh4iMsoOK0y6wql94OYAb8Q/Wous2kuVaYghGlVPSyY+M8INAWXMNK/lWMVCrb5fi
         Exy98c1+3NTn+hSEzYEjiyAjALcQneH1k9RKX1lD8yWxxG24R3rdhu6W0Y7WG/k3RB4k
         Jzkw==
X-Forwarded-Encrypted: i=1; AJvYcCW+h1u28uxpTUVX5EgUpZeOB+OITWsBZou/ukwEqTeowR0jW/iC+jxnUGOSJcU7CqOSd2oxqaAE@vger.kernel.org, AJvYcCWyUE30pACj8SjCixRg/IDG5LtVwhlh8O0oNsJkIignHMCmG7tVKEVxQTowQuvzAgaYdGJP0alfwoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHstS6vaQBkVGmLl6e18AJK8NM3Qn8UcD0G8bCROCfeQtZi3aL
	dOSgQQg27thVoIvqpSlmuI+rH4RougoSyeATj5IxA3kRvO75o+GZ
X-Gm-Gg: ASbGnctzzfLWCiYDmzBpHrs6I28oAew32FzuUp+Alwv0KVkDNOMuvd4AXhEJ3/VXbEO
	Thfapsp2jpbnCBcHX2WRcoRGL3ODyur5eewsIVA4hQ6bv6zWr/7iOvYY25xNSsvI5/y+RVPeBaX
	h/DPzHw6GONgLALbpf/ngnUawijUoYYOzJ+XjIh7nN9LX/EkiAbQu4Jho0potNpaeEnFLy69SHv
	Y40McPFkg8YYCeBV0JU5yiGyogjTasYhbFLHpB8xxZ00nxoTZR7hLrpxkecitYNXZai6/EFSCZZ
	rpQwBF8u+aZ5wi+GXU6VVdUftOc5yzX1Svp+nHHHi7VvGJCa
X-Google-Smtp-Source: AGHT+IFqzGgXpVIXDzJc4C6VHeZK7VT63QgiIWVuvvjrGLY3MMZmxxatDJO1KlqdLNV06ScaVx7+YQ==
X-Received: by 2002:a5d:5885:0:b0:38f:23ed:2c7 with SMTP id ffacd0b85a97d-38f23ed03d1mr6353757f8f.14.1739478265010;
        Thu, 13 Feb 2025 12:24:25 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913eb6sm2778994f8f.51.2025.02.13.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:24:24 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8AC40BE2EE7; Thu, 13 Feb 2025 21:24:22 +0100 (CET)
Date: Thu, 13 Feb 2025 21:24:22 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Forest <forestix@nom.one>, linux-usb@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke
 fastboot android bootloader utility
Message-ID: <Z65U9rZrZUjofo02@eldamar.lan>
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net>
 <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
 <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net>
 <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
 <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net>
 <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
 <2tq7pj5g33d76j2uddbv5k8iiuakchso16@sonic.net>
 <ee229b33-2082-4e03-8f2b-df5b4a86a77d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee229b33-2082-4e03-8f2b-df5b4a86a77d@linux.intel.com>

Hi Mathias,

On Wed, Jan 29, 2025 at 01:01:58PM +0200, Mathias Nyman wrote:
> On 24.1.2025 21.44, Forest wrote:
> > On Mon, 13 Jan 2025 17:05:09 +0200, Mathias Nyman wrote:
> > 
> > > I'd recommend a patch that permanently adds USB_QUIRK_NO_LPM for this device.
> > > Let me know if you want to submit it yourself, otherwise I can do it.
> > 
> > It looks like I can't contribute a patch after all, due to an issue with my
> > Signed-off-by signature.
> > 
> > So, can you take care of the quirk patch for this device?
> > 
> > Thank you.
> 
> Sure, I'll send it after rc1 is out next week

Not something superurgent, but wanted to ask is that still on your
radaar? I stumpled over it while looking at the current open bugs
reported in Debian, reminding me of https://bugs.debian.org/1091517

Thanks for your work!

Regards,
Salvatore

