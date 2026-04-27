Return-Path: <stable+bounces-241204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCmdD9bI7mmvxgAAu9opvQ
	(envelope-from <stable+bounces-241204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 04:24:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B846C167
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 04:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 755E6300C920
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E531A807;
	Mon, 27 Apr 2026 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="UTvn1ma1"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9A21A316E;
	Mon, 27 Apr 2026 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256655; cv=none; b=TStJCDLmusIxhGEFRkRXywquMjzYfH9RRv0p/ID5dCG/Qi7iDEwS0D8YvowuTDDzh8LKYXH6dFvPNur5saF5ZlYZprP1vQPlUtWdF7PvyY8ItyU8jCVIKaOIEpMr/Ff0wbb0jAMOEq2h3N9y+Ivp33SBxzVmY9SmloVIIZxZobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256655; c=relaxed/simple;
	bh=tBvJL95sFLic+Nj5r26PFFmPBTJB6fNdLbQxxKlYB0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WnImIP09iDCliwjHxlmeBPcJhG6j+XmtP/g61qnp028YSNHkgLchlXQy4r5Xeu8yvHl/jdfgr+0GO+iHwVx8q5EzEJ71ZfuEGmPba+JgkfZNxmP2ehquQeJqaSqoxS/ouY9MI2naqKBvER28DMAcigP6xZ3v+p6LrONm49UPDNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=UTvn1ma1; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1777256247;
	bh=528vr2AkUjMKWg88iUbPWVy7Vntp/tP5Nh4tc1Xl3pE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UTvn1ma1ujvwO8jT1rdxBsJNTvq4tecuJr9o7x/hykzuA5Ta4f/PtAPO5zBQG7rKX
	 TURoB4r+I6Vi2iLlpw9IOe8PwKgvvIeiWVz24CdZslw3B2Uh3yOciEf6m0kLp42Av/
	 pctL/dZFXZvWSFqt8G0ukUkpOYwAXTvdpTsmTLtk=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 04E3F65992;
	Sun, 26 Apr 2026 22:17:22 -0400 (EDT)
Message-ID: <6d2f0e3659659bece726a90810e3aacb0a4d75b6.camel@xry111.site>
Subject: Ping: [PATCH v8] PCI: loongson: Override PCIe bridge supported
 speeds for Loongson-3C6000 series
From: Xi Ruoyao <xry111@xry111.site>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?gb2312?Q?Wilczy=A8=BDski?=	 <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring	 <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Ziyao Li	 <liziyao@uniontech.com>
Cc: niecheng1@uniontech.com, zhanjun@uniontech.com,
 guanwentao@uniontech.com,  Kexy Biscuit <kexybiscuit@aosc.io>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, kernel@uniontech.com, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Lain
 Fearyncess Yang <fsf@live.com>, Ayden Meng <aydenmeng@yeah.net>,  Mingcong
 Bai <jeffbai@aosc.io>, stable@vger.kernel.org, Huacai Chen
 <chenhuacai@kernel.org>, Huacai Chen	 <chenhuacai@loongson.cn>
Date: Mon, 27 Apr 2026 10:17:20 +0800
In-Reply-To: <20260412101731.107059-1-xry111@xry111.site>
References: <20260412101731.107059-1-xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DB2B846C167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241204-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[uniontech.com,aosc.io,vger.kernel.org,lists.linux.dev,linux.intel.com,live.com,yeah.net,kernel.org,loongson.cn];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Ping.

On Sun, 2026-04-12 at 18:17 +0800, Xi Ruoyao wrote:
> From: Ziyao Li <liziyao@uniontech.com>
>=20
> Older steppings of the Loongson-3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 0x3c19,
> 0x3c29)
> as only 2.5 GT/s, despite the upstream bus supporting speeds from
> 2.5 GT/s up to 16 GT/s.
>=20
> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if
> more
> than one speed is supported"), bwctrl will be disabled if there's only
> one 2.5 GT/s value in vector `supported_speeds`.
>=20
> Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
> amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
> clocks and lanes in power management. We hope this patch can prevent
> similar problems in future driver changes (similar checks may be
> implemented in other GPU, storage controller, NIC, etc. drivers).
>=20
> Manually override the `supported_speeds` field for affected PCIe
> bridges
> with those found on the upstream bus to correctly reflect the
> supported
> link speeds.
>=20
> This patch was originally found from AOSC OS[1].
>=20
> Link: https://github.com/AOSC-Tracking/linux/pull/2=C2=A0#1
> Tested-by: Lain Fearyncess Yang <fsf@live.com>
> Tested-by: Ayden Meng <aydenmeng@yeah.net>
> Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> Link:
> https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73=
175a17f493454
> [Ziyao Li: move from drivers/pci/quirks.c to
> drivers/pci/controller/pci-loongson.c]
> Signed-off-by: Ziyao Li <liziyao@uniontech.com>
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> [Xi Ruoyao: Fix falling through logic and add kernel log output;
> =C2=A0add Fixes tag and rebase to 7.0-rc7]
> Cc: stable@vger.kernel.org
> Fixes: cd89edda4002 ("PCI: loongson: Add ACPI init support")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>=20
> Changes in v8:
> - Add the Fixes tag.
> - Link to v7:
> https://lore.kernel.org/all/20260121-loongson-pci1-v7-1-fc79c85a574d@unio=
ntech.com/
>=20
> Ziyao Li's original commentary message follows below:
>=20
> The reason of not just copying pdev->bus->self->supported_speeds is
> that we're concerned that this approach assumes the upstream port
> reports the same capabilities as bridge, which may not always be the
> case in future silicon revisions.
>=20
> Our current conservative approach ensures we only enable speeds that
> are physically supported by checking the actual max_bus_speed. For
> example, if there's a future Loongson-3C9999 where the virtual bridge
> reports Gen4 support but the physical bridge only supports Gen3.
>=20
> In this scenario, directly copying the upstream port's
> supported_speeds
> would incorrectly report Gen4 support for the downstream bridge. The
> current patch ensures we only set speed bits up to what the hardware
> actually supports, based on the measured max_bus_speed. This seems
> safer for future silicon.
>=20
> Changes in v7:
> - adjust commit message
> - Link to v6:
> https://lore.kernel.org/r/20260114-loongson-pci1-v6-1-ee8a18f5d242@uniont=
ech.com
>=20
> Changes in v6:
> - adjust commit message
> - Link to v5:
> https://lore.kernel.org/r/20260113-loongson-pci1-v5-1-264c9b4a90ab@uniont=
ech.com
>=20
> Changes in v5:
> - style adjust
> - Link to v4:
> https://lore.kernel.org/r/20260113-loongson-pci1-v4-1-1921d6479fe4@uniont=
ech.com
>=20
> Changes in v4:
> - rename subject
> - use 0x3c19/0x3c29 instead of 3c19/3c29
> - Link to v3:
> https://lore.kernel.org/r/20260109-loongson-pci1-v3-1-5ddc5ae3ba93@uniont=
ech.com
>=20
> Changes in v3:
> - Adjust commit message
> - Make the program flow more intuitive
> - Link to v2:
> https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e57b6ef8@uniont=
ech.com
>=20
> Changes in v2:
> - Link to v1:
> https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniont=
ech.com
> - Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-
> loongson.c
> - Fix falling through logic and add kernel log output by Xi Ruoyao
>=20
> =C2=A0drivers/pci/controller/pci-loongson.c | 36
> +++++++++++++++++++++++++++
> =C2=A01 file changed, 36 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-loongson.c
> b/drivers/pci/controller/pci-loongson.c
> index bc630ab8a283..a4250d7af1bf 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -176,6 +176,42 @@ static void loongson_pci_msi_quirk(struct pci_dev
> *dev)
> =C2=A0}
> =C2=A0DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5=
,
> loongson_pci_msi_quirk);
> =C2=A0
> +/*
> + * Older steppings of the Loongson-3C6000 series incorrectly report
> the
> + * supported link speeds on their PCIe bridges (device IDs 0x3c19,
> + * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting
> speeds
> + * from 2.5 GT/s up to 16 GT/s.
> + */
> +static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
> +{
> +	u8 old_supported_speeds =3D pdev->supported_speeds;
> +
> +	switch (pdev->bus->max_bus_speed) {
> +	case PCIE_SPEED_16_0GT:
> +		pdev->supported_speeds |=3D PCI_EXP_LNKCAP2_SLS_16_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_8_0GT:
> +		pdev->supported_speeds |=3D PCI_EXP_LNKCAP2_SLS_8_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_5_0GT:
> +		pdev->supported_speeds |=3D PCI_EXP_LNKCAP2_SLS_5_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_2_5GT:
> +		pdev->supported_speeds |=3D PCI_EXP_LNKCAP2_SLS_2_5GB;
> +		break;
> +	default:
> +		pci_warn(pdev, "unexpected max bus speed");
> +
> +		return;
> +	}
> +
> +	if (pdev->supported_speeds !=3D old_supported_speeds)
> +		pci_info(pdev, "fixing up supported link speeds: 0x%x
> =3D> 0x%x",
> +			 old_supported_speeds, pdev-
> >supported_speeds);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19,
> loongson_pci_bridge_speed_quirk);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29,
> loongson_pci_bridge_speed_quirk);
> +
> =C2=A0static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus
> *bus)
> =C2=A0{
> =C2=A0	struct pci_config_window *cfg;

--=20
Xi Ruoyao <xry111@xry111.site>

