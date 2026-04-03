Return-Path: <stable+bounces-233239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNtqCbI30GmP4wYAu9opvQ
	(envelope-from <stable+bounces-233239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 23:57:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74601398949
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 23:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37608301D69F
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 21:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536B35838F;
	Fri,  3 Apr 2026 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBQKPM5U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A19325490;
	Fri,  3 Apr 2026 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253418; cv=none; b=awLctfdYG0ppaqXGMcrfcB+Gbwdq31NhM2VRs+a20dxB/GAapSx0XCsyd+2sOxg1SawmNFO9zDU4XWnZvCLHYVfi1hcYhVE1tch+TkptyX+Pj7WqMnw114TChYNdQbKDf8JIUau1S4qo2nf6TX8qr3rtgkS8LE7fFFZhMHHsgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253418; c=relaxed/simple;
	bh=uHkzLeYRPMdYHIG9yS72h3rCLUWaLfdftqsXVr+qimI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qu++Wbt23eTi9s+EdWUldmWC2jT94MmCFWo6uejK0P44ZrOlvHxQMSBezpztq7V19djugvbM1FS9+ZXcxT9Fj4Ht+c7iKIjxjK17YmB7Z5Sv08VVBp14Bln0S+zsY+v8Y+e98kKIyQoH0zBDBPrZCi1O2bz5vVcicnkKcET2MXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBQKPM5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA43C4CEF7;
	Fri,  3 Apr 2026 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253418;
	bh=uHkzLeYRPMdYHIG9yS72h3rCLUWaLfdftqsXVr+qimI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MBQKPM5UnHKHXaLvuAW2yMteTzbBKm6o+cIPktQNSj7g8MkMeNPI9vLcMxFjuJ5vd
	 QYvwf90vLdXpqUi2aCAm2lAexHcIkCPFbho11IkgLhK/rv4OkSUIFXxsHTB64iQcO9
	 LCLHcm8pKQbw1FvuWQ9zeVB3j6Fqk23nWR6UV6iLk+tTxrqJJkyu3i9xyHUGNbpiFA
	 KM7nX6SaPg/sgjKVXQWQvkhlIieK0m1LaUm+XOvgxte3WdlX/D1pVFjqJ3e02+2nHU
	 IMwMUAeQtPdkLF5kzicxA/yiDeQBrGz69Oz8j182HYbEGlwSjB+7SqkOVS0EF6cqu7
	 ofu8KrqrngGhA==
Date: Fri, 3 Apr 2026 16:56:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Don't remove MSI capability for
 i.MX7D/i.MX8M
Message-ID: <20260403215656.GA360979@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233239-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74601398949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:52:52PM +0800, Richard Zhu wrote:
> The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> capability register settings in the root complex. Removing the MSI
> capability breaks MSI functionality for these endpoints.
> 
> Add keep_rp_msi_en flag to indicate platforms (i.MX7D, i.MX8MM, i.MX8MQ)
> that should preserve the MSI capability during initialization.

I guess Mani added this to the commit log:

  Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
  PME and others won't be received by default. So users need to use
  workarounds such as passing 'pcie_pme=nomsi' cmdline param.

Why can't we fix this automatically?  I hate it when users are
expected to use command line parameters to work around issues.

Obviously we know at probe-time, before any PCI devices are
enumerated, so it seems like we should be able to do the equivalent of
"pcie_pme=nomsi" even without the parameter.

> Cc: stable@vger.kernel.org
> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> v3 changes:
> Use a flag 'dw_pcie_rp::keep_rp_msi_en' to identify SoCs that require MSI
> capability preservation, and skip the capability removal in
> pcie-designware-host.c accordingly.
> 
> v2 changes:
> CC stable tree.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c             | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 20dafd2710a3..fde173770933 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -117,6 +117,8 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
>  #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
>  #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
> +/* Preserve MSI capability for platforms that require it */
> +#define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1820,6 +1822,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	} else {
>  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
>  			pci->pp.skip_l23_ready = true;
> +		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
> +			pci->pp.keep_rp_msi_en = true;
>  		pci->pp.use_atu_msg = true;
>  		ret = dw_pcie_host_init(&pci->pp);
>  		if (ret < 0)
> @@ -1897,6 +1901,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET |
>  			 IMX_PCIE_FLAG_SKIP_L23_READY |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET,
> @@ -1909,6 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> @@ -1923,6 +1929,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_PHYDRV |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a74339982c24..7b5558561e15 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1171,7 +1171,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
>  	 * to fall back to INTx instead.
>  	 */
> -	if (pp->use_imsi_rx) {
> +	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
>  		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
>  		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
>  	}
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ae6389dd9caa..b12c5334552c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -421,6 +421,7 @@ struct dw_pcie_host_ops {
>  
>  struct dw_pcie_rp {
>  	bool			use_imsi_rx:1;
> +	bool			keep_rp_msi_en:1;
>  	bool			cfg0_io_shared:1;
>  	u64			cfg0_base;
>  	void __iomem		*va_cfg0_base;
> -- 
> 2.37.1
> 

