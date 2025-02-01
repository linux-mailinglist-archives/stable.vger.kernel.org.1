Return-Path: <stable+bounces-111895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3309A24A9D
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B56E3A6459
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09CB1C5F1A;
	Sat,  1 Feb 2025 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kyi8k3dG"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC091CAA68
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428252; cv=none; b=HS8mLp/2Tlj3ochYCv5c7JfCdl0r5Z1L33A+7BRH2EYi6ssqfX7+elqG0HlEFU1S2uK98r5CsAQ9tmgScon6S/dyopbtQeZgCFKWWAWxXIHzh4jJrakLvVE8fpuIELW9+2jyhme90rioWLh4OA/NYypGBOkxGJJ84R1Jd6soZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428252; c=relaxed/simple;
	bh=DDtWvqSvTMHlhlSfjRB65K77J85x2N5Zg2ez4O5SvaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=G4OqVlM/TeuzOyBFaFnrz/9rDhZDohf9BbhwJyCSYqcztzOlvsfW+T9w8LYeNZEVLcojMhDbQNPgtM1oEfeYzbG1HAUY1J5F2RQBISGM8YgbDdaDO8qzCibKewUC44fHtYfm/NzFtbqGzyr8l+CPWf3aEEcuJ2nttUvl0iOpUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Kyi8k3dG; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250201164402epoutp03d0143848b04c9bd18f699dc905064e4b~gI0a1Bq832145721457epoutp030
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 16:44:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250201164402epoutp03d0143848b04c9bd18f699dc905064e4b~gI0a1Bq832145721457epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738428242;
	bh=jLUb5G3NKhilcETtJx9Mx0srRqluN5dRf++Eobd3kOw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Kyi8k3dG0rOA7rAhVKjyui2kGevL5frPoScke9D18bDoRGEjbvQ0dyomy9adme/bs
	 WXbK+0ZHGheJaI50GKGQp62YgNM5NHcWnpMtL4aoefaZpMzYEUD9Jyk/K0cl3jJxI8
	 ZxVWtYSlHpWbHfVTKzOZIjjZqIMRp+mO4ZiA2RlI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250201164401epcas5p1d8b5507f22d418533d286b0fd2bba7fe~gI0ZS1p3Y2779827798epcas5p1g;
	Sat,  1 Feb 2025 16:44:01 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YldrH55Rbz4x9Pv; Sat,  1 Feb
	2025 16:43:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.61.19710.F4F4E976; Sun,  2 Feb 2025 01:43:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250201164359epcas5p3a6373dcd0dffd7fe3946e4288d1f98ce~gI0XmMTPh0094000940epcas5p3x;
	Sat,  1 Feb 2025 16:43:59 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250201164359epsmtrp2bfe597065193358e8e85f6fe616cfee6~gI0Xlcktq2528825288epsmtrp2X;
	Sat,  1 Feb 2025 16:43:59 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-07-679e4f4fe8b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.B4.23488.F4F4E976; Sun,  2 Feb 2025 01:43:59 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250201164357epsmtip197df7a5ce24460cf26018c73563685a8~gI0VpLGqw1429514295epsmtip13;
	Sat,  1 Feb 2025 16:43:57 +0000 (GMT)
