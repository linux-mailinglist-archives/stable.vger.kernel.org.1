Return-Path: <stable+bounces-244520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABH4LYU9/GnfNQAAu9opvQ
	(envelope-from <stable+bounces-244520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 09:21:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252F4E3FD4
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 09:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C086301CFBE
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 07:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CB34B669;
	Thu,  7 May 2026 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="QxAPkw0h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQ29OrEB"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38D30EF7B;
	Thu,  7 May 2026 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138470; cv=none; b=ibKOIzmGJNy+m4XKPjNurDOBmm8gXPyoJET42O+Tzat6S5yyUUzXLknSorx+rB7Fp1kwiLh+BRUsCYGq8sOnfqoZ+Lz/3jym/4PsU70zmHTA7Yi0CaeVCkUxMxV58LPiVYXIMoQMSbtEPXMgbNnVu7gik1WH7QFPdzXk+q7JS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138470; c=relaxed/simple;
	bh=j/HLbSe/M7OJEyVnieMqLBCTMPLCxU7JiJj98F/nu4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAjLLimT2xEtesrD24gRUb4fBgKg8QeUyEyDx8whLENIQfcUIQ7YJj9sIW7gIyGDdc4zZ3iulOL/0OPojBw31JJQ/TayaqOfRDZ+tRVYSDYflsznnx6XDv0+WAlsdxcN6k7lxy4OMwXsaBKr8lxW+8bhYN+GaQ+mAlExILU8s6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=QxAPkw0h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQ29OrEB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DDFC140010E;
	Thu,  7 May 2026 03:21:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 07 May 2026 03:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1778138467; x=1778224867; bh=SoBxBKXCi0
	56PB68P6GNZ6Iahdos94p14LAJP/9ievM=; b=QxAPkw0h++mYhy2+YLFrtZgCut
	Nkaz40jnNPtG8pA90ihyoa3ZTSzGvZFbvml34nscuNKaH//uZqQeyEQ0txYEpYin
	VItjRfrmyii+VomWSRZmOP/gpAQto+5vd9uSpSlqMyd806McVfWJaMGesYK92a52
	XDmGqu7nuImoDUQ4vmltuUB36v+VKtbHL34bQWijKenaPr4NmWjvJwcvyb5bepIB
	CyEBzB3P2LRi14/tVBt7/HF25am4yfSUgO8NfHVAj2CcVGUKvZ5FniIscW0OG8qf
	vamdhsvMC3bbnPof3SFanuBStcV3O2tHSeq3yl+dPzxAjI/fG3ij7eZ+N20w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778138467; x=1778224867; bh=SoBxBKXCi056PB68P6GNZ6Iahdos94p14LA
	JP/9ievM=; b=MQ29OrEBgigekbfNIYslatl8MwXhczGGbmEojXkSfHHQJIZn2yh
	plSXNVf5zZRddzdxKcIniZK5mumXY8halJYPJXReb3xrfsmFMEul6vkFcpdMdSRK
	nqdBzkrKbLj/Pl1qojAcKjLpT/rNRZP2x7d2VX/CsYauAKgCIUHX/MCHifvDNon7
	N3qbMv/LJsMQSMNPVZl5l4egLqUGeAorBN9mgjp0LcZF9A6jgs8gtUw25JpPT/H4
	F5HwIUoTAfYrG53fhRfKEe8hlYSfFQ08tGYdPrKFyA3tFokEQWVoQwstQbHVm/4r
	jJGkG3wNVGEj0weP9Cx4KzTvui9x11RornQ==
X-ME-Sender: <xms:YT38aYOx-6lMdDmB6ewMZYuQzT80opuM7cj6K7L--i0_xDHAZMXK8g>
    <xme:YT38aVfm1yW1OYTQjneztoVtbybtwW_uQSqqCWjx5DJfh1jY2b7k7RP9UlHfvBVR3
    QVKj3-DPs1XY3iZQRcBybGIJDegKKTKAV-3N2dmLZ0OpUAjHr7bIwKi>
X-ME-Received: <xmr:YT38adRH_Xgr6LJeV6nFRur-PW_MOxqvNVUmJ5JApBBOcb9zCL71FH0DefmjZVF9krNemUcW3W8OzZcJWIaueMdGZVCqI0wf_7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeikeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgud
    euffelfeekgeeukedtheekjeettdfftddujefhvdehtefgiefgledtueefjeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedu
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquh
    hsrdhnvghtpdhrtghpthhtohepshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopeifihhmsehlihhnuhigqdifrg
    httghhughoghdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqfigrthgthhguohhg
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YT38aTdZei8qYOWwTp0-HeyiPPmMTq-TbnNsvgZp5kfwloXsoBWrJw>
    <xmx:YT38aWtJ4Y2_B0ZbeVvIAkUjNJ9Kq3kno4yua8Ni1VSg9xXWKNlGDQ>
    <xmx:YT38afJXTOfU07DAbpsPh7oecQZqN4D9dm8hF91aQX0j7Bovq2ciKA>
    <xmx:YT38aaYrFMkjru0GQPFCS4xKZfK_VYpMavrm4b2h79AWDRya-0zM3g>
    <xmx:Yz38aejUONk53dOFNZO8hBLUkZ4EOx-4CLPexYMT7_SHFpfurOHo8lcm>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 03:21:05 -0400 (EDT)
Date: Thu, 7 May 2026 09:21:03 +0200
From: Janne Grunau <j@jannau.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] watchdog: apple: Add "apple,t8103-wdt" compatible
Message-ID: <20260507072103.GA514139@robin.jannau.net>
References: <20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net>
 <68e8bd60-85b1-4b4a-8a82-f47640ad0ad9@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68e8bd60-85b1-4b4a-8a82-f47640ad0ad9@roeck-us.net>
