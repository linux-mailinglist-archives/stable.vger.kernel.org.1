Return-Path: <stable+bounces-55144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6D915EF1
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D2B213C1
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28122145FEC;
	Tue, 25 Jun 2024 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F4oeZ7px"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1AD1CFB6
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297185; cv=none; b=KirMGArX1XxXVwBi3tFINzX2XU1h6PAA1vdcwK4k+ujoWbZJ/gCeoQtkmB8CkuerW9b2wM1sA5bL3nbRPSDi/oDvOhRvwpcEfHvfb2wz+AdyvmgNAFD8v6hcbjOfW8bivIH3RkmnHxmMf2GOHdcghB6a722/F0x+FCGxalCKqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297185; c=relaxed/simple;
	bh=tsP3ZTPJBEdI0PsuCtRuexzxDzB85NFpgLKwrg//dG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poVBRjO3t1xQAqe4HkkBRvSWaCyHaZ3xPctz5P5lwpd7w/Dp7Y841iFv/H2GwvshIU7XaCJacrcZ9L5LGiBI2w0NyUXY7T83DXK2t9tpQul70uWNn0wHbmIt8h7/+aGzIvBu/ZxO520/YgmJCG7AAliZzUXc9OR+2kqIAZapdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F4oeZ7px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0A0C32781;
	Tue, 25 Jun 2024 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719297185;
	bh=tsP3ZTPJBEdI0PsuCtRuexzxDzB85NFpgLKwrg//dG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4oeZ7pxrTXWF6budLG9AoKZ31RtngmETFLagKhNmE8JoL4+HZzwL80mZgn4KRiIF
	 uXVIM1wDxGmzp9RrZ7LVeT3TQd7+1W1e6N4atsqH2e6P8sfLZyn8uVef/vqEgq9VOV
	 huQAT7cnTBogZLxXp9EMPRkAV0t5lNku2YKn+aAQ=
Date: Tue, 25 Jun 2024 08:33:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Schiller <ms@dev.tdt.de>
Cc: tsbogend@alpha.franken.de, stable@vger.kernel.org
Subject: Re: Patch "MIPS: pci: lantiq: restore reset gpio polarity" has been
 added to the 6.9-stable tree
Message-ID: <2024062554-numerator-enslave-d823@gregkh>
References: <2024062436-wrist-skier-47a6@gregkh>
 <fb91fed8b962373e995c0afa9757abf5@dev.tdt.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb91fed8b962373e995c0afa9757abf5@dev.tdt.de>

On Tue, Jun 25, 2024 at 08:28:25AM +0200, Martin Schiller wrote:
> On 2024-06-24 19:01, gregkh@linuxfoundation.org wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     MIPS: pci: lantiq: restore reset gpio polarity
> > 
> > to the 6.9-stable tree which can be found at:
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      mips-pci-lantiq-restore-reset-gpio-polarity.patch
> > and it can be found in the queue-6.9 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> 
> This patch is buggy and should not go into the stable trees.
> It has already been reverted upstream in the mips-fixes.
> 
> Thank you very much and sorry for the inconvenience,

Thanks for letting us know, now dropped.

greg k-h

