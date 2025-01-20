Return-Path: <stable+bounces-109506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14702A16B14
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 11:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F61F169454
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51781B6D10;
	Mon, 20 Jan 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTQ5JTL7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF1187872;
	Mon, 20 Jan 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737370559; cv=none; b=NiBDgJjdIDEzANm1yEsr+ulenwkSSfvARMDWqtXVLw45LLrb8T1L2yA5IvitR2qxDAlIGiRuqV6b3IWAjuynIBk5p72jsimBV9ZY/fCA7vlTSvH0cNYeN82wCWj3Z86aTzHUmyNBkdi+LbgmoFNwBBWv+Cw+L9SOVNKDAQ5MFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737370559; c=relaxed/simple;
	bh=ZQplCrnYOIJgt1Q4Im1edYAEoa42Ovah9tI2/a2kdgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeLxx35m+a6jGZR3Bo1gd1JPAShHuL9n2I22/DqX/WK6hkrwMR7gh2wmYlyVT9U/jPD35rQcDa7mM0Sd7o5GzS6J4rUfmXl/CUAOG1D9gz1CvCDiyFlZBGQZiuslTPyXHYErqJOtC8ZTQtRIefRLskTHaZ3sg56El8cdsUL4QTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTQ5JTL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945CEC4CEDD;
	Mon, 20 Jan 2025 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737370559;
	bh=ZQplCrnYOIJgt1Q4Im1edYAEoa42Ovah9tI2/a2kdgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTQ5JTL7+IQhKWbNc1y/3/7SIIkqFYBaZtZ8AXf1aBMQazQT9CVM+L1FyuyPAS9eQ
	 g2im9+RBnINnOKtEG7yvHFQ11zYWmORcgjcRKUvRnQA3YShR8bLRFsKswhWskNmjgg
	 +KclRy30xRTN4srUKDzt0UwGcr857HmMoZYUvSPqumSInVezXZEju40TwG61Du+7eg
	 BnZJsNjLS2ClWt5KHJL04GS2rntKJxsOcnHFILyvnrK379Sne0LzDv6AYbVW5+f0Ct
	 D5AEgQ8J5kIjSKDBsoQot3deZAlN7CRC7visgdNDTAehX7jV8Ucsm+uCvjCNdQsfa6
	 VSgMnkUbEC6+g==
Date: Mon, 20 Jan 2025 10:55:55 +0000
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] atm/fore200e: Fix possible data race in fore200e_open()
Message-ID: <20250120105555.GV6206@kernel.org>
References: <20250115131006.364530-1-2045gemini@gmail.com>
 <20250116165914.35f72b1a@kernel.org>
 <CAOPYjvaVZAHqWhzYsLjtc4Q8CSCF2g4bG-efLHPOP_NMSs0crg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOPYjvaVZAHqWhzYsLjtc4Q8CSCF2g4bG-efLHPOP_NMSs0crg@mail.gmail.com>

On Fri, Jan 17, 2025 at 10:28:59AM +0800, Gui-Dong Han wrote:
> > On Wed, 15 Jan 2025 13:10:06 +0000 Gui-Dong Han wrote:
> > > Protect access to fore200e->available_cell_rate with rate_mtx lock to
> > > prevent potential data race.
> > >
> > > The field fore200e.available_cell_rate is generally protected by the lock
> > > fore200e.rate_mtx when accessed. In all other read and write cases, this
> > > field is consistently protected by the lock, except for this case and
> > > during initialization.
> >
> > That's not sufficient in terms of analysis.
> >
> > You need to be able to articulate what can go wrong.
> 
> fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
> In this case, since the update depends on a prior read, a data race
> could lead to a wrong fore200e.available_cell_rate value.

Hi Gui-Dong Han,

I think it would be good to post a v2 of this patch with
an explanation along the lines of the above included in
the patch description.