Message-ID: <d6aed1b7-b267-4b1b-817d-a42d92be04f6@samsung.com>
Date: Sat, 1 Feb 2025 22:13:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Fix timeout issue during controller
 enter/exit from halt state
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"balbi@ti.com" <balbi@ti.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jh0801.jung@samsung.com"
	<jh0801.jung@samsung.com>, "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
	"naushad@samsung.com" <naushad@samsung.com>, "akash.m5@samsung.com"
	<akash.m5@samsung.com>, "h10.kim@samsung.com" <h10.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20250201001506.jr3yw4twwr7zutzd@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmpq6//7x0g9NT1CzeXF3FavFg3jY2
	i4P36y3uLJjGZHFq+UImi+bF69ks/t6+yGpx9+EPFovLu+awWSxa1sps8enof1aLBRsfMVqs
	aAZyVy04wO7A57F/7hp2j74tqxg9tuz/zOhx/MZ2Jo/Pm+QCWKOybTJSE1NSixRS85LzUzLz
	0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOADlVSKEvMKQUKBSQWFyvp29kU5ZeW
	pCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfsm3+eseC9ZMXqzr3MDYy/
	RboYOTkkBEwk7i5aztbFyMUhJLCbUeLssyesEM4nRonXi2+zQDjfGCWeX7/DDtPy7QRMYi+j
	xM7PG6Gct4wSv8+1soBU8QrYSZz9dwTMZhFQkdj0o40ZIi4ocXLmE7C4qIC8xP1bM8CmCgsk
	SOw7vRWsRkRAR+LAifNMIEOZBWazStxaNJsNJMEsIC5x68l8oAQHB5uAocSzEzYgYU4Ba4nl
	G6ezQpTISzRvnc0M0ishcIBD4vaBTcwQZ7tIHF/TAfWCsMSr41ugbCmJz+/2skHYyRJ7Jn2B
	imdIHFp1CKrXXmL1gjOsIHuZBTQl1u/Sh9jFJ9H7+wnYORICvBIdbUIQ1aoSpxovQ02Ulri3
	5BorhO0h8W3XM2hY72eU+PX2H+sERoVZSMEyC8mXs5C8Mwth8wJGllWMkqkFxbnpqcmmBYZ5
	qeXwGE/Oz93ECE7IWi47GG/M/6d3iJGJg/EQowQHs5IIL8fhOelCvCmJlVWpRfnxRaU5qcWH
	GE2B8TORWUo0OR+YE/JK4g1NLA1MzMzMTCyNzQyVxHmbd7akCwmkJ5akZqemFqQWwfQxcXBK
	NTClKZ286xw27Ulfx+J3uw73L3YLXLYrodiX3fp4oPEn97vzf+ksPvmpNel5eADD3yMJ854w
	3DCad16rtKdEtm/ihAzVkPICTeUf+o6XlNZkHpBfsCLfTmXZ6QOXzbwYT/LtDeB4MHPTlYuV
	tn+Stiuc/SatcYx7r7fun2scSx5UzOy+puO2iuuM4VTbNSqJi4JuFOu36ddcs7+lkCh5d9b6
	qMPLJJMW1YeonSn9tjTs9sps94cZJ24Zzl74Uq3rq8TUYNk5sQ/e8dhLuns5FPL/CjITS5Lc
	u2P9Dc6N3jHimoXv3Kf0vLma17fZ0i2laqr7qYTjZZOkLxtkP5RtsdGrrt2X80V1+poUZd6K
	o05KLMUZiYZazEXFiQC0YcXZUQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnK6//7x0g43vuC3eXF3FavFg3jY2
	i4P36y3uLJjGZHFq+UImi+bF69ks/t6+yGpx9+EPFovLu+awWSxa1sps8enof1aLBRsfMVqs
	aAZyVy04wO7A57F/7hp2j74tqxg9tuz/zOhx/MZ2Jo/Pm+QCWKO4bFJSczLLUov07RK4MvbN
	P89Y8F6yYnXnXuYGxt8iXYycHBICJhLfTtxm6WLk4hAS2M0osXnCBXaIhLTE61ldjBC2sMTK
	f8/B4kICrxklDu3QA7F5Bewkzv47wgJiswioSGz60cYMEReUODnzCVhcVEBe4v6tGWC9wgIJ
	Eof79oHViAjoSBw4cZ4JZDGzwEJWidOXbkFdsZ9R4sKn52CbmQXEJW49mQ9UxcHBJmAo8eyE
	DUiYU8BaYvnG6awQJWYSXVu7oMrlJZq3zmaewCg0C8kds5BMmoWkZRaSlgWMLKsYJVMLinPT
	c5MNCwzzUsv1ihNzi0vz0vWS83M3MYJjT0tjB+O7b036hxiZOBgPMUpwMCuJ8HIcnpMuxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnHelYUS6kEB6YklqdmpqQWoRTJaJg1OqgUk5i3uC04336fwb
	zpjPivC4VrdOf6/v1dtKq3UUd9cIfjnA8fR+UvxF2+7pRdM72L/06DBveexWaqba1mFxfa7A
	v+Ufys7FPjjAK7Hmnt/bE4UvPwTufvYmN1NrxZ3WYvl5Wi6RSybKZHRt19V60mQ8z2TVsq/C
	OU0dZWeMk+7FMcTYXn/w4u4m7eTepTLcvWzLuZID+plNg7UUuziMlm9XmfTmmfnZHdPyTsy7
	ub8z5MzCKZoiSz/xT3v5oEVm+p6rX6Rcq9bK8fdxL++0iGn5zmV/j7vW0zeTLa1y4pvm2IOR
	DwTUbgtx9kTNn8X1fvOurvMKx18bRJkJG0gem7Lr2bRXs7hWcfeVTMhfv0yJpTgj0VCLuag4
	EQBXQHLhLAMAAA==
