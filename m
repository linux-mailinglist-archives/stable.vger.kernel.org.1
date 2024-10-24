Return-Path: <stable+bounces-88027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9169AE270
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 12:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA52B21AA1
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4C1C07F8;
	Thu, 24 Oct 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YkrdX2bI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF91C174A;
	Thu, 24 Oct 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765411; cv=none; b=lcsFFnHl2oj5IrO1JJbJ3iQdur1bnn/0r8YZbhTChan+XORPfCrJgS004BgALd1MH4bUIJxx1clk9fPBv3EzMl1WAfs8Dx9gqEboTfUVyTg5Liqh7kHZuRcVYEfr61l8lmhCymBtJOMkf5Tk7CJy3BPCMmpO6yqn/3k88xqADUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765411; c=relaxed/simple;
	bh=sLem/rGrykk79e3RMqlPZLsw/40EPz5CsCor6sYGK1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMsfOdnL4ZuxkRsHui5nBy+Uy4k3vntkUFj8e/AJnUlBYIJe9yuJ5ogTok6dXofzvidUZz3hE5iLL6h6KT5hpGnNwT9krXxoUwAfuc+TV9s6HJGNoUMqT9xCemfK3/ou+qQ2f1LBGTeqg+EfnlxCV9Uabg1GCQ9RRuphkoUHggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YkrdX2bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ACEC4CEC7;
	Thu, 24 Oct 2024 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729765411;
	bh=sLem/rGrykk79e3RMqlPZLsw/40EPz5CsCor6sYGK1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkrdX2bINPCx9QEt7pcvUO9Jfx6ItBqW+F6S1OK86V9aTn3aDzUnS8g0J4rbqtqLa
	 DLiYBO/IoKLYFzqtz6uJGXX7mcQV51J7AZ7WsPwLLrsCD8sxIyfOgZMB6JqpB156b8
	 +xKMOjAhYy1CB9JPOE2VD2e2OIv8g7WbJlB07R6I=
Date: Thu, 24 Oct 2024 12:23:20 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"saravanak@google.com" <saravanak@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Seiya Wang =?utf-8?B?KOeOi+i/uuWQmyk=?= <seiya.wang@mediatek.com>,
	Singo Chang =?utf-8?B?KOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Message-ID: <2024102411-handgrip-repayment-f149@gregkh>
References: <20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.com>
 <2024102406-shore-refurbish-767a@gregkh>
 <88f78b11804b0f18e0dce0dca95544bf6cf6c7c6.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88f78b11804b0f18e0dce0dca95544bf6cf6c7c6.camel@mediatek.com>

On Thu, Oct 24, 2024 at 10:16:05AM +0000, Jason-JH Lin (林睿祥) wrote:
> Hi Greg,
> 
> Thanks for your information.
> 
> On Thu, 2024-10-24 at 11:47 +0200, Greg KH wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, Oct 24, 2024 at 05:37:13PM +0800, Jason-JH.Lin via B4 Relay
> > wrote:
> > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > > 
> > > This reverts commit ac88a1f41f93499df6f50fd18ea835e6ff4f3200.
> > > 
> > > Reason for revert:
> > > 1. The commit [1] does not land on linux-5.15, so this patch does
> > not
> > > fix anything.
> > > 
> > > 2. Since the fw_device improvements series [2] does not land on
> > > linux-5.15, using device_set_fwnode() causes the panel to flash
> > during
> > > bootup.
> > > 
> > > Incorrect link management may lead to incorrect device
> > initialization,
> > > affecting firmware node links and consumer relationships.
> > > The fwnode setting of panel to the DSI device would cause a DSI
> > > initialization error without series[2], so this patch was reverted
> > to
> > > avoid using the incomplete fw_devlink functionality.
> > > 
> > > [1] commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> > detection more robust")
> > > [2] Link: 
> > https://lore.kernel.org/all/20230207014207.1678715-1-saravanak@google.com
> > > 
> 
> Please don't mind me make a confirmation.
> I just need to add this line here and send it again, right?
> 
> Cc: <stable@vger.kernel.org> #5.15.169

Yes.

