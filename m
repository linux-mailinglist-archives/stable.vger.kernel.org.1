Return-Path: <stable+bounces-192753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C55C41E9E
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 00:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFCF1898E76
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B229301460;
	Fri,  7 Nov 2025 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bXuC5v+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55843009CB;
	Fri,  7 Nov 2025 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762556843; cv=none; b=LpgxN2aDY5/H3iJ1Ubm2GTSJa9vcR8sRPEvCo6MW391ykdLxXkhxC88h+H6FnY1i3II4qhu63qFgXqBJPZOhPduCNB57yN28Ck414KUBQPu5p7bBFP05+vqQYTYdWF0JW7xv1XXBHSuC6F5vVhcckAfCSs+LOm05cxIDxcFUCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762556843; c=relaxed/simple;
	bh=IFrW/8wkEFTdJsCV1ajusTiEZ/ACUDMTmryjdfd0HUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5VktHxGlXsXl3XaPV4sj9vkjtt0NMZpKAQhLLnnWylDTWH/eb96XQeEGnNcYVnv4gTrzBf/2zJ7FZT/ESW4AULYrpZbkLZ7rzV2WDeNcJopPN9UOQJD2V4Aoea8u+yzIPIwB3lHalr1jRhBgtGwo8C+j7XClM1QABSHArmstYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bXuC5v+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D4CC4CEF7;
	Fri,  7 Nov 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bXuC5v+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762556839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpCcvvXDvS225r6ycN7BEql+i73c6ph5/3/xeWgcF0A=;
	b=bXuC5v+ZHX2GjEVgHpDubrR5y7TOoo0dDdozLMuhmSnjwQVNpwAxtibWrLOKj0XN1OTuyv
	cvaTz5sFJafYzCUryCP+xJHfummxM7+YXyaPdVEZgsoh01zYzSt8ys2UnBW/jjLn9ayhmh
	tGzQwYU+tI1vKvFPrCmWIHFtKLma534=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 559a4b8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Nov 2025 23:07:19 +0000 (UTC)
Date: Sat, 8 Nov 2025 00:07:13 +0100
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
Message-ID: <aQ57ofElS-N0gEco@zx2c4.com>
References: <aPT9vUT7Hcrkh6_l@zx2c4.com>
 <1903914.sHLxoZxqIA@tjmaciei-mobl5>
 <aQ5E2ArhkmziwWA8@zx2c4.com>
 <2790505.9o76ZdvQCi@tjmaciei-mobl5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2790505.9o76ZdvQCi@tjmaciei-mobl5>

Hi Thiago,

On Fri, Nov 07, 2025 at 11:55:35AM -0800, Thiago Macieira wrote:
> I'm not asking about the performance of generating new random numbers in this 
> process.
> 
> I am asking about the system-wide impact that draining the entropy source 
> would have. Is that a bad thing?
> 
> I suspect the answer is "no" because it's the same as /dev/urandom anyway.

Oh. "Entropy source draining" is not a real thing. There used to be
bizarre behavior related to /dev/random (not urandom), but this has been
gone for ages. And even the non-getrandom Linux fallback code uses
/dev/urandom before /dev/random. So not even on old kernels is this an
issue. You can keep generating random numbers forever without worrying
about running out of juice or irritating other processes.

Jason

