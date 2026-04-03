Return-Path: <stable+bounces-233221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABqINZXzz2mt1wYAu9opvQ
	(envelope-from <stable+bounces-233221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 19:06:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D11396C23
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6FD530A10BC
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E43CAE73;
	Fri,  3 Apr 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcppZFR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541311A9FBA;
	Fri,  3 Apr 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235798; cv=none; b=u4X/th8pxpUnJLOhKCw5pafPmcsqqoAIOjq2NRb51+W5uXUQaS5T87OhImcDWPhTaz0hYAPoyX7hsZW815zTTax4HNmLlyT3IdVcATN9PMuSDvSdxe5h/+SDUP2bZ6SVrOZpHUCEzbMWqDCFO3NOc6PEjcsqUlsg9ru12yS3fM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235798; c=relaxed/simple;
	bh=AOS61gbnHSp9w8+XowYHPIQQIZMANYd5/P0NBGDXrIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUbuFJ0vCezbvL8AeWJYleEp81Rmn7uCzJFUzbXAxnRG3j8uld15XoZ49vW/vg7ZXA9Y71p/uehQuwvt3dwS2S+iUrID1TK0tAR95gIAfSK05ajxnSkQx0ow7DD3nEsAuUvBgCxpgeziVIuq0lIY5VN+OMW7VgQy88Vre+Vkkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcppZFR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AB5C4CEF7;
	Fri,  3 Apr 2026 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775235797;
	bh=AOS61gbnHSp9w8+XowYHPIQQIZMANYd5/P0NBGDXrIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcppZFR2728XjAy91UjuJreyiJLkT1JSxrFm7WUeqgzLH+t/zs9O2CadQ1LuQPkCE
	 1yPDzkplh6xvOy1RnplfX8yvT0MT5n3r5y6uAL9W9T8JxkF0/wTH2ELd580zM0CwZ/
	 SXEntQ4XlfCN9EnwqzCO/FEEM7soxB/8YwacJBRvo5rTgrLJkLLlRgInit/UnNyDxy
	 ApHFhNzgr+NnbNMhMBmK8PhFKfJoOB3ePgrrI7wRvps3m8xudbtzTA3Mwi6OSoEL9W
	 fksYtPkY5QapWcxwaceESrOlfI1TdrP+mbiWez7tsavsiX5N8XehlDq+r+8Q8rBD6p
	 50VpNVzisZwew==
Date: Fri, 3 Apr 2026 22:33:04 +0530
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
Message-ID: <y76fzvju42srykr3khio2bx5lmzusy6iasodvs45imis7fw3b5@wjv3gsocj534>
References: <AS8PR04MB8833061F34B9BEFC9D19764A8C4EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20260323220858.GA1084506@bhelgaas>
 <AS8PR04MB8833137860C682F9E1E743E08C48A@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833137860C682F9E1E743E08C48A@AS8PR04MB8833.eurprd04.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-233221-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,pengutronix.de,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77D11396C23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 02:01:58AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2026年3月24日 6:09
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; jingoohan1@gmail.com;
> > l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > mani@kernel.org; robh@kernel.org; bhelgaas@google.com;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
> > suspend skip
> > 
> > On Wed, Mar 18, 2026 at 02:55:45AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > ... [messed up quoting]
> > 
> > > > On Tue, Mar 17, 2026 at 02:12:56PM +0800, Richard Zhu wrote:
> > > > > Add a force_suspend flag to allow platform drivers to force the
> > > > > PCIe link into L2 state during suspend, even when L1SS (ASPM L1
> > > > > Sub-States) is enabled.
> > > > >
> > > > > By default, the DesignWare PCIe host controller skips L2 suspend
> > > > > when L1SS is supported to meet low resume latency requirements for
> > > > > devices like NVMe. However, some platforms like i.MX PCIe need to
> > > > > enter L2 state for proper power management regardless of L1SS
> > support.
> > > > >
> > > > > Enable force_suspend for i.MX PCIe to ensure the link enters L2
> > > > > during system suspend.
> > > >
> > > > I'm a little bit skeptical about this.
> > > >
> > > > What exactly does a "low resume latency requirement" mean?  Is this
> > > > an actual functional requirement that's special to NVMe, or is it
> > > > just the desire for low resume latency that everybody has for all
> > > > devices?
> > >
> > > From my understanding, L1SS mode is characterized by lower latency
> > > when compared to L2 or L3 modes.
> > >
> > > It can be used on all devices, avoiding frequent power on/off cycles.
> > > NVMe can also extend the service life of the equipment.
> > 
> > All the above applies to all platforms, so it's not an argument for
> > i.MX-specific code here.
> >
> Hi Bjorn:
> Thanks for your kindly review. 
> Yes, it is.
> > > > Is there something special about i.MX here?  Why do we want i.MX to
> > > > be different from other host controllers?
> > >
> > > i.MX PCIe loses power supply during Deep Sleep Mode (DSM), requiring
> > > full reinitialization after system wake-up.
> > 
> > I don't know what DSM means in PCIe or how it would help justify this
> > change.
> > 
> i.MX PCIe power is gated off during suspend, requiring full reinitialization
> on resume
> 

Is this an unconditional behavior? What if the PCIe device is configured as a
wakeup source like WOL, WOW? And if you connect NVMe, this behavior will result
in resume failure as NVMe driver expects the power to be retained if ASPM is
supported.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

