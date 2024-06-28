Return-Path: <stable+bounces-56072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC791C10B
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C8C2811D5
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF61BF32E;
	Fri, 28 Jun 2024 14:33:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9791B645
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585232; cv=none; b=haoAWihjOiZH8XoeStZS7R89y91oW9umijmKHw5TLuzamRjpYq6P1gi7hin7DuzR4JYcnqXPkO0qNxo6MrkcIW4GoYs8Pk1k2RVNZvmgHiSZ6FGAgfaUS4oFNuuw2dm5iCWahfCPOJRd9tQPuayJiXXmcxCYjrA+nW39YLAInGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585232; c=relaxed/simple;
	bh=LtXGdAvA8SSqAS3F+t4KJ2GOnTAb6HXKdBXoDMECpwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTsN1XkrYsVY8k8IX9Xf9/d9m0g0+wt87xGy296PuR6Hs+RluxiTD9yoZZvVnfxusjNHRvi5rmwQChGf4dvU+nzkt5DNTaXh1JKGlnLT63IwfYEADpDoIZqR+TpUEWgKD844GQVWYARq2FkrAtkbZesJq49i0BJ+vyqvPQ+G0xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 4242272C8CC;
	Fri, 28 Jun 2024 17:33:48 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 369E136D016C;
	Fri, 28 Jun 2024 17:33:48 +0300 (MSK)
Date: Fri, 28 Jun 2024 17:33:47 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	"Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: CONFIG_LEGACY_TIOCSTI support in stable branches
Message-ID: <20240628143347.enzrbfcec6lorq3q@altlinux.org>
References: <20240628114723.dnrkvdmiweteccrf@altlinux.org>
 <2024062827-sympathy-suffrage-ddbf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <2024062827-sympathy-suffrage-ddbf@gregkh>

Greg,

On Fri, Jun 28, 2024 at 04:16:26PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 28, 2024 at 02:47:23PM +0300, Vitaly Chikunov wrote:
> > Sasha, Greg,
> > 
> > Can you please backport CONFIG_LEGACY_TIOCSTI support into stable
> > kernels?
> 
> That seems to be a new feature, not a bugfix, right?  Is that applicable
> to older kernels?

This is related to CVE-2016-2568 (in polkit), but it's believed this is
better fixed on the kernel side.

> 
> > This, perhaps, would include there mainline commits:
> > 
> >   83efeeeb3d04b22aaed1df99bc70a48fe9d22c4d tty: Allow TIOCSTI to be disabled
> >   5c30f3e4a6e67c88c979ad30554bf4ef9b24fbd0 tty: Move TIOCSTI toggle variable before kerndoc
> >   b2ea273a477cd6e83daedbfa1981cd1a7468f73a tty: Fix typo in LEGACY_TIOCSTI Kconfig description
> >   690c8b804ad2eafbd35da5d3c95ad325ca7d5061 TIOCSTI: always enable for CAP_SYS_ADMIN
> >   3f29d9ee323ae5cda59d144d1f8b0b10ea065be0 TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig
> >   8d1b43f6a6df7bcea20982ad376a000d90906b42 tty: Restrict access to TIOCLINUX' copy-and-paste subcommands
> 
> Why not just use 6.6.y if you want this feature?

Since I maintain older kernels for ALT Linux I thought I'd first ask
upstream if it's possible to backport the patches before cherry-picking
them myself. It is also good to know they aren't backported
intentionally and not by a slip.

Thanks,

> 
> greg k-h

