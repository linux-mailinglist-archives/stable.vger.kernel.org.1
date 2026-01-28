Return-Path: <stable+bounces-211936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEZaLcmveWnnyQEAu9opvQ
	(envelope-from <stable+bounces-211936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 07:42:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC279D7F9
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 07:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A371301016E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB7F334683;
	Wed, 28 Jan 2026 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amk5cveT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6032ED42;
	Wed, 28 Jan 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769582518; cv=none; b=DLgqpvwugbVaewsklZnnPm517owCDeJ4ljWl0i+kcEZLU4/ryPW2sPZvTHGkkVEegExzyOzXrzR/nxiFDcX0dE5x/5Bp9g9E6Wr59bgy6t4iBerEOa+ww70j9G7xzVH/2fuKGHXHiXOTNhT0L2zOyJsOaGVXdmvmrrJdbl+i2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769582518; c=relaxed/simple;
	bh=OAjnSWOINKYgfKpkwIdBvGmKZJn+u8LMW8kAjAhHK1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ewqz20Ph6pOA+yl8HKvzt2AFBV0mTRDhz+Y0VdvXTgl3QcM+dYk6dOZf1FaxN1FZfXRGN0WsHFOMAeFSfLFZfJb83a9YR1otWdZGjBtoisdLaG4GfJsKIeYadH0pijo8GZmSh4i5FsQhgd/Mh+zQRzIk/84rz1HILr7px8PTYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amk5cveT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F8C4CEF1;
	Wed, 28 Jan 2026 06:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769582517;
	bh=OAjnSWOINKYgfKpkwIdBvGmKZJn+u8LMW8kAjAhHK1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Amk5cveTd/pWJZP4lA/5BtbCmukZE6Pn+aJJQzOPAmboL9HgdR37OnQawWOpaFcL0
	 qACVtgFKdgr/K0HyBRsdR7HKEZ6mflOdr7YauPkKXTkeijLBhM4G7B61lxzelhGMk/
	 SrgSrY0hm3394JorGnRQwQAg+oD3C272LaoqW6yb7aHKdoPC+iL2Zb+yz6UQohHRPQ
	 HGSgnqgGz42zELJ63XlHokyvxPXZi0jCKFa7uCk/G4oJ01wpaxkcSkONBYxM9U3wIL
	 7D4r5Y83J8sn8D8ifnSrAgowTgp9xbXeHfDhhJa3KUDa3R5SNlZz7LSNAUCYzd3s24
	 8JQkFj/6LOABw==
Message-ID: <cfacec0b-4855-44c7-b710-41fe28cc43b2@kernel.org>
Date: Wed, 28 Jan 2026 15:36:57 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] PCI: dwc: Fix msg_atu_index assignment
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
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
References: <20260127151038.1484881-5-cassel@kernel.org>
 <20260127151038.1484881-6-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260127151038.1484881-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211936-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com,nxp.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AC279D7F9
X-Rspamd-Action: no action

On 1/28/26 12:10 AM, Niklas Cassel wrote:
> When dw_pcie_iatu_setup() configures outbound address translation for both
> type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iATU index to use is
> incremented before calling dw_pcie_prog_outbound_atu().
> 
> However, for msg_atu_index the index is not incremented before use,
> causing the iATU index to be the same as the last configured iATU index,
> which means that it will incorrectly use the same iATU index that is
> already in use, breaking outbound address translation.
> 
> In total there are three problems with this code:
> -It assigns msg_atu_index the same index that was used for the last
>  outbound address translation window, rather than incrementing the index
>  before assignment.
> -The index should only be incremented (and msg_atu_index assigned) if the
>  use_atu_msg feature is actually requested/in use (pp->use_atu_msg is set).
> -If the use_atu_msg feature is requested/in use, and there are no outbound
>  iATUs available, the code should return an error, as otherwise when this
>  this feature is used, it will use an iATU index that is out of bounds.
> 
> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index b3d6a474fd16..d7f57d77bdf5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>  
> -	pp->msg_atu_index = i;
> +	if (pp->use_atu_msg) {
> +		if (pci->num_ob_windows > ++i) {

I would still prefer:

		i++;
		if (pci->num_ob_windows > i) {

As that is far easier to understand rather than having to remember the value
return vs increment order for ++ as a prefix or suffix.
But not going to fight it.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +			pp->msg_atu_index = i;
> +		} else {
> +			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
> +			return -ENOMEM;
> +		}
> +	}
>  
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {


-- 
Damien Le Moal
Western Digital Research

