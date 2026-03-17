Return-Path: <stable+bounces-225760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCoQFTMGuWmEnAEAu9opvQ
	(envelope-from <stable+bounces-225760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:43:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36E2A5038
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6062E302C927
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A8939280D;
	Tue, 17 Mar 2026 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Aa6jzP26"
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A556391849
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733332; cv=none; b=F8OWHS0FWgJZrs+ZokGzRsrW7dKtvzGH0yWPgRDR90xLlsD5RmpssUVB8jnB3Nu1StZ/5ktpbdWAbqQfP3OMKjFSqDak12NjvGcZHlWzSD1lY8nhOQTVc49GqhmRViG9XFh3lLE4xGt23aYY0QtWPBX/XUF4mdTYMKHej+8wjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733332; c=relaxed/simple;
	bh=axppJ7vgRT+l1j200xQDrNPk6kDH5EhBlMQpMegQ1DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LET2Yr5iegmra3aUPfs96BRjGXMQtGaOGtVGoyD5AV68dRxGdEe5b28KEc4vV9OZbAPJQTNikciN3XmQCFcPN0QT30xd4rOl8cyTVXi4uCmRe7+le1pSIcDeyUG8JodblnfaxboXSCI+7Iw+sKF5m8YSnzTVyw+Tff/0Y8k37ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Aa6jzP26; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1fxb
	qImj03OXajBmpzO1CQUCWD5bO4dGjX1EHtbcLAY=; b=Aa6jzP26tOFbp867zHZJ
	/Wez7/ws1xj+fYCjTuWXNVyOt8TBM+Qh+9qqjoe/08lACxSnjZnuze2e/foZ8dk5
	5gst9VJR9MVZxK1up39HIYurtorLzowfdVFjGTms2Bd8nOqGP5sUHw81+ZPpqBc4
	kUmK5QGGEDgIYjxUNWGYXrynV4eLqPjfsHo+Be1UGornxMXwK7Ojtawvhpsw54Jx
	9zkzEXqQSec60WN/Ef1vkS+Kv1IySz9OyALNAU3OcWxPLI0SJrrpG4sxCalVmrfL
	MhE59O6Bns/GhGXVP0ItcgSyUpPoLjBr095rHZgRWEkvI6o1weebYFFstS9Q7bGU
	NA==
Received: (qmail 167291 invoked from network); 17 Mar 2026 08:42:08 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2026 08:42:08 +0100
X-UD-Smtp-Session: l3s3148p1@Ze/6eDNNfNVSwmvS
Date: Tue, 17 Mar 2026 08:42:08 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
	Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	driver-core@lists.linux.dev, imx@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
Message-ID: <abkF0GO01sMcOhvb@shikoro>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro>
 <abkD-VLprcbbEbB1@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abkD-VLprcbbEbB1@ashevche-desk.local>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225760-lists,stable=lfdr.de,renesas];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chromium.org,linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,linux.intel.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA36E2A5038
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> > ... this change costs some memory on every system. Maybe it can be
> > avoided?
> 
> How much memory does it cost? On most 64-bit architectures is +4 bytes,
> rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> +0 bytes. I expect that 64-bit machines will cope with this bump.

I am not opposing that the issue should be fixed. If it is not possible
to take the lock everywhere, this is a proper solution. But if we don't
have to use more memory, then we could save it. Our new SoC easily has
'struct device' in the hundreds.


