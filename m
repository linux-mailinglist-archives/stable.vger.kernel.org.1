Return-Path: <stable+bounces-242604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDR3EiQD9mkzRgIAu9opvQ
	(envelope-from <stable+bounces-242604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE64B2394
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95124300D169
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EABA30DD30;
	Sat,  2 May 2026 13:58:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DC23D281;
	Sat,  2 May 2026 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730313; cv=none; b=EmLvmJYQMFhksMI6LIyE4BufAO/uwdtRqY844BsDREcz2uVR2rmoE7eVChKUUFvSoXk5zjAP2Wcm3eRLEUx38W6oP3FSRRVPj9RMzWsTaBuI2OIQzsjqC0IWy4PBRz+ugk0LLM9YkFvEiem5WXWdOteTknuL1SVB4MACNBKyGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730313; c=relaxed/simple;
	bh=Sb1P/UJsx2ORy0a0bNGk3UrMIn6yN/zSwVYbw/ZFAAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yp65rdXRjrleIXxlQIYPt9px8nSBXIicwkQLJxar/lB8+CGR9Wb9zjSFZ222I78Qldo42CGY8HIg4VE0MXQbW6jBVokq/dx8G7IKO95OAVgdl5qewdS5jv2UVc8JtbOicTIf0dc9yxCX7XOyI/bf7rY0+RkmAStdIFT4CdmTMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.122])
	by APP-03 (Coremail) with SMTP id rQCowAAnDOPsAvZpzmzfDw--.27778S2;
	Sat, 02 May 2026 21:58:05 +0800 (CST)
Message-ID: <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Manivannan Sadhasivam <mani@kernel.org>, Han Gao <gaohan@iscas.ac.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <u.kleine-koenig@baylibre.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Lukas Wunner <lukas@wunner.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Kees Cook	
 <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	linux-pci@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org, 	linux-riscv@lists.infradead.org, Han Gao
 <rabenda.cn@gmail.com>, Inochi Amaoto	 <inochiama@gmail.com>, Vivian Wang
 <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 	stable@vger.kernel.org
Date: Sat, 02 May 2026 21:58:04 +0800
In-Reply-To: <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
	 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
	 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowAAnDOPsAvZpzmzfDw--.27778S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4UKr43uF17AF18Gw1ftFb_yoW5tF1rpF
	Z5GasYyr40gFyUKw4UXw18CFyDua1vy34Fkr9IgayxuanIyr95Xrs2qr98KFsrXFsrXF1Y
	qwn8Ww13GayDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07bxNV9UUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Rspamd-Queue-Id: 08FE64B2394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242604-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,baylibre.com,huawei.com,wunner.de,linux.intel.com,kernel.org,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,iscas.ac.cn,ziyao.cc];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

=E5=9C=A8 2026-05-01=E4=BA=94=E7=9A=84 22:23 +0530=EF=BC=8CManivannan Sadha=
sivam=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Apr 01, 2026 at 01:56:58AM +0800, Han Gao wrote:
> > SG2042's PCIe root ports [1f1c:2042] fail to deliver MSI interrupts
> > to
> > downstream devices when native port services are enabled. Devices
> > under
> > an affected root port receive zero interrupts despite successful
> > vector
> > allocation, causing driver timeouts (e.g. amdgpu fence fallback
> > timer
> > expired on all rings).
> >=20
>=20
> Have you investigated why the endpoint is not able to deliver MSIs to
> host when
> Port services are enabled? Is it because the portdrv driver consumes
> all MSIs or
> MSIs are masked in hw (if so why? due to hardware issue?) or
> something else?

The problem is that the MSI controller has only 16 MSIs usable (it's
wrongly described as 32 previously, a fix to this is pending[1]), and
the failing device have an onboard PCIe switch, which created many PCIe
ports (and corresponding pcieport devices).

With pcieport devices activated, 11 MSIs are requested by the pcieport
drivers -- 3 SoC PCIe ports and 8 switch downstream ports. Then only 5
MSIs are available, but there're still 10 downstream-facing PCIe ports
now (and 5 of them are hardwired to onboard peripherals).

Thanks,
Icenowy

[1]
https://lore.kernel.org/all/20260407160143.1182430-1-zhengxingda@iscas.ac.c=
n/

>=20
> Currently, the problem description is very vague.
>=20
> - Mani
>=20
> > Set PCI_DEV_FLAGS_NO_PORT_SERVICES on SG2042 root ports to prevent
> > the
> > port service driver from probing, restoring correct MSI delivery.
> >=20
> > Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> > ---
> > =C2=A0drivers/pci/quirks.c=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++
> > =C2=A0include/linux/pci_ids.h |=C2=A0 2 ++
> > =C2=A02 files changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 48946cca4be7..bbde482ff7cb 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6380,3 +6380,15 @@ static void
> > pci_mask_replay_timer_timeout(struct pci_dev *pdev)
> > =C2=A0DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750,
> > pci_mask_replay_timer_timeout);
> > =C2=A0DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755,
> > pci_mask_replay_timer_timeout);
> > =C2=A0#endif
> > +
> > +/*
> > + * SG2042's PCIe root ports do not correctly deliver MSI
> > interrupts to
> > + * downstream devices when native PCIe port services are enabled.
> > All
> > + * services including bwctrl must be disabled, equivalent to
> > pcie_ports=3Dcompat.
> > + */
> > +static void quirk_sg2042_no_port_services(struct pci_dev *dev)
> > +{
> > +	pci_info(dev, "SG2042: disabling native PCIe port
> > services\n");
> > +	dev->dev_flags |=3D PCI_DEV_FLAGS_NO_PORT_SERVICES;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOPHGO, 0x2042,
> > quirk_sg2042_no_port_services);
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 406abf629be2..9663be526dd0 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2630,6 +2630,8 @@
> > =C2=A0
> > =C2=A0#define PCI_VENDOR_ID_CXL		0x1e98
> > =C2=A0
> > +#define PCI_VENDOR_ID_SOPHGO		0x1f1c
> > +
> > =C2=A0#define PCI_VENDOR_ID_TEHUTI		0x1fc9
> > =C2=A0#define PCI_DEVICE_ID_TEHUTI_3009	0x3009
> > =C2=A0#define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> > --=20
> > 2.47.3
> >=20


