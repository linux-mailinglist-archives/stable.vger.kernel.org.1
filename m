Return-Path: <stable+bounces-155294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D09AE35B0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17121891EDD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76AD1DC9BB;
	Mon, 23 Jun 2025 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oRnFs++g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A861A072C;
	Mon, 23 Jun 2025 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660096; cv=none; b=T9t+9RburUzqmfyZ1AYyoVNIT60YulFiLyp78ecc7LeQYQ7wK0VUYYi6j8MVbAbQaIvjCHW7p6zNiacbjTXvMM1s39Dv/fyC2xurVaMYVj9bb9WAmmiiaTKLhIbeFMdlwcAvqOjF+8DvTDCxlJHJZTZCSkeUFSw09QL2iWbIgOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660096; c=relaxed/simple;
	bh=HagfiHIsWhwV2eaS8RFEYMwbq2J6hxG1xCpPj6Ss2ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTRI5ls0RzVrEIDZHcOqevy6QYk458zRLo1LbP+3blb//qOAVaKJxnwClJQJaahwemJTCyTqXwf5PWS5dGUnGEkLiU6n9zr3dnCzBBhrT8t1l0i9tmWsMOrVBxal6s4YGvX9gDAOlS2csPe41WIgIkennHnNIosdQxS0MC+698U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRnFs++g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DECC4CEED;
	Mon, 23 Jun 2025 06:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750660094;
	bh=HagfiHIsWhwV2eaS8RFEYMwbq2J6hxG1xCpPj6Ss2ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRnFs++gnVEAvl7o7Ruxy8QBPqaKMkhUB7gQkDl+ezSTSZ+zUvWqDcRY0prZIy4sC
	 8Mc3a0ffakJzlX376fFqrGTmzQ2vT2UXdvDLoaK5BXFqo7EOhOFAxwZC8M3HnAZL0X
	 j56JDN34QgevP+OcQPRvKX8eNK9RtBv6xZXjlit8=
Date: Mon, 23 Jun 2025 08:28:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	ziyao@disroot.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH for 6.1/6.6] platform/loongarch: laptop: Fix build error
 due to backport
Message-ID: <2025062349-proximity-trapeze-24c6@gregkh>
References: <20250622110148.3108758-1-chenhuacai@loongson.cn>
 <2025062206-roundish-thumb-a20e@gregkh>
 <CAAhV-H4S=z5O0+pq-x9X4-VjYsJQVxib+V-35g50WeaivryHLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4S=z5O0+pq-x9X4-VjYsJQVxib+V-35g50WeaivryHLA@mail.gmail.com>

On Sun, Jun 22, 2025 at 09:11:44PM +0800, Huacai Chen wrote:
> On Sun, Jun 22, 2025 at 9:10 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 22, 2025 at 07:01:48PM +0800, Huacai Chen wrote:
> > > In 6.1/6.6 there is no BACKLIGHT_POWER_ON definition so a build error
> > > occurs due to recently backport:
> > >
> > >   CC      drivers/platform/loongarch/loongson-laptop.o
> > > drivers/platform/loongarch/loongson-laptop.c: In function 'laptop_backlight_register':
> > > drivers/platform/loongarch/loongson-laptop.c:428:23: error: 'BACKLIGHT_POWER_ON' undeclared (first use in this function)
> > >   428 |         props.power = BACKLIGHT_POWER_ON;
> > >       |                       ^~~~~~~~~~~~~~~~~~
> > >
> > > Use FB_BLANK_UNBLANK instead which has the same meaning.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/platform/loongarch/loongson-laptop.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > What commit id is this fixing?
> 
> commit 53c762b47f726e4079a1f06f684bce2fc0d56fba upstream.

Great, can you resend this with a proper Fixes: tag so I don't have to
manually add it myself?

thanks,

greg k-h

