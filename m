Return-Path: <stable+bounces-242646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAMaBpb29mnoagIAu9opvQ
	(envelope-from <stable+bounces-242646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 09:17:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B424B4AC8
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 09:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F353008766
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF9346E46;
	Sun,  3 May 2026 07:17:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52428C874;
	Sun,  3 May 2026 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777792650; cv=none; b=W2mYFxwEbtX6rkE7LGW54yuUMG6wDXBFKWAmr/qngZL0Cfl3lrK1Jt7LfcNChNWLvepjn10NAmxIMBge46sG9Ju475D14jg/juAeuzflyTNhc+CGb1CoLKih/887GyvdZzsIME46BOsQIepiTBs+9l5lS2yFQNjp0PNw69tde8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777792650; c=relaxed/simple;
	bh=h/I660Vux5Yonm29fHvwUsy25zdomQR89KFRopfV7w8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epUgZppukcbBzZC3xPd3DS9sEF56IVMOOJnjMcnqFqd3xs1ENAki5NtH176lvboXdUudTTyOdnkBwvFvvMqK0lY+fSKbPndmrVJtgOXuG6p8pIT6mLFcKYqJbKCRzFtNix+klXe4hhLgv18x1RzxS2skBtz6nnZ+CldEYXzKi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.122])
	by APP-01 (Coremail) with SMTP id qwCowACXP2sD9fZpjdgiDw--.44921S2;
	Sun, 03 May 2026 15:10:59 +0800 (CST)
Message-ID: <68d4a49bf1df785ae906fbc2dd16e64b667ca5f0.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Han Gao <gaohan@iscas.ac.cn>, 
 Bjorn Helgaas <bhelgaas@google.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@baylibre.com>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  Kees Cook <kees@kernel.org>, Chen Wang
 <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>, Inochi
 Amaoto	 <inochiama@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, Yao
 Zi <me@ziyao.cc>, 	stable@vger.kernel.org
Date: Sun, 03 May 2026 15:10:58 +0800
In-Reply-To: <afZUxYhkCQ0wG0Uu@wunner.de>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
	 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
	 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
	 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
	 <afZUxYhkCQ0wG0Uu@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:qwCowACXP2sD9fZpjdgiDw--.44921S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry5WFyDJrWDXr4UKFy7Awb_yoW5JFWUpF
	W7K3Wqkr4qqFyxtw1DG3yxJryrAw48Aw4rJ3s8tryUAas8JryfXrn7Kas8WrsrGF1fZFyY
	vrWrCF1rC3ykXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYsSdPUUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Rspamd-Queue-Id: 74B424B4AC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242646-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,google.com,baylibre.com,huawei.com,linux.intel.com,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,ziyao.cc];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

=E5=9C=A8 2026-05-02=E5=85=AD=E7=9A=84 21:47 +0200=EF=BC=8CLukas Wunner=E5=
=86=99=E9=81=93=EF=BC=9A
> On Sat, May 02, 2026 at 09:58:04PM +0800, Icenowy Zheng wrote:
> > The problem is that the MSI controller has only 16 MSIs usable
> > (it's
> > wrongly described as 32 previously, a fix to this is pending[1]),
> > and
> > the failing device have an onboard PCIe switch, which created many
> > PCIe
> > ports (and corresponding pcieport devices).
>=20
> Is the SG2042 only used in that single product?=C2=A0 If it is used in
> other
> products which do not have an on-board PCIe switch, why do you want
> to
> disable MSIs on those other products as well?

It's used in multiple products, but only one of them (EVBv1, which is
just an early EVB available for a few people including me) lacks an
onboard switch, because SG2042 is short on on-chip peripherals. All
other devices (including two mainlined ones, EVBv2 and Milk-V Pioneer,
and unmainlined dual socket rack servers; Milk-V Pioneer should be the
most popular device because it was on shelf) have an onboard switch to
mitigate the lack of on-chip peripherals in SG2042.

>=20
> My point is, you want to constrain this to a specific product, not to
> the SoC.=C2=A0 Can you maybe solve this by not specifying interrupts in
> the
> devicetree for the PCIe switch?

The PCIe switches are not described in the device tree at all, because
they're all just discoverable; can we describe them in the DT and
redirect their interrupts to void?

>=20
> > With pcieport devices activated, 11 MSIs are requested by the
> > pcieport
> > drivers -- 3 SoC PCIe ports and 8 switch downstream ports. Then
> > only 5
> > MSIs are available, but there're still 10 downstream-facing PCIe
> > ports
> > now (and 5 of them are hardwired to onboard peripherals).
>=20
> pcieport can make do with a single MSI vector because all port
> services
> support a shared interrupt.=C2=A0 But I assume your point is that this
> particular product has so many PCIe ports that you're still close
> to the 16 MSIs limit?

Yes, different services of the same port are now sharing a single MSI
(the 3 native ports have PME, aerdrv, bwctrl sharing the same IRQ while
the only service available for switch downstream ports is bwctrl).
However there're 11 ports (3 native ports + 8 switch downstream ports),
so this still leaves too few room for other cards.

Thanks,
Icenowy

>=20
> Thanks,
>=20
> Lukas
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


