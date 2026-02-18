Return-Path: <stable+bounces-217312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH8lKFD0lWlTWwIAu9opvQ
	(envelope-from <stable+bounces-217312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 18:18:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE515832E
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 436F93012E84
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8BC33D4FE;
	Wed, 18 Feb 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4g8Qx9R"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181CA23909C
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771434935; cv=none; b=u00hNasYr99mnQ2tHbxKBdXjmde0/FR00B4N5/xwLpAbPtTySlfAijAUuonsv4/U2Tlv24dPn+EZ6MtSDBEOn1bL53qGLnqpZma/DOte9cEszLCli9vJNUGZRGNw9O0kwcxGiyQQsTjqbQZM7EAq88FMLPHM7kiXVXwO+fyM4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771434935; c=relaxed/simple;
	bh=Q9ooPQVTGTcVJezfW6R+eFguPYeeOCmuofwhzMEcloE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjsGkvObX8U/GQG3xqknamc0o3+58TsDf0VopoTC79vaXEZ546hlCC5IU6+0TYLgrmn0OiUA+8mx7oc0lY698eIMPscc3LorcjfcgqPq948r2/m/stofk0LKFmRpNhM4g48pe3YVHdBPNGGdlzt8e8s+iZWDrs2X3owGT0PiHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4g8Qx9R; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-126ea4b77adso6906608c88.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 09:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771434933; x=1772039733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wIZQJcadFJwIiNdmilqedpFYEso+tQwK1rGzbwDAdbY=;
        b=A4g8Qx9RHBdDCRZPnmspn153wPXv/iwgGb9oWxb/dbrKzEZrt5NcSBFKWtOrdSSX9b
         3xefLpNJfZW37VIhvrnwJ19AoDRRnIBwAhLW0jUz3liS2CPTw0p3wMHaSW+plpbENmxT
         bmImBV0NkWBfV9wSEhXE05Phq9e++/x9AoAbYKIhGXXNcaV/cwjLe5MjKPs0f+3hxDzs
         lwUccqVlwjAkjlxjyVKU0lGDtiu21K9OlUmU5CD4Z6p0V4IO+xYB8wnuD6w1gSqlAg3h
         wAqGRtxrmez6c7AG1dbIhG5xnddg3XfYstdc8B2eMlx52Yzl70p5/f9ggkDFz1PTlR8k
         0b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771434933; x=1772039733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIZQJcadFJwIiNdmilqedpFYEso+tQwK1rGzbwDAdbY=;
        b=Lws5PJADBPFrklWF6Xhe09BwKPfGBwx5eziZwFhDAd0y20Lmab4kFSfZYdCvARTBZl
         MarorZnfCyYOl+P0Iz6xDQOr5ZSUiIz4y4qBoEDzVswZ9ZXGw1YbirSa/AkeTCmTUcZ8
         PUnD+lPQwzqL/+dhDZDrrxXYe8r789r3A8oSxv2EImJGX25KRxocJAScj5YJMjleW4KG
         +/N2KgMZsZmRnBKkhHiObhwP5yGKckUcx+sefmocrG8bvRGyvPRdkUHjGoNIK72hEgyI
         S6i7SY9By0v/gMVPqVip5xwLvAO3gFEZvTo5GA65eOIiBKszTlFAPZ6e7q04sDHCFs8n
         QBXg==
X-Forwarded-Encrypted: i=1; AJvYcCUJY7iez4Cnl8bxrQzG9Nwu/1Oz1tBlT6qx3uW7oBB/4PO3jHXA2GWKl/0Kh80ty/AVB1GTrAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyohPvRgnvEj85P1GUyFyJxhtnus0H8CuLKXegN6PZBBcB3OU5/
	kjoDTwuHeKiiVGANh/N3UdVzADEaRVAMp35d+cGWtWa70NzgDnyB8Xc9
X-Gm-Gg: AZuq6aIVSr4dyD9OT0a0Te8W/mc6kynrT9vA8W9ljND0b+EnxMKY2IBjPunwgVrVagv
	SuESW7ASTJoX9xdOI9Q9IZMhve1nycrq9YIKarVuctb/nJuaWeHPlbNNuPqsIDRev83ujEKKtzI
	PV0RAiO5fdFDADvy2znEztlKLfWzVyQbhlynFlGWaVKI8l5aTgzzdbWPFJrURIg2hJMy/SvR3aa
	3H4wBV4w5bFoMN9LQiacdhzat9zx6pCEqx1ggmxUk6Ug6zEpGqDlTiGXgOKkVA5hr4+QDUuIao1
	H+P/RiutFzmts19PwmyP09n9Fa5KFV58eQ9piwRcT1ha33CX/Uy6IzYAlYbSKgdmoUqGQdUsXPM
	qfuo+RtL9wa4VfMMu8X49Oy8cpHAVVABfz31o8mzK7HByq1hFc42ghkHklIy2DQHyLmWUeSSb22
	kdvqFFKUooRiiC7fvS8PcjGRY7x/01Zn44LFuuOW6ZYT+jVJh/EzJQlOgs0DianQqk
X-Received: by 2002:a05:7022:60b:b0:11b:9386:a37d with SMTP id a92af1059eb24-127398466d9mr5205084c88.44.1771434932895;
        Wed, 18 Feb 2026 09:15:32 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb5622f2sm22285550eec.10.2026.02.18.09.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:15:32 -0800 (PST)
Date: Wed, 18 Feb 2026 09:15:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: swnode: restore the
 swnode-name-against-chip-label matching
Message-ID: <aZXyPjIjIDKCBLvs@google.com>
References: <20260211085313.16792-1-bartosz.golaszewski@oss.qualcomm.com>
 <aZUIFiOYt6GOlDQx@google.com>
 <CAMRc=Md_x+DxmW742HRUW-jeg9_AW-stKkHUP9z13+M+POd4Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md_x+DxmW742HRUW-jeg9_AW-stKkHUP9z13+M+POd4Tw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217312-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,intel.com:email]
