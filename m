Return-Path: <stable+bounces-128424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8404FA7CFBD
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 20:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244A33A4E61
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4D7189B91;
	Sun,  6 Apr 2025 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv97GlfH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0D51C5A;
	Sun,  6 Apr 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964614; cv=none; b=NCLprSBNgcBD5y18ZU2cKxOZqCdNxq33HSZTU++kIVe6hNjuCDOwumXxxnLQtqJkiol10D9h5KhDN5o5GMss4/ieC6Wquv0D2aCxtMVPPj4hKkFGFjZRckUDGL2yAOz5L2JxtFWfs3X7yZi6XbnH0PFbxqCzdU4gjf5++LDtTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964614; c=relaxed/simple;
	bh=J+dIIbXRSvx2SK8wSzV0kTyp98SUwGvbs6XaLwywoyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9eWjGPpQ8i7kmxmy86Kq988l+dQbepT+Y3W5EwVTFERr3QvQ5yXUcbS8qnnb69R6TW3yys4EXqu0m3RiPz+YOEKL3Tz2IOLmioHy0JLusd7c5fXw825Uf/WASVYXOehVGpmkFKBD+2BcVQG4L6WqA+hmnEFVEIE3KAaq2rN7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv97GlfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F375C4CEE3;
	Sun,  6 Apr 2025 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743964612;
	bh=J+dIIbXRSvx2SK8wSzV0kTyp98SUwGvbs6XaLwywoyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rv97GlfHbWS4yQom1dhJVBdnyR6B6LW68DGiFm0IdJZ9TVJePqsSjlW/fas4XclmM
	 ZxzEhjAxuZXCfDlP9/9dSq5khrQWu62AZcYUloYv8uSHtoD1vL38g3rRLczEc+tguF
	 kWuyiLBkHEhL0dV4WsvGPYOwQNSMGdumu7U9I4ilVw5/wZWNG1BHfvd5tfR44y/ctR
	 0MlpIWa3bZ3457ezvUIJHqEe5e/n+VrWDnRLkf4PjXu1qSr/vMErH6r/ANsrAddG3g
	 qoNxakSJ3Iz+CXO0ZFOZbMI7eIR/bppMCbboxYpJDogSo7i/nzhofPtJUVhYnIv5rw
	 yMlEjuhMdu6nw==
Date: Sun, 6 Apr 2025 20:36:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Roberto Ricci <io@r-ricci.it>
Subject: Re: [PATCH v3] x86/e820: Fix handling of subpage regions when
 calculating nosave ranges
Message-ID: <Z_LJv9gATY6nk4Yu@gmail.com>
References: <20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz>
 <Z_LGqgUhDrTmzj5r@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_LGqgUhDrTmzj5r@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz> wrote:
> 
> > The current implementation of e820__register_nosave_regions suffers from
> > multiple serious issues:
> >  - The end of last region is tracked by PFN, causing it to find holes
> >    that aren't there if two consecutive subpage regions are present
> >  - The nosave PFN ranges derived from holes are rounded out (instead of
> >    rounded in) which makes it inconsistent with how explicitly reserved
> >    regions are handled
> > 
> > Fix this by:
> >  - Treating reserved regions as if they were holes, to ensure consistent
> >    handling (rounding out nosave PFN ranges is more correct as the
> >    kernel does not use partial pages)
> >  - Tracking the end of the last RAM region by address instead of pages
> >    to detect holes more precisely
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: e5540f875404 ("x86/boot/e820: Consolidate 'struct e820_entry *entry' local variable names")
> 
> So why is this SHA1 indicated as the root cause? AFAICS that commit 
> does nothing but cleanups, so it cannot cause such regressions.

BTW.:

 A) "It was the first random commit that seemed related, sry"
 B) "It's a 15 years old bug, but I wanted to indicate a fresh, 8-year old bug to get this into -stable. Busted!"

... are perfectly fine answers in my book. :-)

I'm glad about the fixes, I'm just curious how the Fixes tag came about.

Thanks,

	Ingo

