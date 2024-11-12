Return-Path: <stable+bounces-92197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333409C4E32
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 06:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B3B287527
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 05:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E220822C;
	Tue, 12 Nov 2024 05:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="erDnl4zO"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630F208203
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389232; cv=none; b=AfvPHNisA4SHmAAXKygC1We/PkYHTclZscYNzmuWtTlBxYQQOKBcy4YjLDmRURKhbEhhKlJki5IYy0vixUA7AixEsdbOE9aZFjakV/UWluuku2OCLhh0JK+QcU0uUvZheQVy/nDADwSQ8BB77/2UU64fiPfDQ5DrzWYLJmzRG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389232; c=relaxed/simple;
	bh=QnwzgB1vdKeuy3tIBv67Gj0qhjj2871eocGPFyHEmgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QhGsYLAa3zIVhdDTSN+CYTvhINva1viK7iXDrC6Gt9HZX/7bC7pZE2Z1Ort5EBbPF34sG+O2Yo1Ltjys4DGKRLETgcFz/+LOyl6A3AOGx60wwD+8fgE/unooCwuyD5QIfQIdPmIMsO42nvAawywXPAKnbtT8YHnzqM0S3tSsL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=erDnl4zO; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241112052707epoutp01dfe9dc9715ac905b25a38eab19cb2560~HIVRcOQgO2930629306epoutp01N
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 05:27:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241112052707epoutp01dfe9dc9715ac905b25a38eab19cb2560~HIVRcOQgO2930629306epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731389227;
	bh=UiK4f++FcFZ6Y+t4zol3Bo5cF6sDUFA/e/ck+xoPeko=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=erDnl4zO2tlTMIx9wF70v9sJHDV3zLdJkhJjrN/BZ2MoOBHL9Ij9H1Rid2zhRgEWZ
	 BLaICM2hkuHiXIubU2laawPM7aJFnuL9XSTnphJtOaiw+sDLeLQpajtKDRSWS+9qkj
	 VW3jd5xDJHV9ELK/U/kAVAWYl9VpJbsiqU8z7SVc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241112052707epcas5p44a4bccfb112f23f5186bd305a0511d26~HIVQxydXR1563315633epcas5p4l;
	Tue, 12 Nov 2024 05:27:07 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XnZfd2TRxz4x9Pv; Tue, 12 Nov
	2024 05:27:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.E5.09770.927E2376; Tue, 12 Nov 2024 14:27:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241112052704epcas5p36fed63eb93fadaf5741a16c9e5639ac5~HIVOewSlm2377223772epcas5p3n;
	Tue, 12 Nov 2024 05:27:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241112052704epsmtrp104947e24f930b7cccefde1844b98f6d8~HIVOdmj7I2515625156epsmtrp1V;
	Tue, 12 Nov 2024 05:27:04 +0000 (GMT)
X-AuditID: b6c32a4a-bbfff7000000262a-ef-6732e7294d97
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.40.08227.827E2376; Tue, 12 Nov 2024 14:27:04 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241112052702epsmtip1378845bb0d394487bc78e656ca6d50ee~HIVMA_aYE2925729257epsmtip1b;
	Tue, 12 Nov 2024 05:27:01 +0000 (GMT)
