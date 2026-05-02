Return-Path: <stable+bounces-242622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ31NdlU9mlJUAIAu9opvQ
	(envelope-from <stable+bounces-242622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 21:47:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459784B355B
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 21:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70973300AEFD
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59743803E7;
	Sat,  2 May 2026 19:47:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429317B43F;
	Sat,  2 May 2026 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777751249; cv=none; b=CIGAE8dTdmah26ftRlc1n7Pde6WIRX7HDObYfoxw47yw7CEU6I/3nBYUVXl+M9gtZDr27PfmbnrvfnkIsUoToO9s9cS+q5SY9l2mD9ryEnHoY4m1vNmnRpBk+kkh/mcEbQGqITR9112vd0oE7ImXzr3x4l3ff902Y+geEzbY278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777751249; c=relaxed/simple;
	bh=RidMpHcPzz2n7kv4mCsdJULr7f4Z4t7Ti5cDaR0/2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlIo42TI+0jfRqiGTiTq+AYrtQ6SV77OUZFu4f5umaiAXg3ZNOKzd3wCAnshXSa8tkga8hgceYV2d6bYIfeDemjBtiM0sc9kxhlqep3QSeIKNPmOllEYjRRr6Ug5OLh8mraIZdxhUaqdo/VeLAN+UZTV0HnJSz5R9XKWRpkKOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 97365C1D;
	Sat, 02 May 2026 21:47:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5975B600D3D5; Sat,  2 May 2026 21:47:17 +0200 (CEST)
Date: Sat, 2 May 2026 21:47:17 +0200
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
Message-ID: <afZUxYhkCQ0wG0Uu@wunner.de>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
X-Rspamd-Queue-Id: 459784B355B
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
	TAGGED_FROM(0.00)[bounces-242622-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid]

On Sat, May 02, 2026 at 09:58:04PM +0800, Icenowy Zheng wrote:
> The problem is that the MSI controller has only 16 MSIs usable (it's
> wrongly described as 32 previously, a fix to this is pending[1]), and
> the failing device have an onboard PCIe switch, which created many PCIe
> ports (and corresponding pcieport devices).

Is the SG2042 only used in that single product?  If it is used in other
products which do not have an on-board PCIe switch, why do you want to
disable MSIs on those other products as well?

My point is, you want to constrain this to a specific product, not to
the SoC.  Can you maybe solve this by not specifying interrupts in the
devicetree for the PCIe switch?

> With pcieport devices activated, 11 MSIs are requested by the pcieport
> drivers -- 3 SoC PCIe ports and 8 switch downstream ports. Then only 5
> MSIs are available, but there're still 10 downstream-facing PCIe ports
> now (and 5 of them are hardwired to onboard peripherals).

pcieport can make do with a single MSI vector because all port services
support a shared interrupt.  But I assume your point is that this
particular product has so many PCIe ports that you're still close
to the 16 MSIs limit?

Thanks,

Lukas

