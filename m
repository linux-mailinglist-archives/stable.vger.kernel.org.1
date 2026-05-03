Return-Path: <stable+bounces-242647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qILqIcQM92lTbgIAu9opvQ
	(envelope-from <stable+bounces-242647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 10:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0120F4B4F9E
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC6673006B1C
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059D1A0728;
	Sun,  3 May 2026 08:52:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B62264A9;
	Sun,  3 May 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798338; cv=none; b=R6zB8ApN8t4tXi0Rz2mN4U2SZyHEpHcyZdkzwgy6MgL+67jGaVGxvlyPJ7COjSGBttBswzHWVQLaNpayJtCf2ulOGVUtX/F4svhgHUtdhICO0lJbvjbG4SlWmCS49BxO5P1+dXvKobbQQvUlxEC2Yl7Bihw8FHgzxq0W/yzOU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798338; c=relaxed/simple;
	bh=ukg3P5tO/AfXZ1GP9HxF4bAlhimrzz6SSRbG/iYZB/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv5rEDi14UDUq6OHxGUIPWsJXpkCfjyXsAIna4E6n4dxh9BTp4XWjMLqWTJE+9gZHWnGqxxkI0UJ6wfFwoVwT+q7SFFQfN2jAlgt64OhAF3CAmm+pLsnbqlkSvY4DNIOuUbfaJb+NJvfCyVr90JH3IIYR9CAnn6/BDFuHwFLobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 4E9B41058A;
	Sun, 03 May 2026 10:52:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 38258600D2F5; Sun,  3 May 2026 10:52:06 +0200 (CEST)
Date: Sun, 3 May 2026 10:52:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Han Gao <gaohan@iscas.ac.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
	linux-pci@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Han Gao <rabenda.cn@gmail.com>, Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
Message-ID: <afcMtlBJYeuxSqZr@wunner.de>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
 <afZUxYhkCQ0wG0Uu@wunner.de>
 <68d4a49bf1df785ae906fbc2dd16e64b667ca5f0.camel@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d4a49bf1df785ae906fbc2dd16e64b667ca5f0.camel@iscas.ac.cn>
X-Rspamd-Queue-Id: 0120F4B4F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,google.com,baylibre.com,huawei.com,linux.intel.com,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,ziyao.cc];
	TAGGED_FROM(0.00)[bounces-242647-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,farlepet.github.io:url]

On Sun, May 03, 2026 at 03:10:58PM +0800, Icenowy Zheng wrote:
> It's used in multiple products, but only one of them (EVBv1, which is
> just an early EVB available for a few people including me) lacks an
> onboard switch, because SG2042 is short on on-chip peripherals. All
> other devices (including two mainlined ones, EVBv2 and Milk-V Pioneer,
> and unmainlined dual socket rack servers; Milk-V Pioneer should be the
> most popular device because it was on shelf) have an onboard switch to
> mitigate the lack of on-chip peripherals in SG2042.

Who knows, maybe someone will design a product which doesn't attach
a PCIe switch to the SoC, maybe the lack of peripherals isn't a
problem for them.

It seems reasonable to accommodate such non-switch use cases as well,
so I think you definitely do not want to quirk all products using that
SoC but only those that need it, regardless whether it's the majority.

> > My point is, you want to constrain this to a specific product, not to
> > the SoC.  Can you maybe solve this by not specifying interrupts in
> > the devicetree for the PCIe switch?
> 
> The PCIe switches are not described in the device tree at all, because
> they're all just discoverable; can we describe them in the DT and
> redirect their interrupts to void?

Yes, somebody did a writeup how to represent switches and endpoints
in the devicetree:

https://farlepet.github.io/linux/2024/02/20/using-linux-device-tree-with-pcie-devices.html

And then I would try providing an empty "interrupts" property for
those switch ports for which you want to avoid port services being
instantiated.

That way you could selectively *enable* port services for specific
ports where it's useful.  Let's say you need DPC on a specific port
to contain errors of an attached NVMe drive.  Just assign a single
MSI for that port and assign no MSIs for all the others.  Much more
flexible than globally disabling port services.

Thanks,

Lukas