Message-ID: <33dd650c-624f-414b-a8b6-44336cac9753@samsung.com>
Date: Tue, 12 Nov 2024 10:57:00 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_akakum@quicinc.com" <quic_akakum@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "rc93.raju@samsung.com"
	<rc93.raju@samsung.com>, "taehyun.cho@samsung.com"
	<taehyun.cho@samsung.com>, "hongpooh.kim@samsung.com"
	<hongpooh.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20241111235345.2vpht6ck2bwojdc7@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmuq7mc6N0gwN7eCzeXF3FavFg3jY2
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPF4vKuOWwWi5a1Mlt8Ovqf1eL2n72sFqs65wAl
	vu9ktliw8RGjxYTfF4A6DoparFpwgN1B0GP/3DXsHhP31HnMvvuD0aNvyypGjy37PzN6fN4k
	F8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3S7
	kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSo
	MCE74+5Mh4KrphXHLvk3MLZpdzFyckgImEg827GcrYuRi0NIYDejxL3v55ghnE+MEl/OrWWC
	cL4xShy69ZURpuXfnQZ2iMReRompLzayQjhvGSXWv78OVMXBwStgJ3H8Bw9IA4uAqkTz2i+s
	IDavgKDEyZlPWEBsUQF5ifu3ZrCD2MICsRLv/j1iA7FFBHQkDpw4D7aZWeAJm8TNuSAOJ5Aj
	LnHryXwmkPlsAoYSz07YgIQ5Bawl9n2YwQxRIi/RvHU22AsSAnc4JH7cOc0McbWLxN+5TWwQ
	trDEq+Nb2CFsKYmX/W1QdrLEnklfoOwMiUOrDkH12kusXnCGFWQvs4CmxPpd+hC7+CR6fz8B
	O0dCgFeio00IolpV4lTjZahN0hL3llxjhbA9JFr73zBCgmo/o8SixgPMExgVZiEFyywkX85C
	8s4shM0LGFlWMUqmFhTnpqcWmxYY5aWWw6M7OT93EyM4YWt57WB8+OCD3iFGJg7GQ4wSHMxK
	Irwa/vrpQrwpiZVVqUX58UWlOanFhxhNgfEzkVlKNDkfmDPySuINTSwNTMzMzEwsjc0MlcR5
	X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgSvrALiyovLVKc6Fpy0L2NfsEf/CtjWp6cdSA/d9C
	B0GOpBcHJ594/i1Vvn7bgY9J2XdNrmqKnCtaubpRqEArYP1v+zWL+ORbhCpNA1vPv1b6/cZY
	sV93UdrfgMvCSx7uMH75+viTx4d3Prt4se3iReMdyl+NBRw9F33gaFTgXMDdZ7hH8sHBHwcE
	2n4KZa6sdxXQff33nN7PX5IVrs9LmPZ/0jbXmunmrF8rtZjzojiD85VHix4pF9S3qGjeOKP9
	yYXP7MHTUKsggZ+Zb7sdNOs+blGfr89fcE8obvmNAPec1adO12TuuBhl6xjtcqDA93BW8q7g
	K5/rT566Z+F3cZfcTPPK41O1d5qe5NZjV2Ipzkg01GIuKk4EAA4wUu1hBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnK7Gc6N0g/l/NCzeXF3FavFg3jY2
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPF4vKuOWwWi5a1Mlt8Ovqf1eL2n72sFqs65wAl
	vu9ktliw8RGjxYTfF4A6DoparFpwgN1B0GP/3DXsHhP31HnMvvuD0aNvyypGjy37PzN6fN4k
	F8AWxWWTkpqTWZZapG+XwJVxd6ZDwVXTimOX/BsY27S7GDk5JARMJP7daWDvYuTiEBLYzShx
	fOIDdoiEtMTrWV2MELawxMp/z6GKXjNKzDl1l62LkYODV8BO4vgPHpAaFgFViea1X1hBbF4B
	QYmTM5+wgNiiAvIS92/NAJspLBAr8e7fIzYQW0RAR+LAifNMIDOZBV6xScxas4wZYsF+RokF
	jX/AOpgFxCVuPZnPBLKMTcBQ4tkJG5Awp4C1xL4PM5ghSswkurZCHMoMtKx562zmCYxCs5Dc
	MQvJpFlIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4OrW0djDuWfVB
	7xAjEwfjIUYJDmYlEV4Nf/10Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqem
	FqQWwWSZODilGph4niT1r/f6OvHr61wRjuxo+biOR3sjjC4/1p1kYfCFJ7xsr4r6zmVSN+4n
	8qwJ/x/Q33VQPrykfKPFgTaDQxGhObbiPimvCg338frxla5azdRhZjMt98nUhM7rCmss78Xf
	u/Sm5mnQl6bHu7NX71/lXJ+8efrHL/ka9csucn2aUX7c9eL75Sz2SY+U2OSLgwLzTW//7wzT
	0bTl+DflrJDIhmnv1m0VSTicf4iVYZmqrPcXpYVHrrutuXFoxQuLVOt/ERIxx18K3xPtviEa
	MinzbXi4/Yr4KVqPX7Cel10V0KH2M+GWd8Od7UYe+sfi1kv0+z58MW+lneil7BX8d0UDC1IN
	+WuOzTt1T1Fon44SS3FGoqEWc1FxIgCFecUdPQMAAA==
