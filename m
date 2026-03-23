Return-Path: <stable+bounces-230018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOlcAAG6wWm/UwQAu9opvQ
	(envelope-from <stable+bounces-230018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:09:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E032FE15F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA24D30219D3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747D23806BE;
	Mon, 23 Mar 2026 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6c6b7WN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359CF330650;
	Mon, 23 Mar 2026 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303740; cv=none; b=rWbTslhY+uHWo5Ewv+bmdBxnys7wMjOHWMkX082Reg1EVXkKnR9DpJLIbcftDoPFRJTmJWBHxSgsTtig58GfZFqt3zrjKheu0Vx1L2JHsK0R1r5cEto9xt8jd9is5m/IW/AhnxL7Umyp3UCt1bsKBZRZDGzvUVIO2Z3VDGInkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303740; c=relaxed/simple;
	bh=7+YNRg0192JPCv78lvVe/YYOAr1sQyE0YYeqhV3a2LE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r0AYMm+GIPbFt0aPGFlqwTowenCm59JmigX5a8J/0D/GUL0ib7pBi73muCA/owdZyJma1bJxSPfFOrKASIFoRSBUTB7P4l2/NWqRlMBjtVkLnTwsp82PsMh2/4w4GSxomwM4ftwNMEX45OiNQgSDAK3oa7c+ajWe4YnQqIa7HvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6c6b7WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CD6C4CEF7;
	Mon, 23 Mar 2026 22:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774303739;
	bh=7+YNRg0192JPCv78lvVe/YYOAr1sQyE0YYeqhV3a2LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p6c6b7WNpOd2eeBbpZ+9+2Gsn8oNjJpqEk2RkYgUgq1lw+rXj7lyV3xUSS/Fs1CIS
	 EUqx124nJBcjkR3Uu8YXUq3V3WcG29Bxtwo484LJIaQFr9GjafiBnbsFCRaG9LxULg
	 wu5+MF1aIyKWHUL+pOXMNuWfo0nzegfaEcyt/Fj4LeK90B1W7TAs2lzxA28ZLPkKs7
	 U7dkrBFu4aukb5MEnrk3StnwOweJG23d38+yVBRo++3W7W/CyiQjuEGv0tSez4uV4t
	 CON5b+WUJSNCIFl6UfWTmP9KZVHCJc64626ftkv5JWT8AVGPaZ/J45MWlOVXTnBtTG
	 bIOiaGwk4qPzg==
Date: Mon, 23 Mar 2026 17:08:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Message-ID: <20260323220858.GA1084506@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8833061F34B9BEFC9D19764A8C4EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230018-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,pengutronix.de,kernel.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92E032FE15F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 02:55:45AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> ... [messed up quoting]

> > On Tue, Mar 17, 2026 at 02:12:56PM +0800, Richard Zhu wrote:
> > > Add a force_suspend flag to allow platform drivers to force the PCIe
> > > link into L2 state during suspend, even when L1SS (ASPM L1 Sub-States)
> > > is enabled.
> > >
> > > By default, the DesignWare PCIe host controller skips L2 suspend when
> > > L1SS is supported to meet low resume latency requirements for devices
> > > like NVMe. However, some platforms like i.MX PCIe need to enter L2
> > > state for proper power management regardless of L1SS support.
> > >
> > > Enable force_suspend for i.MX PCIe to ensure the link enters L2 during
> > > system suspend.
> > 
> > I'm a little bit skeptical about this.
> > 
> > What exactly does a "low resume latency requirement" mean?  Is
> > this an actual functional requirement that's special to NVMe, or
> > is it just the desire for low resume latency that everybody has
> > for all devices?
>
> From my understanding, L1SS mode is characterized by lower latency
> when compared to L2 or L3 modes.
>
> It can be used on all devices, avoiding frequent power on/off
> cycles. NVMe can also extend the service life of the equipment.

All the above applies to all platforms, so it's not an argument for
i.MX-specific code here.

> > Is there something special about i.MX here?  Why do we want i.MX
> > to be different from other host controllers?
>
> i.MX PCIe loses power supply during Deep Sleep Mode (DSM), requiring
> full reinitialization after system wake-up.

I don't know what DSM means in PCIe or how it would help justify this
change.

> Removing the L1SS check allows the suspend process to complete
> successfully and ensures the pci->suspended flag is set to true,
> which triggers the proper resume sequence during system wake-up for
> i.MX PCIes.

> > > Cc: stable@vger.kernel.org
> > > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume
> > > functionality")
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c             | 1 +
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 4 +++-
> > >  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
> > >  3 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 81a7093494c8..7902d39185a5 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -1831,6 +1831,7 @@ static int imx_pcie_probe(struct platform_device
> > *pdev)
> > >  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
> > >  			pci->pp.skip_l23_ready = true;
> > >  		pci->pp.use_atu_msg = true;
> > > +		pci->pp.force_l2_suspend = true;
> > >  		ret = dw_pcie_host_init(&pci->pp);
> > >  		if (ret < 0)
> > >  			return ret;
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index a74339982c24..720154fd4ff0 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1229,7 +1229,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  	 * If L1SS is supported, then do not put the link into L2 as some
> > >  	 * devices such as NVMe expect low resume latency.
> > >  	 */
> > > -	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
> > PCI_EXP_LNKCTL_ASPM_L1)
> > > +	if (!pci->pp.force_l2_suspend &&
> > > +	    (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
> > > +	     PCI_EXP_LNKCTL_ASPM_L1))
> > >  		return 0;
> > >
> > >  	if (pci->pp.ops->pme_turn_off) {
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > index ae6389dd9caa..5261036bbe6e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -447,6 +447,7 @@ struct dw_pcie_rp {
> > >  	bool			ecam_enabled;
> > >  	bool			native_ecam;
> > >  	bool                    skip_l23_ready;
> > > +	bool                    force_l2_suspend;
> > >  };
> > >
> > >  struct dw_pcie_ep_ops {
> > > --
> > > 2.37.1
> > >

