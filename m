Return-Path: <stable+bounces-212999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM5tMmZmf2mwpgIAu9opvQ
	(envelope-from <stable+bounces-212999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 15:42:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41037C6396
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 15:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 453453008889
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B168350D4C;
	Sun,  1 Feb 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgkUhVmu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1DB3FC9;
	Sun,  1 Feb 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769956956; cv=none; b=PedechkEojC6CO/iKGSLpu6NnqnUcorR0laSvy9yxsFfAgCCAdJU1E+eqSfxQFUU1alxGhj1gUL/8tzX3leQ+73tyfpwMvd5AtbmvSf4PeFulObZLMnvoXC0CJABPDxX3Q82mpZpNxvb2X6UYVD6DNTywvJbpaUZ25bCVMpVTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769956956; c=relaxed/simple;
	bh=OeBpCErw6r8n4vjTlbift/I6h4KXHBnrI+uQFy8NL8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLIxrUtGIHp59ZJpYNXCwAOzvJmolbwuk9hPaJi+CkoxVdjor6MIJRE+PTYOnn+HowljO4ywvvs2chw8rTWEybfaPMMvVS8ma/oLH1mF43SsEfdXtMZUbKGk1rDUKog+63WvUIxC5dkHTW+ArCvxFbYRgl/+jwK5SWzJUJfnFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgkUhVmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC4CC4CEF7;
	Sun,  1 Feb 2026 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769956956;
	bh=OeBpCErw6r8n4vjTlbift/I6h4KXHBnrI+uQFy8NL8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AgkUhVmuj+KM0l7ldEon9TGhYTBZB6JybPJoz6HSB8qo1fTOXVBObZiuUwX66IUa1
	 q3I2/vBksSYfwauLPldWiRusTS8byPxwc9UzgMIQyL49VkT1Lrexmf+iuHzhTMhNeC
	 PlQd3istsBRC5yM/3P1dMkvPPFr3EM+C7/ke3t0fNYiw664HPgAZTGZTI2D02aekI+
	 /YdqvR4vtJwBnrEqMD+sUsTfUX6trhx9y+utzTLmQPOuJtUgmXfRfG5EjkinaQz5GV
	 3sm3gLRCNxFV82LNJ13Jmj1PtLveTuUULB7tHkm/L6U//KmPkwKF3KSeL5UU1vJPK5
	 V21aVQIEOAHHQ==
Date: Sun, 1 Feb 2026 14:42:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 1/8] iio: dac: ds4424: fix -128 rejection and
 refactor raw access
Message-ID: <20260201144226.218a43cb@jic23-huawei>
In-Reply-To: <aX9Jysah66FlHfLZ@pengutronix.de>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
	<20260128153824.3679187-2-o.rempel@pengutronix.de>
	<20260129175819.789a99ac@jic23-huawei>
	<aX9Jysah66FlHfLZ@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212999-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email]
X-Rspamd-Queue-Id: 41037C6396
X-Rspamd-Action: no action

On Sun, 1 Feb 2026 13:40:42 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Jonathan,
> 
> On Thu, Jan 29, 2026 at 05:58:19PM +0000, Jonathan Cameron wrote:
> > On Wed, 28 Jan 2026 16:38:17 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >   
> > > The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented.
> > > Previously, passing -128 resulted in a truncated value that programmed 0mA.
> > > 
> > > Fix this by validating the input against the 7-bit magnitude limit.
> > > Additionally, refactor the raw access logic to use symmetrical bitwise
> > > operations, replacing the union structure.
> > > 
> > > Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>  
> > Hi Olkesij
> > 
> > This is good stuff but, this fails the test of being the minimal fix
> > suited for a trivial backport.
> > 
> > The right solution here is split it.  Just apply the correct
> > limit in the fix patch, then the refactors in a patch on top of
> > that which most likely won't be backported for stable.  
> 
> The v1 of this patch was implemented according to the fix patch
> requirements:
> https://lore.kernel.org/all/20260119182424.1660601-5-o.rempel@pengutronix.de/
> 
> May be keep v1 as is and rebase v3 as refactoring stage on top of it?
Perfect.

Thanks!

Jonathan

> 
> Best Regards,
> Oleksij


