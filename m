Return-Path: <stable+bounces-189980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D4C0DF52
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814633A68D1
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074C5259CBB;
	Mon, 27 Oct 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="Z7v6A9Au";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fw4Oari4"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E6258EFC
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570771; cv=none; b=TTbCoRWGeY5eLE58tGGV+IEfCLogsWydcQepfoewei2ZpLuiTkrPu3N5bmG2I5J4ppCt3A9h/sAueLHl5+18nvIgcJHDOJ9I0Fkh3AzRZp3PmoNjkl0oZmQkWBbws4vX1FyldlhO8soXfpBbo3Tc2tLURbG2Zwyx52eHRlB0lPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570771; c=relaxed/simple;
	bh=Bz6kmj+ur2LqoT7ZrXDtExMxZuptE4aMiCFfw0vOe4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JarWWybnre6tvvNqgdX9Db1e82GOxGSCFqwMYI+gv7UZjng7GCbn1cto6M5qjJo4SgljnC5dtv35iGNOylTXZ9MHWgervrkU1zO+GCQhkaywQwnhMA8uW8eJDF7QGqbaOjft0XkvaPMZfLe7adhP6xCRSSrN2m7kqHzZqrH9Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=Z7v6A9Au; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fw4Oari4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D8E7BEC033A;
	Mon, 27 Oct 2025 09:12:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 09:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761570767; x=1761657167; bh=tjn5qBaZqF
	RTCvYPUdaIg0qwQDChJ0z3F8r0zDZXl5I=; b=Z7v6A9Au8fQ9nBjG4A8LTcyxdi
	mR05Qk+M/40eamLbqcpF1B+IPqnsgsSnwR1a7jnlC864S/PO2EwgD3wKD7CHEGXN
	RbWleWIvF2DlzcuDh/DHNsvntbOESQFQh309XSNnjbaAeTfsL5NlynvronB0fRa7
	UmpfkFdj7Ax8g/3xKX6rnArIA4zsPSAjc+KQPge8mg1OTy4lSimHj0rz+/jd+WxM
	yFIEMQXHaCiLyjSjYlqTHm83S6ln1cnVzfahQg4bEFwCSgs1gE0oqr0/AVWOVjGr
	ugq+rYhWJoTBuKtde6ZkPq4vsYTC7Ly3hbboyqce3VZwR5lwwi6Jsk+cC6+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761570767; x=
	1761657167; bh=tjn5qBaZqFRTCvYPUdaIg0qwQDChJ0z3F8r0zDZXl5I=; b=f
	w4Oari4TqFAup5HpTxmiSvwQ5ANQy3MPTVrh2orrAoqbe5QMoHTEJz8952HAqtip
	26zzjeKZ7ozgnAIqvrQ7PHdV6hcW/tZ2AOfSqCEeypzup6XwD2tYPCU48MYZbkJm
	ryXGFTmAoNblRJhD7yuge9ntW6I5CbGeXWgRCucvUivXy/z5DVy68S67EuTTXTLI
	1Deaqs/RQOwIhE8Z/HZ3uIlXR56JWHb8mtbfekXyWXpQwUq6Mtx7gUrIY7VACOgv
	5eBp2TkFZvhV1X7+DFTloph3uZ+s6NMEyqGnTw+uxbTljb1a8r1s86wKGK090esg
	VKeVvuZtQsOaOdUUT/tEQ==
X-ME-Sender: <xms:z2__aHh3wYERnyIdsM9M7ME_KqLKzNeMPpcz1vIS1YTWIe4GtHsiXQ>
    <xme:z2__aK6Ugl6QKShzb0WxeRuI2loxI7PDK-ug3Mtf-hi1AecaTEuemgtufzxBvjayI
    UHg_xGeFkfBI_hFi6IKo_gnai0R1Lb3UiEnkq_GvuciITqRyL5Hj9CL>
X-ME-Received: <xmr:z2__aPY0qCaqzUZDu2Uq9R7eMJGi838NxZipmJ6wR6VJ5exwb2wvsqbpu51c52C9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheektdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:z2__aP66nEG0srXhC-Fn9cDA_FJLf0MOJSPLNsEbafATU2OPT0hfOw>
    <xmx:z2__aCCP-ZrLFZuk32RGFfGyf6f3V2FGnyy_gKzDWekGe17Pd3xung>
    <xmx:z2__aFcKVejIm7M-itTjNQDNjXNGG_bdg6nSeUOHx0_RqJnAvW8xiw>
    <xmx:z2__aBLZ7KMzwFQhoQ3P2EYs7A1XGAekyv4BS9RxOODA8BmzGVj9fw>
    <xmx:z2__aKVfbzIWsG9PWbWmrIzsBZ-bl-pSViolo1U7XB5mjyqKZTK8mEdW>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 09:12:45 -0400 (EDT)
Message-ID: <d92fd187-6fbe-4bce-b98c-31dad249cda7@coelacanthus.name>
Date: Mon, 27 Oct 2025 21:12:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] can: gs_usb: increase max interface to U8_MAX
Content-Language: en-GB-large
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <2025102041-mounting-pursuit-e9d3@gregkh>
 <20251020122237.1517578-2-uwu@coelacanthus.name>
 <2025102739-gout-copilot-7469@gregkh>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <2025102739-gout-copilot-7469@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-27 19:40, Greg KH wrote:
> On Mon, Oct 20, 2025 at 08:22:38PM +0800, Celeste Liu wrote:
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
>> index 1a24c1d9dd8f..509b0c83ebb8 100644
>> --- a/drivers/net/can/usb/gs_usb.c
>> +++ b/drivers/net/can/usb/gs_usb.c
>> @@ -156,10 +156,6 @@ struct gs_host_frame {
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
>> @@ -190,10 +186,11 @@ struct gs_can {
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
>> @@ -321,7 +318,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>>  	}
>>  
>>  	/* device reports out of range channel id */
>> -	if (hf->channel >= GS_MAX_INTF)
>> +	if (hf->channel >= usbcan->channel_cnt)
>>  		goto device_detach;
>>  
>>  	dev = usbcan->canch[hf->channel];
>> @@ -409,7 +406,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>>  	/* USB failure take down all interfaces */
>>  	if (rc == -ENODEV) {
>>   device_detach:
>> -		for (rc = 0; rc < GS_MAX_INTF; rc++) {
>> +		for (rc = 0; rc < usbcan->channel_cnt; rc++) {
>>  			if (usbcan->canch[rc])
>>  				netif_device_detach(usbcan->canch[rc]->netdev);
>>  		}
>> @@ -991,20 +988,22 @@ static int gs_usb_probe(struct usb_interface *intf,
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
>> @@ -1045,7 +1044,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
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
> Again, not going to try :)

Sorry, fixed version sent. In 5.4, lack -std flags issue is even worse, not only
in REALMODE_FLAGS, but also in drivers/firmware/efi/libstub/Makefile and arch/x86/boot/compressed/Makefile

