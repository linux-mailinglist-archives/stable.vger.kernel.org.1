Return-Path: <stable+bounces-211332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF8QFxH5cmn8rQAAu9opvQ
	(envelope-from <stable+bounces-211332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 05:29:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3C97048B
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 05:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9628830075CD
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 04:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F133D6F8;
	Fri, 23 Jan 2026 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TT1/gpxr"
X-Original-To: stable@vger.kernel.org
Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7238A725;
	Fri, 23 Jan 2026 04:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769142539; cv=none; b=FHeSyHqOrfXa/IzJOXCNFRtOakuWVKwt4jRfvoSIneirbESobl6uugi9BpJ9RpA46GkS7GuoaWIBANainYghmB2Res5qBoQ3pnxkym2DcIHu/GuX/dq6Py5L6bOSyySqHTc/eRhK8khFhvvKkYTPd3BHUEHQ8caM6/QhfsAvYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769142539; c=relaxed/simple;
	bh=rowhrAXXExk67XkgZc9nReeJF9DwBPq7lS0cYueK+oY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GheLyTM3Ql8pPYUivJJLhP4+xmXHEuhskglk4uUUcbwFMELFRgU+CrM4kxdem8LaNK/5jHz/Iy53u7d/kBV27bkv/hXBC4ulmyh8ZZzwWSOmSLkM47ccPzwz3MmZhQ3DOkdDiydEmtegtnOgbkDIYcFWNa+f3xkiRz45HuWFeO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TT1/gpxr; arc=none smtp.client-ip=117.135.214.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31aadeb54;
	Fri, 23 Jan 2026 10:06:17 +0800 (GMT+08:00)
Message-ID: <b6219e3f-cfdb-4a6a-b93b-739b8cafd1c0@rock-chips.com>
Date: Fri, 23 Jan 2026 10:06:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Randolph Lin <randolph@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, stable@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: dwc: Fix msg_atu_index assignment
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>
References: <20260122222914.523238-6-cassel@kernel.org>
 <20260122222914.523238-7-cassel@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260122222914.523238-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be89a308b09cckunm9c2cfb7713de3c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhNTVZJSx1JHR1LSU4eGUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TT1/gpxrO/8ERONXGvVaRaYXIHSkfzgInytU6ydeiNKGP5EdOJ+8V3h3tSRdOAex+MiH9+Dy05vSQPYb9G//52DRhLY708kJ8BgiH0D3kJOLfmh+70u6fdAExSib+iIuoMdXQsPYodYBir1L5KErSaya9nOQxFZxnGfKQVEr0eg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=M+57lnuTy1l0t6ZNWrRKgUgZNn2OrLJN6RVEZRZH0yI=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211332-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,rock-chips.com:dkim,rock-chips.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD3C97048B
X-Rspamd-Action: no action

在 2026/01/23 星期五 6:29, Niklas Cassel 写道:
> When dw_pcie_iatu_setup() configures outbound address translation
> for both type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iatu index
> to use is incremented before calling dw_pcie_prog_outbound_atu().
> 
> However, for msg_atu_index the index is not incremented before use,
> causing the iATU index to be the same as the last configured iatu
> index, which means that it will incorrectly use the same iatu index
> that is already in use, breaking outbound address translation.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ab17549af518..cca5fc886409 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,7 +982,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>   			 pci->num_ob_windows);
>   
> -	pp->msg_atu_index = i;
> +	pp->msg_atu_index = ++i;
>   
>   	i = 0;
>   	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {


