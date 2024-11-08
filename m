Return-Path: <stable+bounces-91894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE09C15A5
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 05:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C5D284A9C
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 04:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCF1C3F0B;
	Fri,  8 Nov 2024 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aqYhjWWd"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787181A2631
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041662; cv=none; b=cD1RgSRw90b0ojnAOmnWtBb0dnwIwNl4ScJ/wRHUil3QP2nNzRNVNspJ8mBYyVqnXEPGvKWi6AqB5wCREjz81r0AK2u7V7iHICq6prxsHW5Hg3z8LJignmtXC5c5MBU3UylvOElJawjwFnCyLwDLP8+gYMvGutOTae0uW5/WRsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041662; c=relaxed/simple;
	bh=C+nr/6ayK8SNvoyh7eUg7ItNcdmETK3vpxAWoCKJ9ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Uule4Wq4G04qrkPd4W09uei9tjrLxmV8UyodvNGQCxz26YkxFFLorAfPqUrYoedx03vikkCBusU1DjKzerVDBT2Qa5hpzdsMBIBJHgmXBlbVlkhCQTp7ayTM2N2GEXvzCGsz/kWNNeHLY8RZKfAtiRSNxqX0wAvr/Pn7fge5yak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aqYhjWWd; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241108045410epoutp019562d5312c2a22caf7e03456b421a0dc~F5TXJ7_I00407104071epoutp01L
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 04:54:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241108045410epoutp019562d5312c2a22caf7e03456b421a0dc~F5TXJ7_I00407104071epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731041651;
	bh=0YdHcX375BxNFDRbutohoNOLYAj1P+TuRkOr75XwxCM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aqYhjWWdchLrxlIw1BMQtrUTskqeHwjIzAI0uIPG7kZq3Ol8v0LRrspfqXA83y0Ss
	 vxiEsl9YuQldthUnKMpRD1+2ScnPDtxLTQKzle/L6qYoAe6owRVQNtqrKB5SAZFVB4
	 16k9Dr27S2IvCflZUJuhIbpnX6U2gU/cgCl49qdU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241108045410epcas5p3aa167cfaf703485c64ae87281ac23ab3~F5TWjSNIR0196401964epcas5p3j;
	Fri,  8 Nov 2024 04:54:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Xl66T0XqGz4x9Q6; Fri,  8 Nov
	2024 04:54:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1C.8C.09420.0799D276; Fri,  8 Nov 2024 13:54:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241108045408epcas5p49b4bb6c718b361b15c05850c6f593822~F5TUys2cb1667216672epcas5p4X;
	Fri,  8 Nov 2024 04:54:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241108045408epsmtrp196c8ad62864a948ea6aacc42c4cc3049~F5TUxx8hy1656116561epsmtrp1I;
	Fri,  8 Nov 2024 04:54:08 +0000 (GMT)
X-AuditID: b6c32a49-33dfa700000024cc-f3-672d99702f2f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.BD.08227.0799D276; Fri,  8 Nov 2024 13:54:08 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241108045405epsmtip2cfd807cf00f63130534c9744bb162419~F5TSdlqyD0303203032epsmtip2I;
	Fri,  8 Nov 2024 04:54:05 +0000 (GMT)
Message-ID: <0c8b4491-605f-466c-86cd-1f17c70d6b7b@samsung.com>
Date: Fri, 8 Nov 2024 10:24:04 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_akakum@quicinc.com" <quic_akakum@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "rc93.raju@samsung.com"
	<rc93.raju@samsung.com>, "taehyun.cho@samsung.com"
	<taehyun.cho@samsung.com>, "hongpooh.kim@samsung.com"
	<hongpooh.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, alim.akhtar@samsung.com
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20241107233403.6li5oawn6d23e6gf@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmum7BTN10gw8XTS3eXF3FavFg3jY2
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPF4vKuOWwWi5a1Mlt8Ovqf1eL2n72sFqs65wAl
	vu9ktliw8RGjxaSDoharFhxgdxDw2D93DbvHxD11Hn1bVjF6bNn/mdHj8ya5ANaobJuM1MSU
	1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoIuVFMoSc0qBQgGJ
	xcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZTyZnFCxy
	rZgw4wlTA2OneRcjB4eEgInEzdb4LkZODiGB3YwS90+wdjFyAdmfGCV6v/2Gcr4xShxY9YUZ
	pAqkYc3kzUwQHXsZJeb9zoMoessoMbUFpIOTg1fATqL97SMWEJtFQEXizqHL7BBxQYmTM5+A
	xUUF5CXu35oBFhcWiJLYs/EA2AIRAR2JAyfOM4EMZRboZZNYufwaG0iCWUBc4taT+UwgZ7MJ
	GEo8O2EDEuYUsJaYfvAQC0SJvETz1tnMIL0SAic4JJ5eWM0OcbWLxKy2RVAfCEu8Or4FKi4l
	8bK/DcpOltgz6QuUnSFxaNUhqHp7idULzrCC7GUW0JRYv0sfYhefRO/vJ0yQUOSV6GgTgqhW
	lTjVeJkNwpaWuLfkGiuE7SFxZO8pdkhY7WeU+NV7lG0Co8IspGCZheTLWUjemYWweQEjyypG
	ydSC4tz01GLTAsO81HJ4bCfn525iBKdmLc8djHcffNA7xMjEwXiIUYKDWUmE1z9KO12INyWx
	siq1KD++qDQntfgQoykwfiYyS4km5wOzQ15JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp
	2ampBalFMH1MHJxSDUzshv3+P0NMzJymH6x9yTx7XeErmTxPfaZ47f31r4Oz+j7VaSa83Z3e
	arjs/3UBU/Z9XyUvXE3izrvMw1CmZs2XXcbjp3ZHZWbs9YeXNH4Gn95zYcs5Hbnzq04fqjcr
	eF94Ll/MMu3qns3p3+181sSdKPldNbO1MiDPtoAreuEmFqvZYkszNxkFsBspzHy7zeq0y2TF
	zR9iEqpPC9RH8+z8yF1uNFvSRLoia+pzPq/nD6cdOvqxa94tFQfVM35i/6pjuvcvmiA3I2My
	y6HOMnk19oQm45r9fgcON+14v+SlMBOnvGqIlaWtz/2+u0mTPj0z5X4+I+X4XnUJzzgmlbcS
	B8urwo+8v71/S+DKbCWW4oxEQy3mouJEAHKKDZpWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvG7BTN10gx8/BSzeXF3FavFg3jY2
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPF4vKuOWwWi5a1Mlt8Ovqf1eL2n72sFqs65wAl
	vu9ktliw8RGjxaSDoharFhxgdxDw2D93DbvHxD11Hn1bVjF6bNn/mdHj8ya5ANYoLpuU1JzM
	stQifbsErownkzMKFrlWTJjxhKmBsdO8i5GTQ0LARGLN5M1MXYxcHEICuxklpj5/xgKRkJZ4
	PauLEcIWllj57zk7RNFroKJpa1lBErwCdhLtbx+BNbAIqEjcOXSZHSIuKHFy5hOwuKiAvMT9
	WzPA4sICURJ7Nh5gBrFFBHQkDpw4D7aZWWAim8SVN+cZITbsZ5SYdaYJrINZQFzi1pP5QFUc
	HGwChhLPTtiAhDkFrCWmHzzEAlFiJtG1FeJSZqBlzVtnM09gFJqF5I5ZSCbNQtIyC0nLAkaW
	VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwdGopbWDcc+qD3qHGJk4GA8xSnAwK4nw
	+kdppwvxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXANH2p
	2otTD04fDbwgeSyuTXVVf5FwRe6eaRkxoga8jM+1lzM1cJ6TzowpNuab8J6nneNHffTe4LPn
	Mi9PiggTtXF9HSvxs8jZoGvqZE4fDpfDu0zOmh2fwiAm6XTPymSP+1SL1VYpM6QWZSg33eEK
	OvNoUpiZb6z0TAnWm3VbdLcfY9317piySK/Dahf/5DL7J8unnla/Gx34vVKO7+NBgXlXQgRC
	L6wIsva++Zzx+6tCz8VHU3l2bTHbJB3B/154y4P1kw48c5P6yqAcptE3LXqn7t5A4TsbbF7U
	Nx989D2nwI2V81/+KRVz82+PamP1LypFnO6eLVTwdndJvpx2IkfJ7Ro2+/Mzttjw9PYpsRRn
	JBpqMRcVJwIA+f2hCDUDAAA=
X-CMS-MailID: 20241108045408epcas5p49b4bb6c718b361b15c05850c6f593822
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6
References: <CGME20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6@epcas5p1.samsung.com>
	<20241107104040.502-1-selvarasu.g@samsung.com>
	<20241107233403.6li5oawn6d23e6gf@synopsys.com>


On 11/8/2024 5:04 AM, Thinh Nguyen wrote:
> On Thu, Nov 07, 2024, Selvarasu Ganesan wrote:
>> This commit adds support for resizing the TxFIFO in USB2.0-only mode
>> where using single port RAM, and limit the use of extra FIFOs for bulk
> This should be split into 2 changes: 1 for adding support for
> single-port RAM, and the other for budgeting the bulk fifo setting.
>
> The first change is not a fix, and the latter may be a fix (may need
> more feedback from others).
Hi Thinh,
Thanks for reviewing.
Sure i will do split into 2 changes.
>> transfers in non-SS mode. It prevents the issue of limited RAM size
>> usage.
>>
>> Fixes: fad16c823e66 ("usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs")
>> Cc: stable@vger.kernel.org # 6.12.x: fad16c82: usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>   drivers/usb/dwc3/core.h   |  4 +++
>>   drivers/usb/dwc3/gadget.c | 56 ++++++++++++++++++++++++++++++---------
>>   2 files changed, 48 insertions(+), 12 deletions(-)
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
>> index 2fed2aa01407..d3e25f7d7cd0 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -687,6 +687,42 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
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
>> +	bool spram_type;
>> +	int tmp;
>> +
>> +	/* Check supporting RAM type by HW */
>> +	spram_type = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);
>> +
>> +	/* If a single port RAM is utilized, then allocate TxFIFOs from
>> +	 * RAM0. otherwise, allocate them from RAM1.
>> +	 */
> Please use this comment block style
> /*
>   * xxxx
>   * xxxx
>   */
Sure, will update it in next version.
>> +	ram_depth = spram_type ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
>> +			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
> Don't use spram_type as a boolean. Perhaps define a macro for type value
> 1 and 0 (for single vs 2-port)
Are you expecting something like below?

