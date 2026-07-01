Return-Path: <stable+bounces-270253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VIUnGyGJRWqkBgsAu9opvQ
	(envelope-from <stable+bounces-270253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 23:39:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCEC6F1E3F
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 23:39:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JsEPiXJG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270253-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270253-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 555D03045842
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258C83C0621;
	Wed,  1 Jul 2026 21:36:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BE126BF7;
	Wed,  1 Jul 2026 21:36:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941787; cv=none; b=tyLsnqVLP9ATdhpSCNibUP5dqg7ZJ9YAGELS0PfHt9yEZGZ5KRtLHYB9MRjX/pf5dWy6JX8UsPfsT95jIjVMRotlo1iqgaC0AdJ2adUE791kSRfBmfGKKzwftOXk8/OLdLDd4vdh0nj6mLj48M8EfjZz8f5CxUgiH7VnezGzw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941787; c=relaxed/simple;
	bh=HbpNaRpWDDCBeG6ANkvOf/buiFuDy8gK4KPQhWjEMlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKkV4440h0Xj/da1IuIotWhF+hz+LIGKpafgL2hsukzk7E06B+Zv5c/KZgoP6Kf7lkOKxVthP0rKvDRRWXD3QtwKBFGPMVfh9M5Islg3wdtV8ER7dYLyjCIGVlplCiEcWjaB/TyxMbOqZ+VGFOhZx5/x4UaMSQELEArB2XvwmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsEPiXJG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CAE1F000E9;
	Wed,  1 Jul 2026 21:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782941786;
	bh=Z9n4hgFW1lcg5WJBcaxfj0XD7SO1SGF4heQUZIBAA74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JsEPiXJG2ec9ZhGTdPnc3dP9h2/lZFSjMaKkvvHXfqvKpRFpYoELblIr11XXwTaIu
	 3HVZnLtYDsDGmQ4XjURUg/SLQVcUKN8QU33jSPZXJb4HbcWjkJbTijMIvtHAI9CCJr
	 N/z3X2YuDJd6cELsgt+Sz0Ly6JYPN1eslEXSzhgoUhKwOMwu6ezqHN+acdF6Lsemq0
	 pshI5SGxUGaJY5z148z7YQfIN9zDzBw/1NQAo8XZ8wxD5zwwhFCYVQDMcSn8YXt/TW
	 wMa497ZPb4mQtPi7KV15ZWcMPFbqGdRCPRPfTC9g8pDgCafS0nUhH9KdhCe9qDYQ5C
	 PnlstwqUgfcTA==
Date: Wed, 1 Jul 2026 22:36:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Joshua Crofts
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads124s08: Return reset GPIO lookup
 errors
Message-ID: <20260701223620.714f4e7f@jic23-huawei>
In-Reply-To: <ajzPBWPKTra82lb_@ashevche-desk.local>
References: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
	<20260625054407.82228-1-pengpeng@iscas.ac.cn>
	<ajzPBWPKTra82lb_@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270253-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@intel.com,m:pengpeng@iscas.ac.cn,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:dmurphy@ti.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshua.crofts1@gmail.com,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[iscas.ac.cn,baylibre.com,analog.com,kernel.org,ti.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,jic23-huawei:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBCEC6F1E3F

On Thu, 25 Jun 2026 09:47:33 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 25, 2026 at 01:44:07PM +0800, Pengpeng Hou wrote:
> > devm_gpiod_get_optional() returns NULL when the optional GPIO is absent,
> > but returns an ERR_PTR when the GPIO provider lookup fails, including
> > probe deferral.
> > 
> > Probe currently logs the ERR_PTR case as if the reset GPIO were simply
> > absent and keeps the error pointer in reset_gpio. Later ads124s_reset()
> > treats any non-NULL reset_gpio as a valid descriptor and passes it to
> > gpiod_set_value_cansleep().  
> 
> The GPIOLIB code will print an error message each time that's called.
> This might flood the logs with a noise.
> 
> > Return the lookup error instead of retaining the ERR_PTR.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> It's good as a fix for backport, but can you consider switching to use reset
> framework and reset-gpio driver instead? (As a separate change on top of this
> one.)
> 

Applied to the fixes-togreg branch of iio.git.

One small process thing.  Please don't send new versions in reply to older
ones - just send a new thread.  Doing it as replies makes for confusing threads
and ensures they are many pages up in the maintainers inbox!

Jonathan


