Return-Path: <stable+bounces-210689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABBnH3VlcGmGXwAAu9opvQ
	(envelope-from <stable+bounces-210689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:34:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D151926
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2ED5E354D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405B41C30A;
	Wed, 21 Jan 2026 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0RxuFE9"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD50410D27
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973666; cv=none; b=c6JYO/tjHEQti+UnGpreHTgt4tJaAhH0YQ6eQxomY2WSUmBXpq40nh9H7b7GBkXze0kLr1WEqbwL8+0sOCmsEw+101kkSoyH8QZkIw5xwCoVq6Ra7YXiY3bQe4ZOXsmEx55Gh7U3o9hrm7xzdMP0s1gF8mBvglTBPTN41ZHLE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973666; c=relaxed/simple;
	bh=kGMn/SzteXybWLySz6wGLPTY2zt9TaoQFMuFNdgvwSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbzJ3YnRmW+/rXgnigkC4F1AfnZCEBd05SfLs5ToPd5Bo2xfWJ+fK/ZnhAPrTuir63d/tAFUw4gPXlZ/qqsy+pvavXNzQJMWwg7T7oCOXcYoayl0KLAi+wRtZd/zfHSAvtxHPXRzmBKb1Dd6/y6iWcIPEQ2WfQ4tUUe9gK3PlHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0RxuFE9; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12336f33098so5124662c88.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 21:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768973661; x=1769578461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0QFwipTPR5DqdzbEaQ8Ys+o+tWAmaO3Qrn/zG23vmY=;
        b=h0RxuFE9pL96f6DRdLh5CwKYK1TxDP3fgG+lAm5Pt6LvMG80kl9Ui+g8HWpYgSkKWj
         2qDHXWAYSiKJA9yZFimGMTbdceNHa1XYoq2yGre7R/a3iGJ0jtLdQf7ckMZ7iFL7dWGq
         vVlrXzqeTFcFNl2lrqJhKXqZnblTq1+ESjUm8wmnGxbtVZqIu7+s84gjrPSJTEH78VwM
         rBEkZQmqzzv0exjvZDrw7VjOzvYbukZJk9SYb+IDtQOKglRwllT+1aBtMzMs7ntCxhut
         96sB+3kzjlo2WXPHc7L9rt/9US6D47qeyLDKhqiuydPnoqamGgpRTDo9jEKU1GMLb5LV
         Lv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768973661; x=1769578461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0QFwipTPR5DqdzbEaQ8Ys+o+tWAmaO3Qrn/zG23vmY=;
        b=Yxt28SjRZsVLfAiho583Ig411D7xIuhvpBBIBIsYKM2BaC5LukfDGg3TaEwfjzsQMU
         jCFu6EGHTQS5ejst1T17BhNe4t0iH2Q/YIK7q+u+BhU/H1MHyEar/d4VfsWF8fbMruaM
         5fp2ULOGJjvZptVGgEw6luOvRL8BkzNhFMMGWJPRnoLpViUEVwAG0C8BJ+aI6uv7VA80
         K2/G8KnuaEI+dp5/QSiRjwBUhgL0nj6XaTK4vu3tPabGaKEhsSLdm2HxMyh5kzRB+6Ei
         j7PzHQuE/sNGGUL/ee7I8hGEeqUIYBBMbgphqVTmM4q08F2uuxIsxKqw5Cp5XzF7Lrnc
         Geow==
X-Forwarded-Encrypted: i=1; AJvYcCVtFHCLrmp5txFKByf57PF8FFrZEJ7vFNCsfNSRU+Y/L3ZRd1IiL99bCppkfiESaW45dU4JDvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8lPXlSqwRrvf1KYwOlgA2sVi2fo/xfvBTr6T4IjDPxWVz1yQ
	qfKpte5zSgfBjcRF+/sZT2aEVoJovu8cXKSs85K/1Po9Z0IpzZS/3UdM
X-Gm-Gg: AZuq6aIJmK4luduD+m0j68+nq69tLeAKxgOWvtdrWJIhnO3VYkHjyXsF696dnI60RNk
	bGknCWCYisv6J4ctvnsvJ7q9bp4n20eoDKLF6DvIT/KkkSjrBO5GI+TU7AJ6UHjsgz1f5hYnBCd
	1oOmA76C5EpITW0TcvRsFpIDhO+ilAEuDZ38RwQ5DBDpFlgGXxecwUXAmNPQHQku8eTIUgZRitF
	xyrEgXGl8DnvaRfqUfTFKYbEE2+9hBMJM2Ctu8y7mUKaRHM2GJEfRJaNOGqvlTD68cjeLrGZi5J
	VTNrP64Yh5s2mM+ucCCxtb4UXDwl+WnB2yr8QCkB/+Q7fETxai/zuwoHBYXNAge4wnUp5Pw5xyJ
	PqdaDyZpljrv61csSDfa4JuoGEj5qyXFOFjlmvclAT4uLYG0FUt+X8xQhTV7og6cIJxEhDm/FJj
	qBOMJwGoRzxKtO+Z1mOWs6Kn65RmEN4oL2A5s+1fXD9UqF2n/EmbOp
X-Received: by 2002:a05:7022:f304:b0:11b:9386:8254 with SMTP id a92af1059eb24-1244b36f538mr12507910c88.41.1768973661409;
        Tue, 20 Jan 2026 21:34:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361df88sm19588566eec.18.2026.01.20.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:34:20 -0800 (PST)
Date: Tue, 20 Jan 2026 21:34:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Minseong Kim <ii4gsp@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] input: synaptics_i2c - cancel delayed work before
 freeing device
