Return-Path: <stable+bounces-233505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDhGODOx1GnvwQcAu9opvQ
	(envelope-from <stable+bounces-233505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:24:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4D63AABCE
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4BF300BC8F
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6BD392C2A;
	Tue,  7 Apr 2026 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPmQrMhV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F60175A83;
	Tue,  7 Apr 2026 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546665; cv=none; b=GkOIDEXYH6QklvYPr9bia3lSoRP+QhN4CyqaE2qnbhAGjOge8ajv62yYJB+u6vGZ73hmgPEUVuwDsKa94Y9m126YYCajLc0K8Tnc5gcEfhUrsJ/nMFPhjDpBDwWqzEr0JAzXsJqe5xoBYFYhuwTTDVYjuzbyJLG6OcfqOi2E3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546665; c=relaxed/simple;
	bh=jEc9B6t8+lXVDt5wKNS6slGegGXQKYnxbzzTO5yXNHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH4Ooy6j27nk1NN4DuEobdp79fhsCoQ/1tmjWJqWDtamNCL5q63K+47PefTN/TymlwbiPXM7CWulrMV3XqaRSYtHowK7hlRM6CYuuXtm3OjtNS6aKu07W3RSfTyaD1G/VcFcuKpkaELLRPBOC2BhEB4woinl5D0uXY52F18aoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPmQrMhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6945C116C6;
	Tue,  7 Apr 2026 07:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775546665;
	bh=jEc9B6t8+lXVDt5wKNS6slGegGXQKYnxbzzTO5yXNHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPmQrMhVxW1tQdh87LPyX8H6IconvtcEUVKVP+aHk9T7B7lTyXvj9pj5i5oTV7OmZ
	 Damuf1sgbXHS0uOdxW2AHsOaVlkv4gyp7NXcgtUvyHldfqSC4U6+i0/KmZkW5mQ9Ae
	 MjG4FJ93sVs3JIApyRkt683Cvq35sw1Cb8kbsLpKIjjnj9oq8llBAlNQPCTs/ndC5b
	 R3mpnhoVDEVrLmTs0r+m+f5WkAGKz5d1MOTxTAs5vvFl7uAD5cCE5l2D74u+1ngZjj
	 0BF5S/GyFrHnvRDuIQdKo8ojli0YLHdBLptY236EeP97P5QuZXkFet7IVcYUibvVqd
	 0D/kWWYt39OtA==
Date: Tue, 7 Apr 2026 12:54:15 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Message-ID: <ihoprlijtwgihkbmszm53iftvpyg7ljvubs3bv2lt22uma74ul@zqgulwmj4jpb>
References: <AS8PR04MB8833061F34B9BEFC9D19764A8C4EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20260323220858.GA1084506@bhelgaas>
 <AS8PR04MB8833137860C682F9E1E743E08C48A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <y76fzvju42srykr3khio2bx5lmzusy6iasodvs45imis7fw3b5@wjv3gsocj534>
 <AS8PR04MB8833C20B6FF92F96EE7641E38C5AA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833C20B6FF92F96EE7641E38C5AA@AS8PR04MB8833.eurprd04.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233505-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,pengutronix.de,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F4D63AABCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 03:31:57AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: mani@kernel.org <mani@kernel.org>
> > Sent: 2026年4月4日 1:03
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>; Frank Li <frank.li@nxp.com>;
> > jingoohan1@gmail.com; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kwilczynski@kernel.org; robh@kernel.org; bhelgaas@google.com;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
> > suspend skip
> > 
> > On Tue, Mar 24, 2026 at 02:01:58AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: 2026年3月24日 6:09
> > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > Cc: Frank Li <frank.li@nxp.com>; jingoohan1@gmail.com;
> > > > l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> > > > bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > > festevam@gmail.com; linux-pci@vger.kernel.org;
> > > > linux-arm-kernel@lists.infradead.org;
> > > > imx@lists.linux.dev; linux-kernel@vger.kernel.org;
> > > > stable@vger.kernel.org
> > > > Subject: Re: [PATCH v1] PCI: imx6: Add force_suspend flag to
> > > > override L1SS suspend skip
> > > >
> > > > On Wed, Mar 18, 2026 at 02:55:45AM +0000, Hongxing Zhu wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > ... [messed up quoting]
> > > >
> > > > > > On Tue, Mar 17, 2026 at 02:12:56PM +0800, Richard Zhu wrote:
> > > > > > > Add a force_suspend flag to allow platform drivers to force
> > > > > > > the PCIe link into L2 state during suspend, even when L1SS
> > > > > > > (ASPM L1
> > > > > > > Sub-States) is enabled.
> > > > > > >
> > > > > > > By default, the DesignWare PCIe host controller skips L2
> > > > > > > suspend when L1SS is supported to meet low resume latency
> > > > > > > requirements for devices like NVMe. However, some platforms
> > > > > > > like i.MX PCIe need to enter L2 state for proper power
> > > > > > > management regardless of L1SS
> > > > support.
> > > > > > >
> > > > > > > Enable force_suspend for i.MX PCIe to ensure the link enters
> > > > > > > L2 during system suspend.
> > > > > >
> > > > > > I'm a little bit skeptical about this.
> > > > > >
> > > > > > What exactly does a "low resume latency requirement" mean?  Is
> > > > > > this an actual functional requirement that's special to NVMe, or
> > > > > > is it just the desire for low resume latency that everybody has
> > > > > > for all devices?
> > > > >
> > > > > From my understanding, L1SS mode is characterized by lower latency
> > > > > when compared to L2 or L3 modes.
> > > > >
> > > > > It can be used on all devices, avoiding frequent power on/off cycles.
> > > > > NVMe can also extend the service life of the equipment.
> > > >
> > > > All the above applies to all platforms, so it's not an argument for
> > > > i.MX-specific code here.
> > > >
> > > Hi Bjorn:
> > > Thanks for your kindly review.
> > > Yes, it is.
> > > > > > Is there something special about i.MX here?  Why do we want i.MX
> > > > > > to be different from other host controllers?
> > > > >
> > > > > i.MX PCIe loses power supply during Deep Sleep Mode (DSM),
> > > > > requiring full reinitialization after system wake-up.
> > > >
> > > > I don't know what DSM means in PCIe or how it would help justify
> > > > this change.
> > > >
> > > i.MX PCIe power is gated off during suspend, requiring full
> > > reinitialization on resume
> > >
> > 
> > Is this an unconditional behavior? What if the PCIe device is configured as a
> > wakeup source like WOL, WOW? And if you connect NVMe, this behavior will
> > result in resume failure as NVMe driver expects the power to be retained if
> > ASPM is supported.
> 
> Yes, this is unconditional behavior. The i.MX PCIe controller exclusively
> supports sideband wakeup mechanisms, which operate independently of the
> PCIe link state and device power configuration.
> 

I believe you are referring to WAKE# as the sideband wakeup mechanism. If so,
both host and device has to support WAKE#.

> For devices configured as wakeup sources (WOL, WOW, etc.): The sideband
> wakeup path bypasses the standard PCIe power management, so these
> configurations do not impact the i.MX PCIe RC controller's suspend/resume
> behavior.
> 

Once user enables wakeup for a device, PCI core will configure PME_EN only if
the device supports toggling WAKE# from D3Cold. So the wakeup functionality
depends on device too, not just the RC.

> For NVMe devices with ASPM: While NVMe drivers typically expect power
> retention when ASPM is enabled, the i.MX implementation's sideband wakeup
> mechanism operates through a separate signaling path. The wakeup functionality
> does not depend on maintaining PCIe link power, thus avoiding conflicts with
> NVMe power state expectations.
> 

There is no relation between WAKE# and NVMe. NVMe is a passive device, so it
doesn't support WAKE#. With this patch alone, the NVMe driver won't resume (is
ASPM is enabled). You need to tell the NVMe driver to perpare for power loss
too. Maybe this patch can help you:
https://lore.kernel.org/all/20251231162126.7728-1-manivannan.sadhasivam@oss.qualcomm.com/

But that patch will only help if your platform supports S2RAM through PSCI.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

