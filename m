Return-Path: <stable+bounces-244410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAZNM/5Q+2mSZQMAu9opvQ
	(envelope-from <stable+bounces-244410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:32:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440A4DC3E2
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98B1D3098E49
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491D466B75;
	Wed,  6 May 2026 14:23:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE539393DF5;
	Wed,  6 May 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077390; cv=none; b=WnoMH583X1k+dhJN/xBhfrwksmfZm0R1R55Bk09R6i63L3HYs45qlh7xDDOei8ZV1hKx03hYEfSnAXLdIPd96Twm6W2/EGCALtlA9DKZy4csiHMIo/TEuWssPumcG473QTe4hwl9V2AwBs9fi4/85ZOAoYYqUzYTngyZ5MolCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077390; c=relaxed/simple;
	bh=YhT+L9gfUolQQ/67uHtY8wxjDfQEf4qc6b1yQM1L3Pw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GnlWP9c50RZ6qgxX6G0FUmIagB/VQXk/8kSpWd5kD5sZvFGZAcRJbuKc+AKxGuuxZFffZQvewQ5V0UYBajKkJlugIcM/WZLB0XpS9j2fDQVUy4wVPBB+naDpwyEyz/xB81TV3bBffn0TKKeNh6/KDjE76bNCN9oU9MNLBbxwI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
	by APP-05 (Coremail) with SMTP id zQCowAAHmQy7TvtptBGODw--.6857S2;
	Wed, 06 May 2026 22:22:52 +0800 (CST)
Message-ID: <2415c7a9e33912ac4b87176b07f6cf4db21fa57c.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Han Gao <gaohan@iscas.ac.cn>, Bjorn Helgaas <bhelgaas@google.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>,  Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Kees Cook <kees@kernel.org>, Chen Wang	
 <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org,
 sophgo@lists.linux.dev, 	linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Han Gao	 <rabenda.cn@gmail.com>, Inochi
 Amaoto <inochiama@gmail.com>, Vivian Wang	 <wangruikang@iscas.ac.cn>, Yao
 Zi <me@ziyao.cc>, stable@vger.kernel.org
Date: Wed, 06 May 2026 22:22:51 +0800
In-Reply-To: <2se24qgfmwumdpdjdcszz7l3m5rbucnp22hbidvhz6xc3p6j4i@fkb4u4hg6ha2>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
	 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
	 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
	 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
	 <afZUxYhkCQ0wG0Uu@wunner.de>
	 <68d4a49bf1df785ae906fbc2dd16e64b667ca5f0.camel@iscas.ac.cn>
	 <afcMtlBJYeuxSqZr@wunner.de>
	 <2se24qgfmwumdpdjdcszz7l3m5rbucnp22hbidvhz6xc3p6j4i@fkb4u4hg6ha2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:zQCowAAHmQy7TvtptBGODw--.6857S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8urW3WF15KrykKr4fAFb_yoW5uF4kpF
	W7Kay8tFs8JF4Iy3ZrKw10qFyayF4DJw15C3s5GrWjvrs8WryrZryxtFyDZasrCr1xAw1a
	vrZYq348u3yDXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07b4oGdUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Rspamd-Queue-Id: 8440A4DC3E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244410-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iscas.ac.cn,google.com,baylibre.com,huawei.com,linux.intel.com,kernel.org,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,ziyao.cc];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,farlepet.github.io:url,iscas.ac.cn:mid]

=E5=9C=A8 2026-05-06=E4=B8=89=E7=9A=84 19:09 +0530=EF=BC=8CManivannan Sadha=
sivam=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, May 03, 2026 at 10:52:06AM +0200, Lukas Wunner wrote:
> > On Sun, May 03, 2026 at 03:10:58PM +0800, Icenowy Zheng wrote:
> > > It's used in multiple products, but only one of them (EVBv1,
> > > which is
> > > just an early EVB available for a few people including me) lacks
> > > an
> > > onboard switch, because SG2042 is short on on-chip peripherals.
> > > All
> > > other devices (including two mainlined ones, EVBv2 and Milk-V
> > > Pioneer,
> > > and unmainlined dual socket rack servers; Milk-V Pioneer should
> > > be the
> > > most popular device because it was on shelf) have an onboard
> > > switch to
> > > mitigate the lack of on-chip peripherals in SG2042.
> >=20
> > Who knows, maybe someone will design a product which doesn't attach
> > a PCIe switch to the SoC, maybe the lack of peripherals isn't a
> > problem for them.
> >=20
> > It seems reasonable to accommodate such non-switch use cases as
> > well,
> > so I think you definitely do not want to quirk all products using
> > that
> > SoC but only those that need it, regardless whether it's the
> > majority.
> >=20
> > > > My point is, you want to constrain this to a specific product,
> > > > not to
> > > > the SoC.=C2=A0 Can you maybe solve this by not specifying interrupt=
s
> > > > in
> > > > the devicetree for the PCIe switch?
> > >=20
> > > The PCIe switches are not described in the device tree at all,
> > > because
> > > they're all just discoverable; can we describe them in the DT and
> > > redirect their interrupts to void?
> >=20
> > Yes, somebody did a writeup how to represent switches and endpoints
> > in the devicetree:
> >=20
> > https://farlepet.github.io/linux/2024/02/20/using-linux-device-tree-wit=
h-pcie-devices.html
> >=20
>=20
> I wouldn't recommend going this far... We do have some switches
> described in DT,
> but they have some resource requirements like regulator, i2c...
>=20
> > And then I would try providing an empty "interrupts" property for
> > those switch ports for which you want to avoid port services being
> > instantiated.
> >=20
>=20
> There is no 'interrupts' property in DT binding for PCI bridge nodes.
> There is
> 'interrupt-map', but that's used for mapping INTx with platform
> interrupt
> controller.
>=20
> Moreover, DT should just describe the hardware topology/resource, not
> platform constraints.
>=20
> I'd recommend introducing a new cmdline param to the portdrv driver
> to disable
> using MSIs for services. But the platform limitation would hit one

Currently `pcie_ports=3Dcompat` command line parameter is used to
workaround the current situation, and this patch is designed to
integrate such workaround into the kernel.

> way or the
> other if one of the endpoints consume all MSIs...

I think one EP claiming multiple MSI (not MSI-X) is an extended
capability of the MSI controller controlled by MSI_FLAG_MULTI_PCI_MSI
flag, which isn't supported for the SG2042 MSI controller driver.

In fact the SG2042 MSI controller isn't originally designed for PCIe
MSIs -- one bit in its doorbell register corresponds to one interrupt.
It's why there's only 16 MSIs available (only one doorbell register is
available and the PCI MSI restricts to 16-bit message data), and also
why multiple PCI MSI isn't supported (multiple PCI MSIs must have
consecutive data values, which isn't possible in such case).

Thanks,
Icenowy

>=20
> - Mani