X-Rspamd-Queue-Id: 49AE515832E
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 09:42:28AM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 18, 2026 at 1:31 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Wed, Feb 11, 2026 at 09:53:13AM +0100, Bartosz Golaszewski wrote:
> > > Using the remote firmware node for software node lookup is the right
> > > thing to do. The GPIO controller we want to resolve should have the
> > > software node we scooped out of the reference attached to it. However,
> > > there are existing users who abuse the software node API by creating
> > > dummy swnodes whose name is set to the expected label string of the GPIO
> > > controller whose pins they want to control and use them in their local
> > > swnode references as GPIO properties.
> > >
> > > This used to work when we compared the software node's name to the
> > > chip's label. When we switched to using a real fwnode lookup, these
> > > users broke down because the firmware nodes in question were never
> > > attached to the controllers they were looking for.
> > >
> > > Restore the label matching as a fallback to fix the broken users but add
> > > a big FIXME urging for a better solution.
> > >
> > > Cc: stable@vger.kernel.org # v6.18, v6.19
> > > Fixes: 216c12047571 ("gpio: swnode: allow referencing GPIO chips by firmware nodes")
> > > Link: https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > > ---
> > > Changes in v2:
> > > - check if gdev_node and gdev_node->name are not NULL before trying to
> > >   match the label (Hans & Dan)
> > > - use the right link
> > > - collect tags
> > >
> > >  drivers/gpio/gpiolib-swnode.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
> > > index 21478b45c127d..0d7f3f09a0b4b 100644
> > > --- a/drivers/gpio/gpiolib-swnode.c
> > > +++ b/drivers/gpio/gpiolib-swnode.c
> > > @@ -42,6 +42,25 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
> > >
> > >  fwnode_lookup:
> > >       gdev = gpio_device_find_by_fwnode(fwnode);
> >
> > By the way, should we extend gpio_device_find_by_fwnode() to use both
> > primary and secondary nodes?
> >
> 
> That's already done on a higher lever for all fwnodes in gpiod_fwnode_lookup().

How exactly? I am not talking about checking secondary node for the
fwnode that is used in the reference, I am talking about secondary
fwnode that might be assigned to the gpio chip and you need to check
both primary and secondary if they match with the fwnode that you call
gpio_device_find_by_fwnode() with.

Thanks.

-- 
Dmitry

