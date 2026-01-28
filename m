Return-Path: <stable+bounces-211932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCh7LQioeWl/yQEAu9opvQ
	(envelope-from <stable+bounces-211932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 07:09:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E49D56F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 07:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA153010DA9
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC27334692;
	Wed, 28 Jan 2026 06:09:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF533556E;
	Wed, 28 Jan 2026 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580542; cv=none; b=rFIu/PiyeDaMS01ZRivRBDMhWzGUU4XdP6BZC1YFu9ty/gAma3AjP9Z4ZoXMzzmR6nglXnroybfGmxjiY1CMdwNdk3b45Re+4wvWT7Ubaqo2TPWnaSKaTVR5UFNw3vudaZmvVEvbfSyYKAysWzdwn0DUPJh4uTW2tukAXDzp/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580542; c=relaxed/simple;
	bh=P6rBaAhX6FZCH4Fdaw2tduiKb3lAeTia5/ef2XTFmEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIL1tIeYBAUbw4+2h/eqA+NNwESviNc0iM3QlCsnMMQBoZ/5bVda/s8+ZEV1eYJRUBM8B/B6FCjLq0/2zi5R4rm+t784HunMGtXLypOf0lakUbDLkS2Ec1upanbfDkUoptRtctKWGcfGvTtkQQHwMzo9yHDgsFnvBRQ2SkDfq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ecosda.com; spf=pass smtp.mailfrom=ecosda.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ecosda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecosda.com
X-QQ-mid: zesmtpgz3t1769580466t93f1b5c2
X-QQ-Originating-IP: q6tJ1G5nt+Ei8/Bmmdn6qJYOS4cpKD1NG8/H/k2gPzg=
Received: from [192.168.51.35] ( [140.206.53.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 28 Jan 2026 14:07:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1813790067454774171
Message-ID: <EF25534B0F56F73B+30e1bd84-330c-49ec-b934-0d6838020d18@ecosda.com>
Date: Wed, 28 Jan 2026 14:07:43 +0800
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
 dlemoal@kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-pci@vger.kernel.org
References: <20260127151038.1484881-5-cassel@kernel.org>
 <20260127151038.1484881-6-cassel@kernel.org>
Content-Language: en-US
From: Hans Zhang <zhanghuabing@ecosda.com>
In-Reply-To: <20260127151038.1484881-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ecosda.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: NMMSTmykDl9bHj7ylUuINkleLpY3DoPWlVxlMv8Ih5xy+OidJCXXLyWY
	VyiAORAb/G9y+kJEUpDO3OBSMN5f9sWNils5EqDNSek9IQee+oWnDPpc07pdCzEGxnShxPa
	pf5LbBarYxZpUM1iq0LK1hzSBQoVnz3QV29hsL1n1nEVb0GYSSXtlodCIGlgJBzBWrXFogg
	1+f/+1HnjMYT6wJjKr21RqwPaK4KUHSNF16eE2rCU9eO+CpJD2GfkusJDLf5LdKz33Fz2g3
	FH9xXgJJA34qbwD0A6qzTN0iBeRa4v/X1+4ObnnktXZ1EAFFtkWh2V1B9+PDkVUdhE0q91l
	SXKhlgLUKE5UjGR4RdYo3FURr1YTpXJpNd7wmknFP9mi0DG9f25mRGWFFoXYLaIlOXfTrpW
	qG6R5wF2ZDRYdz2X/r8rpwu2dj6mUqldEz7Xuz2PdYd/wiMZ/qXeofwqG709xEyNFZ4ErMw
	i7ewVtkKuY3NwrhQErMr7cbQ669uFqmu+UvN3EcV05u8/ek/8jqfj4CeZyj5sQRH7rqA3yn
	8XKiMk0+4tIi4c6t/jL5/QzomzFj1eRJMi5q448ZsRmVrtkHGrmUL6sRj6CmBstmMbPqxjK
	mCC9JgsLPOgOSQ+SFxZ/mwAKGJuaYGjmM4u6IbJKtCcCsjJlsGfdUxqKY/ZbbVelCseTwNW
	4JdIFpoT8NIn2BZMSzXqM5OPOatg5PEj/79BzzeqAJbEq6JRW0lqJ3dB0fQQWMjxXhtWAAP
	Y12EUQznOpk+Lw9qB+D1dGQRToycdxqkfP87718R1r1FRvgg8bi+Mf2RVpOO20blLZaSL8K
	kpKX/15JcF40F+1kWhp0HADWDM62TnG5yXSkdrtUbkLDBKl/MkWisissDRrqCiDmtquXPWw
	BuqzDxUZa24amQlmFppjzOX6+2W8+Tzb1/GzY5vo4IEbodt1nFW0s6W7ts+7E6at8eBuRJj
	3IEdeCq2MjJIT/W70XZLQ4gHuqJS7pN/YggWCcG8aeaufllP8tv5Gqp9mn2HVCq9Cdn3J8+
	3mBCK+bCahSzmnNW/M
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ecosda.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211932-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanghuabing@ecosda.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ecosda.com:mid,ecosda.com:email,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 633E49D56F
X-Rspamd-Action: no action



On 1/27/2026 11:10 PM, Niklas Cassel wrote:
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
>   outbound address translation window, rather than incrementing the index
>   before assignment.
> -The index should only be incremented (and msg_atu_index assigned) if the
>   use_atu_msg feature is actually requested/in use (pp->use_atu_msg is set).
> -If the use_atu_msg feature is requested/in use, and there are no outbound
>   iATUs available, the code should return an error, as otherwise when this
>   this feature is used, it will use an iATU index that is out of bounds.
> 
> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Hans Zhang <zhanghuabing@ecosda.com>

> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index b3d6a474fd16..d7f57d77bdf5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>   			 pci->num_ob_windows);
>   
> -	pp->msg_atu_index = i;
> +	if (pp->use_atu_msg) {
> +		if (pci->num_ob_windows > ++i) {
> +			pp->msg_atu_index = i;
> +		} else {
> +			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
> +			return -ENOMEM;
> +		}
> +	}
>   
>   	i = 0;
>   	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {



