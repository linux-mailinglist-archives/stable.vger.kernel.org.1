Return-Path: <stable+bounces-161586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED8B0053B
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D2B5A3057
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C40272E54;
	Thu, 10 Jul 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUFAYUfs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AA272E44;
	Thu, 10 Jul 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157623; cv=none; b=lmyTzZTgADXlNHEH3e56C57EOn4I0qMBVL5kqQI/Xad0ABjb2brWiEM3d2QxQSKC1TgbyUaZy0IF3oeVzqpI2Qs3jy7HOHiW6d2eGclOJemm2zWhR1pFP9v3gMfi3JCZJ7jnl+8joZuWZG5RwBlCRzdwWqXmiFVVkIjAL+nM6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157623; c=relaxed/simple;
	bh=Lp0YKCDEbOTykxsN9b7ISwn3sIb0ktutrPOjgADtWTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY4QL8YoWrSxKxe4jIAuzRpmokqrOZ4GflKeFffEvJ8uIHyjbeG9tvwzclrC/Yd8GbYR24GwgsIJ8VGE3rIcfjhFpqkcGc6PVVAJiY1602isAvAz8FehkFG9S3fQ2COMfEx3q891tgfj5WPj8f9R+4DuIhCYO/FNgkIakemFGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUFAYUfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE687C4CEE3;
	Thu, 10 Jul 2025 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752157622;
	bh=Lp0YKCDEbOTykxsN9b7ISwn3sIb0ktutrPOjgADtWTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUFAYUfs+dQsYzEFb4sR6gIxcqKZVzRQ/A0iSgpF4lSWWIhnM9cREvEsr4Mt8C8Jd
	 YFhgYhAGdxo5WyS/33r3fYg1ZXqSnrEw+ZKGTw5DA93cGRmTuifePdfIWiShqsT51E
	 WTvbkOiGJWR53vS9fcFX+Dx60WACbt2noQxtmEZ/l2TJCQoSCLEMc4p+48kCdtGguj
	 BWYyvhMiBimhWkBWB5dvY5WglYBDCudet8N2FIO/MTOwAx3eoKhp52kw7XVwKk06K1
	 ZHTYbhjow1GgDk2Sz+TIur3ilq7tGw626x6MKDLmyMv2pRIqz14Uxj/fLG85N5FkkN
	 T7hchzHvKTMdg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZsEi-000000005Bb-2yia;
	Thu, 10 Jul 2025 16:26:56 +0200
Date: Thu, 10 Jul 2025 16:26:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit Cinterion FE910C04 (ECM)
 composition
Message-ID: <aG_NsFLI5UsVvYkt@hovoldconsulting.com>
References: <20250708120004.100254-1-fabio.porcedda@gmail.com>
 <aG4_jEQmeD9a_oWo@hovoldconsulting.com>
 <CAHkwnC9tb=SZXsP7t8oeNPJ24pij4Y1ayFVRk6tqLhzc5zbsqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkwnC9tb=SZXsP7t8oeNPJ24pij4Y1ayFVRk6tqLhzc5zbsqQ@mail.gmail.com>

On Wed, Jul 09, 2025 at 12:50:27PM +0200, Fabio Porcedda wrote:
> Il giorno mer 9 lug 2025 alle ore 12:08 Johan Hovold
> <johan@kernel.org> ha scritto:
> >
> > On Tue, Jul 08, 2025 at 02:00:04PM +0200, Fabio Porcedda wrote:
> > > Add Telit Cinterion FE910C04 (ECM) composition:
> > > 0x10c7: ECM + tty (AT) + tty (AT) + tty (diag)

> > >  /* Interface does not support modem-control requests */
> > >  #define NCTRL(ifnum) ((BIT(ifnum) & 0xff) << 8)
> > > +#define NCTRL_ALL    (0xff << 8)

> > > +     { USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),     /* Telit FE910C04 (ECM) */
> > > +       .driver_info = NCTRL_ALL },
> >
> > Please just use NCTRL(4) here. (And remember to mention additions like
> > this in the commit message in the future.)
> 
> Ok, I will send a v2.
> 
> > Or do you have reasons to believe the interface numbering may change? Or
> > is it just to avoid matching on both number and protocol?
> 
> The interface number should not change, it's just to have a more
> generic definition that matches also other pids for the same soc. I
> think it's easier to write and less error prone because the interface
> number changes based on the PID.

Yeah, I can see it having some merit. Maybe I reacted to the naming as
I at first incorrectly read it as no interface supporting the control
request (perhaps naming it "NCTRL_ANY" would have avoided this).

But for consistency I think we can continue using the interface numbers
until we have some better abstraction for these that can be used to
avoid also the explicit per protocol entries.

Johan

