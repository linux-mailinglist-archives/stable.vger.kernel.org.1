Return-Path: <stable+bounces-166753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD4FB1D0BE
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 03:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA240188C756
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042411C3BFC;
	Thu,  7 Aug 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WfaoMtyR"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CD1A2389
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531606; cv=none; b=MZSSvc5K6JKJidNLrCNhjyC1WZqRK9hW6c7FNZlS5NTTHGMdzGVJVTcFgM5Bh4PDykRpYQbNW9oV5c1OfTTH19oA2PvmkJO8krSul2qRsKNNjDQSI5CyxkjiHQ375qYleEnkRP880lFwsY/OvCkWLaHl3Fk09BAsLQwd+l9Wzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531606; c=relaxed/simple;
	bh=Y9oSM9/w1NfZrP1j30ItyWLKlJpMBNsclInALq9iQeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=e8osKIUBsKq+h5LYKpC93LlXv5V0k/T5eE/UVtXEZIsjqKE75pRZBgHI7wdJ4ax/JgiKZRmbs7YBLBB+GfPVUZrpVOP59hAziuhmO1QtZGUaYUnM5yIAppJ4fkHniPbI5qGUA6W+k40Tq8tE8eZ4rPOlen2pUXV8UMAnRNLLvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WfaoMtyR; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250807015323epoutp03f27cc0da4290d81c1af136384f843312~ZWTJyQs873083230832epoutp03L
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 01:53:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250807015323epoutp03f27cc0da4290d81c1af136384f843312~ZWTJyQs873083230832epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754531603;
	bh=DGZ/El3JOSWXEpxSygYUARXe3bm1cG1lUFQojuw/LbI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WfaoMtyROS0ZpjvrFHBRglt8/yt3VrBfvAea8BBlydE861jrggr7b3DUr13EBGW+l
	 2Sbw87ue77R5T5dh+QCaioRnnR/XIGDrsgGggdTyqfDGE/n55JCC74IRe3dhwM9DaT
	 C19Aquak/cnObwyfiCgL0xhPyc0PwqY3uJNaBf2g=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250807015322epcas5p42de63a1834a128fc0fcb5008dcbf1a56~ZWTJaCVhT0035700357epcas5p4s;
	Thu,  7 Aug 2025 01:53:22 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4by9DK64kfz2SSKX; Thu,  7 Aug
	2025 01:53:21 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250807015321epcas5p32599056a49a47c2e20acb82f51102b81~ZWTILEu7y2538125381epcas5p3D;
	Thu,  7 Aug 2025 01:53:21 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250807015318epsmtip12e93a87b574a61829d7e74d9f2f25ee5~ZWTF2MIkw0137501375epsmtip1e;
	Thu,  7 Aug 2025 01:53:18 +0000 (GMT)
Message-ID: <81b12279-e84d-4f81-b41c-0857c6a7975c@samsung.com>
Date: Thu, 7 Aug 2025 07:23:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>, "balbi@ti.com"
	<balbi@ti.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "akash.m5@samsung.com" <akash.m5@samsung.com>,
	"hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>, "shijie.cai@samsung.com"
	<shijie.cai@samsung.com>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "muhammed.ali@samsung.com"
	<muhammed.ali@samsung.com>, "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20250807005638.thhsgjn73aaov2af@synopsys.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250807015321epcas5p32599056a49a47c2e20acb82f51102b81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e
References: <CGME20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e@epcas5p3.samsung.com>
	<20250804142258.1577-1-selvarasu.g@samsung.com>
	<20250805233832.5jgtryppvw2xbthq@synopsys.com>
	<99fa41ed-dee0-499f-8827-67e1e1c70e60@samsung.com>
	<20250807005638.thhsgjn73aaov2af@synopsys.com>


On 8/7/2025 6:26 AM, Thinh Nguyen wrote:
> On Wed, Aug 06, 2025, Selvarasu Ganesan wrote:
>> On 8/6/2025 5:08 AM, Thinh Nguyen wrote:
>>> On Mon, Aug 04, 2025, Selvarasu Ganesan wrote:
>>>> From: Akash M <akash.m5@samsung.com>
>>>>
>>>> This commit addresses a rarely observed endpoint command timeout
>>>> which causes kernel panic due to warn when 'panic_on_warn' is enabled
>>>> and unnecessary call trace prints when 'panic_on_warn' is disabled.
>>>> It is seen during fast software-controlled connect/disconnect testcases.
>>>> The following is one such endpoint command timeout that we observed:
>>>>
>>>> 1. Connect
>>>>      =======
>>>> ->dwc3_thread_interrupt
>>>>    ->dwc3_ep0_interrupt
>>>>     ->configfs_composite_setup
>>>>      ->composite_setup
>>>>       ->usb_ep_queue
>>>>        ->dwc3_gadget_ep0_queue
>>>>         ->__dwc3_gadget_ep0_queue
>>>>          ->__dwc3_ep0_do_control_data
>>>>           ->dwc3_send_gadget_ep_cmd
>>>>
>>>> 2. Disconnect
>>>>      ==========
>>>> ->dwc3_thread_interrupt
>>>>    ->dwc3_gadget_disconnect_interrupt
>>>>     ->dwc3_ep0_reset_state
>>>>      ->dwc3_ep0_end_control_data
>>>>       ->dwc3_send_gadget_ep_cmd
>>>>
>>>> In the issue scenario, in Exynos platforms, we observed that control
>>>> transfers for the previous connect have not yet been completed and end
>>>> transfer command sent as a part of the disconnect sequence and
>>>> processing of USB_ENDPOINT_HALT feature request from the host timeout.
>>>> This maybe an expected scenario since the controller is processing EP
>>>> commands sent as a part of the previous connect. It maybe better to
>>>> remove WARN_ON in all places where device endpoint commands are sent to
>>>> avoid unnecessary kernel panic due to warn.
>>>>
>>>> Fixes: e192cc7b5239 ("usb: dwc3: gadget: move cmd_endtransfer to extra function")
>>>> Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
>>>> Fixes: c7fcdeb2627c ("usb: dwc3: ep0: simplify EP0 state machine")
>>>> Fixes: f0f2b2a2db85 ("usb: dwc3: ep0: push ep0state into xfernotready processing")
>>>> Fixes: 2e3db064855a ("usb: dwc3: ep0: drop XferNotReady(DATA) support")
>>>> Cc: stable@vger.kernel.org
>>> I don't think this is a fix patch. You're just replacing WARN* with
>>> dev_warn* without doing any recovery. Let's remove the Fixes and table
>>> tag. Also, can we replace dev_warn* with dev_err* because these are
>>> critical errors that may put the controller in a bad state.
>>>
>>> Thanks,
>>> Thinh
>>
>> Hi Thinh,
>>
>> Thanks for your review comments.
>> Yeah we agree. This is not a fix patch. Sure we will update new patchset
>> with replace dev_warn* with dev_err*.
>>
>> As for dropping the stable tag,  It would be better these changes to be
>> applied across all stable kernels, so shall we keep stable tag in place?
>>
> That's fine with me.

Hi Thinh,
Thanks for the confirmation.

Please review the updated patchset v2:
https://lore.kernel.org/all/20250807014639.1596-1-selvarasu.g@samsung.com/
Thanks,
Selva
>
> BR,
> Thinh

