Return-Path: <stable+bounces-272179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R6yqMdGDS2r9SgEAu9opvQ
	(envelope-from <stable+bounces-272179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 12:30:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6656170F336
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 12:30:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=deZw+PHZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272179-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272179-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2011330248A1
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797583D0BE4;
	Mon,  6 Jul 2026 10:29:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B33ACA71;
	Mon,  6 Jul 2026 10:29:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333791; cv=none; b=SmkJXNHraa4SKztlpFO/FNrNc12d6ZsPPYQZVqVp1BG6YBs8G7fiibHWqjwQf/aF9voc0zFVqdiADTFB4FpGbHbS/0YL6pRX1XZaa/pV5E3RikMKvpYnfa3EkbZyLbDBhH8EaU6UQbMO1wvxcSxSQYXuTUKAIkYqCHjxWo1EVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333791; c=relaxed/simple;
	bh=HP+bijMJa9X7wYxSCkOyzfRBILRidWOlKxrUNln+31Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5Gvvel4+JhD0YYijf7b5NbyYwN0xcZ4u5yE1GMSzRnyuNlP0zFaO/P4sqeS6fzOQ1rZabMk+3rSAZGtuzEKVA6mJP1ESCzzBkCEEHsaDFcZDMBuMuNG2as9B1wycEjRfE+ZVjK84Z6luMoaWgMV5UfkLsushlK35wUGaV9j7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deZw+PHZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366911F000E9;
	Mon,  6 Jul 2026 10:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333788;
	bh=YaiT2z3qpXhTNE58QdMIFf3NiMwIsaqv9pHhX1hnvXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=deZw+PHZpD4PiC0sDZ+djpQLp9rq1RHiV3XJ4vz8ya27J+ITC8sQrrFsxsgM2rbWh
	 QuSF3XOxqXtS59J7ZItsOgAlnu8M2dhW2VLiuzRfi1OnHZe4bXe6JoL+JMdZDMVL7u
	 cbW/kExxihnu45MyBitLObmt8fn15wK+TewA4KedSUbFbJ+PU2eAdTumd7y9ggk92o
	 aGjvtMcgUi/3cVFZXh3NKYfH6BJtKa5cl5Cben3FaoC11KQD2j/b1wMO0aXBnZuL/d
	 ekH98V2cPLpFUPgye9mTySNgTjrat1iOCiF7PT/7uH0Eu7S8MW/lJD3wKNwAIVjBM8
	 PLDBE0qSS+ydw==
Date: Mon, 6 Jul 2026 12:29:35 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Soeren Moch <smoch@web.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org, 
	Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Message-ID: <2cbqhvfjszzuanp4i3rohntkxpfgftfjvzt66te3wkohsvw26g@yv4txuy74tvu>
References: <20260427115804.134231-1-smoch@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427115804.134231-1-smoch@web.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272179-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:smoch@web.de,m:bhelgaas@google.com,m:hongxing.zhu@nxp.com,m:stable@vger.kernel.org,m:l.stach@pengutronix.de,m:Frank.Li@nxp.com,m:festevam@gmail.com,m:linux-pci@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:imx@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[web.de,google.com];
	FORGED_SENDER(0.00)[mani@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,vger.kernel.org,pengutronix.de,gmail.com,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6656170F336

On Mon, Apr 27, 2026 at 01:58:04PM +0200, Soeren Moch wrote:
> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
> 
> Even though the Root Port MSIs won't be received by the iMSI-RX controller
> due to design, this chipset has some weird hardware bug that prevents
> the endpoint MSIs from reaching when the Root Port MSI capability is
> disabled.
> 
> Hence, always keep the Root Port MSI capability for this chipset.
> 
> Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
> PME and others won't be received by default. So users need to use
> workarounds such as passing 'pcie_pme=nomsi' cmdline param.
> 
> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug")

This is not the correct fixes tag. Correct one is:
f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")

> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: Soeren Moch <smoch@web.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

@Bjorn: Can you merge this patch for 7.2-rcS with correct fixes tag?

- Mani

> ---
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: imx@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> 
> Tested on a tbs2910 board [1]
> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6d6a1688e7eb..3d461bdef967 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

