Return-Path: <stable+bounces-189970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E6FC0DBC9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AC354F659B
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845323535E;
	Mon, 27 Oct 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="hvPBA7ig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1hDFqyv3"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ADE22FE0D
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569399; cv=none; b=VDcvplnNmf8+uyHwRdz/zUR88IPtAazbll3lymUxMxCgQ6aV6XrMOVkoC0IBE5+l07xqgv6uiGkD302kq9r/VfAViEt77SgtllIn1xp60PJ8F8v9L379RnQnygF4ha4ItBN75jAHE9qbDW6n/wjM4xDXmArIZFVbIoZ001ck05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569399; c=relaxed/simple;
	bh=VMRze8sNaO41riE5S2YGqos+SwhH85pXCo57ANWy7eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzzJZZv8ngCHnHg3oBQ895PD89tnDJcqsy6FT6vMnRIx+MS0M57HFo/OjaSZ4k5GI8vZGqXlnrxB7ItfwoOpcw2XdvxOkhIQozHMht3jo4vxph/7rLt6hm1C/FKk+SyNrHCWVjNfWC8+smur0AH67qHBiylDhy38fXRhBcd5TZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=hvPBA7ig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1hDFqyv3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D37EF1400300;
	Mon, 27 Oct 2025 08:49:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 08:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761569396; x=1761655796; bh=I9g1zZYthN
	4iw+GZLZ9TQs9zBhAx9YSgeAfE7yvHKp8=; b=hvPBA7igfVdqplL67r1q4Yk/qM
	73uKOz+LPQUzojsoD+JnuostG4igN119fpZCYdlqBHRpkdKPFtynpPcErQQtTrZD
	nSkdz30o7F2WLSSzJmIzh5b/r6T8eB51NRUOeNvgdjKk56pNP1G4H4kl8Ypj3LHH
	lpYy7oXlsPgbf1itndjnW8FkdSoRGzV1kSxoPWVfyqqYqA6UXaKFE47Y0XPaxTfq
	rNOyiHwKE7LDfEl+UOZxAveGMMvl4EubtJY1G44XPha3zPKOpQvQth9QK/nGfhv+
	tnKlfKOwYme+KB6h8g1KehWfIc3VSd1UpQU7nKwyDeE1eZeJ3KCeYdeuEwKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761569396; x=
	1761655796; bh=I9g1zZYthN4iw+GZLZ9TQs9zBhAx9YSgeAfE7yvHKp8=; b=1
	hDFqyv3Sdx4P1qHa+X50QBeBHm3yMhqozS2WtoR3sRyF6OdmyCbIc+Oh79LQ/d+b
	It3tcUvYuoIVV2mm8LPCQPKgPNDIS5E5/oglPu+evPkuvM1T6zkwnZp/G6ZN35Xs
	9phmrPwpp/PAdCv+K20Ep1GJVAHs/gmzwEx+lmTb/VNxJAFx+PTM+PlY68PIFB0G
	Q6yK+7OxGjwrm0YYa1kuORP1eDlKBa4mIbtZc23d+JJOyafj8aQPdQ53XITQ8nuz
	ySL9dwrisSOTdR1AfXCJoiOFpAo+PS9RlHq55wgxn/r+t29mHHfgHDSArSUdrE/W
	36hBNelE/9gCGlsyv5nJg==
X-ME-Sender: <xms:dGr_aJ1mxi3gddfUobFqxtxkX9sss3dc_BBG8_cMpzlcDU8VxKpJog>
    <xme:dGr_aG-lk5dzdFy_WcxFHEAmZKKU30WtT_HsUOQbuLsxExANnEOKOcS_xPTjmSDXN
    WhjABFqzY1e-QgnU-51I76K21OlpJoZD6v9jOqYV8mtAF5W5-Cy0Eo>
X-ME-Received: <xmr:dGr_aCO95Zd_-_xwXJ49xGSCZJ9AwgO6Q8n6JQiOCahjvg0Cs04SUIl4E1Tk_RyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheektdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeevvghlvghs
    thgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepfeevkeduhfdujeetueettdekuedvvddugeeuudeiueejjeeljeetteej
    ueduffeunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhsghhiugdrlhhinhhkne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhes
    tghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohephedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhhunhgthhgvnhhgrdhluheshhhpmhhitghrohdrtghomhdprhgt
    phhtthhopehmrghilhhhohhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmkhhlse
    hpvghnghhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:dGr_aCckpFBvlAtsSJTFrqkQhpRInGwgQB0VqZArBMVFCnpwfPRC0Q>
    <xmx:dGr_aJUraCkoHtkwDdcouz7e5ZDXSRZu2RvYb459DEQrULZ54FPXFg>
    <xmx:dGr_aCjG2p92U5gsR3gEMKFsixEP9tH7WbuUfmAMLlZfzOZYEVRhjQ>
    <xmx:dGr_aA-XR1EtHyja7V0KuIeYF60E2_da-ydFVrns1N2CadLvlO6l5A>
    <xmx:dGr_aNablDjw8zZ_EuuO9vps6VSi8whHFZPN34BpbOkF2Y005o6lc7ah>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 08:49:54 -0400 (EDT)
