Return-Path: <stable+bounces-225756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNsKC7cCuWmEnAEAu9opvQ
	(envelope-from <stable+bounces-225756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:28:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B88492A4CE6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F93302335B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44D38F228;
	Tue, 17 Mar 2026 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="G1SOiayi"
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA938C41D
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732426; cv=none; b=IRdCHR8smMl3+cioh0VnC8Y+uc4CQ6iz7pQCo8+gzgGtcMD1mEBk8RIEsaPi3wECK5rgnZGzQ1j6Rmk1qpn/Zpi4jeoDFoOGD7MUdB03YkDEvTK7TGaRWOP+TN7Wn6p2205w4ZZ7NHUbYImdxGMgxQLXXMQT8CVC1Y4amdzNvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732426; c=relaxed/simple;
	bh=uK/yatnqUfTvDqI7YxNLRspu58OylQogpc14FiQPe68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CskANBE42lUO0HCnN4APBBVLP1U+49Bfmkainw8eHeP9qNPwaWlEMIXSvK7MMDeovhMs9OtuM2qxdXdln8zAreyy9tOn/xhgmmoOkrERTueHM4G8aOw3bMzPkGAxMjTN4dZIOJ7U5/WrRz7H13ZTuLZhzL27j0QTIQu8ry7I1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=G1SOiayi; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+E5J
	ExlH1gsTbrfMSDrOrCsvoCvNuc0M7joRkI7q/a0=; b=G1SOiayi7IoPrStzYmkA
	vE7X7q92XlvwYuEl9Qq+m43cNpJ1xkkG+3XSjgJJ6u1gQUoFRCQaWvd0ltaIwWz/
	HONuSZqyrenHqXgFemBvGilKgGqmEuKXcnp8Z15LGRMALDs51AhRCugiRG2ZV4Px
	7B8PLtMebupyzkbYa1PW8sHAh8ZqVD5/mREnBxYk3r9vU+BvmA5PxdwAF0in6ofA
	GidGANePhLce/03m5Xss1p3CFf+7JesvhB182Kx4jRpvr5t72lro76lUMfRTZflS
	96CCkOxwe23kNqh//4oAvR+2RX1AQZM5LMQLBymy9yiVdMAaxP+s1rKPe3u/WBsI
	nA==
Received: (qmail 162337 invoked from network); 17 Mar 2026 08:26:53 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2026 08:26:53 +0100
X-UD-Smtp-Session: l3s3148p1@khhxQjNNeKhSwmvS
Date: Tue, 17 Mar 2026 08:26:53 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
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
Message-ID: <abkCPU3rxHI49N4_@shikoro>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225756-lists,stable=lfdr.de,renesas];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,linux.intel.com,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B88492A4CE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Doug,

thanks for tackling this issue! I agree it should be fixed, just
wondered about one thing:

> While flags are often modified while under the "fwnode_link_lock",
> this is not universally true.

Is it a possibility to use the lock in all code paths instead?
Because...

>  	struct list_head consumers;
> -	u8 flags;
> +	unsigned long flags;

... this change costs some memory on every system. Maybe it can be
avoided?

Happy hacking,

   Wolfram


