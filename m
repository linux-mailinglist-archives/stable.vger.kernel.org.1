Return-Path: <stable+bounces-189976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8784C0DD84
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3146719A7178
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02799285CB2;
	Mon, 27 Oct 2025 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="bP5Airt0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sprHwgKg"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16494DF6C
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570027; cv=none; b=ewUbBwvPJx7QRWezAtlAE+LVwT/z9Y1DOXBuoWosQ2H3KPPVWZl5udirVkjikpZBaHlmCrljnluwPnEaOdb5wQX3wOpe5byA3g5BooVZ7zkk8SkzzN2QLJUKca9BEOvlfDiXSagm3WIZVISjTpgbfRVgycZUDRSFecVpFkoqk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570027; c=relaxed/simple;
	bh=WRcilRftJVdHCIoBiSVP+iHS3wOM6SbMr0GiS2HgLYU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BGJFA4MYLYyHWnFtjGdGulJTzaBjpc8AKX+H0Y7F6Qrb0xYvm7ucozGwQMCJuTBI06c5f8Bcg+IdYYxGjDyXXE2GKE3YeB7gJzfTTwByaX9qud0DD9M6RabLcMqr/mjOMU6XPuioeP6h7tw97W+ayzwzmoOIpsFqkU7y9OtL6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=bP5Airt0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sprHwgKg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 33B0CEC028E;
	Mon, 27 Oct 2025 09:00:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 27 Oct 2025 09:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761570025; x=1761656425; bh=N9VfkjvUCY
	5OuqVTdQ4uCw26shd67lDM49Udtcb7CjY=; b=bP5Airt0zZhWyQtRubb6391S0R
	l850Ax1QEJzExSCIbtTEGWR5TcuW/FIiChpdq8BY6WQnsKj2ICQwdI6EbH7RXt2O
	Q7usd9AIJ1tRZXrfvYGW6/orkrXdlQQgmSdOajtFwuPyefZKxD6R9D/moyWDwMQE
	fDoYC9ZJYIkC8B4sH8YgESY3bo8p+7qYZkQqkWd+nK6+EkNHF8EPMnPX8k5iEyYX
	Tf5pSTdjx/dLX09mTVhGju0ilzrvujcjtphu06Qngh9Q83aJPqdSPU3JcuPEQz0X
	zrb7I6L4ay63P6xh6xDL5FuJmyJ2AIkwYkKC4S8jBdjk5ZyrZ+pXARCdsUqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761570025; x=
	1761656425; bh=N9VfkjvUCY5OuqVTdQ4uCw26shd67lDM49Udtcb7CjY=; b=s
	prHwgKgEWuA7HO0S0xoxJBn45PxMFbpjQPbKlPIWHesro/oI+YmG1NFR++k5NsWW
	N3lA5CDxS2pfi8PmeNK/9+/YmDFQ0KbSCScncGDbXrJIYq0KljD+WnMaLuSARUos
	zQ1N0Jg894OjpgdOba6L40oMlPPDdS4IFKFxQYgN1kougiSiXdgdRZUKgo9cTwtB
	Z8/TXZrj6wgyuKJs0M6XJUG3NFdoOB1dw0rCpRMIVStkEsl2cBN9Vu2QpxmPstWb
	3QjFxFaXPMJQZKp8WJ7VCRmVAWLbvO6qylr2372atzmlg48sjIHaHVPLyPzdSTQK
	QRhwOHJAtFjpBEbF4e5oA==
X-ME-Sender: <xms:6Gz_aIYp23_Oz7zgZ8osSU_6dmoA658Bf-AhOB8yEREYMCPLOKZxsQ>
    <xme:6Gz_aKT4U-4IOzWcictjEu1G7gTrUNAdA9Y-KeZ9VRC8i6m_wbUKueyU_WPJcNA9f
    tG8TZZ0A9pnXHB54YaF4H6CapmYNE6AfegzfSZ6ueFxlBZ6UiSxLk0>
X-ME-Received: <xmr:6Gz_aLTIZv2v84tfB9iQhokDVkqZHoqDDqcHJ-pxIzbwSjY40Y0mojSTxWD9jXpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeevvghlvghs
    thgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepkeffhfehffejuefhffekueelgfevlefgfeeiieejgeehvdefueeuvedv
    jeffkeejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhsghhiugdrlhhinhhkne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhes
    tghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohephedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhrvghgsehkrhhorghhrdgtohhmpdhrtghpthht
    ohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhunh
    gthhgvnhhgrdhluheshhhpmhhitghrohdrtghomhdprhgtphhtthhopehmrghilhhhohhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmkhhlsehpvghnghhuthhrohhnihigrd
    guvg
X-ME-Proxy: <xmx:6Gz_aORWpuCEh7d22RCCdW9p5N4bQXGlhPn1jcHQFu_qFGeahv3oqQ>
    <xmx:6Gz_aA6UKSC94csKZ0IQtrPTwxLGkmg-wzP3ZIu2IuIb7sgjbLf1Jg>
    <xmx:6Gz_aK33nLFyaojNw2HBkenhjsZGpzWAEffKdL_N_6iiWI_98kFL4w>
    <xmx:6Gz_aLAqEFZIqadAP2kqCkkXU-0Fgp37S4MZcfyxnMCCDsS0Ti9erQ>
    <xmx:6Wz_aGjssbqKVAv5MmA4Ya1wOY0T2Ly3pLricWv0sUMBqd8dAaJ69gLe>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 09:00:22 -0400 (EDT)
