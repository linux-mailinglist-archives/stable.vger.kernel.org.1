Return-Path: <stable+bounces-233257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIMuDax40Gn/7wYAu9opvQ
	(envelope-from <stable+bounces-233257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 04:34:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88C399A8A
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 04:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D7533028F68
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 02:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B72D5436;
	Sat,  4 Apr 2026 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl9mBwBO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523CF3B2BA;
	Sat,  4 Apr 2026 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775270047; cv=none; b=qANV+ejv71+zX78a8Lz1t9cgnaTiItuZl+gyOvWXrXU6vuyh3A+0/1yMTx+HxIZoKJcdJG0zTyaj9SsY9EUasTtCLWsxK/AuZzCprEFuTLKXmXc2P+9VTHkIbwfkHEwNcgfjkugUAh+gHYpeihapY8MGMe64md2OfTTpZ+cuLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775270047; c=relaxed/simple;
	bh=ov2H8JzYKmYOc6CcKNfzyC7ZEUeHD2YB4AVNGff6iNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnLP5ikvGlNmkMj+KNO/Ns+I+n7j6/XzPcTlF5jYVjOr7yXwVQpS+b3MdOW8uMd/XlE61xsa94m2lWZg2odltL2O4/w1V/s2B0Mv1H0RIGpNfXoZz7GgfB9NTebRaTqHTis7HcHD8abEhcvmd8J98v5DRLFu0+e3KihBCM9ZaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl9mBwBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7F4C4CEF7;
	Sat,  4 Apr 2026 02:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775270046;
	bh=ov2H8JzYKmYOc6CcKNfzyC7ZEUeHD2YB4AVNGff6iNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sl9mBwBOOKMXn8NEElmhNDOFCe0AXa8FhEfUbyBjxm5l1b1rOhI/gHTHEbFK3AWzy
	 urFBnB5FEIhF66/Ht5mew/l0VFBEKCT/mwFHunY4bBlEqKqo9NwjxJVVbzyOVkr2k+
	 wkqDKW/wxQHeCiQikMP+4LfwkyP52a1ne2M5RVkUSCG/5miKkLabfTe62B6W41dHGV
	 aBPyiZJ2tCeXJwDYM+/6GyDrE4V6imIR0SYqPWE0FhMGUA4nH1A7FmFg+lH1jk14D6
	 rx6HjQ+gPZptXGbXO9YIu8xjzUhY5F3qQ4GwuK3TdTlhsx9TgOJTNFJmFCcNQgmFvu
	 cRNEQX6geTkzw==
Date: Sat, 4 Apr 2026 08:03:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, frank.li@nxp.com, 
	l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Don't remove MSI capability for
 i.MX7D/i.MX8M
Message-ID: <sp2jnu23k6gy2kgpdmwajmz65nah6pdgwjja7apq3ewoqmm2rd@qsaqikndaofl>
References: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
 <20260403215656.GA360979@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403215656.GA360979@bhelgaas>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233257-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E88C399A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:56:56PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 31, 2026 at 04:52:52PM +0800, Richard Zhu wrote:
> > The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> > i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> > capability register settings in the root complex. Removing the MSI
> > capability breaks MSI functionality for these endpoints.
> > 
> > Add keep_rp_msi_en flag to indicate platforms (i.MX7D, i.MX8MM, i.MX8MQ)
> > that should preserve the MSI capability during initialization.
> 
> I guess Mani added this to the commit log:
> 
>   Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
>   PME and others won't be received by default. So users need to use
>   workarounds such as passing 'pcie_pme=nomsi' cmdline param.
> 

Yes, I did.

> Why can't we fix this automatically?  I hate it when users are
> expected to use command line parameters to work around issues.
> 
> Obviously we know at probe-time, before any PCI devices are
> enumerated, so it seems like we should be able to do the equivalent of
> "pcie_pme=nomsi" even without the parameter.
> 

That's why we came up with the idea of disabling the MSI/MSI-X capabilities of
the Root Port so that the code falls back to INTx. But the issue is that,
disabling that capability or MSI Enable bit (mayebe?) prevents endpoint MSIs
from being received. We don't know exactly what's going on inside the hardware
though. But is broken at its best. Fortunately, this behavior only applies to a
subset of the NXP SoCs.

- Mani

> > Cc: stable@vger.kernel.org
> > Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> > Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> > v3 changes:
> > Use a flag 'dw_pcie_rp::keep_rp_msi_en' to identify SoCs that require MSI
> > capability preservation, and skip the capability removal in
> > pcie-designware-host.c accordingly.
> > 
> > v2 changes:
> > CC stable tree.
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c             | 7 +++++++
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
> >  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 20dafd2710a3..fde173770933 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -117,6 +117,8 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
> >  #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
> >  #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
> > +/* Preserve MSI capability for platforms that require it */
> > +#define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
> >  
> >  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
> >  
> > @@ -1820,6 +1822,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	} else {
> >  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
> >  			pci->pp.skip_l23_ready = true;
> > +		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
> > +			pci->pp.keep_rp_msi_en = true;
> >  		pci->pp.use_atu_msg = true;
> >  		ret = dw_pcie_host_init(&pci->pp);
> >  		if (ret < 0)
> > @@ -1897,6 +1901,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> >  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
> >  			 IMX_PCIE_FLAG_HAS_APP_RESET |
> >  			 IMX_PCIE_FLAG_SKIP_L23_READY |
> >  			 IMX_PCIE_FLAG_HAS_PHY_RESET,
> > @@ -1909,6 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> >  		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
> > +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
> >  			 IMX_PCIE_FLAG_HAS_PHY_RESET |
> >  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > @@ -1923,6 +1929,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> >  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
> >  			 IMX_PCIE_FLAG_HAS_PHYDRV |
> >  			 IMX_PCIE_FLAG_HAS_APP_RESET,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index a74339982c24..7b5558561e15 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1171,7 +1171,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
> >  	 * to fall back to INTx instead.
> >  	 */
> > -	if (pp->use_imsi_rx) {
> > +	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
> >  		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
> >  		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
> >  	}
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index ae6389dd9caa..b12c5334552c 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -421,6 +421,7 @@ struct dw_pcie_host_ops {
> >  
> >  struct dw_pcie_rp {
> >  	bool			use_imsi_rx:1;
> > +	bool			keep_rp_msi_en:1;
> >  	bool			cfg0_io_shared:1;
> >  	u64			cfg0_base;
> >  	void __iomem		*va_cfg0_base;
> > -- 
> > 2.37.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

