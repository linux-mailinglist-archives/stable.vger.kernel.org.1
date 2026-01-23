Return-Path: <stable+bounces-211365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ18JpBBc2mWtwAAu9opvQ
	(envelope-from <stable+bounces-211365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:38:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5171D737CE
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F9843063948
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416836F438;
	Fri, 23 Jan 2026 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4zdI2ug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DC936C0A8;
	Fri, 23 Jan 2026 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160848; cv=none; b=hQQJm8M/hIJPqaTZh7xkP6D+JHBKGZ4Scw87MbYG/qJXG9XCZ8aEj7hlqUHkMO3O8cWRjBCHCTWML8RJBKtHqgWa7kCsyvNhnx/E+3LRjSdZ+C0lXBsC52WZ05/WS5y5l/GIyejLAmIzACiOxD+f2r8Odvo2L86RyKgvWZVtBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160848; c=relaxed/simple;
	bh=OHgUB6UEKM0ab7UrpkwVT+z2dqOdymtjtNsQzMlv0bM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrrOA2zQ5B36U4bkErfnhm8Y99GoQ8lm5MNDwKgNwSgQMqxGCVK3mzcbG6lnKOp0TW0qbvo4Ur2lR8OUgy8kDsdDLFW3VdAFXH/BrTppKI6JNwdmsct48El5+xqyDE898VRC2XIqKMJBINark50CdDdGghkPwsKYLagzzuN3ifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4zdI2ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1207C4CEF1;
	Fri, 23 Jan 2026 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160847;
	bh=OHgUB6UEKM0ab7UrpkwVT+z2dqOdymtjtNsQzMlv0bM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V4zdI2ug+9Nsn1fhBMdLw+rlWMsUSy1WMR0LMRIV2H4J1d3mkRGNiQYM1bkmSnK0K
	 rwg4caeYfvbmBohzuWpldR3915Avre1hRsA+T/5b/AOsCv5V8vAPWKZ1VZ6zcyQSnN
	 bNyTjWLiyYIoojRPltW8Z8qUEV0d7lxByrDupi6KNheE3shHd1LgXZKMG01jS/bbnb
	 oJymRNR8i2m/ai7tLRh8+nWTO/iTNyfzO0QDhmNzNxLi8ohAk/xJ99zc8Fzz4xTXyl
	 KsK3y8M+fTTHxPLJnKF44U8Da26Rmog4KV3GJzoOHkAgy7KUxXIjufoVI7cSYLwawy
	 xEvjl2CherMuA==
Date: Fri, 23 Jan 2026 09:33:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 4/8] iio: dac: ds4424: reject -128 RAW value
Message-ID: <20260123093357.6996154f@jic23-huawei>
In-Reply-To: <aW6AEszfRQzuHf6j@smile.fi.intel.com>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
	<20260119182424.1660601-5-o.rempel@pengutronix.de>
	<aW6AEszfRQzuHf6j@smile.fi.intel.com>
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
	TAGGED_FROM(0.00)[bounces-211365-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 5171D737CE
X-Rspamd-Action: no action

On Mon, 19 Jan 2026 21:03:46 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jan 19, 2026 at 07:24:20PM +0100, Oleksij Rempel wrote:
> > The DS442x DAC uses sign-magnitude encoding, so -128 cannot be
> > represented in hardware.
> > 
> > With the previous check, userspace could pass -128, which gets converted
> > to a magnitude of 128 and then truncated by the 7-bit DAC field. This
> > ends up programming a zero magnitude with the sign bit set, i.e. an
> > unintended output (effectively 0 mA instead of -128 steps).
> > 
> > Reject -128 to avoid silently producing the wrong current.  
> 
> ...
> 
> > -		if (val < S8_MIN || val > S8_MAX)
> > +		if (val <= S8_MIN || val > S8_MAX)
> >  			return -EINVAL;  
> 
> Hmm... So the range is [ -127 .. 0 .. 127 ] ?
> 
> I think in such case the plain numbers would be more specific than
> the type related limits.
> 

Check the abs(val) <= 127 given that's what we care about I think?
Or make it explicit and do
FIELD_FIT() against a mask that you then use to fill the register
value (another mask for the sign bit).

Btw use abs(val) to set raw.dx and drop it out of the conditional.
Even better get rid of the bitfield stuff and just add
two defines + fill val directly in this function using FIELD_PREP().
Then both the checking and the field filling use the same defines
and it should be easy to see what is going on.

Jonathan




