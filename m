Return-Path: <stable+bounces-121280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D586A551D2
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2BE18862ED
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F45F2144BC;
	Thu,  6 Mar 2025 16:50:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailsrv.ikr.uni-stuttgart.de (mailsrv.ikr.uni-stuttgart.de [129.69.170.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB8211715
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.170.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279822; cv=none; b=Kitf4VIE/bxnoyHCpebUpBTaVxo970MNXYr7KVivJ4xCc0Na7cu01ADDKl7oyEhisw6dVJ1NYq70bbpdmF3CORXVxTUMwOqXanfgjoS+T6n/zWv7MNL3mJSQqoxZKFZgnW6PH568uxbjmsviCc+mScV8PcLvUgGW4lc+Nk3i0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279822; c=relaxed/simple;
	bh=WIQvrMmpPfH84Uw5cREnaT5FAQ+McOHpdBp0AicpnbE=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=p904E3KoADBFnoS4b/5rhHoIuc6YRiH+1HRLYgHDnMysnF4tR9Gakb8DYSGkYBlZBCrfZMBUmI+blGChZXwlnPEwVWcSVlTxSenNkBjrwgOCClL0OG5qazP25ocxY17wOvp+swv4XPbuYXIgAgKp6QvdUlvFclJzfYCI8X+jtME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikr.uni-stuttgart.de; spf=pass smtp.mailfrom=ikr.uni-stuttgart.de; arc=none smtp.client-ip=129.69.170.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikr.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikr.uni-stuttgart.de
Received: from netsrv1.ikr.uni-stuttgart.de (netsrv1 [10.21.12.12])
	by mailsrv.ikr.uni-stuttgart.de (Postfix) with ESMTP id 47BA21B3ED65;
	Thu,  6 Mar 2025 17:50:18 +0100 (CET)
Received: from ikr.uni-stuttgart.de (pc021 [10.21.21.21])
	by netsrv1.ikr.uni-stuttgart.de (Postfix) with SMTP id 32C781B3ED64;
	Thu,  6 Mar 2025 17:50:16 +0100 (CET)
Received: by ikr.uni-stuttgart.de (sSMTP sendmail emulation); Thu, 06 Mar 2025 17:50:16 +0100
From: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Organization: University of Stuttgart (Germany), IKR
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Regression for PXE boot from patch "Remove the 'bugger off' message" in stable 6.6.18
Date: Thu, 6 Mar 2025 17:50:16 +0100
User-Agent: KMail/1.9.10
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de> <87AE5E2B-4BD4-468E-ABD5-6E717FE925EE@zytor.com> <CAMj1kXFuC2_J9wUuJ-GnRRSBN6C2YbahxJ9PD9X26TX+smhBgA@mail.gmail.com>
In-Reply-To: <CAMj1kXFuC2_J9wUuJ-GnRRSBN6C2YbahxJ9PD9X26TX+smhBgA@mail.gmail.com>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202503061750.16147.ulrich.gemkow@ikr.uni-stuttgart.de>

On Thursday 06 March 2025, Ard Biesheuvel wrote:
> On Thu, 6 Mar 2025 at 16:23, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > On March 6, 2025 6:44:11 AM PST, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >On Thu, 6 Mar 2025 at 15:39, H. Peter Anvin <hpa@zytor.com> wrote:
> > >>
> > >> On March 6, 2025 6:36:04 AM PST, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >> >(cc Peter)
> > >> >
> > >> >
> > >> >I managed to track this down to a bug in syslinux, fixed by the hunk
> > >> >below. The problem is that syslinux violates the x86 boot protocol,
> > >> >which stipulates that the setup header (starting at 0x1f1 bytes into
> > >> >the bzImage) must be copied into a zeroed boot_params structure, but
> > >> >it also copies the preceding bytes, which could be any value, as they
> > >> >overlap with the PE/COFF header or other header data. This produces a
> > >> >command line pointer with garbage in the top 32 bits, resulting in an
> > >> >early crash.
> > >> >
> ...
> > >>
> > >> Interesting. Embarrassing, first of all :) but also interesting, because this is exactly why we have the "sentinel" field at 0x1f0 to catch *this specific error* and work around it.
> > >
> > >We're crashing way earlier than the sentinel check - the bogus command
> > >line pointer is dereferenced via
> > >
> > >startup_64()
> > >  configure_5level_paging()
> > >    cmdline_find_option_bool()
> > >
> > >whereas sanitize_bootparams() is only called much later, from extract_kernel().
> >
> > That is a bug in the kernel then. The whole point of the sentinel check is that it needs to be done before any of the fields touched by the sentinel check are accessed.
> 
> Indeed - I have just sent out a fix for this.
> 

Hello Ard,

thanks for the patch! It does not apply cleanly to 6.6.80 (the includes
are different) so I applied it manually and it helps - the systems boots.

Please allow the remark regarding the patch description that in
our kernel CONFIG_X86_5LEVEL is not set. The patch helps anyway :-)

Thanks again and best regards

Ulrich

-- 
|-----------------------------------------------------------------------
| Ulrich Gemkow
| University of Stuttgart
| Institute of Communication Networks and Computer Engineering (IKR)
|-----------------------------------------------------------------------

