Return-Path: <stable+bounces-55929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA6291A14D
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 10:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04FF283783
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C1770F9;
	Thu, 27 Jun 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBxOamM9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D51CAB3;
	Thu, 27 Jun 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476464; cv=none; b=SE9NG+VMbCjGHLPGP9SBDjWR+UJxg5mt1t1+VZLoS0aHJlfCFEdH6UiVE7zkBUe0xonMGsfO6nTRbp5aq0UuDoe1rTw4epNOXqBT9fdFVC8fAbgOwqYIJzl9Fv1KXU2WbcYXQR/Hu5HE2sBETXvn7z0WRvQN3wmqMlvoNf/swz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476464; c=relaxed/simple;
	bh=3i/mb3lQF+zYNgRDubFvUfTK5wvAo3uSQa+lQxUp8og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfPTA2oVuOOBCMdyXR5JPAQ+e4A375VbsCynNrR6Rc74v+UV7qzYtsCIHg9C0MTEcYLcAqhQ4BX6MFx4s3EcnZHUSP9Hy50cG4NX3bUhVTAShnT3Lnmmveqqt9BEL79jMy4+LzzoprKAcjwSvjCBCX859At77hnixs0E+CpULGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBxOamM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B060BC2BBFC;
	Thu, 27 Jun 2024 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719476463;
	bh=3i/mb3lQF+zYNgRDubFvUfTK5wvAo3uSQa+lQxUp8og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBxOamM9n7UkfjXL40jWnl3UfjmlblyIqa509kEWzSN2udW/xKeXM1P6vRPu2Jcu9
	 hbP43hwYVGuDK2y+6VSShT6n0XOtP2ceK3bF5LoTU1N/9b+X/ruccTlefn8jhDYDYX
	 XyzuMa7UncNOe7m/9omLlzyIILh0kHMZx/mN9HtsBlQ5dBP/XcIhQBzJQuos5Njezl
	 dRqH2Aq/SXwyXH58WaZiVp6KZpPtfEo434igdbg6YhN6ksTqusy4f7IwArz9Vf1KNj
	 +J5Ct3BwwMMJ8IoonrjzniTAvejtxoY8c37LR6Gmiq5M6v0X2QbcrWKhUa1IPFFBFN
	 izXJ+woKqSOuw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sMkNY-0000000020a-3G6u;
	Thu, 27 Jun 2024 10:21:16 +0200
Date: Thu, 27 Jun 2024 10:21:16 +0200
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM350-GL
Message-ID: <Zn0g_I9VWFgcoUCU@hovoldconsulting.com>
References: <20240626133223.2316555-1-bjorn@mork.no>
 <Zn0WSAHHQQr61-Og@hovoldconsulting.com>
 <87ed8i958k.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ed8i958k.fsf@miraculix.mork.no>

On Thu, Jun 27, 2024 at 10:09:31AM +0200, Bjørn Mork wrote:
> Johan Hovold <johan@kernel.org> writes:
> > On Wed, Jun 26, 2024 at 03:32:23PM +0200, Bjørn Mork wrote:
> >> FM350-GL is 5G Sub-6 WWAN module which uses M.2 form factor interface.
> >> It is based on Mediatek's MTK T700 CPU. The module supports PCIe Gen3
> >> x1 and USB 2.0 and 3.0 interfaces.
> >> 
> >> The manufacturer states that USB is "for debug" but it has been
> >> confirmed to be fully functional, except for modem-control requests on
> >> some of the interfaces.
> >> 
> >> USB device composition is controlled by AT+GTUSBMODE=<mode> command.
> >> Two values are currently supported for the <mode>:
> >> 
> >> 40: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB
> >> 41: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB+AP(LOG)+AP(META)(default value)
> >
> > The order here does not seem to match the usb-devices output below (e.g.
> > with ADB as interface 3 and 5, respectively). 
> >
> > Could you just update these two lines so we the interface mapping right?
> 
> Thanks, I didn't notice that.
> 
> This part was copied from the Fibocom AT+GTUSBMODE documentation and
> seems to list supported functions independently of the resulting USB
> interface order.
> 
> I'm afraid I can't verify the actual order since I don't have access to
> this module myself, and there is no way to tell the AT, GNSS, META,
> DEBUG, NPT and LOG functons from eacohother based on USB descriptors.
> 
> The best I can do is dropping these two lines. Is that better?

No, I'll just amend the commit message to clarify that the order is
unspecified. Thanks.

Johan

