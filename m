Return-Path: <stable+bounces-225797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePrBAiEouWkAtAEAu9opvQ
	(envelope-from <stable+bounces-225797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:08:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9032A78F9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4D0B303DAAC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2983A4F2A;
	Tue, 17 Mar 2026 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLK1kV0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E835838B;
	Tue, 17 Mar 2026 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741762; cv=none; b=jCzAFskxAKNxosihU3I3/FgNDWb1M4Egjm1mz5r2XvByxTtafbKNawEQREpItUX91tg1x5ZyC2y0obSVRaO+PyCLDKTaAN1lc7hPwvhwBkQgf3RZ5nz4dM2c36wwF91Iqb+FH8ZSWXIa1dlu296BCHNpGHToHMQgU0WNogf9M+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741762; c=relaxed/simple;
	bh=zOhE3MyoOIAA0bgcSSk1uYsIQSRxBFkKa/QEeH/yO6Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=YiJ4YCIVG2AZ7kT+KrGi37ikAEv67pMEp6W7gfirU3nxzrrAZJtLF+dplIuaEl/MJ62HVkbaFxZlrJI2Lf0xhyYDcCLPAa0TzxyUdz+4hlBpNkSIoEbvV65GC2lSSLw3qNj1tfCBoBJu5K1RStwN0clVIULujcOL/bK4p3S+nWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLK1kV0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0BCC4CEF7;
	Tue, 17 Mar 2026 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741761;
	bh=zOhE3MyoOIAA0bgcSSk1uYsIQSRxBFkKa/QEeH/yO6Y=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=iLK1kV0bEUnBKSlVECk17rCfbiRFOK8e9m2VQ9Eam8FJnejzsncMSvQLAFJIvb1Pr
	 Vrqp1T/Wu3PeHwdqqCKwH5HHxvI/GlAmEOIi3tfcPHkHrB8vT93is7PF8gwaUAqxb5
	 JzSXmNuoes9ApijJJRYovbhvzhwBUi9fykKAQygrEKxHzTjISn8Gl4qVh9MTfnmzrh
	 TNuhmnwPHHmX99KzVtklCPpGYF2T12iw9QXIf1B/lIEfIYXfpjXuCSQXEHjD38avMb
	 Glyz74CIMcdU9eEVsElTX638WBp72ugjDLW4ZSO4Lo+vmLbkcaTgsemgoqv6sedF7Q
	 8HzUvbG0bQqeA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 11:02:34 +0100
Message-Id: <DH4YZ4XEWDVH.25QOLQ4QJ4PXD@kernel.org>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Douglas
 Anderson" <dianders@chromium.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 <stable@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>, "Daniel Scally"
 <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Fabio Estevam" <festevam@gmail.com>,
 "Frank Li" <Frank.Li@nxp.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Jakub Kicinski" <kuba@kernel.org>, "Len Brown"
 <lenb@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Rob Herring" <robh@kernel.org>, "Russell King" <linux@armlinux.org.uk>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Saravana Kannan"
 <saravanak@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 <devicetree@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <imx@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <netdev@vger.kernel.org>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid> <abkCPU3rxHI49N4_@shikoro> <abkD-VLprcbbEbB1@ashevche-desk.local> <abkF0GO01sMcOhvb@shikoro> <abkLEgrZbdb03VWg@ashevche-desk.local> <abkLY4AAQuFlTRC7@ashevche-desk.local> <abkT_jpjIki6pvX1@shikoro>
In-Reply-To: <abkT_jpjIki6pvX1@shikoro>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225797-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,chromium.org,linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D9032A78F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 17, 2026 at 9:42 AM CET, Wolfram Sang wrote:
>
>> > What's the alignment for the u8 member in your SoC? 4 bytes or 8 bytes=
?
>> > (I assume it's 64-bit SoC.)
>>=20
>> FWIW, with the given change it will be still inside 64-byte data structu=
re
>> which most likely occupies a single cache line (before this patch and af=
ter
>> as well).
>
> I consider this directon of the discussion irrelevant. If the number is
> (maybe? That's to be discussed!) needlessly bigger than 0, then it
> doesn't matter how big the number is.
>
> Why don't you like the idea of taking the lock?

Which lock are we talking about, the device lock? If so, please not use it =
to
protect arbitrary other structures.

