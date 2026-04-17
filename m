Return-Path: <stable+bounces-238434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEc7IUDc4WmtzAAAu9opvQ
	(envelope-from <stable+bounces-238434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:07:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04814417B46
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB052317EA1D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3563382CB;
	Fri, 17 Apr 2026 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uAKNCEC+"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0531E830
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409387; cv=none; b=rVXfoWU8F35xfb4xfmNx4BXyEMxy1uw0KuPa712Bz0unD5qRBjVTrx9Z17u19/qDhAQG1F42XhwOpWyAl7rtxmIrqrZr3Ue2IhHVy+tJJVhTRcawFAQdZ5+9kBE+xvmVQZKE7K+nS3mR611lm+8wERyHCULlnBeg9wrneYefR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409387; c=relaxed/simple;
	bh=cMo0AnvZOw2+7NIckLdUQ3GBke2xBcqzdUUjT0pUoug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=A938Gg8ogi17yEUzN/6nPn/hfRbr//Gq5kzHzeMN0/slWt9mbvVSsBZyobual43PzCdEUUsj6eBnbN9f50U27xdZieon1aD61drAB1MH8LR0xDfuH/XuUuxka5RBn9YBj7Y90B+9KZwPsMI3Mg/DpAodjr8WAMgkTLzEohkdmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uAKNCEC+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260417070302epoutp030b05896e8d481fa8ae0a5346fd4cbd50~nEuv1XVHy2388523885epoutp03V
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 07:03:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260417070302epoutp030b05896e8d481fa8ae0a5346fd4cbd50~nEuv1XVHy2388523885epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776409382;
	bh=cXTs5l9ydocQ27nawvJSB7Pi80S0iZCE5uIvj34oMfw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uAKNCEC+iQB6ianTIAEdJgS4g05MUMkVlmuO6aZFPModYHV7BAfBkh1wZUhGF7JLA
	 vcMu+eWJVt+jlis1/ynhh2X0XrJCkxmfxDi+cLR027v85YGhGG1ej40RGX8siLUrTt
	 siNzZGAEfwFvAdkhI4qFDE6FNMQR+v60cQ54KZ/A=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260417070302epcas5p134e148996793ac1a15db89bb07875f5f~nEuvSN6il1861718617epcas5p1b;
	Fri, 17 Apr 2026 07:03:02 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fxm6r6Yb4z6B9mH; Fri, 17 Apr
	2026 07:03:00 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260417070300epcas5p483278499e9b1f0dbb53402bc6c060572~nEutvE9lb1952219522epcas5p4i;
	Fri, 17 Apr 2026 07:03:00 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260417070255epsmtip1e2276f28fa1e85ba9a0d0df2a2d23537~nEupkRBB31704817048epsmtip1j;
	Fri, 17 Apr 2026 07:02:55 +0000 (GMT)
Message-ID: <9f94b535-8e3a-4ac9-854a-39a9ed6c4c84@samsung.com>
Date: Fri, 17 Apr 2026 12:32:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: Move GUID programming after PHY
 initialization
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	paulz@synopsys.com, balbi@ti.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, akash.m5@samsung.com, h10.kim@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	stable@vger.kernel.org, Pritam Manohar Sutar <pritam.sutar@samsung.com>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20260417063314.2359-1-selvarasu.g@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260417070300epcas5p483278499e9b1f0dbb53402bc6c060572
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260417063502epcas5p4f8f7fefb697e6d130ef7e9a78581ed84
References: <CGME20260417063502epcas5p4f8f7fefb697e6d130ef7e9a78581ed84@epcas5p4.samsung.com>
	<20260417063314.2359-1-selvarasu.g@samsung.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238434-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvarasu.g@samsung.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 04814417B46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/17/2026 12:03 PM, Selvarasu Ganesan wrote:
> The Linux Version Code is currently written to the GUID register before
> PHY initialization. Certain PHY implementations (such as Synopsys eUSB
> PHY performing link_sw_reset) clear the GUID register to its default
> value during initialization, causing the kernel version information to
> be lost.
>
> Move the GUID register programming to occur after PHY initialization
> completes to ensure the Linux version information persists.
>
> Fixes: fa0ea13e9f1c ("usb: dwc3: core: write LINUX_VERSION_CODE to our GUID register")
> Cc: stable@vger.kernel.org
> Reported-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
>   drivers/usb/dwc3/core.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Apologies, I missed including the what is change in patch-v2 for this 
submission.

Changes in v2:
- Update commit message for properly describe the problem and solution.
Link to v1:  
https://lore.kernel.org/linux-usb/20260410064735.515-1-selvarasu.g@samsung.com/

Thanks,
Selva
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 161a4d58b2cec..0d3c7e7b2262f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1341,12 +1341,6 @@ int dwc3_core_init(struct dwc3 *dwc)
>   
>   	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>   
> -	/*
> -	 * Write Linux Version Code to our GUID register so it's easy to figure
> -	 * out which kernel version a bug was found.
> -	 */
> -	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
> -
>   	ret = dwc3_phy_setup(dwc);
>   	if (ret)
>   		return ret;
> @@ -1378,6 +1372,12 @@ int dwc3_core_init(struct dwc3 *dwc)
>   	if (ret)
>   		goto err_exit_phy;
>   
> +	/*
> +	 * Write Linux Version Code to our GUID register so it's easy to figure
> +	 * out which kernel version a bug was found.
> +	 */
> +	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
> +
>   	dwc3_core_setup_global_control(dwc);
>   	dwc3_core_num_eps(dwc);
>   

