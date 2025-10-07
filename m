Return-Path: <stable+bounces-183549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC8BBC1EDB
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C9619A0D05
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A12E62BF;
	Tue,  7 Oct 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEmkLKWD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263C2E1EE0
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850801; cv=none; b=oX4dlDuo7J0ssVLaE8VHGtf4b4SfySmDXPz/dvvy0A38olrrVUbJOv1POEJvZcK+36dsc7OLiwMYgSWgQWckGJTHvO8WW4Foy/jh7QjgmD/KtyZkyUNbm5fH4R6q8mtLjC0jF78ACh+xx30u0VDk2Bl6aGgZIrl+lF+RQWApR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850801; c=relaxed/simple;
	bh=FsqhePDWRuiRAACsmByj4z/yoHGUIer3cs/fnexqmQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgiwPIwWlkflynZ3YPfKKaTBR5tVYM6ZoBAaHfkxRDRhVoB7Pbu/XuoFjhbPUOc5+XEm+/ZprP2CRjGpf/wSJKqbbtB9UGkHW837y8byuZZoSdkUPtIP+V5Oed7/TR2HV79jC90mzohTkDcvx2gT8MjFrwOYw6FcbJEKUT6nHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEmkLKWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F511C4CEF1;
	Tue,  7 Oct 2025 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759850800;
	bh=FsqhePDWRuiRAACsmByj4z/yoHGUIer3cs/fnexqmQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEmkLKWDvHJTHnI6+auIV2gpzZfoQOFQCZt4iJB2WdbG6ZJOzAg68wwbDptI9+uZU
	 Iig2YG+3ZhzPZ/CDRoilHBbqof9EH8adYiXiA2RQT41/doNFea7PocSuBjcFmW95XO
	 OXiO4mrM6Njhj3e57mRP3yufPt1Z4FJ2n/g1hCWo=
Date: Tue, 7 Oct 2025 17:26:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: Romain Sioen <romain.sioen@microchip.com>, stable@vger.kernel.org,
	jikos@kernel.org,
	syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] hid: fix I2C read buffer overflow in raw_event() for
 mcp2221
Message-ID: <2025100716-rockfish-panda-9c4b@gregkh>
References: <20251007130811.1001125-1-romain.sioen@microchip.com>
 <20251007130811.1001125-2-romain.sioen@microchip.com>
 <2025100751-ambiance-resubmit-c65e@gregkh>
 <3a44a61b-bd60-4dec-a5e6-8ad064203f2b@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a44a61b-bd60-4dec-a5e6-8ad064203f2b@arnaud-lcm.com>

On Tue, Oct 07, 2025 at 05:23:17PM +0200, Lecomte, Arnaud wrote:
> 
> On 07/10/2025 15:16, Greg KH wrote:
> > On Tue, Oct 07, 2025 at 03:08:11PM +0200, Romain Sioen wrote:
> > > From: Arnaud Lecomte <contact@arnaud-lcm.com>
> > > 
> > > [ Upstream commit b56cc41a3ae7323aa3c6165f93c32e020538b6d2 ]
> > > 
> > > As reported by syzbot, mcp2221_raw_event lacked
> > > validation of incoming I2C read data sizes, risking buffer
> > > overflows in mcp->rxbuf during multi-part transfers.
> > > As highlighted in the DS20005565B spec, p44, we have:
> > > "The number of read-back data bytes to follow in this packet:
> > > from 0 to a maximum of 60 bytes of read-back bytes."
> > > This patch enforces we don't exceed this limit.
> > > 
> > > Reported-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
> > > Tested-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
> > > Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> > > Link: https://patch.msgid.link/20250726220931.7126-1-contact@arnaud-lcm.com
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > [romain.sioen@microchip.com: backport to stable, up to 6.12. Add "Fixes" tag]
> > I don't see a fixes tag :(
> Hey, I am the author of the patch. I can find the fixes tag if this looks
> good to you.

There's no need for a fixes tag, just let us know where you want this
backported to.

thanks,

greg k-h

