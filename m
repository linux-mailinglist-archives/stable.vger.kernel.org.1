Return-Path: <stable+bounces-69915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E19895C127
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 00:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3756B22F62
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113017E006;
	Thu, 22 Aug 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YSLcGkZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE912B72
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367323; cv=none; b=LUttaJ0xRcEXpds1JlLWet8PlrxkWZLt+3NjNoEqsPdYaBPklIrSVJ4zcFS6HX+T00OF/h22adRobInwJ5e5Xh0MWbw0OaRXvm1rQVdnlmTuY2u54uo29e6rmU0jtEFpFlRonXMwEFIE5P2ocdculqeJY62AsSse/rWY7N3wnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367323; c=relaxed/simple;
	bh=JIA+CGVbeNGnu+H4qQklqTmdulMArXrVl7QpSOvZ7NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6kL5DdXS5RdUQypCYXs/ohb7xWYQVBkjZxmSFaRWQzo/2Tf0SQVHC6uf7kVhyyRHBiXHlqUo28FMuBt/Y2jkw1x5bZQbhIMe/aZWHjpVPxIu7FBGs6VkHzuZ41hEFtvJJ391SaXZHUxI8SDTkJcjTKOV1YHG7m5RmmbXPxFNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YSLcGkZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1196DC32782;
	Thu, 22 Aug 2024 22:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724367322;
	bh=JIA+CGVbeNGnu+H4qQklqTmdulMArXrVl7QpSOvZ7NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSLcGkZxPOcBcY9v8cqfklqLFupYpT0dp19TjWP6lGvnaw2ASoAR2OFH+0bDNukAV
	 p69XEkFiMDehvZOh0eyhrMPEifbC4gOmZgJzX+f4j3YXXFPHU0Dcta2pkvKOPbXIc6
	 3HqkN1DH55iCumO+lDqj/ZHJvqlsRT1sTidoKIAU=
Date: Fri, 23 Aug 2024 06:55:19 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Laight <David.Laight@aculab.com>,
	Jiri Slaby <jirislaby@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Please apply commit 31e97d7c9ae3 ("media: solo6x10: replace
 max(a, min(b, c)) by clamp(b, a, c)") to 6.1.y
Message-ID: <2024082346-strobe-balance-68ec@gregkh>
References: <ZsdzH-n9-9K8XYSx@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsdzH-n9-9K8XYSx@eldamar.lan>

On Thu, Aug 22, 2024 at 07:19:27PM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> While building 6.1.106 based verson for Debian I noticed that all
> 32bit architectures did fail to build:
> 
> https://buildd.debian.org/status/fetch.php?pkg=linux&arch=i386&ver=6.1.106-1&stamp=1724307428&raw=0
> 
> The problem is known as
> 
> https://lore.kernel.org/lkml/18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com/
> 
> This now affects as well 6.1.y as the commits 867046cc7027 ("minmax:
> relax check to allow comparison between unsigned arguments and signed
> constants") and 4ead534fba42 ("minmax: allow comparisons of 'int'
> against 'unsigned char/short'") were backported to 6.1.106.
> 
> Thus, can you please pick as well 31e97d7c9ae3 ("media: solo6x10:
> replace max(a, min(b, c)) by clamp(b, a, c)") for 6.1.y? 
> 
> Note I suspect it is required as well for 5.15.164 (as the commits
> were backported there as well and 31e97d7c9ae3 now missing there).

Now queued up, thanks!

greg k-h

