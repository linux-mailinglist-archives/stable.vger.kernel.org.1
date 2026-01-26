Return-Path: <stable+bounces-211543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBb8He85d2mMdQEAu9opvQ
	(envelope-from <stable+bounces-211543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 10:54:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B793886413
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 10:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 520783009821
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6273313543;
	Mon, 26 Jan 2026 09:52:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5C32D43C
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421166; cv=none; b=THPL/rhlSEQ+iRuKy1S/N2VpRZKEfl6flaVmSFI3mOS+c4VDPSuGKQ60L4zqxXNFTjtzsPY55YBQq34zz1Sd9hCgoqS9Do9NuF7gNCxUaeaKaDTyBbEQZAvdOux38Hx3PH9TVk1jt9Wma+3CYdtf1v5hvocRHp/ZXabrom2i/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421166; c=relaxed/simple;
	bh=GvlqXsYlJpBfKDbhLQVPx/9zjMm1auq6vLVLKzaEOoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhHrAGKCWZoxrXDoCvR35QuWXbRkfTWLHYSya56TVAXmvVmvnvVMAV3mKWkmFgZOQfQyckLXX426LnfbzOf0hCA/weyrPioeWkpaw+TA6PTGJAJ7NAhYQqQ8k5sQZB1S6qN44b4VhHN0G685DPpuOBIt5JoUAs9sd8ctdy3q8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vkJH1-0003kA-Io; Mon, 26 Jan 2026 10:52:43 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkJH1-002Yjf-05;
	Mon, 26 Jan 2026 10:52:42 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkJH0-00GVpx-0e;
	Mon, 26 Jan 2026 10:52:42 +0100
Date: Mon, 26 Jan 2026 10:52:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 4/8] iio: dac: ds4424: reject -128 RAW value
Message-ID: <aXc5agTyH4XmzKUi@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-5-o.rempel@pengutronix.de>
 <aW6AEszfRQzuHf6j@smile.fi.intel.com>
 <20260123093357.6996154f@jic23-huawei>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123093357.6996154f@jic23-huawei>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-211543-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: B793886413
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 09:33:57AM +0000, Jonathan Cameron wrote:
> On Mon, 19 Jan 2026 21:03:46 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Mon, Jan 19, 2026 at 07:24:20PM +0100, Oleksij Rempel wrote:
> > > The DS442x DAC uses sign-magnitude encoding, so -128 cannot be
> > > represented in hardware.
> > > 
> > > With the previous check, userspace could pass -128, which gets converted
> > > to a magnitude of 128 and then truncated by the 7-bit DAC field. This
> > > ends up programming a zero magnitude with the sign bit set, i.e. an
> > > unintended output (effectively 0 mA instead of -128 steps).
> > > 
> > > Reject -128 to avoid silently producing the wrong current.  
> > 
> > ...
> > 
> > > -		if (val < S8_MIN || val > S8_MAX)
> > > +		if (val <= S8_MIN || val > S8_MAX)
> > >  			return -EINVAL;  
> > 
> > Hmm... So the range is [ -127 .. 0 .. 127 ] ?
> > 
> > I think in such case the plain numbers would be more specific than
> > the type related limits.
> > 
> 
> Check the abs(val) <= 127 given that's what we care about I think?
> Or make it explicit and do
> FIELD_FIT() against a mask that you then use to fill the register
> value (another mask for the sign bit).
> 
> Btw use abs(val) to set raw.dx and drop it out of the conditional.
> Even better get rid of the bitfield stuff and just add
> two defines + fill val directly in this function using FIELD_PREP().
> Then both the checking and the field filling use the same defines
> and it should be easy to see what is going on.

FIELD_* macros require compile-time constant masks. Since the next patch
adds support for variants with different data widths (making the mask a
runtime variable), I prefer using an implementation now that remains
consistent with the followup changes.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

