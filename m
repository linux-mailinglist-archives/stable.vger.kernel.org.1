Return-Path: <stable+bounces-179216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764C7B5204C
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 20:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A5A1C85513
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E02C21D9;
	Wed, 10 Sep 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kg1V77eU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742B2C3245
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529315; cv=none; b=lXZ8i7JGewX5GzXHHamckTe7vWJuzEWoBUq2jdZIjoHwJ/9AKqRxwtJUAlqg+434DfRDst9BFNxfkysoKN5uhcMZK+FZVQeJNaANshMgX0qNwWsK/9k5wrXvESpfLUlJn81UriWp+ITdPHoUtBq0h7IepDDCSNblNLGjxikoEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529315; c=relaxed/simple;
	bh=5lFys8BTPsGWhrt0SoMF130W3SY2Xb+sxr9D2suSUyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwlVj6/3LwQDEmKAO2oBohKAqsVOVoaHWdqahCohI4K8Ctzt+lOttADD8p8qY4b4J/xKpXDIsGYrJ/2bVB5wXp24H3lOA+K6MWMwYzcQ6UvOsFFP75q+DQmWtRoLTWOlfPwyVKO1CxU5rzfh5mMixBMHfKQZUiDPNGTFT5iz3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kg1V77eU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7742adc1f25so3639196b3a.2
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757529313; x=1758134113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtDjIHDTo3C1gWUX1+oDXMnJAa5/njN7fZggjarDkBw=;
        b=kg1V77eUf3SglXa4GCnEZsMPWXlf/ZxlggfSMwZms+pwhg4hxSeLb8sLPd24tU3iE9
         WicklG67Mo9PlxzU4USgoXTYzlGPWhhmSpR+uBoQMoN9TvMyqS23sdldsGVOMcjN6UZs
         qvEK7YnlAC80H/KqCUt8SUKZbmjH/uKb9+F8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757529313; x=1758134113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtDjIHDTo3C1gWUX1+oDXMnJAa5/njN7fZggjarDkBw=;
        b=oDkRhmOAGxzpstHgufSO36LC/ugqT8ZWqKN/0DXqDs2ROLKXZG//rFYVj5hXdn2Nzo
         GSSnz7znIO+vIxDIocb9OwVO0P2E7FiL4J/FmLVStcKrgUgTQ/EHlDt4PCPN70iONnH1
         WESFwCN5w6T7hC3X8Tz0cXS2nHi7Bo+f1QIUkWBxjtN5dcp1wOGePID7rZvXb7ii5xVK
         BSGwdjwt7HfKXCBEUZjUPuZqrbUCdf4aZSJ4+CgEy7ZrQCvYc4SmyyhfE90Lk5aKyNNc
         O4BR67Z9At5LU9FNCWty8ajq4Im807/wYC5aUSP68LqQCLEuL2AYrldguBLHDBDUVw1Z
         DIsg==
X-Forwarded-Encrypted: i=1; AJvYcCUjPp8inHHFkpBgmMlPrQJQ+170uSj6znzgej49i739xROXb6pwgyVqG8rBH1AkjcQ+MKMu2yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiQzs1iHYhAzv5X24OHOiLmZXOL2ZpxHNS6RpRl53HQRTuE7n
	CnIB1msimkLTyashsT7bw9iOE5lDbP23iwxdlrbUJczFZBA7GqLFf8VbeZQrVj3itQ==
X-Gm-Gg: ASbGncsaKxNtnWjvJxM7UiMLhuc/6M4hGX2tLthbOyMfCrr7oaj4SHLtD86hu1ZkGIg
	oppNoTxaowdIu0nU9B7yq5K3NQ/6tpbXNEWxaqf5H5nV6AGI3gPOtVJzC/ZKctzKKCzOODUSAZ9
	UilSbnQIZVjVq0ZKvwjYlr7Jn2TIQ495TwNPYqq002vmQFjnBExWylIzDUVOIZ7sAsHzZjwOZ7A
	h+wWovrvmq3DtvMPll6iwKlyfIRfSIbs0VYVzwVOYvIkYjGdvOIgmrUjtCDWKi3ZAxt3+3zKTnG
	34aNIq13hGzkksR4DA5rzZ7L6D+SC+ORjfkD0Fx4+eXhE+Fma8tvRHMtBjLU6jDzxSeuccDky2o
	m74FLtXqz3wkVFdE/ulmoZ4JJ4J8orjHEnqDcPdcWAMCM/TwJCKKiW6PtjisEEiRodRVCtqw=
