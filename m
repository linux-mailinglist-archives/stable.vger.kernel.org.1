Return-Path: <stable+bounces-237848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE5iLIQu3mnxogkAu9opvQ
	(envelope-from <stable+bounces-237848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:09:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E173F9D04
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EB1D30682E6
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03D3E5EEB;
	Tue, 14 Apr 2026 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V9M9iO9W"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A139B486
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168333; cv=none; b=Wc8Hr1yVtcHZnwEnQRSoKP1g0HlT/YeQ6DGvb+PagiDqmlmGNxF7nRVQ0QIu5i+Rq1FhggBaEzzVcK5F34M1PxdxulLJn+YQ5Zk1sgCjIZx/BaeSdPEh+NhZPDhiW3oJBmTVOKniiWa+lDB55okI4pwK6cmXLlqnHe5DFUJYx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168333; c=relaxed/simple;
	bh=tLbh6Dtabtd0bULDfZQM4nBsiH734PBHEQmrg6Ik+TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rSdogRbjqb4GgHMTwnyj+YKzLArET6+S1XU+8WFe1rkuo1+1ylzMMoCoWeVre2QOtCcFaUd28GB0K7tNeXDSlWLEYlG3QSuit3TdvzTCuCSbB75HPzs3bamih9G5eeL1xQwb4bhYsPkuYtYKHZ80/fyex3YFTBYMhUvWpWKQqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V9M9iO9W; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260414120522epoutp02ebdd7c677817d58cee054d76e19bf7d1~mN624ag603244432444epoutp02U
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:05:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260414120522epoutp02ebdd7c677817d58cee054d76e19bf7d1~mN624ag603244432444epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776168322;
	bh=7LMcgHYoyDKjt5p7XcIwEBqvkpHrB91lMgYwqIJMSQ0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=V9M9iO9WPKYIqqr5YCkcks27w9d9cSmBZyqhCYFR/JFT+WKSH82dfP0XBUGdCULLk
	 K5+89rPy7wNRQ3QKH1V470GcgJu9To84UpN3bUi9HUzhNYETHEON/kvMTtQRgWeTwX
	 lHVcUQcHVIDsrL80dP+T0bABKk9X7M0RSyZWpSUQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260414120521epcas5p4dac48d96a4988f18a449c074669c7025~mN62RRFAK2879428794epcas5p4Z;
	Tue, 14 Apr 2026 12:05:21 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fw2z46Nq5z3hhT3; Tue, 14 Apr
	2026 12:05:20 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260414120520epcas5p1af40edf6f26de616e19cbc98174f63ae~mN61HBdF60316703167epcas5p1k;
	Tue, 14 Apr 2026 12:05:20 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260414120518epsmtip2d6510d55c1caec1d3e6193ef60fd3418~mN6zHDeJT0669906699epsmtip27;
	Tue, 14 Apr 2026 12:05:18 +0000 (GMT)
Message-ID: <d2be3f54-5375-4f1b-ab4b-e2ff81c43630@samsung.com>
Date: Tue, 14 Apr 2026 17:35:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Fix GUID register programming order
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"paulz@synopsys.com" <paulz@synopsys.com>, "balbi@ti.com" <balbi@ti.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "akash.m5@samsung.com"
	<akash.m5@samsung.com>, "h10.kim@samsung.com" <h10.kim@samsung.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "thiagu.r@samsung.com"
	<thiagu.r@samsung.com>, "muhammed.ali@samsung.com"
	<muhammed.ali@samsung.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Pritam Manohar Sutar <pritam.sutar@samsung.com>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20260414010532.sxciijnzak3ldw35@synopsys.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260414120520epcas5p1af40edf6f26de616e19cbc98174f63ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec
References: <CGME20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec@epcas5p4.samsung.com>
	<20260410064735.515-1-selvarasu.g@samsung.com>
	<20260414010532.sxciijnzak3ldw35@synopsys.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	TAGGED_FROM(0.00)[bounces-237848-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:dkim,samsung.com:email,samsung.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvarasu.g@samsung.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 62E173F9D04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/14/2026 6:35 AM, Thinh Nguyen wrote:
> On Fri, Apr 10, 2026, Selvarasu Ganesan wrote:
>> The Linux Version Code is currently written to the GUID register before
>> dwc3_core_soft_reset() is executed. Since the core soft reset clears the
>> GUID register back to its default value, the version information is
>> subsequently lost.
> This is not right. Soft reset should not clear the GUID register.
> Something else must have cleared it. Did you assert Vcc reset (hard
> reset) during phy reset/initialization?
>
> BR,
> Thinh

Hi Thinh,

Thank you for the clarification. Yes, you are correct, this issue is not 
related to a dwc3 core soft reset. Instead, the GUID value reverts to 
its default state when the PHY link_sw_reset completes during PHY init 
sequence.

We are using the Synopsys eUSB PHY, this reset is triggered from our 
downstream driver during the PHY init sequence (invoked through 
|dwc3_core_init|).

Could you please suggest the best way to retrieve the correct linux 
version information from the GUID?
Additionally, would it be feasible to update the GUID register after the 
PHY init sequence (triggered by |dwc3_core_init|) completes?

Thanks, Selva

>
>> Move the GUID register programming to occur after the core soft reset
>> has completed to ensure the value persists.
>>
>> Fixes: fa0ea13e9f1c ("usb: dwc3: core: write LINUX_VERSION_CODE to our GUID register")
>> Cc: stable@vger.kernel.org
>> Reported-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>   drivers/usb/dwc3/core.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 161a4d58b2cec..0d3c7e7b2262f 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1341,12 +1341,6 @@ int dwc3_core_init(struct dwc3 *dwc)
>>   
>>   	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>>   
>> -	/*
>> -	 * Write Linux Version Code to our GUID register so it's easy to figure
>> -	 * out which kernel version a bug was found.
>> -	 */
>> -	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
>> -
>>   	ret = dwc3_phy_setup(dwc);
>>   	if (ret)
>>   		return ret;
>> @@ -1378,6 +1372,12 @@ int dwc3_core_init(struct dwc3 *dwc)
>>   	if (ret)
>>   		goto err_exit_phy;
>>   
>> +	/*
>> +	 * Write Linux Version Code to our GUID register so it's easy to figure
>> +	 * out which kernel version a bug was found.
>> +	 */
>> +	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
>> +
>>   	dwc3_core_setup_global_control(dwc);
>>   	dwc3_core_num_eps(dwc);
>>   
>> -- 
>> 2.34.1