X-CMS-MailID: 20241112052704epcas5p36fed63eb93fadaf5741a16c9e5639ac5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241111142135epcas5p32c01b213f497f644b304782876118903
References: <CGME20241111142135epcas5p32c01b213f497f644b304782876118903@epcas5p3.samsung.com>
	<20241111142049.604-1-selvarasu.g@samsung.com>
	<20241111235345.2vpht6ck2bwojdc7@synopsys.com>


On 11/12/2024 5:23 AM, Thinh Nguyen wrote:
> On Mon, Nov 11, 2024, Selvarasu Ganesan wrote:
>> The existing implementation of the TxFIFO resizing logic only supports
>> scenarios where more than one port RAM is used. However, there is a need
>> to resize the TxFIFO in USB2.0-only mode where only a single port RAM is
>> available. This commit introduces the necessary changes to support
>> TxFIFO resizing in such scenarios.
>>
>> Cc: stable@vger.kernel.org # 6.12.x: fad16c82: usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
> You should reword the patch $subject and commit message along the line
> of adding missing check for single port ram. For this to qualify for
> stable, emphasize that this is a fix for certain platform
> configurations. Then add a Fixes tag that can go as far as 9f607a309fbe
> ("usb: dwc3: Resize TX FIFOs to meet EP bursting requirements")
Thanks for your review comments.
And Updated all the your review comments in the below newer version.

https://lore.kernel.org/linux-usb/20241112044807.623-1-selvarasu.g@samsung.com/