X-Rspamd-Queue-Id: 5252F4E3FD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244520-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gompa.dev:email]
X-Rspamd-Action: no action

On Wed, Dec 31, 2025 at 06:28:17AM -0800, Guenter Roeck wrote:
> On Wed, Dec 31, 2025 at 01:07:21PM +0100, Janne Grunau wrote:
> > After discussion with the devicetree maintainers we agreed to not extend
> > lists with the generic compatible "apple,wdt" anymore [1]. Use
> > "apple,t8103-wdt" as base compatible as it is the SoC the driver and
> > bindings were written for.
> > 
> > [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> > 
> I don't understand the rationake from the reference. This patch will need
> an Ack from a DT maintainer.

Sorry for the late reply, I forgot about this. The corresponding change
to the dt-bindings in commit 5410df1a5a4b ("dt-bindings: watchdog:
apple,wdt: Add t6020-wdt compatible") was acked by Rob and is merged.

Cc-ing DT maintainers, patch still applies unchanged.

Janne

> > Fixes: 4ed224aeaf66 ("watchdog: Add Apple SoC watchdog driver")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> > This is split off from the v1 series adding Apple M2 Pro/Max/Ultra
> > device trees in [2].
> > 
> > 2: https://lore.kernel.org/r/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net
> > ---
> >  drivers/watchdog/apple_wdt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> > index 66a158f67a712bbed394d660071e02140e66c2e5..6b9b0f9b05cedfd7fc5d0d79ba19ab356dc2a080 100644
> > --- a/drivers/watchdog/apple_wdt.c
> > +++ b/drivers/watchdog/apple_wdt.c
> > @@ -218,6 +218,7 @@ static int apple_wdt_suspend(struct device *dev)
> >  static DEFINE_SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
> >  
> >  static const struct of_device_id apple_wdt_of_match[] = {
> > +	{ .compatible = "apple,t8103-wdt" },
> >  	{ .compatible = "apple,wdt" },
> >  	{},
> >  };
> > 
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251231-watchdog-apple-t8103-base-compat-8a623e9831b6
> > 
> > Best regards,
> > -- 
> > Janne Grunau <j@jannau.net>
> > 

