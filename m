Return-Path: <stable+bounces-226795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJWOEd2OuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 026502AF905
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF2EE304DFB8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF39336EF1;
	Tue, 17 Mar 2026 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guPDowRa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385E32AAC5;
	Tue, 17 Mar 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768222; cv=none; b=bpfAHRdsYqK9nx/vc8nxO2StSHLGlRkysylNVz69qDDC+Bm/wlyqGJogXLTaWeV9W787S6577Dmcv6GuM5mBS2blrcGvJGr4hOTTc4CkNK+qS7oqqYfVB+Nes85Coe69FXXsuVyfpDf99nPqXzr5YErNWM8qg764Bmv1desVYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768222; c=relaxed/simple;
	bh=X5fHBbpDzeFVzWixmb94Hcy8csQ9JBTe8/DmdE9ryfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RMEsJgtzbh/AhVcMXRgywiLC3Sc3qqpMX1cCrnrgktd6Vvhi4/9iP4cLRnMggHDR6IgWbnfwkk7CzxrD6QETa1eoRjdRmXpm2Njl897qdllTIogv/6XaDAWnVVcJxjS1xRkrugDULdcpNjjwCiJCqPooQKNdqWsGx1/c5M2B4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guPDowRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBDBC4CEF7;
	Tue, 17 Mar 2026 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768222;
	bh=X5fHBbpDzeFVzWixmb94Hcy8csQ9JBTe8/DmdE9ryfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=guPDowRaX61zFVajSzO0hupq6WJ5sOfYVl0Hy6ms0ASA32KObXv+jR7ZF/mAQuChl
	 ajMhjocKSDiblUfZYOrUg9yxpM/1uo4kTzAloy1Gtg9nL+Wm6Eczc3KdHgDiE7rr64
	 OgvVNciBJ2PYkX2uIUOLco6ihZNW+MJN4jDl7s4BBAKzFIftJBgBzsUwz9NZOBfRK/
	 wnu7my2orJr1dl3dZVcUA9D6LWIPwYgtEbk1QVH6Ysb3qymyDM5naMZH7rEyhuspR+
	 Svnn63XAbXOVbv5tVuOARJZir9q3QiP0UqAIOpMWHAflEHBlvkXhJ8QfcPCrEuat1Z
	 kYfZhFZM3Yk1Q==
Date: Tue, 17 Mar 2026 12:23:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Message-ID: <20260317172341.GA93733@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317061256.591362-1-hongxing.zhu@nxp.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226795-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,pengutronix.de,kernel.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,i.mx:url]
X-Rspamd-Queue-Id: 026502AF905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 02:12:56PM +0800, Richard Zhu wrote:
> Add a force_suspend flag to allow platform drivers to force the PCIe
> link into L2 state during suspend, even when L1SS (ASPM L1 Sub-States)
> is enabled.
> 
> By default, the DesignWare PCIe host controller skips L2 suspend when
> L1SS is supported to meet low resume latency requirements for devices
> like NVMe. However, some platforms like i.MX PCIe need to enter L2 state
> for proper power management regardless of L1SS support.
> 
> Enable force_suspend for i.MX PCIe to ensure the link enters L2 during
> system suspend.

I'm a little bit skeptical about this.

What exactly does a "low resume latency requirement" mean?  Is this an
actual functional requirement that's special to NVMe, or is it just
the desire for low resume latency that everybody has for all devices?

Is there something special about i.MX here?  Why do we want i.MX to be
different from other host controllers?

> Cc: stable@vger.kernel.org
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c             | 1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 +++-
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 81a7093494c8..7902d39185a5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1831,6 +1831,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
>  			pci->pp.skip_l23_ready = true;
>  		pci->pp.use_atu_msg = true;
> +		pci->pp.force_l2_suspend = true;
>  		ret = dw_pcie_host_init(&pci->pp);
>  		if (ret < 0)
>  			return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a74339982c24..720154fd4ff0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1229,7 +1229,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	 * If L1SS is supported, then do not put the link into L2 as some
>  	 * devices such as NVMe expect low resume latency.
>  	 */
> -	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> +	if (!pci->pp.force_l2_suspend &&
> +	    (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
> +	     PCI_EXP_LNKCTL_ASPM_L1))
>  		return 0;
>  
>  	if (pci->pp.ops->pme_turn_off) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ae6389dd9caa..5261036bbe6e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -447,6 +447,7 @@ struct dw_pcie_rp {
>  	bool			ecam_enabled;
>  	bool			native_ecam;
>  	bool                    skip_l23_ready;
> +	bool                    force_l2_suspend;
>  };
>  
>  struct dw_pcie_ep_ops {
> -- 
> 2.37.1
> 

