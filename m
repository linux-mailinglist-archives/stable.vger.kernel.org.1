Return-Path: <stable+bounces-210713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBxVIXmGcGkEYQAAu9opvQ
	(envelope-from <stable+bounces-210713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 08:55:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D2531AE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 08:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99A2470A19A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760746AED6;
	Wed, 21 Jan 2026 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZAiZ1YE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784F3A7855;
	Wed, 21 Jan 2026 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982051; cv=none; b=pzf8G3TXq42ljyOPUoXFT4M5JGcgLY3e8V0PkykQl3jd54f0MB3qEDXFIsicYKDERYkkCL4T0qjVFjaDU54AehfxTueCfPaF+4KZtz/wBpINhfwm74h97PK3yLSePl4WqF3U6QW26db99mkDk9aVRRjumOIL2j3gr2OQQv+Y56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982051; c=relaxed/simple;
	bh=TC2tcJfS2vWZBe0m/+BUUBgTB+Yd6OYy+mlQ7DX9l5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt4zcX2V/VgOH0osuOa1l5we17AOX0WlWqiyVR/Asqrnf3i7Q7t6uFyGITjI1Ux+ff/sUuuRnLGONjJti6vQeZHo9Nrfz7U3bRA8nzsRfvZxHhJwkwzZxZjaKYcH6mymGv/JL6u5k8i48N7Owr2YMiZfjhL398rerK3+KMOnIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZAiZ1YE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80DAC116D0;
	Wed, 21 Jan 2026 07:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768982050;
	bh=TC2tcJfS2vWZBe0m/+BUUBgTB+Yd6OYy+mlQ7DX9l5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZAiZ1YE6AiRjIWAhVzofjXAwpVtlMftLzINR9Foi5IBYGEqBk1/OAY+Ddvjl+i+S
	 HJDBwTQs3pdOnyCQ8rfsjZauZ7H2ZJSlvTfuSi1VvT0grFVC8yYDQxCNOi7nJcPzSZ
	 JurscrLIXiiwYjavr2jeR2mvyXsGHzu+h98xwN161zMF7215uPhpdRuFunx4Oli0e7
	 LPWmQ4cjB2gH5Y7tSGQdFDujYHnZv7bDjseRgXJ5NHlnSiJ1ZK+1Ox0aEhiFn1g3JH
	 4g0sPvi0rwDbcffy++1aRiTN7nayp/Q94w1q1AN9uK8ypPZWL35JZlYmuGQ6rDCXPI
	 Xe1cNNZFn0y8w==
Date: Wed, 21 Jan 2026 13:23:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v9] PCI: dwc: Don't poll L2 if skip_l23_wait is true
Message-ID: <drqhmcl5vzuk7dx5g4fjhrsfstu2tssmmotychgyf3vcus2tz5@rqsrsrbpjc2o>
References: <20260114083300.3689672-1-hongxing.zhu@nxp.com>
 <20260114083300.3689672-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114083300.3689672-2-hongxing.zhu@nxp.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,pengutronix.de,kernel.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 053D2531AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 14, 2026 at 04:33:00PM +0800, Richard Zhu wrote:
> Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
> 
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
> 
> The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
> PME_Turn_Off is sent out.
> 
> To support this case, don't poll L2 state and apply a simple delay of
> PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the skip_l23_wait flag is true in
> suspend.
> 

I think this patch should simply say:

"In i.MX6QP and i.MX7D SoCs, LTSSM registers are not accessible once
PME_Turn_Off is broadcasted to the link. So there is no way to verify whether
the link has entered L2/L3 state or not.

Hence, add a new flag 'dw_pcie_rp::skip_l23_wait' and set it for the above
mentioned SoCs. This flag when set, will allow the DWC core to skip the L23 poll
and just wait for 10ms as per the delay mentioned in PCIe spec r6.0 sec
5.3.3.2.1."

Does it look good?

- Mani

> Cc: stable@vger.kernel.org
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c             |  5 +++++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4668fc9648bf..cbe98824427b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -114,6 +114,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
>  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
>  #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
> +#define IMX_PCIE_FLAG_SKIP_L23_WAIT		BIT(12)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1777,6 +1778,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		 */
>  		imx_pcie_add_lut_by_rid(imx_pcie, 0);
>  	} else {
> +		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_WAIT))
> +			pci->pp.skip_l23_wait = true;
>  		pci->pp.use_atu_msg = true;
>  		ret = dw_pcie_host_init(&pci->pp);
>  		if (ret < 0)
> @@ -1838,6 +1841,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.variant = IMX6QP,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
> +			 IMX_PCIE_FLAG_SKIP_L23_WAIT |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> @@ -1854,6 +1858,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.variant = IMX7D,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX_PCIE_FLAG_SKIP_L23_WAIT |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET,
>  		.gpr = "fsl,imx7d-iomuxc-gpr",
>  		.mode_off[0] = IOMUXC_GPR12,
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index fad0cbedefbc..5aa7f23bb58e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1194,6 +1194,21 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  			return ret;
>  	}
>  
> +	/*
> +	 * Skip L23 poll and wait to avoid the read hang, when LTSSM is
> +	 * not powered in L2/L3/LDn properly.
> +	 *
> +	 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
> +	 * State Flow Diagram. Both L0 and L2/L3 Ready can be
> +	 * transferred to LDn directly. On the LTSSM states poll broken
> +	 * platforms, add a max 10ms delay refer to PCIe r6.0,
> +	 * sec 5.3.3.2.1 PME Synchronization.
> +	 */
> +	if (pci->pp.skip_l23_wait) {
> +		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> +		goto stop_link;
> +	}
> +
>  	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
>  				val == DW_PCIE_LTSSM_L2_IDLE ||
>  				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f87c67a7a482..b31f8061f23a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -442,6 +442,7 @@ struct dw_pcie_rp {
>  	struct pci_config_window *cfg;
>  	bool			ecam_enabled;
>  	bool			native_ecam;
> +	bool                    skip_l23_wait;
>  };
>  
>  struct dw_pcie_ep_ops {
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