Message-ID: <cd1c9cfc-4dab-4b06-9d0e-6f0c76a21ea7@coelacanthus.name>
Date: Mon, 27 Oct 2025 20:49:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] can: gs_usb: increase max interface to U8_MAX
Content-Language: en-GB-large
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <2025102039-detoxify-trustee-aa22@gregkh>
 <20251020122529.1518396-2-uwu@coelacanthus.name>
 <2025102727-wing-symphony-713d@gregkh>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <2025102727-wing-symphony-713d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-27 19:36, Greg KH wrote:
> On Mon, Oct 20, 2025 at 08:25:30PM +0800, Celeste Liu wrote:
>> commit 2a27f6a8fb5722223d526843040f747e9b0e8060 upstream
>>
>> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
>> converter[1]. The original developers may have only 3 interfaces
>> device to test so they write 3 here and wait for future change.
>>
>> During the HSCanT development, we actually used 4 interfaces, so the
>> limitation of 3 is not enough now. But just increase one is not
>> future-proofed. Since the channel index type in gs_host_frame is u8,
>> just make canch[] become a flexible array with a u8 index, so it
>> naturally constraint by U8_MAX and avoid statically allocate 256
>> pointer for every gs_usb device.
>>
>> [1]: https://github.com/cherry-embedded/HSCanT-hardware
>>
>> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
>> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>> Link: https://patch.msgid.link/20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/net/can/usb/gs_usb.c | 23 +++++++++++------------
>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
>> index 7dc4fb574e45..33800bb75064 100644
>> --- a/drivers/net/can/usb/gs_usb.c
>> +++ b/drivers/net/can/usb/gs_usb.c
>> @@ -157,10 +157,6 @@ struct gs_host_frame {
>>  #define GS_MAX_TX_URBS 10
>>  /* Only launch a max of GS_MAX_RX_URBS usb requests at a time. */
>>  #define GS_MAX_RX_URBS 30
>> -/* Maximum number of interfaces the driver supports per device.
>> - * Current hardware only supports 2 interfaces. The future may vary.
>> - */
>> -#define GS_MAX_INTF 2
>>  
>>  struct gs_tx_context {
>>  	struct gs_can *dev;
>> @@ -191,10 +187,11 @@ struct gs_can {
>>  
>>  /* usb interface struct */
>>  struct gs_usb {
>> -	struct gs_can *canch[GS_MAX_INTF];
>>  	struct usb_anchor rx_submitted;
>>  	struct usb_device *udev;
>>  	u8 active_channels;
>> +	u8 channel_cnt;
>> +	struct gs_can *canch[] __counted_by(channel_cnt);
>>  };
>>  
>>  /* 'allocate' a tx context.
>> @@ -322,7 +319,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>>  	}
>>  
>>  	/* device reports out of range channel id */
>> -	if (hf->channel >= GS_MAX_INTF)
>> +	if (hf->channel >= usbcan->channel_cnt)
>>  		goto device_detach;
>>  
>>  	dev = usbcan->canch[hf->channel];
>> @@ -410,7 +407,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>>  	/* USB failure take down all interfaces */
>>  	if (rc == -ENODEV) {
>>   device_detach:
>> -		for (rc = 0; rc < GS_MAX_INTF; rc++) {
>> +		for (rc = 0; rc < usbcan->channel_cnt; rc++) {
>>  			if (usbcan->canch[rc])
>>  				netif_device_detach(usbcan->canch[rc]->netdev);
>>  		}
>> @@ -993,20 +990,22 @@ static int gs_usb_probe(struct usb_interface *intf,
>>  	icount = dconf->icount + 1;
>>  	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
>>  
>> -	if (icount > GS_MAX_INTF) {
>> +	if (icount > type_max(typeof(dev->channel_cnt))) {
>>  		dev_err(&intf->dev,
>> -			"Driver cannot handle more that %d CAN interfaces\n",
>> -			GS_MAX_INTF);
>> +			"Driver cannot handle more that %u CAN interfaces\n",
>> +			type_max(typeof(dev->channel_cnt)));
>>  		kfree(dconf);
>>  		return -EINVAL;
>>  	}
>>  
>> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> +	dev = kzalloc(struct_size(dev, canch, icount), GFP_KERNEL);
>>  	if (!dev) {
>>  		kfree(dconf);
>>  		return -ENOMEM;
>>  	}
>>  
>> +	dev->channel_cnt = icount;
>> +
>>  	init_usb_anchor(&dev->rx_submitted);
>>  
>>  	usb_set_intfdata(intf, dev);
>> @@ -1047,7 +1046,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
>>  		return;
>>  	}
>>  
>> -	for (i = 0; i < GS_MAX_INTF; i++)
>> +	for (i = 0; i < dev->channel_cnt; i++)
>>  		if (dev->canch[i])
>>  			gs_destroy_candev(dev->canch[i]);
>>  
>> -- 
>> 2.51.1.dirty
>>
>>
> 
> Breaks the build :(

Sorry, I have sent fixed version. And REALMODE_CFLAGS on x86 on linux-5.15.y
lacks -std flag, so it will build failed on GCC 15 because it use c23 by default
and the code try to typedef bool/true/false.