Message-ID: <ztalz7evj3yijuzx7m6yyealexdbfpky3ksughcv2n2ieamvwg@zbudj3q7oga5>
References: <20251210032027.11700-1-ii4gsp@gmail.com>
 <xeski4dr32zbxvupofis5azlq2s6fwtnuya7f3kjfz5t7c2wnq@jbvlajechlrd>
 <aTlmwhOF3zB1UkrI@kernel.org>
 <py7u3qpp6s4nfdceefufkjpbyhkj7wp2kyetlw54vlhdp4gmwn@6vghr6bqkbxc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <py7u3qpp6s4nfdceefufkjpbyhkj7wp2kyetlw54vlhdp4gmwn@6vghr6bqkbxc>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210689-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E44D151926
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Dec 12, 2025 at 08:38:23PM -0800, Dmitry Torokhov wrote:
> On Wed, Dec 10, 2025 at 09:25:38PM +0900, Mike Rapoport wrote:
> > Hi,
> > 
> > On Tue, Dec 09, 2025 at 08:40:54PM -0800, Dmitry Torokhov wrote:
> > > Hi Minseong,
> > > 
> > > On Wed, Dec 10, 2025 at 12:20:27PM +0900, Minseong Kim wrote:
> > > > synaptics_i2c_irq() schedules touch->dwork via mod_delayed_work().
> > > > The delayed work performs I2C transactions and may still be running
> > > > (or get queued) when the device is removed.
> > > > 
> > > > synaptics_i2c_remove() currently frees 'touch' without canceling
> > > > touch->dwork. If removal happens while the work is pending/running,
> > > > the work handler may dereference freed memory, leading to a potential
> > > > use-after-free.
> > > > 
> > > > Cancel the delayed work synchronously before unregistering/freeing
> > > > the device.
> > > > 
> > > > Fixes: eef3e4cab72e Input: add driver for Synaptics I2C touchpad
> > > > Reported-by: Minseong Kim <ii4gsp@gmail.com>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
> > > > ---
> > > >  drivers/input/mouse/synaptics_i2c.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> > > > index a0d707e47d93..fe30bf9aea3a 100644
> > > > --- a/drivers/input/mouse/synaptics_i2c.c
> > > > +++ b/drivers/input/mouse/synaptics_i2c.c
> > > > @@ -593,6 +593,8 @@ static void synaptics_i2c_remove(struct i2c_client *client)
> > > >  	if (!polling_req)
> > > >  		free_irq(client->irq, touch);
> > > >  
> > > > +	cancel_delayed_work_sync(&touch->dwork);
> > > > +
> > > 
> > > The call to cancel_delayed_work_sync() happens in the close() handler
> > > for the device. I see that in resume we restart the polling without
> > > checking if the device is opened, so if we want to fix it we should add
> > > the checks there.
> > > 
> > > However support for the PXA board using in the device with this touch
> > > controller (eXeda) was removed a while ago. Mike, you're one of the
> > > authors, any objections to simply removing the driver? 
> >  
> > No objections from my side.
> 
> Hmm, it looks like it is still referenced from
> arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
> 
> Marek, is this device still relevant?

I see these devices (SanDisk Sansa Fuze+) for sale on e-bay, so I guess
there is a chance it will be used...

Minseong, could you please prepare a v2 that would check if the device
is opened in resume before restarting polling? It should take input
device's mutex and then use input_device_enabled().

Thanks.

-- 
Dmitry

