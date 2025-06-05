Return-Path: <stable+bounces-151507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E94ACEC38
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC853AB853
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B90720E023;
	Thu,  5 Jun 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dCnylNWF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5181E7C03
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113033; cv=none; b=MVpMgjdbdZVt3VO49ZnIxe1ENlwhRc6frsgzKBJq+8KxnynA0YHN52XXMQDtGyDvxbxpTg79jwXdFJQbIekMmExW9waXISgRzA7LqWytHhgh3mWwib1h4WGlMtU5WX5h8VXhsjgjg5F7uj3jd8i0t7EIGVpj5sV5wfBjpkWSVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113033; c=relaxed/simple;
	bh=CvqLDOWnaeFkA1pdcuNFTDkIjwrabBroTkWR6vLPCYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8IEW1Fr9QtzH1YAZaVXG68xCjy2x43wy6UNPZ9MgLUA1apFHhttn5U8JT4lHnEL/lBbMDIUI1cryCP+ne4+WJrn0Tm9IohqicEYvTIPyIyzRkoGtyZy99eFXMgNvhy8o6sKqvNdmhTOMQNftn1cisAAf9MoWVhxgRiCZH2tNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dCnylNWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60544C4CEF1;
	Thu,  5 Jun 2025 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749113032;
	bh=CvqLDOWnaeFkA1pdcuNFTDkIjwrabBroTkWR6vLPCYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCnylNWF9mwNaIPuQGHf5oKviIKGqtGPHZNwCIzjQuacpNTqwFbVmWYu3rm+UNkFK
	 89xJ2m8qJtUuSViyCdvFCuQGaMf8fu6WnBlhjEOY6rVyDqDwnS1BSsybUARTWAQhle
	 Rkjy5Mw4OBGkMIyZ04AXqw/xyMI2Ws+cwXq3VT9I=
Date: Thu, 5 Jun 2025 10:43:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ingo Saitz <ingo@hannover.ccc.de>, 1104745@bugs.debian.org,
	stable@vger.kernel.org
Subject: Re: Bug#1104745: gcc-15 ICE compiling linux kernel 6.14.5 with
 CONFIG_RANDSTRUCT
Message-ID: <2025060526-dill-character-2c95@gregkh>
References: <174645965734.16657.5032027654487191240.reportbug@spatz.zoo>
 <hix7rqnglwxgmhamcu5sjkbaeexsogb5it4dyuu7f5bzovygnj@3sn4an7qgd6g>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hix7rqnglwxgmhamcu5sjkbaeexsogb5it4dyuu7f5bzovygnj@3sn4an7qgd6g>

On Wed, Jun 04, 2025 at 10:43:11PM +0200, Uwe Kleine-König wrote:
> Control: tag -1 + fixed-upstream
> Control: forwarded -1 https://lore.kernel.org/r/20250530221824.work.623-kees@kernel.org
> 
> Hello,
> 
> On Mon, May 05, 2025 at 05:40:57PM +0200, Ingo Saitz wrote:
> > When compiling the linux kernel (tested on 6.15-rc5 and 6.14.5 from
> > kernel.org) with CONFIG_RANDSTRUCT enabled, gcc-15 throws an ICE:
> > 
> > arch/x86/kernel/cpu/proc.c:174:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1516
> >   174 | const struct seq_operations cpuinfo_op = {
> >       |              ^~~~~~~~~~~~~~
> 
> This is claimed to be fixed in upstream by commit
> https://git.kernel.org/linus/f39f18f3c3531aa802b58a20d39d96e82eb96c14
> that is scheduled to be included in 6.16-rc1.
> 
> This wasn't explicitly marked for stable, but I think a backport would
> be good.

Does not apply cleanly, we need backports submitted to us to be able to
take it.

thanks,

greg k-h

