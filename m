Return-Path: <stable+bounces-189974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A7FC0DD8D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390EE3AE9A4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2624A05D;
	Mon, 27 Oct 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="znQrnqmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QzxOdoHa"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10C24A04A
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569903; cv=none; b=HyhQUUoUK3lGWp5+pHQ8FT8R5ai1CpDSiFWQwlBesrX7BKJdKYk/AfMoHLlDB4HUy/XuUTbFsX/FFPtGOb5XZfZTD5qsfVtcbQ5tvlkQ/1Ie4R/sIVvfv8n0yBc1r1jKMG7LuOBcO39i/LUAjXBrRAfueCBDGADnHkr9M1nCDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569903; c=relaxed/simple;
	bh=DEZx3vRkMZG9FQs/FbVZjQoDPOh+9mbD9Bvmuf/UeQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eazdqYemlByo8Jv9rf1CPVinvg52kIcyOhYO51YKsd3GGbUf2LL7Q8AbwrvQgjP6CLeZpySqkwYxOihmf0ah9ec8AbfTMw56b7bHOgtoUl/Brfl3+yopKKzs2yHZxdJZDzRrS1fDuoV7SM/cGiayYyeSkxtYiZoxVbp2dgbfo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=znQrnqmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QzxOdoHa; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAB0714000FC;
	Mon, 27 Oct 2025 08:58:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 27 Oct 2025 08:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761569900; x=1761656300; bh=0ITSfqSs8U
	e5Fc8+4JBcWOXON5TI3ogMHyq1DkpiVqM=; b=znQrnqmcbGaMh3fvlfjSM8abP3
	CIdsIvaNzF8tNk/1SWhrm4jqx7AL8x8vYxL4KDB1OpktCzwd2/t9/rTeLJhrE9wp
	VJRenpGhNQhhZLNEox47Mzhmuovn4YrP/11hZS2EZLL/yPv/JwkAjYZeM+knGJrB
	3+3/aNOJDVL+V/GtP0ehaGwiTFBOFuPdCskoymQrLmnABpF9b+vuwwnWa8cjnn0N
	dbqHI6gzlNfqFarx1gzl5HhVDQqFpv6KcrT4D42nMCcqRuc0kHwPKwbympxwzdLg
	ZRX4rHJwsyY67cPFzpUcXToNcaSjkk3GILRnQzE+D7ev9NgLcGkrp9u6OsWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761569900; x=
	1761656300; bh=0ITSfqSs8Ue5Fc8+4JBcWOXON5TI3ogMHyq1DkpiVqM=; b=Q
	zxOdoHaBkfKbrapQoybUcmSTfgoAypwlU+LZwI6lvdNgLjXYC4weQ6+XVu8/GINL
	xch+S500OEBHmVZeeYKLGQwiCdvR87INhT/QroSxWGI84dI8CmTwVyHBNHRPMS57
	iWZ+KSukCgVdfM4OAHf5nSjuaew9Jz0hfvsL7hHVEW4DBAsS5Z4RktQqJtL2yksc
	WSolS0BYmC7N1CDNWHFDN+ihh6xLrJxnMjQ1DpOLXs6pnJWmP+XGOG/uZwHDf+NM
	brMJ0c0V6MXhKOtpYg7Y8Jr17cZbOl8ye/bmPpZAsI1o524ZOkjoP6EXloJqBELL
	xWffp+osoOfmVtwxBo3fg==
X-ME-Sender: <xms:bGz_aG2AkqQcmh11LjvmEMqYDNsFg-eKz-RMO6NcyslXIYN7jf_MZg>
    <xme:bGz_aP-Ca7ci8t2tZNQ0qCsb1xpRdqPnBz-24C1aOv97c8-GeiC1dGXj4Y5fDfJTx
    IiQh2c82gDwqCLe21_qha_EFIIhA2G8LE1no31DhUzfa5USSh_Grgo>
X-ME-Received: <xmr:bGz_aHNznjj5-XCgl8-QjlQ0OOJ3xcEeccgWUhqJoJmzR-_NVoTZgD451HOuKbBp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeevvghlvghs
    thgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepfeevkeduhfdujeetueettdekuedvvddugeeuudeiueejjeeljeetteej
    ueduffeunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhsghhiugdrlhhinhhkne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhes
    tghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohephedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhrvghgsehkrhhorghhrdgtohhmpdhrtghpthht
    ohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhunh
    gthhgvnhhgrdhluheshhhpmhhitghrohdrtghomhdprhgtphhtthhopehmrghilhhhohhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmkhhlsehpvghnghhuthhrohhnihigrd
    guvg
X-ME-Proxy: <xmx:bGz_aDek1SSXmJ7Wfd4kiZG0ijVB9rA1W3kLh0HVzzHbyfk9gdUW8A>
    <xmx:bGz_aGUSSuqdm9_9UyMNRVDppK8KnRcHMdbTE74ku9JFnfGkpL93uw>
    <xmx:bGz_aLjsKN3_GMPa21OUAdmFzH__uJuERII0DLKiaU_mCH1Y-g9yfw>
    <xmx:bGz_aF9i8w7N8486yffqXtaPG6kQfUU7-g9fDavpI5rH2-5hLoN2jA>
    <xmx:bGz_aDN98_6pFjpZcdlBM1haTOBD7oAq0XCLwuzBDK8p3yIa3T93p_Im>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 08:58:18 -0400 (EDT)
Message-ID: <58f56c78-2e74-4d72-8748-5a82ec1beb6a@coelacanthus.name>
Date: Mon, 27 Oct 2025 20:58:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] can: gs_usb: increase max interface to U8_MAX
Content-Language: en-GB-large
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <2025102040-unusual-concur-90e9@gregkh>
 <20251020122342.1517889-2-uwu@coelacanthus.name>
 <2025102730-overcoat-carol-dbf9@gregkh>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <2025102730-overcoat-carol-dbf9@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-27 19:37, Greg KH wrote:
> On Mon, Oct 20, 2025 at 08:23:43PM +0800, Celeste Liu wrote:
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
>> index 864db200f45e..f39bd429f77d 100644
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
> I'm not even going to try to build this one :)

Sorry. Fixed version has been sent. In 5.10.y, REALMODE_CFLAGS on x86 also lacks -std
flag, so it will build failed on GCC 15 because it use c23 by default and the code try
to typedef bool/true/false. Since both 5.10 and 5.15 have this issue, I think 5.4 will
have issue as well.

