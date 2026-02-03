Return-Path: <stable+bounces-213191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Fi/N7vOgWl1JwMAu9opvQ
	(envelope-from <stable+bounces-213191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 11:32:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11551D7B5A
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 11:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9027C3007A68
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3A31B823;
	Tue,  3 Feb 2026 10:28:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7331AA96
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114534; cv=none; b=T6oGbN5XLlotI/4tE+TeSc0ZjxZRSue1uR3Nv0JEfECqOhZNb4o8YjZ85Yck969elOYeKcjdSlWU83gammrGVVo/hiMS14vTXg3z2KfV815s5ENUiBr+WL+SviX8j7B9rhl46cuVRJbuPLJy+KjlywEeV0FwkHkbiPqxej44yCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114534; c=relaxed/simple;
	bh=/SUfDw43r3dt6Wpf0yKB09fpD6dxuIv6K0uCA4c4bYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toRE7aXpUZUtyHXrSchHJ6aBSSj8q9VWnmfFJuHgPdGplce69Cr6HY5T+twHjrXYucUCZ08f0MXhh+unghicqQ7fCFI4DAqU2xHhB+u7WhJyLhtW4xAC6fCpA4sEpo5fOQLJRwP+8iC/Xf7Dx9mf5SeOo2tRhkw3V/HagmwlvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vnDeI-0003ge-Dn; Tue, 03 Feb 2026 11:28:46 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnDeH-003tCp-3C;
	Tue, 03 Feb 2026 11:28:45 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnDeH-00E2NX-0c;
	Tue, 03 Feb 2026 11:28:45 +0100
Date: Tue, 3 Feb 2026 11:28:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	kernel@pengutronix.de, David Jander <david@protonic.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 01/13] iio: dac: ds4424: reject -128 RAW value
Message-ID: <aYHN3YfKCgEnAfD5@pengutronix.de>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-2-o.rempel@pengutronix.de>
 <aYHF29ZR9mdi6Pqx@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYHF29ZR9mdi6Pqx@smile.fi.intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-213191-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 11551D7B5A
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:54:35AM +0200, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 10:34:21AM +0100, Oleksij Rempel wrote:
> > The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented
> > in hardware (7-bit magnitude).
> > 
> > Previously, passing -128 resulted in a truncated value that programmed
> > 0mA (magnitude 0) instead of the expected maximum negative current,
> > effectively failing silently.
> > 
> > Reject -128 to avoid producing the wrong current.
> 
> ...
> 
> >  	case IIO_CHAN_INFO_RAW:
> > -		if (val < S8_MIN || val > S8_MAX)
> > +		if (val <= S8_MIN || val > S8_MAX)
> >  			return -EINVAL;
> 
> I still consider using -127, 127 is better than type _MIN/_MAX.
> This is all due to '='.

The use of S8_MIN here is intentional to satisfy the requirement for a minimal
stable backport, as requested by Jonathan:
https://lore.kernel.org/all/20260201144226.218a43cb@jic23-huawei/

This patch: Strict "Fix only" for stable. Uses minimal logic changes (<=
S8_MIN) to avoid introducing new bugs during backporting.

N++ patch: Full refactoring.

Can we accept this temporary state to facilitate the stable process?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