X-CMS-MailID: 20250201164359epcas5p3a6373dcd0dffd7fe3946e4288d1f98ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250131110910epcas5p25ee5f0ab53949ad3759c0825d11170b3
References: <CGME20250131110910epcas5p25ee5f0ab53949ad3759c0825d11170b3@epcas5p2.samsung.com>
	<20250131110832.438-1-selvarasu.g@samsung.com>
	<20250201001506.jr3yw4twwr7zutzd@synopsys.com>


On 2/1/2025 5:45 AM, Thinh Nguyen wrote:
> On Fri, Jan 31, 2025, Selvarasu Ganesan wrote:
>> There is a frequent timeout during controller enter/exit from halt state
>> after toggling the run_stop bit by SW. This timeout occurs when
>> performing frequent role switches between host and device, causing
>> device enumeration issues due to the timeout. This issue was not present
>> when USB2 suspend PHY was disabled by passing the SNPS quirks
>> (snps,dis_u2_susphy_quirk and snps,dis_enblslpm_quirk) from the DTS.
>> However, there is a requirement to enable USB2 suspend PHY by setting of
>> GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY bits when controller starts
>> in gadget or host mode results in the timeout issue.
>>
>> This commit addresses this timeout issue by ensuring that the bits
>> GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
>> the dwc3_gadget_run_stop sequence and restoring them after the
>> dwc3_gadget_run_stop sequence is completed.
>>
>> Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index d27af65eb08a..4a158f703d64 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2629,10 +2629,25 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
>>   {
>>   	u32			reg;
>>   	u32			timeout = 2000;
>> +	u32			saved_config = 0;
>>   
>>   	if (pm_runtime_suspended(dwc->dev))
>>   		return 0;
>>   
> Can you add some comments here that this was added through experiment
> since it is not documented in the programming guide. It would be great
> to also note which platform you used to test this with.
>
>> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> +	if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
> I know we have "unlikely" in the other check, but we should not need it
> here or the other place. Please remove this here.


Hi Thinh,

Thanks for your review comments. I updated below newer version with 
addressed your comments. Please review it.

https://lore.kernel.org/linux-usb/20250201163903.459-1-selvarasu.g@samsung.com/

Thanks,
Selva
>> +		saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
>> +		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
>> +	}
>> +
>> +	if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
>> +		saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
>> +		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
>> +	}
>> +
>> +	if (saved_config)
>> +		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +
>>   	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>>   	if (is_on) {
>>   		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 187A)) {
>> @@ -2660,6 +2675,12 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
>>   		reg &= DWC3_DSTS_DEVCTRLHLT;
>>   	} while (--timeout && !(!is_on ^ !reg));
>>   
>> +	if (saved_config) {
>> +		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> +		reg |= saved_config;
>> +		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +	}
>> +
>>   	if (!timeout)
>>   		return -ETIMEDOUT;
>>   
>> -- 
>> 2.17.1
>>
> Thanks,
> Thinh