X-Google-Smtp-Source: AGHT+IEv3VB5QczmrOwpVAmxhE/aEbuXp1vgX7hNah2/dUWAz+OV7H3EEAVGg1UBZuQpPsnmusrRcA==
X-Received: by 2002:a05:6a00:c89:b0:772:177:d442 with SMTP id d2e1a72fcca58-7742dddce93mr17438912b3a.20.1757529313302;
        Wed, 10 Sep 2025 11:35:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:4780:f759:d36a:6480])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7746629088dsm5859972b3a.53.2025.09.10.11.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 11:35:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:35:10 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <aMHE3hmnGTYBrK0E@google.com>
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
 <aKaK4WS0pY0Nb2yi@google.com>
 <048bd3c4-887c-4d17-9636-354cc626afa3@gmail.com>
 <aKc7D78owL_op3Ei@google.com>
 <da46b882-0cd3-48cd-b4fc-b118b25e1e7e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da46b882-0cd3-48cd-b4fc-b118b25e1e7e@gmail.com>

On Fri, Aug 22, 2025 at 09:11:25AM +0800, Ethan Zhao wrote:
> On 8/21/2025 11:28 PM, Brian Norris wrote:
> > On Thu, Aug 21, 2025 at 08:41:28PM +0800, Ethan Zhao wrote:
> > > Hold a PM reference by pci_config_pm_runtime_get() and then write some
> > > data to the PCIe config space, no objection.
> > > 
> > > To know about the linkspeed etc capabilities/not status, how about
> > > creating a cached version of these caps, no need to change their
> > > power state.
> > 
> > For static values like the "max" attributes, maybe that's fine.
> > 
> > But Linux is not always the one changing the link speed. I've seen PCI
> > devices that autonomously request link-speed changes, and AFAICT, the
> > only way we'd know in host software is to go reread the config
> > registers. So caching just produces cache invalidation problems.
> Maybe you meant the link-speed status, that would be volatile based on
> link retraining.

Yes.

> Here we are talking about some non-volatile capabilities value no
> invalidation needed to their cached variables.

I missed the "not status" part a few lines up.

So yes, I agree it's possible to make some of these (but not all) use a
cache. I could perhaps give that a shot, if it's acknowledged that the
non-cacheable attributes are worth fixing.

>
> > > If there is aggressive power saving requirement, and the polling
> > > of these caps will make up wakeup/poweron bugs.
> > 
> > If you're worried about wakeup frequency, I think that's a matter of
> > user space / system administraction to decide -- if it doesn't want to
> > potentially wake up the link, it shouldn't be poking at config-based
> IMHO, sysfs interface is part of KABI, you change its behavior , you
> definitely would break some running binaries. there is alternative
> way to avoid re-cooking binaries or waking up administrator to modify
> their configuration/script in the deep night. you already got it.

That's not how KABI works. Just because there's a potentially-observable
difference doesn't mean we're "breaking" the ABI. You'd have to
demonstrate an actual use case that is breaking. I don't see how it's
"broken" to wake up a device when the API is asking for a value that can
only be retrieved while awake. Sure, it's potentially a small change in
power consumption, but that can apply to almost any kind of change.

My claim is that this is a currently broken area, and that it is
impossible to use these interfaces on a system that aggressively enters
D3cold. If a system observes any difference from this change, then it
was broken before. Bugfixes are not inherently KABI breakages just
because they can be observed.

Brian

