Return-Path: <stable+bounces-28209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28787C515
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 23:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4365EB21286
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166497641F;
	Thu, 14 Mar 2024 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z/EfwMaJ"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AA73196
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710454770; cv=none; b=biMvFQprdgSDa3xfS9z3Y9klPmVzk2ihBy168ffkDPNSvkNFernqPtzkbtQ/VenWALHLbW+Clm7pYZHyCJaDUG6w+rxJMHsGNVOKJ2xzFun7GvWexT2JiHyvIUNPsb7n5m6u1Zfsmo8NrD6Zj+DFQGR3eNLuesHtO1/IxpXeg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710454770; c=relaxed/simple;
	bh=hV/v8SEGyOe2zb+RS/kY6GZqidy+b5YiROi+ruJDbL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1memxOYA/DBCPRU4uC31ifvG7nS8x2GqsaSUQVbLITjM9Sz8bpQNQJIC9MPasvgqZnbeITneXC0+DwPhaCEbH+1n9FbvhBpTBbKZ1hDwENEt7omNMNEtvZDFMTl/ZKxizAg3zyKybsa+4h7a28bL64/YY/9aNgFPDs4YuUmt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z/EfwMaJ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 18:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710454766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWaKTwt67oq2V4M+z70zbirgnb4sXCm8FfmHFpAIu+w=;
	b=Z/EfwMaJInqL5P2oqnsmRcjLc2rABsSpUS3upz3W73qk1E7pleHS4fzVEDzfh0eqGRSo2x
	3X4VGySIDRLb3hRmTrv+m9AeSaVG4I/r/xNroj5yCfCMVsBRi9VwVbNeeKL8P9fg+pPnp4
	BtJrOPbhRrK1229ochNqORCLKgtA0aI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Helge Deller <deller@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Helge Deller <deller@kernel.org>
Subject: Re: bachefs stable patches [was dddd]
Message-ID: <rgwqmfpfcpcnmoma5by4qf6c5ehugdz2uijkffdwq2cdhingqy@7676cbvj34vl>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
 <ed1eda66-8d67-4661-b50f-f2b152928bf3@gmx.de>
 <2vpsaj7bwn5yvpyerexgga3m22wvqfom32hbc3cics4vrs6lbm@gc47zhr756sr>
 <77fd3622-8b01-418f-9dab-2ab23a3a844e@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77fd3622-8b01-418f-9dab-2ab23a3a844e@gmx.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 10:34:59PM +0100, Helge Deller wrote:
> On 3/14/24 20:08, Kent Overstreet wrote:
> > On Thu, Mar 14, 2024 at 01:57:51PM +0100, Helge Deller wrote:
> > > (fixed email subject)
> > > On 3/14/24 10:46, Kent Overstreet wrote:
> > > > On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
> > > > > Dear Greg & stable team,
> > > > > 
> > > > > could you please queue up the patch below for the stable-6.7 kernel?
> > > > > This is upstream commit:
> > > > > 	eba38cc7578bef94865341c73608bdf49193a51d
> > > > > 
> > > > > Thanks,
> > > > > Helge
> > > > 
> > > > I've already sent Greg a pull request with this patch - _twice_.
> > > 
> > > OIC.
> > > You and Greg had some email exchange :-)
> > > 
> > > Greg, I'm seeing kernel build failures in debian with kernel 6.7.9
> > > and the patch mentioned above isn't sufficient.
> > > 
> > > Would you please instead pull in those two upstream commits (in this order) to fix it:
> > > 44fd13a4c68e87953ccd827e764fa566ddcbbcf5  ("bcachefs: Fixes for rust bindgen")
> > 
> > You'll have to explain what this patch fixes, it shouldn't be doing
> > anything when building in the kernel (yet; it will when we've pulled our
> > Rust code into the kernel).
> 
> Right. It doesn't actually do anything in the kernel (which is good), but
> it's logically before patch eba38cc7578bef94865341c73608bdf49193a51d
> and is required so that eba38cc7578bef94865341c73608bdf49193a51d cleanly
> applies.

yeah I just fixed the merge conflict

