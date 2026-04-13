Return-Path: <stable+bounces-235975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN4bDPi33Gn2VgkAu9opvQ
	(envelope-from <stable+bounces-235975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:31:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983193E9DDB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60C2B3018BF4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4733ACA6F;
	Mon, 13 Apr 2026 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gyDZknSe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667237CD44;
	Mon, 13 Apr 2026 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072526; cv=none; b=Mv/Xk3s9tYZPc41KcRZTYJHLo21+66psxyIc8NnTD/bz5qGno6FK003bRghtRzS9edYQJgAp/l0xbmcPovV4A/kHAZuy+Z7n2EiV1CCND50Sp5jcKVGdMKXy8Wj26PBsGh6Atv051oSSUL9NTjjUCrUcpElwpTQUHwhOWqoAhbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072526; c=relaxed/simple;
	bh=swrqoNRI7b5SyUeon1VlvSsyJjrUtH0QoZ70SUxzLKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hS3fMtp8AnxeMDwlKMvZPXekTz+7mkUtWvIuyo8LcfMwrEzOUPH5QLrrIhPReZUM02BoPXlK2v5zmiy6PH5rHgn2hgxrwudfH4B28/usCwUJ3JI6PF8IXgkNkxXZH4izJiBOpriuKRnJmkdrOCdROIQFvGpMX7XOcq5IjREo/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gyDZknSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADE2C116C6;
	Mon, 13 Apr 2026 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776072526;
	bh=swrqoNRI7b5SyUeon1VlvSsyJjrUtH0QoZ70SUxzLKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyDZknSe9kOXSE3sMi0i4SzDbRCLiYA4OE3DsVfsKOLbnn0On0cnQ/38++ZaxKvRQ
	 uRDaSuFHypp2hIXrzmsT4vSVmIzRh7rQGEfL4aTtC+yXiKf/H50NlVt65Kw/FVRIGP
	 0RXDFEjxXTP3nhAgmtZZpG456tjmDtpUy3yZfKgk=
Date: Mon, 13 Apr 2026 11:28:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Hans de Goede <hansg@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: fusb302: Switch to threaded IRQ handler
Message-ID: <2026041357-diabolic-knickers-e504@gregkh>
References: <20260317-fusb302-irq-v2-1-dbabd5c5c961@flipper.net>
 <2026040344-uncouple-maroon-69a1@gregkh>
 <CAKTNdwGqKqK80-B75Bto7muzqdKoqCuCUaxVwNx=9Cs+fb8WsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKTNdwGqKqK80-B75Bto7muzqdKoqCuCUaxVwNx=9Cs+fb8WsQ@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235975-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,flipper.net:email]
X-Rspamd-Queue-Id: 983193E9DDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 12:59:11PM +0400, Alexey Charkov wrote:
> Hi Greg,
> 
> On Fri, Apr 3, 2026 at 10:36 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 17, 2026 at 08:30:15PM +0400, Alexey Charkov wrote:
> > > FUSB302 fails to probe with -EINVAL if its interrupt line is connected via
> > > an I2C GPIO expander, such as TI TCA6416.
> > >
> > > Switch the interrupt handler to a threaded one, which also works behind
> > > such GPIO expanders.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 309b6341d557 ("usb: typec: fusb302: Revert incorrect threaded irq fix")
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > ---
> > > Changes in v2:
> > > - Re-added the IRQF_ONESHOT flag to the request_threaded_irq() call
> > >   (thanks Hans de Goede and Sebastian Andrzej Siewior)
> > > - Link to v1: https://lore.kernel.org/r/20260311-fusb302-irq-v1-1-7e7105706629@flipper.net
> > > ---
> > >  drivers/usb/typec/tcpm/fusb302.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> > > index ce7069fb4be6..889c4c29c1b8 100644
> > > --- a/drivers/usb/typec/tcpm/fusb302.c
> > > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > > @@ -1764,8 +1764,9 @@ static int fusb302_probe(struct i2c_client *client)
> > >               goto destroy_workqueue;
> > >       }
> > >
> > > -     ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> > > -                       IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
> > > +     ret = request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
> > > +                                IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> > > +                                "fsc_interrupt_int_n", chip);
> > >       if (ret < 0) {
> > >               dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
> > >               goto tcpm_unregister_port;
> > >
> >
> > I'll take this, but the testing systems rightly point out that
> > chip->gpio_int_n_irq may NOT be initialized before this call is made in
> > some situations, so this whole irq handler might never be set up.
> 
> Thanks for the heads up. I've been staring at this code from different
> angles for a while but I can't see how gpio_int_n_irq can remain
> uninitialized and the function still reach this point in the control
> flow:
> - The whole `chip` struct gets zero-initialized at the beginning of
> the probe function
> - For non-zero values of `client->irq` this field is explicitly set to
> the (non-zero) value of client->irq
> - For zero values of `client->irq`, the helper function `init_gpio()`
> is always called. This function either sets this field to the result
> of a `gpiod_to_irq()` call (which must be a valid interrupt number) or
> it errors out early, terminating the entire probe before control
> reaches request_threaded_irq()

Ah, it's this last thing that I, and the compiler test, misses, sorry
about that.

So all is good here, thanks.

greg k-h

