Return-Path: <stable+bounces-249443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD2JBLzJC2pSNQUAu9opvQ
	(envelope-from <stable+bounces-249443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 04:23:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D357668C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 04:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 601A73046CC7
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EE5314B6D;
	Tue, 19 May 2026 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="RWBdVxlY"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7530567B;
	Tue, 19 May 2026 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157428; cv=none; b=i6en8/Oyaa9bRQQOQ0tbpwy/IUITKQmBW53ytfDLPQ6vhxDAgacrnVfjzgqKDvWN8BJaCdJNLbiU74YUlR/71QG1cr3gJGdM9HcIUm7/D+rjFYxzG1rKoCPkzyEvWD4NRw3poS1JynCdoi8Wrtww5B+Lfs7zgsKOT5k2cb6Na+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157428; c=relaxed/simple;
	bh=Knl8UtAw20hG171E3Y2R0L4KyzCebChTrQDwjiOISdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cABhc0ZEvSpGZCzftPE0ItEcyJ1gwQZXH89LF0ALGXx5nkIoM7i8J2mDowr9r86X/HWIk8IGOaKv2sCmNvf5AATw/xzihB1ssWvHlfFJq6Q9wTH8q9940mfQYMx4XjtSUNOVUtC/Qmacwxlz/KPsvf+hybNKzqbzVAy343C8LeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=RWBdVxlY; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1779157416;
	bh=Knl8UtAw20hG171E3Y2R0L4KyzCebChTrQDwjiOISdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RWBdVxlY4/rIHXqIyPBttw4OUkcK/EolNRZjFQFpbZ1WJXFDmcFiY9HctRgDomwEw
	 KMvk+uiZrWFTnKilQniWZ1HvKinPqD/ct7bfoWvPAw5Z4ImQ+dgFPt33fV3/G+mCcE
	 8PVoVDy27uhwZGVm0/Eqs7K55kaFdgYaUmxo9g9E=
Received: from [IPv6:2409:8a4c:e16:3881:40e6:9163:b33e:104b] (unknown [IPv6:2409:8a4c:e16:3881:40e6:9163:b33e:104b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 2892D6597E;
	Mon, 18 May 2026 22:23:29 -0400 (EDT)
Message-ID: <9d815df3b33a63223112b97440c01247935363c1.camel@xry111.site>
Subject: Re: [PATCH v8] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
From: Xi Ruoyao <xry111@xry111.site>
To: Mario Limonciello <mario.limonciello@amd.com>, Bjorn Helgaas
	 <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?gb2312?Q?Wilczy=A8=BDski?=	 <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring	 <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Ziyao Li	 <liziyao@uniontech.com>,
 niecheng1@uniontech.com, zhanjun@uniontech.com, 	guanwentao@uniontech.com,
 Kexy Biscuit <kexybiscuit@aosc.io>, 	linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	loongarch@lists.linux.dev,
 kernel@uniontech.com, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lain Fearyncess Yang <fsf@live.com>, Ayden
 Meng <aydenmeng@yeah.net>,  Mingcong Bai <jeffbai@aosc.io>,
 stable@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, Huacai Chen	
 <chenhuacai@loongson.cn>
Date: Tue, 19 May 2026 10:23:22 +0800
In-Reply-To: <37823e80-01c4-48ef-b873-c3424024625e@amd.com>
References: <20260518172138.GA626799@bhelgaas>
	 <37823e80-01c4-48ef-b873-c3424024625e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249443-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,uniontech.com,aosc.io,vger.kernel.org,lists.linux.dev,linux.intel.com,live.com,yeah.net,loongson.cn];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xry111.site:email,xry111.site:mid,xry111.site:dkim]
X-Rspamd-Queue-Id: 854D357668C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-05-18 at 13:53 -0500, Mario Limonciello wrote:
> > > Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
> > > amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
> > > clocks and lanes in power management. We hope this patch can prevent
> > > similar problems in future driver changes (similar checks may be
> > > implemented in other GPU, storage controller, NIC, etc. drivers).
> >=20
> > Why is this paragraph here?=C2=A0 Is there code in
> > amdgpu_device_partner_bandwidth() that wouldn't be needed after this
> > patch?
>=20
> I don't think that would be the case as this patch is a pure quirk for
> one device.
>=20
> The policy we have in amdgpu_device_partner_bandwidth() takes into=20
> account specifically the topology of dGPUs that have integrated PCI=20
> switches.
>=20
> We need to look at the speed and width of the link partner connected to=
=20
> the switch not between the switch and the GPU PCI device.

Yes, the paragraph was intended to explain why the lower speed only
manifests on some (not all) PCIe devices, for example amdgpu, with the
incorrect LinkCap2 from hardware.

> > This patch updates pdev->supported_speeds, which is used by
> > pcie_get_speed_cap(), which is in turn used by
> > amdgpu_device_partner_bandwidth().
> >=20
> > Is the point just that users of pcie_get_speed_cap() (currently just
> > amdgpu, radeon, and sysfs) will now see the correct maximum link speed
> > for Loongson-3C6000 bridges?
> >=20
> > And the "checks" you refer to would be the tests in
> > amdgpu_device_get_pcie_info() that use the results of
> > pcie_get_speed_cap()?
>=20
> I think I agree with Bjorn to drop the paragraph, it just adds confusion=
=20
> to the reader.
>=20
> You can have a sentence along the lines of "Updating the speeds to the
> correct actual support of the hardware avoids quirks in drivers=20
> consuming the speed information".

Yes, it will seem better.

Bjorn: do you need a v9 or would you just amend the message in your
tree?

--=20
Xi Ruoyao <xry111@xry111.site>

