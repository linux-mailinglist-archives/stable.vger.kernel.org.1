Return-Path: <stable+bounces-192747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D085C41673
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0683B1F4A
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C22EBB88;
	Fri,  7 Nov 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hfd6kSqa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2B2E7F3F;
	Fri,  7 Nov 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542831; cv=none; b=oKg3a82xkgrHQAHB+1nz9iw7kXOUxCM774dCGCss8HO/O+/Lb/jaRS3Qp1uQADGRUSNRjoHzCOiF/mjJGh5bxc6ElV2kiJj7snltbZiiIdyNCPEqnIuGUOUJ+NppqjIhj3Ztn5QKeKGNB4Pl/v9FE5aqikE8uGHz9z8x0tdavkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542831; c=relaxed/simple;
	bh=QPvzf1ncoB2akJVkCU9fnOKK8+smlfhFLevU4TnM4/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6I2mvaNDX2TKU3DCyvnu47rZ2C4NP1kI1lrOdHljworh75XxSnWrlaZJugOIWqDKr/NdVyE+G2HEad4b0oAeiQtJhmugJijHa0ry11UzCn783Kp7hhA16OG+EnOq7wZ6YPLxOH/JOSVEYCnkCl9bA0F1nZ4i3YMqCCuxPv+KsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hfd6kSqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA61C116C6;
	Fri,  7 Nov 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hfd6kSqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762542827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9Te8GHaL0ce//jLPAsz2MwD/P3XSQZAUk5sFkofyv8=;
	b=hfd6kSqaknI2Wd4hZsGmzGAGKB+4Sqsz1FlvG10wU6tNM5nW5DAnBl//wiECgOZiQIS+9H
	Y2Rh2yY5KKP8rFYmpxZjsIi0KU4kbqZb+TFqewtpbBPZhDjSKrs0KY1gK1F1uhW9eDTvdY
	zpdrtAZzzEKmIbBkB78DZlqqFMjuczI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3582e0ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Nov 2025 19:13:46 +0000 (UTC)
Date: Fri, 7 Nov 2025 20:13:28 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thiago Macieira <thiago.macieira@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Christopher Snowhill <chris@kode54.net>,
	Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <aQ5E2ArhkmziwWA8@zx2c4.com>
References: <aPT9vUT7Hcrkh6_l@zx2c4.com>
 <4632322.0HT0TaD9VG@tjmaciei-mobl5>
 <aQqvTGblMoKkRK1j@zx2c4.com>
 <1903914.sHLxoZxqIA@tjmaciei-mobl5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1903914.sHLxoZxqIA@tjmaciei-mobl5>

On Wed, Nov 05, 2025 at 08:41:01AM -0800, Thiago Macieira wrote:
> > Oh yea, good question. Well, with every major OS now having a mechanism
> > to skip syscalls for random numbers, I guess you could indeed just alias
> > global() to system() and call it a day. Then users really cannot shoot
> > themselves in the foot. That would be simpler too. Seems like the best
> > option.
> 
> Indeed.
> 
> But consider people who haven't upgraded Linux (yes, we get people asking to 
> keep everything intact in their system, but upgrade Qt only, then complain 
> when our dependency minimums change). How much of an impact would they have?

I suppose you could benchmark it and see if it matters. The syscall is
obviously slower than the megafast vDSO code, so it will probably also
be a bit slower than the MT code. But I suspect for most use cases maybe
it doesn't matter that much? It's worth a try and seeing if anybody
complains.

Jason