#define DWC3_SINGLE_PORT_RAM     1
#define DWC3_TW0_PORT_RAM        0

// ...

int ram_depth;
int fifo_0_start;
int spram_type;
int tmp;

/*
* Check supporting RAM type by HW. If a single port RAM
* is utilized, then allocate TxFIFOs from RAM0. otherwise,
* allocate them from RAM1.
*/
spram_type = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);

/*
* In a single port RAM configuration, the available RAM is shared
* between the RX and TX FIFOs. This means that the txfifo can begin
* at a non-zero address.
*/

if (spram_type == DWC3_SINGLE_PORT_RAM) {

     ram_depth = DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6);

     /* Check if TXFIFOs start at non-zero addr */
     tmp = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
     fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(tmp);

ram_depth -= (fifo_0_start >> 16);
} else
     ram_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);

return ram_depth;
>> +
>> +
>> +	/* In a single port RAM configuration, the available RAM is shared
>> +	 * between the RX and TX FIFOs. This means that the txfifo can begin
>> +	 * at a non-zero address.
>> +	 */
>> +	if (spram_type) {
> if (spram_type == DWC3_SPRAM_TYPE_SINGLE) {
> 	...
> }
>
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
>> @@ -753,7 +789,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   {
>>   	struct dwc3 *dwc = dep->dwc;
>>   	int fifo_0_start;
>> -	int ram1_depth;
>> +	int ram_depth;
>>   	int fifo_size;
>>   	int min_depth;
>>   	int num_in_ep;
>> @@ -773,7 +809,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
>>   		return 0;
>>   
>> -	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>> +	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
>>   
>>   	switch (dwc->gadget->speed) {
>>   	case USB_SPEED_SUPER_PLUS:
>> @@ -792,10 +828,6 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   			break;
>>   		}
>>   		fallthrough;
>> -	case USB_SPEED_FULL:
>> -		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
>> -			num_fifos = 2;
>> -		break;
> Please take out the fallthrough above if you remove this condition.
will update it in next version.
>
>>   	default:
>>   		break;
>>   	}
>> @@ -809,7 +841,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   
>>   	/* Reserve at least one FIFO for the number of IN EPs */
>>   	min_depth = num_in_ep * (fifo + 1);
>> -	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
>> +	remaining = ram_depth - min_depth - dwc->last_fifo_depth;
>>   	remaining = max_t(int, 0, remaining);
>>   	/*
>>   	 * We've already reserved 1 FIFO per EP, so check what we can fit in
>> @@ -835,9 +867,9 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
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
>> @@ -3090,7 +3122,7 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
>>   	struct dwc3 *dwc = gadget_to_dwc(g);
>>   	struct usb_ep *ep;
>>   	int fifo_size = 0;
>> -	int ram1_depth;
>> +	int ram_depth;
>>   	int ep_num = 0;
>>   
>>   	if (!dwc->do_fifo_resize)
>> @@ -3113,8 +3145,8 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
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
> We may need to think a little more on how to budgeting the resource
> properly to accomodate for different requirements. If there's no single
> formula to satisfy for all platform, perhaps we may need to introduce
> parameters that users can set base on the needs of their application.
Agree. Need to introduce some parameters to control the required fifos 
by user that based their usecase.
Here's a rephrased version of your proposal:

To address the issue of determining the required number of FIFOs for 
different types of transfers, we propose introducing dynamic FIFO 
calculation for all type of EP transfers based on the maximum packet 
size, and remove hard code value for required fifos in driver,  
Additionally, we suggest introducing DT properties(tx-fifo-max-num-iso, 
tx-fifo-max-bulk and tx-fifo-max-intr) for all types of transfers 
(except control EP) to allow users to control the required FIFOs instead 
of relying solely on the tx-fifo-max-num. This approach will provide 
more flexibility and customization options for users based on their 
specific use cases.

Please let me know if you have any comments on the above approach.

Thanks,
Selva
>
> I'd like to Ack on the new change that checks single-port RAM. For the
> budgeting of fifo, let's keep the discussion going a little more.
>
> Thanks,
> Thinh