Message-ID: <703cefc2-0838-4018-a1ad-26c036b440c2@coelacanthus.name>
Date: Mon, 27 Oct 2025 21:00:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] can: gs_usb: increase max interface to U8_MAX
Content-Language: en-GB-large
From: Celeste Liu <uwu@coelacanthus.name>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <2025102040-unusual-concur-90e9@gregkh>
 <20251020122342.1517889-2-uwu@coelacanthus.name>
 <2025102730-overcoat-carol-dbf9@gregkh>
 <58f56c78-2e74-4d72-8748-5a82ec1beb6a@coelacanthus.name>
In-Reply-To: <58f56c78-2e74-4d72-8748-5a82ec1beb6a@coelacanthus.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-27 20:58, Celeste Liu wrote:
> On 2025-10-27 19:37, Greg KH wrote:
>> On Mon, Oct 20, 2025 at 08:23:43PM +0800, Celeste Liu wrote:
>>> commit 2a27f6a8fb5722223d526843040f747e9b0e8060 upstream
>>>
>>> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
>>> converter[1]. The original developers may have only 3 interfaces
>>> device to test so they write 3 here and wait for future change.
>>>
>>> During the HSCanT development, we actually used 4 interfaces, so the
>>> limitation of 3 is not enough now. But just increase one is not
>>> future-proofed. Since the channel index type in gs_host_frame is u8,
>>> just make canch[] become a flexible array with a u8 index, so it
>>> naturally constraint by U8_MAX and avoid statically allocate 256
>>> pointer for every gs_usb device.
>>>
>>> [1]: https://github.com/cherry-embedded/HSCanT-hardware
>>>
>>> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
>>> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
>>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>>> Link: https://patch.msgid.link/20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>  drivers/net/can/usb/gs_usb.c | 23 +++++++++++------------
>>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
>>> index 864db200f45e..f39bd429f77d 100644
>>> --- a/drivers/net/can/usb/gs_usb.c
>>> +++ b/drivers/net/can/usb/gs_usb.c
>>> @@ -156,10 +156,6 @@ struct gs_host_frame {
>>>  #define GS_MAX_TX_URBS 10
>>>  /* Only launch a max of GS_MAX_RX_URBS usb requests at a time. */
>>>  #define GS_MAX_RX_URBS 30
>>> -/* Maximum number of interfaces the driver supports per device.
>>> - * Current hardware only supports 2 interfaces. The future may vary.
>>> - */
>>> -#define GS_MAX_INTF 2
>>>  
>>>  struct gs_tx_context {
>>>  	struct gs_can *dev;
>>> @@ -190,10 +186,11 @@ struct gs_can {
>>>  
>>>  /* usb interface struct */
>>>  struct gs_usb {
>>> -	struct gs_can *canch[GS_MAX_INTF];
>>>  	struct usb_anchor rx_submitted;
>>>  	struct usb_device *udev;
>>>  	u8 active_channels;
>>> +	u8 channel_cnt;
>>> +	struct gs_can *canch[] __counted_by(channel_cnt);
>>>  };
>>>  
>>>  /* 'allocate' a tx context.
>>> @@ -321,7 +318,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>>>  	}
>>>  
>>>  	/* device reports out of range channel id */
>>> -	if (hf->channel >= GS_MAX_INTF)
>>> +	if (hf->channel >= usbcan->channel_cnt)
>>>  		goto device_detach;
>>>  
>>>  	dev = usbcan->canch[hf->channel];
>>> @@ -409,7 +406,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>>>  	/* USB failure take down all interfaces */
>>>  	if (rc == -ENODEV) {
>>>   device_detach:
>>> -		for (rc = 0; rc < GS_MAX_INTF; rc++) {
>>> +		for (rc = 0; rc < usbcan->channel_cnt; rc++) {
>>>  			if (usbcan->canch[rc])
>>>  				netif_device_detach(usbcan->canch[rc]->netdev);
>>>  		}
>>> @@ -991,20 +988,22 @@ static int gs_usb_probe(struct usb_interface *intf,
>>>  	icount = dconf->icount + 1;
>>>  	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
>>>  
>>> -	if (icount > GS_MAX_INTF) {
>>> +	if (icount > type_max(typeof(dev->channel_cnt))) {
>>>  		dev_err(&intf->dev,
>>> -			"Driver cannot handle more that %d CAN interfaces\n",
>>> -			GS_MAX_INTF);
>>> +			"Driver cannot handle more that %u CAN interfaces\n",
>>> +			type_max(typeof(dev->channel_cnt)));
>>>  		kfree(dconf);
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>> +	dev = kzalloc(struct_size(dev, canch, icount), GFP_KERNEL);
>>>  	if (!dev) {
>>>  		kfree(dconf);
>>>  		return -ENOMEM;
>>>  	}
>>>  
>>> +	dev->channel_cnt = icount;
>>> +
>>>  	init_usb_anchor(&dev->rx_submitted);
>>>  
>>>  	usb_set_intfdata(intf, dev);
>>> @@ -1045,7 +1044,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
>>>  		return;
>>>  	}
>>>  
>>> -	for (i = 0; i < GS_MAX_INTF; i++)
>>> +	for (i = 0; i < dev->channel_cnt; i++)
>>>  		if (dev->canch[i])
>>>  			gs_destroy_candev(dev->canch[i]);
>>>  
>>> -- 
>>> 2.51.1.dirty
>>>
>>>
>>
>> I'm not even going to try to build this one :)
> 
> Sorry. Fixed version has been sent. In 5.10.y, REALMODE_CFLAGS on x86 also lacks -std
> flag, so it will build failed on GCC 15 because it use c23 by default and the code try
> to typedef bool/true/false. Since both 5.10 and 5.15 have this issue, I think 5.4 will
> have issue as well.

Very sorry, I forget to amend before send.... Please use later one.

