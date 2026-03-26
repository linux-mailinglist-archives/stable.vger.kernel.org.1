Return-Path: <stable+bounces-230529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKDwOR6fxWlqAAUAu9opvQ
	(envelope-from <stable+bounces-230529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:03:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5733BA44
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 183AE3036D49
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 21:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D93A1E96;
	Thu, 26 Mar 2026 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPAAIB3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176DA346E63;
	Thu, 26 Mar 2026 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558991; cv=none; b=AGrv5rwy69ZCxe0ocg/aMu8YX+EgIh5k7FGi1LMOpytl7OAnhHzvtycrciYQWXSmTqgQBpCDTL3wKeY27PfaWy4iXvBdr1mI3N1jPZrndAOS5EMbC9iC0uUVAenJh7+NHgjhdLRN/TtDDNAmxjhutK3OimS8w3YyzPUHVFQuT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558991; c=relaxed/simple;
	bh=Oga/OddxY2WJCZhkLe7zcVGjS6Fu4I4k5/6EH62Urbk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=szeZkdJJEMaEKEac4/jeT1SsUEMRT55nf43o96zp0tzF4C0WskdEWf4Do1YrS0zir83x9XuewaUh6xPvnopAOvBxU18C/h+q6XCVThmbSeWtLBo55oJbX0nW8TKedAgWHjzOkk+wMsNUfkZyGPeEplpJHZwCwuG4U0d8EHEpmf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPAAIB3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9306BC116C6;
	Thu, 26 Mar 2026 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774558990;
	bh=Oga/OddxY2WJCZhkLe7zcVGjS6Fu4I4k5/6EH62Urbk=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=gPAAIB3fsENGAvoB1ls1d+lyJstfElum/pLWj2DuNK2WleRkSJpZzbuOcSRguNRex
	 LE7yjFpGJeYqgeiTWSX6kkVoDPXfYgQsoiYvVNcYBuRy7Weff6IyhdJ7LJejW3y2q7
	 Lu58LJqd2qR99uWpkNGFPfJeYhdGTH7gmxUd9PImDf3hgeIKuz12xa1bfI6GtosZ25
	 zz/3VILPimPfvECimlah9QRnSQlerX84zqBcJ1XtWuuz4pCn2J3IQkAwYpmSsY+R6p
	 Vq0PeeQgRdA6sV45AaVZZ3KVJItFvjXCg6L1WvlZQDmeunZRkvtTNmqHb/caoBZYIw
	 rdfYLFPYbjpsg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 22:03:02 +0100
Message-Id: <DHD0NQH9UJ21.3J691DBDXS0K0@kernel.org>
To: "Douglas Anderson" <dianders@chromium.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode
 "flags" thread safe
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <stable@vger.kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Mark Brown" <broonie@kernel.org>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Andrew Lunn"
 <andrew@lunn.ch>, "Daniel Scally" <djrscally@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Fabio
 Estevam" <festevam@gmail.com>, "Frank Li" <Frank.Li@nxp.com>, "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Jakub Kicinski" <kuba@kernel.org>, "Len Brown"
 <lenb@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Pengutronix Kernel
 Team" <kernel@pengutronix.de>, "Rob Herring" <robh@kernel.org>, "Russell
 King" <linux@armlinux.org.uk>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Saravana Kannan" <saravanak@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <imx@lists.linux.dev>,
 <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
In-Reply-To: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
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
	TAGGED_FROM(0.00)[bounces-230529-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,sang-engineering.com,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 66F5733BA44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 17, 2026 at 5:01 PM CET, Douglas Anderson wrote:
> In various places in the kernel, we modify the fwnode "flags" member
> by doing either:
>   fwnode->flags |=3D SOME_FLAG;
>   fwnode->flags &=3D ~SOME_FLAG;
>
> This type of modification is not thread-safe. If two threads are both
> mucking with the flags at the same time then one can clobber the
> other.
>
> While flags are often modified while under the "fwnode_link_lock",
> this is not universally true.
>
> Create some accessor functions for setting, clearing, and testing the
> FWNODE flags and move all users to these accessor functions. New
> accessor functions use set_bit() and clear_bit(), which are
> thread-safe.
>
> Cc: stable@vger.kernel.org
> Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

    [ Fix fwnode_clear_flag() argument alignment, restore dropped blank
      line in fwnode_dev_initialized(), and remove unnecessary parentheses
      around fwnode_test_flag() calls. - Danilo ]

Applied to driver-core-testing, thanks!

