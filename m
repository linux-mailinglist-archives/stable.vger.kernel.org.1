Return-Path: <stable+bounces-106850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227ECA02738
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FE316148A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B071DDC1A;
	Mon,  6 Jan 2025 13:56:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9501D63D8;
	Mon,  6 Jan 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171782; cv=none; b=Ze2lf+lWQxikhFPce/O497AXR3Q7XHH8tS1CJgAsfsP0YLicXgKXqj/o7tQVeq5pq6BMt3YNR/eouXr2bLgPPHcukpy2iCXpIQrZnvup7sbngzNzwJpblUe1VmvcC1xUTNLL7FJqOS2ItRJhr1CpecbBL+Mg43KDY/rKqEQidPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171782; c=relaxed/simple;
	bh=HM2oA0Iu+B0P3p49ym9mPmXZW0CpYiLy6d3dd8OnNZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9d++Ge5jxW4H6Ny50ZpoWrV0ppkUKkQ+bpu4fqhDvAfLymrB1QKyH6F50rCaqIJ9STYfR6iVwIbPUA0Fqu23u6+ax8XUHguBqPlUBO+8f01tqUWCZbsgpTHJ1h7Z6laOl3Usyv5wCV70IJ9Vx4JyUdOx4+ZkAjKz4y0F4P6zh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso24644481a12.0;
        Mon, 06 Jan 2025 05:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736171777; x=1736776577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMTdUkld4falIbel3Xtgcu5G1Kj7VOUe8eE1JDQEfdQ=;
        b=uUlpyxwCK9T6ba0efiBcm3V6rcuJjOmcUodpXBPWJaeCwRjUA+uVpfcumO8aOPv7uA
         d2TH0GiRP/a0PDe8EbBePAIP1SreJoUJzYQCofG6+2aBKAfyYdet4H6rVnopRkdIlwxN
         0wM+EpMo+9v95IVaI5MkMMIPzMgZOshQrbyrWZv6BxrTFpW2U/qwuOHbZ9P/MQsUm3jC
         B5Tzmw6MDdSVPQWsLjB/xC5jNIV2s6xdNf9oYaTVMhg0k/TM0lsjzDAkKkrlQQ7l2fmr
         e6PYkTaF349txUFFA89hjP3m3DagQ+eczpaVL6M+BeEfAfxR4X2RfVp0CdFt495RQAH2
         sJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCVl2UvkEn6roKSJr0+SrsmiDOFd9rOG5LWJw6odKS3o+tlUtIuI7W1IRMSfNCN5AhlCW3vVAMB/kclC9qw=@vger.kernel.org, AJvYcCVxpRHAl93uKYY7+FS32Nhz6vrfZyJrlhXVmHRMwiTfXBJ60QZAuORP0TRNCv81MdYOWGLVMAVF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vilzu2TXOMSwz2p0zN46Wl9s7ISrd8+kd9OOx/4Rxy7AQz/H
	FYzzquBpHTMdydvVpvyiSBjGsOmvkr6cHatfLbTByEDPFqCOGs5WgeWwqw==
X-Gm-Gg: ASbGncvC5hmf8Qmr3CtjdoyAczAtyJe0Plh6x7I5MQjnUiIAp0psEU1TkZxmVnBgnxJ
	8U05AAfRrxAEp9QNyFthxTKMk3APYkkse4KuGZ8St+oc7hCFrGKxliEZPkHLVZp0iydggx6fhl3
	g9NdI2gcJGrDPmqXTouG5e/bsSp7Vr7XC5AzKt/v85Jg3m5mjWws6/FYZKnxjCADsUtCq8jeHcy
	1zpSo+j+NLAlw1U1zwa11r61l5rirECWlT/NqOf4c3JCN0=
X-Google-Smtp-Source: AGHT+IH2gOLsw+NWWJjXJCRfeF410OTxzAogVH61WaHH+G5+icl5YqxcdHBiOySy4P64j6Lr45Q5/Q==
X-Received: by 2002:a17:907:7f0f:b0:aac:1e96:e7cf with SMTP id a640c23a62f3a-aac334425abmr5920773066b.20.1736171776509;
        Mon, 06 Jan 2025 05:56:16 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4c1dsm2282462666b.109.2025.01.06.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:56:16 -0800 (PST)
Date: Mon, 6 Jan 2025 05:56:13 -0800
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>, koichiro.den@canonical.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Koichiro Den <koichiro.den@canonical.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: Linux 6.13-rc6
Message-ID: <20250106-original-opal-shrew-4ecbf0@leitao>
References: <CAHk-=wgjfaLyhU2L84XbkY+Jj47hryY_f1SBxmnnZi4QOJKGaw@mail.gmail.com>
 <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>

On Mon, Jan 06, 2025 at 02:18:17PM +0100, Borislav Petkov wrote:
> On Sun, Jan 05, 2025 at 02:20:54PM -0800, Linus Torvalds wrote:
> > So we had a slight pickup in commits this last week, but as expected
> > and hoped for, things were still pretty quiet. About twice as many
> > commits as the holiday week, but that's still not all that many.
> > 
> > I expect things will start becoming more normal now that people are
> > back from the holidays and are starting to recover and wake up from
> > their food comas.
> > 
> > In the meantime, below is the shortlog for the last week. Nothing
> > particularly stands out, the changes are dominated by various driver
> > updates (gpu, rdma and networking), with a random smattering of fixes
> > elsewhere.
> 
> Something not well baked managed to sneak in and it is tagged for stable:
> 
> adcfb264c3ed ("vmstat: disable vmstat_work on vmstat_cpu_down_prep()")

Thanks for bissecting it.

I've just confirmed that reverting adcfb264c3ed ("vmstat: disable
vmstat_work on vmstat_cpu_down_prep()") gets rid of the "workqueue: work
disable count underflow" WARNING.

