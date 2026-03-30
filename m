Return-Path: <stable+bounces-231019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MISNMX4mymnX5gUAu9opvQ
	(envelope-from <stable+bounces-231019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:30:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F635673D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D29793055DF2
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22E239EF37;
	Mon, 30 Mar 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSyCfOqv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E32E8B67;
	Mon, 30 Mar 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855363; cv=none; b=AmJH2TCl5lowVo/uqkL2pe+wR6B8NaYXDa/SCyvH4O70wxWXVG4mLwcDIRtxdOb8oiPvpXcG5IfDu/hoy8kHbeNS0ZFcB0tf097fACNIAh+UbGg1ZMmIdXsKiDUzH2tXQS5Pl8yGgfnRVp4/3cLFfl2+ACtRsGijNUt/YKB4Gmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855363; c=relaxed/simple;
	bh=BtBXwrPvvOGvQ6wmb6po9SBw/9Uo3r3w4iIszL2DWEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXHMIoxOVfAz03iqaLc+h2FT/nSqZe9VC2oASpQnkJk1rLJbklNHm45vg8OWsKMeba7c66YHRwQ9CQA61fGHeM57tjgQocyhfR3FQv52dvcBxvamtAisTBkDu6HPlfmCCxfByIdpQcivvA1wvECUoE0M0akYL2+DZ8KfHmGPUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSyCfOqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5CFC4CEF7;
	Mon, 30 Mar 2026 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774855363;
	bh=BtBXwrPvvOGvQ6wmb6po9SBw/9Uo3r3w4iIszL2DWEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSyCfOqvUQ+vAlWFaCfOnumDXGkoPCZFhcfrOVrvq98HloqW15nTT8awjVylYkPvc
	 lzCH2y7/qdPJxJvoXCAi5l3C1MxzCYbyYQ1hmM6ZbI5VtXe0v/Dfjrd+FgT9iNDAgk
	 +K96jXv0OMpnazRiYi2Ye1UcpE/9zCr4rXbA9HtkPcklficoQk5wF110eBCCp/Lgiq
	 6wkl6plS+LTN2iUbLvocU/sMzRrk5L6l2sAwp8/mrPtOnefJ2e9sEFJZeLP7k7AODq
	 2Mg1xktcK4SrD/rH7UxLNUDJ4SJmSbAiX9ZnuCwa+LYPcj2P18khkYeTJaaRpMa2HX
	 Kd4cvwa2V2+SA==
Date: Mon, 30 Mar 2026 12:52:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Message-ID: <kqv3x4qocp7rkas5oedlpzd43h3ez7dg26hqnfgubbjdhhxlwe@rfnsicbv7qba>
References: <20260319091823.446030-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319091823.446030-1-hongxing.zhu@nxp.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231019-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,oss.qualcomm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E6F635673D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ Qiang

On Thu, Mar 19, 2026 at 05:18:23PM +0800, Richard Zhu wrote:
> The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> capability register settings in the root complex. Removing the MSI
> capability breaks MSI functionality for these endpoints.
> 

What is the relation between Root Port MSI and endpoint MSI? Endpoint MSIs
should be routed to the platform MSI controller (DWC i.MSI-RX or External like
GIC-ITS) independent of the Root Port MSI state.

I'm just trying to understand the issue here.

- Mani

> Preserve the MSI capability for i.MX7D/i.MX8M PCIe root complex to
> maintain MSI functionality.
> 
> Cc: stable@vger.kernel.org
> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> v2 changes:
> CC stable tree.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 20dafd2710a3..0b0d6a210406 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -41,6 +41,7 @@
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
>  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> +#define IMX8MM_PCIE_MSI_CAP_OFFSET		0x50
>  
>  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
>  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> @@ -117,6 +118,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
>  #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
>  #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
> +#define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -976,10 +978,17 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	struct device *dev = pci->dev;
> -	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset;
>  	u32 tmp;
>  	int ret;
>  
> +	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_KEEP_MSI_CAP) {
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writeb_dbi(pci, offset + 1, IMX8MM_PCIE_MSI_CAP_OFFSET);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +
>  	if (!(imx_pcie->drvdata->flags &
>  	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
>  		imx_pcie_ltssm_enable(dev);
> @@ -991,6 +1000,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	 * started in Gen2 mode, there is a possibility the devices on the
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  	tmp &= ~PCI_EXP_LNKCAP_SLS;
> @@ -1897,6 +1907,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET |
>  			 IMX_PCIE_FLAG_SKIP_L23_READY |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET,
> @@ -1909,6 +1920,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> @@ -1923,6 +1935,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_PHYDRV |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

