Return-Path: <stable+bounces-244389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELmZGrRE+2lPYgMAu9opvQ
	(envelope-from <stable+bounces-244389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:40:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3B4DB18C
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8694F3013B4B
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396634779B9;
	Wed,  6 May 2026 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgr5Bxuo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19B4266AC;
	Wed,  6 May 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074792; cv=none; b=i83eusS7HCJc+2mcmlUfLDlu06m4Rc6bkN7ZsAl6giNdY6EfjUwqCMFHNfdBFXffFiYiUjvyYKblu/4OvnI7QxHQFpgvU0KPwKQ73viA1J4eaJ4rwtiD0lATKMiXmKwsY3vs6W5CLV+ml16TS78FYA+anJTIoVychMf2N8okirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074792; c=relaxed/simple;
	bh=2rWZALc4A+mRpJwikDDsmAMz1q1Of49TfL/SiHnwP8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8evATBGY9QGFMnHAQjj3LYS89/qr3FMM/TPegvzVJbFNUa1QFG5oDh88PveTeQozDSy/c3+U2cuN/CCw9a8Kb0zn9zLmdRxIGnOuTwpw7+VU9O+iH83o8uokg1TD5ChXFBtcbP0nppQuTNXwB8UTji9j5Y9BUUmpXL2ZahdD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgr5Bxuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079BDC2BCC9;
	Wed,  6 May 2026 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074791;
	bh=2rWZALc4A+mRpJwikDDsmAMz1q1Of49TfL/SiHnwP8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jgr5BxuojY8tcD3I/mFhKPvfnuPEHV2mwffwDjUr9kznyx7Jbym6SCMDLUACp3BJZ
	 9uSQUeMDLiQ6eG9dDAAQRm7tTEOpPNgzyDzjlJ7/5pl7tEAcanCQ291+OtABCWFvRt
	 aUYVqhSLpMVzEC1ExZP+S+yhr8F9JCpu59mcv+eFpcQXc3Ox8KOrxED4M7Zq9gxeD/
	 rFfJhfOD5muj32f4HyHShb9Er2Nk3NiWwjduoVqZdb8xLrN4Ry8rpsvk4i4o33SUne
	 sBx5yC7GJC49K7RQYYGU1tc58/ldGhwsGz9vCEzXGQJuKb6AQVw9GuDxPR1y5eppSS
	 EYd0trDl6NkIg==
Date: Wed, 6 May 2026 19:09:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Han Gao <gaohan@iscas.ac.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Han Gao <rabenda.cn@gmail.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
Message-ID: <2se24qgfmwumdpdjdcszz7l3m5rbucnp22hbidvhz6xc3p6j4i@fkb4u4hg6ha2>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
 <afZUxYhkCQ0wG0Uu@wunner.de>
 <68d4a49bf1df785ae906fbc2dd16e64b667ca5f0.camel@iscas.ac.cn>
 <afcMtlBJYeuxSqZr@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afcMtlBJYeuxSqZr@wunner.de>
X-Rspamd-Queue-Id: 25B3B4DB18C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244389-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iscas.ac.cn,google.com,baylibre.com,huawei.com,linux.intel.com,kernel.org,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,ziyao.cc];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[farlepet.github.io:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sun, May 03, 2026 at 10:52:06AM +0200, Lukas Wunner wrote:
> On Sun, May 03, 2026 at 03:10:58PM +0800, Icenowy Zheng wrote:
> > It's used in multiple products, but only one of them (EVBv1, which is
> > just an early EVB available for a few people including me) lacks an
> > onboard switch, because SG2042 is short on on-chip peripherals. All
> > other devices (including two mainlined ones, EVBv2 and Milk-V Pioneer,
> > and unmainlined dual socket rack servers; Milk-V Pioneer should be the
> > most popular device because it was on shelf) have an onboard switch to
> > mitigate the lack of on-chip peripherals in SG2042.
> 
> Who knows, maybe someone will design a product which doesn't attach
> a PCIe switch to the SoC, maybe the lack of peripherals isn't a
> problem for them.
> 
> It seems reasonable to accommodate such non-switch use cases as well,
> so I think you definitely do not want to quirk all products using that
> SoC but only those that need it, regardless whether it's the majority.
> 
> > > My point is, you want to constrain this to a specific product, not to
> > > the SoC.  Can you maybe solve this by not specifying interrupts in
> > > the devicetree for the PCIe switch?
> > 
> > The PCIe switches are not described in the device tree at all, because
> > they're all just discoverable; can we describe them in the DT and
> > redirect their interrupts to void?
> 
> Yes, somebody did a writeup how to represent switches and endpoints
> in the devicetree:
> 
> https://farlepet.github.io/linux/2024/02/20/using-linux-device-tree-with-pcie-devices.html
> 

I wouldn't recommend going this far... We do have some switches described in DT,
but they have some resource requirements like regulator, i2c...

> And then I would try providing an empty "interrupts" property for
> those switch ports for which you want to avoid port services being
> instantiated.
> 

There is no 'interrupts' property in DT binding for PCI bridge nodes. There is
'interrupt-map', but that's used for mapping INTx with platform interrupt
controller.

Moreover, DT should just describe the hardware topology/resource, not
platform constraints.

I'd recommend introducing a new cmdline param to the portdrv driver to disable
using MSIs for services. But the platform limitation would hit one way or the
other if one of the endpoints consume all MSIs...

- Mani

-- 
மணிவண்ணன் சதாசிவம்

