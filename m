Return-Path: <stable+bounces-50471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D19066F4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107991F217EF
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DBC13D606;
	Thu, 13 Jun 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ChT6li9j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919713D524
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267625; cv=none; b=P20ZTU2ZDc97VdwPD6jHrCTQOhDbNHkLB8T4k3ZOwyFlzl8RqQL7TuctCMHmTxFI8XlGCLGFwWopAwpWh4tJH/F491Zj8t8H907r6g8fGT6zBjpZGMcyiPSClge97kQKNHJF58ee0piwrIxDd13yha96AYn526wjg9cUXldAA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267625; c=relaxed/simple;
	bh=SCB0k4erPqzr3zZBBQKe12Ek/ALKAkkGYlBa5K1VLVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrYMW/WO2qGsIwfPR+R+DSMeIwT5UFc/rKAOQVLMiI8RLoSI6rQN43RfJ9QRDNk/5Y20CwwisBAtB/TRRDebv9d/DqwC3TvWsD4qEIW7/gKj4N0NI6BaCOzllxudYdrYButgiEEWF0kk1rAb6e2wK1Ho5MYlHl/l0lB8KjzGA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ChT6li9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C5EC2BBFC;
	Thu, 13 Jun 2024 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718267624;
	bh=SCB0k4erPqzr3zZBBQKe12Ek/ALKAkkGYlBa5K1VLVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChT6li9jxsL/W/fGEHo+F46xw4bhGz3Ff/Uf1UQ47vkhsyWejSPCXMPU6BCWnsvBe
	 r/dWughe8LnyZ+z/AIA0UNUNvq+kbOmCrPbobrn8+ZOTaNLf1odWOTHY9xbNGxXYxe
	 XzHf9yCXsKmFSNjL3c8E9mXSX/I3Yoy0Ph5T8Eqk=
Date: Thu, 13 Jun 2024 10:33:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH stable 4.19] xsk: validate user input for
 XDP_{UMEM|COMPLETION}_FILL_RING
Message-ID: <2024061329-pregnancy-rumbling-74b2@gregkh>
References: <20240606034835.19936-1-shung-hsi.yu@suse.com>
 <2024061258-research-tractor-159b@gregkh>
 <hxq6nby44qaaddymt6s4ucnaq2oeuulir5z2zzjwvvj3sevt2n@zdfubulurdue>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hxq6nby44qaaddymt6s4ucnaq2oeuulir5z2zzjwvvj3sevt2n@zdfubulurdue>

On Thu, Jun 13, 2024 at 09:13:57AM +0800, Shung-Hsi Yu wrote:
> On Wed, Jun 12, 2024 at 04:40:33PM GMT, Greg KH wrote:
> > On Thu, Jun 06, 2024 at 11:48:33AM +0800, Shung-Hsi Yu wrote:
> > > Two additional changes not present in the original patch:
> > > 1. Check optlen in the XDP_UMEM_REG case as well. It was added in commit
> > >    c05cd36458147 ("xsk: add support to allow unaligned chunk placement")
> > >    but seems like too big of a change for stable
> > > 2. copy_from_sockptr() in the context was replace copy_from_usr()
> > >    because commit a7b75c5a8c414 ("net: pass a sockptr_t into
> > >    ->setsockopt") was not present
> > > 
> > > [ Upstream commit 237f3cf13b20db183d3706d997eedc3c49eacd44 ]
> > 
> > What about 5.4.y?  We can't take a patch in an older stable tree and
> > have a regression when someone moves to a new one, right?
> > 
> > I'll drop this for now and wait for a backport for both trees before
> > applying it.
> 
> I somehow though I've checked that 5.4 contains the fix, but apparently
> not. Will send backoprt for 5.4 as well.

Thanks, but please resend this commit as it is long gone from my tree...

