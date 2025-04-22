Return-Path: <stable+bounces-135087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC22A96684
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80B83A7359
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49CC20CCD8;
	Tue, 22 Apr 2025 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zjV3s0mQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEE5FB95;
	Tue, 22 Apr 2025 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745319055; cv=none; b=IXldekTHh9B7eOJesM/n7qlDd63L9oseHkvCQd/C3aCGIQN961hy53D2H9UhqndOzId2rYj5+htWgevPOtsN/aQKdIgjoqykNMzu1wCyEdubwD2i7SfyQGCVm9ln3sXJ4lUARv7lYd6tV59cdvp4evamOyXrkoOZ2mWMMaaQ6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745319055; c=relaxed/simple;
	bh=MrCnwF7GdHkVudInO56SmjoTmH9xscxr0moc8/xmCsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJU0QSWr2WV+wdoOyGS8U4MNpjq6h1HEsHuQbx4jAkkmMLUtyoCRs/YsnCOtuh5hYHF/ALWOTHK/JGaBbIZNXxfuccgCzkHnqvmoNF+M1xv7+8PsZ96qIqd4NtnelpkU/bZhcdhtBpJOBn3ofNG8K6d0O4uI6yjIMusdWxAMPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zjV3s0mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883E8C4CEE9;
	Tue, 22 Apr 2025 10:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745319055;
	bh=MrCnwF7GdHkVudInO56SmjoTmH9xscxr0moc8/xmCsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zjV3s0mQzAED2/N1v4BwcnaDaVYf7m9YLTrcC+oo27o1aTa76+Db7y1pihHuRAjRZ
	 Fsa72hBqbtIH5G9TsKZkib6jncINU0cOVLSETRLjcJ2Eim/MkYUpigLT/L3130TG2h
	 iKG9saWN93SIy2/VBCiWw7oo6GC1d9hQ3qmOEhWY=
Date: Tue, 22 Apr 2025 12:50:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, alex@ghiti.fr,
	aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, jirislaby@kernel.org,
	john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pmladek@suse.com,
	samuel.holland@sifive.com, u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <2025042202-compare-entrap-0089@gregkh>
References: <20250405043833.397020-1-ryotkkr98@gmail.com>
 <20250405044338.397237-1-ryotkkr98@gmail.com>
 <2025040553-video-declared-7d54@gregkh>
 <397723b7-9f04-4cb1-b718-2396ea9d1b91@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397723b7-9f04-4cb1-b718-2396ea9d1b91@suse.cz>

On Tue, Apr 22, 2025 at 12:20:42PM +0200, Vlastimil Babka wrote:
> On 4/5/25 09:35, Greg KH wrote:
> > On Sat, Apr 05, 2025 at 01:43:38PM +0900, Ryo Takakura wrote:
> >> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
> >> The register is also accessed from write() callback.
> >> 
> >> If console were printing and startup()/shutdown() callback
> >> gets called, its access to the register could be overwritten.
> >> 
> >> Add port->lock to startup()/shutdown() callbacks to make sure
> >> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
> >> write() callback.
> >> 
> >> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> >> Cc: stable@vger.kernel.org
> > 
> > What commit id does this fix?
> 
> > Why does patch 1/2 need to go to stable, but patch 2/2 does not?  Please
> > do not mix changes like this in the same series, otherwise we have to
> > split them up manually when we apply them to the different branches,
> > right?
> 
> I admit it's surprising to see such a request as AFAIK it's normally done to
> mix stable fixes and new features in the same series (especially when the
> patches depend on each other), and ordering the fixes first and marking only
> them as stable should be sufficient. We do that all the time in -mm. I
> thought that stable works with stable marked commits primarily, not series?

Yes, but when picking which "branch" to apply a series to, what would
you do if you have some "fix some bugs, then add some new features" in a
single patch series?  The one to go to -final or the one for the next
-rc1?

I see a lot of bugfixes delayed until -rc1 because of this issue, and
it's really not a good idea at all.

> Also since the patches are AFAIU dependent on each other, sending them
> separately makes the mainline development process more difficult, as
> evidenced by the later revisions having to add notes in the diffstat area
> etc. This would go against the goal that stable process does not add extra
> burden to the mainline process, no?

If they are dependent on each other, that's the creator's issue, not the
maintainer's issue, no?  :)

Submit the bug fixes, get them merged, and then submit the new features.

thanks,

greg k-h

