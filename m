Return-Path: <stable+bounces-155311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C552AE37C1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629B57A424D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B3207DF3;
	Mon, 23 Jun 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FZvRXbK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7A2036FE;
	Mon, 23 Jun 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750665828; cv=none; b=JBtICbHIWg7jlx0KcQllO6zJG7mbfQAYAexOFL/vmn4jy5V2j4Ruo+2ZXBA7210GrwC2thfdRihtOhPqbm/c6+q/hlJkUJ2gJpswTP+A5Y7SFVmtS6BTrWGAu+DQOqjtgnbPGOF4IphGWZ9IhgubiV7PnACdT3yQg2qxmXSf/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750665828; c=relaxed/simple;
	bh=+5tLIPL4mupk3HsQHmmJo2/UPa4agOpGHIdMIH/PnqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtPBju+R5hRH4gVf5GkippyhkFHDYU4RbT+Y8bunzK+8MFB/iqUliAGRx9Kxlv0zbgUInZXlFPImn5BUWj8NxUE30tB57ZH8ABt7Q7W/cm5wRijUKN6YYpGQW9+z6yFmD8hu0nSoGJ3VBd8msWoKtx2eGS0txhtALvgk6Zvskl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FZvRXbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D8AC4CEED;
	Mon, 23 Jun 2025 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750665828;
	bh=+5tLIPL4mupk3HsQHmmJo2/UPa4agOpGHIdMIH/PnqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0FZvRXbK5+kYxPJe9hIj1PrFuODwbd+g0bg4bvxtLSZcS4NwiUmTkJJsjEIikDq2F
	 R7sInP+ntZuaaMB3NYX0sqvz4UaOJsLBDynsGq9xSTbaL+TCihCoNeqAPpMFeuoKNY
	 28LQ0KInP4SL84r7ATrQMp6E3z/5mE8bL/s5pU2g=
Date: Mon, 23 Jun 2025 10:03:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	ziyao@disroot.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH for 6.1/6.6] platform/loongarch: laptop: Fix build error
 due to backport
Message-ID: <2025062339-till-sloping-58b2@gregkh>
References: <20250622110148.3108758-1-chenhuacai@loongson.cn>
 <2025062206-roundish-thumb-a20e@gregkh>
 <CAAhV-H4S=z5O0+pq-x9X4-VjYsJQVxib+V-35g50WeaivryHLA@mail.gmail.com>
 <2025062349-proximity-trapeze-24c6@gregkh>
 <CAAhV-H7r-X-t0_i-x=oy2Gin4-ZMhSVwXtcaygZdJ1_J-zD3dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7r-X-t0_i-x=oy2Gin4-ZMhSVwXtcaygZdJ1_J-zD3dg@mail.gmail.com>

On Mon, Jun 23, 2025 at 02:36:18PM +0800, Huacai Chen wrote:
> On Mon, Jun 23, 2025 at 2:28 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 22, 2025 at 09:11:44PM +0800, Huacai Chen wrote:
> > > On Sun, Jun 22, 2025 at 9:10 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sun, Jun 22, 2025 at 07:01:48PM +0800, Huacai Chen wrote:
> > > > > In 6.1/6.6 there is no BACKLIGHT_POWER_ON definition so a build error
> > > > > occurs due to recently backport:
> > > > >
> > > > >   CC      drivers/platform/loongarch/loongson-laptop.o
> > > > > drivers/platform/loongarch/loongson-laptop.c: In function 'laptop_backlight_register':
> > > > > drivers/platform/loongarch/loongson-laptop.c:428:23: error: 'BACKLIGHT_POWER_ON' undeclared (first use in this function)
> > > > >   428 |         props.power = BACKLIGHT_POWER_ON;
> > > > >       |                       ^~~~~~~~~~~~~~~~~~
> > > > >
> > > > > Use FB_BLANK_UNBLANK instead which has the same meaning.
> > > > >
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >  drivers/platform/loongarch/loongson-laptop.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > What commit id is this fixing?
> > >
> > > commit 53c762b47f726e4079a1f06f684bce2fc0d56fba upstream.
> >
> > Great, can you resend this with a proper Fixes: tag so I don't have to
> > manually add it myself?
> Upstream kernel doesn't need to be fixed, and for 6.1/6.6, the commits
> need to be fixed are in linux-stable-rc.git[1][2] rather than
> linux-stable.git now.
> 
> I don't know your policy about stable branch maintenance, one of the
> alternatives is modify [1][2] directly. And if you prefer me to resend
> this patch, I think the commit id is not the upstream id, but the ids
> in [1][2]?
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.1&id=f78d337c63e738ebd556bf67472b2b5c5d8e9a1c
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.6&id=797cbc5bc7e7a9cd349b5c54c6128a4077b9a8c6

What we should do is just drop those patches from the 6.1.y and 6.6.y
queues, I'll go do that now, and wait for you to submit a working
version of this patch for those branches, so that we do not have any
build breakages anywhere.

Can you submit the updated patches for that now?

thanks,

greg k-h