Thanks,
Selva
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>
>> Changes in v2:
>>   - Removed the code change that limits the number of FIFOs for bulk EP,
>>     as plan to address this issue in a separate patch.
>>   - Renamed the variable spram_type to is_single_port_ram for better
>>     understanding.
>>   - Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/lkml/20241107104040.502-1-selvarasu.g@samsung.com/__;!!A4F2R9G_pg!YvZ4F4z6U6Ba9Z6hgsw4-mLPvm9QBopNIbgMe7WSqj7VCUqf9-JQTSV4RE6OdXCw3hJR9suHcjqVrsRlZ7_3ZXQkbAs$
>> ---
>>   drivers/usb/dwc3/core.h   |  4 +++
>>   drivers/usb/dwc3/gadget.c | 54 +++++++++++++++++++++++++++++++++------
>>   2 files changed, 50 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index eaa55c0cf62f..8306b39e5c64 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -915,6 +915,7 @@ struct dwc3_hwparams {
>>   #define DWC3_MODE(n)		((n) & 0x7)
>>   
>>   /* HWPARAMS1 */
>> +#define DWC3_SPRAM_TYPE(n)	(((n) >> 23) & 1)
>>   #define DWC3_NUM_INT(n)		(((n) & (0x3f << 15)) >> 15)
>>   
>>   /* HWPARAMS3 */
>> @@ -925,6 +926,9 @@ struct dwc3_hwparams {
>>   #define DWC3_NUM_IN_EPS(p)	(((p)->hwparams3 &		\
>>   			(DWC3_NUM_IN_EPS_MASK)) >> 18)
>>   
>> +/* HWPARAMS6 */
>> +#define DWC3_RAM0_DEPTH(n)	(((n) & (0xffff0000)) >> 16)
>> +
>>   /* HWPARAMS7 */
>>   #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
>>   
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 2fed2aa01407..4f2e063c9091 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -687,6 +687,44 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
>>   	return fifo_size;
>>   }
>>   
>> +/**
>> + * dwc3_gadget_calc_ram_depth - calculates the ram depth for txfifo
>> + * @dwc: pointer to the DWC3 context
>> + */
>> +static int dwc3_gadget_calc_ram_depth(struct dwc3 *dwc)
>> +{
>> +	int ram_depth;
>> +	int fifo_0_start;
>> +	bool is_single_port_ram;
>> +	int tmp;
> Try to list this in reversed christmas tree style when possible. Move
> declaration of tmp under the if (is_single_port_ram) scope.
>
>> +
>> +	/* Check supporting RAM type by HW */
>> +	is_single_port_ram = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);
>> +
>> +	/*
>> +	 * If a single port RAM is utilized, then allocate TxFIFOs from
>> +	 * RAM0. otherwise, allocate them from RAM1.
>> +	 */
>> +	ram_depth = is_single_port_ram ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
>> +			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>> +
> Remove extra new empty line.
>
>> +
>> +	/*
>> +	 * In a single port RAM configuration, the available RAM is shared
>> +	 * between the RX and TX FIFOs. This means that the txfifo can begin
>> +	 * at a non-zero address.
>> +	 */
>> +	if (is_single_port_ram) {
>> +		/* Check if TXFIFOs start at non-zero addr */
>> +		tmp = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
>> +		fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(tmp);
>> +
>> +		ram_depth -= (fifo_0_start >> 16);
>> +	}
>> +
>> +	return ram_depth;
>> +}
>> +
>>   /**
>>    * dwc3_gadget_clear_tx_fifos - Clears txfifo allocation
>>    * @dwc: pointer to the DWC3 context
>> @@ -753,7 +791,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   {
>>   	struct dwc3 *dwc = dep->dwc;
>>   	int fifo_0_start;
>> -	int ram1_depth;
>> +	int ram_depth;
>>   	int fifo_size;
>>   	int min_depth;
>>   	int num_in_ep;
>> @@ -773,7 +811,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
>>   		return 0;
>>   
>> -	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>> +	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
>>   
>>   	switch (dwc->gadget->speed) {
>>   	case USB_SPEED_SUPER_PLUS:
>> @@ -809,7 +847,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   
>>   	/* Reserve at least one FIFO for the number of IN EPs */
>>   	min_depth = num_in_ep * (fifo + 1);
>> -	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
>> +	remaining = ram_depth - min_depth - dwc->last_fifo_depth;
>>   	remaining = max_t(int, 0, remaining);
>>   	/*
>>   	 * We've already reserved 1 FIFO per EP, so check what we can fit in
>> @@ -835,9 +873,9 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
>>   
>>   	/* Check fifo size allocation doesn't exceed available RAM size. */
>> -	if (dwc->last_fifo_depth >= ram1_depth) {
>> +	if (dwc->last_fifo_depth >= ram_depth) {
>>   		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
>> -			dwc->last_fifo_depth, ram1_depth,
>> +			dwc->last_fifo_depth, ram_depth,
>>   			dep->endpoint.name, fifo_size);
>>   		if (DWC3_IP_IS(DWC3))
>>   			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
>> @@ -3090,7 +3128,7 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
>>   	struct dwc3 *dwc = gadget_to_dwc(g);
>>   	struct usb_ep *ep;
>>   	int fifo_size = 0;
>> -	int ram1_depth;
>> +	int ram_depth;
>>   	int ep_num = 0;
>>   
>>   	if (!dwc->do_fifo_resize)
>> @@ -3113,8 +3151,8 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
>>   	fifo_size += dwc->max_cfg_eps;
>>   
>>   	/* Check if we can fit a single fifo per endpoint */
>> -	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>> -	if (fifo_size > ram1_depth)
>> +	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
>> +	if (fifo_size > ram_depth)
>>   		return -ENOMEM;
>>   
>>   	return 0;
>> -- 
>> 2.17.1
>>
> Other than minor nits, the rest looks fine.
>
> Thanks,
> Thinh

