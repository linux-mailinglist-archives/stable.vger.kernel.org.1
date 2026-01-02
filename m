Return-Path: <stable+bounces-204443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC32CEE10F
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B51C3008EAF
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B81E1A3D;
	Fri,  2 Jan 2026 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KP5DBCqW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="toO6P0/+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF822262BD;
	Fri,  2 Jan 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767346468; cv=none; b=VyXx4ATYV9n3MVeYjRSvqAdcIyswV4Ya7r9NQQdcYvyeoqiANu0MU6wJHHOb4po9OYFouNaqw7WKIruR7OHDmmeBWHHKAoTAK8T4qYrErOeWe9rN2u26e82lEyJPNWdJTS/A7veURkofkLTe0dC9p8WYhWpHsvuidXNH2mASus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767346468; c=relaxed/simple;
	bh=gWt4kq8izZh+CAEXbBoiferIvJCEGOnysSrG1BCISmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIH20s6h6UjryarKQT+FZHSJTA/JiHoZjm7O3fuzoGRsDptd8LVfpgzVN5f5qlmrG6Rc1aRjlJ7iRiaFnkEGFGD9UK5EFSShDmWZHYLYAC5F0xS+KWWf60NcR5ox0k4gLoVVvlj6P7KpjcLPxQV9mhMVbZl2ErjFQ3F5ScAk7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KP5DBCqW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=toO6P0/+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 2 Jan 2026 10:34:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767346464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbnXFaQL1BHk/nnr/YbkuCM39uw199pGBXZav5QhW0Y=;
	b=KP5DBCqWu3lIBNmEbPnrwXl1Hq3DVJffX8GUaUYHJSMhnq6k0olvVhFI092UJkuLRhnd/3
	noYE0mlvDK4BvW5pjdmyXDX6UcwxEbQR8+61EFCIWp2JeM/hUrc+wpgvUZeXGSNXzE3CjU
	mLGcwOmejSyhrm9isGo7PUDXqRdUsIUaxcFAehI9k7RSKSiQCQSjQGAfNZU4KcP0N1ykoX
	vz+vscW/P7AWZTbTSwSLwDac9HBrJG8MCMBi/PfA8UJGRjtgpqu0zORovVw6GDG8akBjH2
	Wd8oQIm19dWxxQb6H9WhcvDXq0N8gW01SGBqkPaFJPXn2bw62qEDntPMJqB3qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767346464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbnXFaQL1BHk/nnr/YbkuCM39uw199pGBXZav5QhW0Y=;
	b=toO6P0/+7eBLhQku5/wCgiMx9NpDABvmuNGfkieHlpRmXq1GnDIeC88PH7ASOb6ec0di71
	ovyy9CXQUs4VbQBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: fix memset64() on big-endian
Message-ID: <20260102103055-cbb5af1d-0704-434d-b4b0-648d334c8b6e@linutronix.de>
References: <20260102-armeb-memset64-v1-1-9aa15fb8e820@linutronix.de>
 <bfd7776e-574a-4828-99a2-f70a3b9015e6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfd7776e-574a-4828-99a2-f70a3b9015e6@app.fastmail.com>

On Fri, Jan 02, 2026 at 10:24:33AM +0100, Arnd Bergmann wrote:
> On Fri, Jan 2, 2026, at 08:15, Thomas Weiﬂschuh wrote:
> > On big-endian systems the 32-bit low and high halves need to be swapped,
> > for the underlying assembly implemenation to work correctly.
> >
> > Fixes: fd1d362600e2 ("ARM: implement memset32 & memset64")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> > Found by the string_test_memset64 KUnit test.
> 
> Good catch! I guess that likely means you are the first one to
> run kunit test on armbe since the tests got added. Did you find
> any other differences between BE and LE kernels running kunit?

No other differences with the default set of tests.
There was a failure for both in test_polyval_preparekey_in_irqs, see [0].
To get some more exposure I propose a new kunit QEMU configuration in [1].

> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

[0] https://lore.kernel.org/lkml/20260102-kunit-polyval-fix-v1-1-5313b5a65f35@linutronix.de/
[1] https://lore.kernel.org/lkml/20260102-kunit-armeb-v1-1-e8e5475d735c@linutronix.de/

