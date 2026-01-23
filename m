Return-Path: <stable+bounces-211418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGBBFSrCc2nnyQAAu9opvQ
	(envelope-from <stable+bounces-211418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:47:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F239E79BFA
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A71305930C
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B9249E5;
	Fri, 23 Jan 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkaUsap7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F923EBF2A;
	Fri, 23 Jan 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194019; cv=none; b=kI2SSfKDfRcxPYO2Y34vZa4a47GBwnSzVtOpNgubCm2vizPKxF6J5RZxeyx5WT11sl1K5874Uj3uOi8YyM4nUE7DjA1AVyENZcSnMa8UbklP5L6yAsSaIAjdMy8Exxnv5crv301CYUr3eFetnrtGlpM1E7J0il0TURDQU4oMQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194019; c=relaxed/simple;
	bh=r6ZEYv1acM820A9Xate+DXThNCoFR1GIsc+2yX3WUZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTVOzgoqI1hoS06hS15UK2ZsspVcFesJhYS5outWkSl6F5JO5G8y82lm2KdcSrHZklfXQH7NsxU3dZYdsKeP68OHBrns42byLv/DwzCgM/+HE8oZ8OPVa7s3c9Gf6WnFcVEcMqoLVIdI/6DDWrvWSfQQOvBYf1GerudlVhlY5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkaUsap7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F11DC4CEF1;
	Fri, 23 Jan 2026 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194019;
	bh=r6ZEYv1acM820A9Xate+DXThNCoFR1GIsc+2yX3WUZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nkaUsap7XB9W5BuDpzbyA9TkQeBZjvTapc2IqDPv4vUElTGz4A+HNmb54tEyNF7RC
	 SvyIw1PorPkJeSWbQ36XXNNLhnmDUhRarlbVrK51UYwmm0UyrR9whLAqoRxP/lz7xP
	 V+EdFtlAKxXkiTkcmbG83gPy7K31hsKXe7zDen0YnAaovrJxMBbAGOl5aetNWVJLH/
	 Ne8QnoIoH51WMFm6uQr8ztruhDkW6pGexdp50Um4l5r00j/JBm8kz6vrOBPLrdO0Rg
	 OsMi72Jm/EyNkc4W0c/6LGSV8Lq55ohQxKvSp/06wHaTQDLKpH0wxGSevPMClmikMt
	 knPVU2EWOhg7g==
Message-ID: <b15b53fe-280c-4d43-978c-fb338f5ad368@kernel.org>
Date: Sat, 24 Jan 2026 05:46:53 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] PCI: dwc: Fix msg_atu_index assignment
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: Randolph Lin <randolph@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, stable@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <zhanghuabing@ecosda.com>,
 linux-pci@vger.kernel.org
References: <20260123182835.831710-6-cassel@kernel.org>
 <20260123182835.831710-7-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260123182835.831710-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com,nxp.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F239E79BFA
X-Rspamd-Action: no action

On 2026/01/24 5:28, Niklas Cassel wrote:
> When dw_pcie_iatu_setup() configures outbound address translation
> for both type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iATU index
> to use is incremented before calling dw_pcie_prog_outbound_atu().
> 
> However, for msg_atu_index the index is not incremented before use,
> causing the iATU index to be the same as the last configured iATU
> index, which means that it will incorrectly use the same iATU index
> that is already in use, breaking outbound address translation.
> 
> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Hans Zhang <zhanghuabing@ecosda.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index b3d6a474fd16..ae5f2d8a3857 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,7 +982,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>  
> -	pp->msg_atu_index = i;
> +	pp->msg_atu_index = ++i;

	pp->msg_atu_index = i + 1;

is a lot more readable in my opinion. Changing i itself is useless since it is
reset to 0 below.

>  
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {


-- 
Damien Le Moal
Western Digital Research

