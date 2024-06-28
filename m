Return-Path: <stable+bounces-56069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0B91C0A3
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 16:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BD72812F4
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7EE1BF334;
	Fri, 28 Jun 2024 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eaS3p49B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C791BF329
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584190; cv=none; b=HtCF0YmdmwPB3RQ0q6U/zawq/dEoJig/RCyd2E4T7yas1p9bnpVVEZP/dElK+Nbq7YgfmSaOvSjz9fSBjOUEGJ3d01vW/VK1vsgIKe7tJvT58sy8meopwX/xqbx8e0pgZK/pFkbOYYBaBEJqoztCprOScI3PdAZfXZ5gr/ujPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584190; c=relaxed/simple;
	bh=2WpzKjm5SfU035UCbRxpPT3AbWaDc1JDisGR+qeBbNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QauPnB81Yfor6N9nNdARrGeaEqg22Lle6kCvn1tHYtFCNPhgcRpjm3fktb1+4lHABmZg+jUNWwl53yW9qArp8m7nSz/IGj29SQfnuPklU0Dd1VTRSoPFpbMzcqGnhi+uMgdQMmyhKiOslnsSMtXyBke4Sbt7vesw46TSUN54ZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eaS3p49B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB779C116B1;
	Fri, 28 Jun 2024 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719584189;
	bh=2WpzKjm5SfU035UCbRxpPT3AbWaDc1JDisGR+qeBbNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eaS3p49Bn+J+HtWVqjUsQ8a2YLH3CQrUumY0/ltWLelAubRQe9RFYq0FrX83EVwGj
	 eF/iZAXq4bhcS+iKVzMFDzDpUTZfkxGrhNiy0Youf3CTGfmvGaJmaytrTLiAP6IDgD
	 /kUu9ynYS+6XXzrTgtRsJDdq0GP1hCmgrqqKIGzs=
Date: Fri, 28 Jun 2024 16:16:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Subject: Re: CONFIG_LEGACY_TIOCSTI support in stable branches
Message-ID: <2024062827-sympathy-suffrage-ddbf@gregkh>
References: <20240628114723.dnrkvdmiweteccrf@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628114723.dnrkvdmiweteccrf@altlinux.org>

On Fri, Jun 28, 2024 at 02:47:23PM +0300, Vitaly Chikunov wrote:
> Sasha, Greg,
> 
> Can you please backport CONFIG_LEGACY_TIOCSTI support into stable
> kernels?

That seems to be a new feature, not a bugfix, right?  Is that applicable
to older kernels?

> This, perhaps, would include there mainline commits:
> 
>   83efeeeb3d04b22aaed1df99bc70a48fe9d22c4d tty: Allow TIOCSTI to be disabled
>   5c30f3e4a6e67c88c979ad30554bf4ef9b24fbd0 tty: Move TIOCSTI toggle variable before kerndoc
>   b2ea273a477cd6e83daedbfa1981cd1a7468f73a tty: Fix typo in LEGACY_TIOCSTI Kconfig description
>   690c8b804ad2eafbd35da5d3c95ad325ca7d5061 TIOCSTI: always enable for CAP_SYS_ADMIN
>   3f29d9ee323ae5cda59d144d1f8b0b10ea065be0 TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig
>   8d1b43f6a6df7bcea20982ad376a000d90906b42 tty: Restrict access to TIOCLINUX' copy-and-paste subcommands

Why not just use 6.6.y if you want this feature?

greg k-h

