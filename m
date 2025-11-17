Return-Path: <stable+bounces-195018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ECCC6602E
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 20:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7CBE22980E
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06483161A5;
	Mon, 17 Nov 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="J2OCl/J8";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="J2OCl/J8"
X-Original-To: stable@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA5276046;
	Mon, 17 Nov 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408688; cv=none; b=m57/pNA1D+VuVnnjqWqAIaG5EsfX8eSQmpeO3ZGEdtnQj+7dHclEnxoBpF39YCC8sHZMdWhxBBNgiOAdfb6ZKSHgiKHgEAg1X2mFgs+BfnapGjhHq7azCvCeKpVuXwMzTBzyN8XykDbvUBvOnI/hpc0cNTvoNj73XJwvSPPWk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408688; c=relaxed/simple;
	bh=maDYVAw3NdZd7Yq2YnAUo3PJYzmMdCYL5n3QL0+uiEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZouMSKEu26ParsGrA2ZDfi2TAMV5CZT7BEZumGnUhK6UwQ9Lq5r/43DQTMZCbO009BycXIaUgL/G/YNCIlEWg3DfoBss73mN8NMOS7N6BygVtwCf9jiEyC3rbdFs8SprE60IQcQ9mcCBXtcvgt4TFgrSCam1H5+Wr/exYr2XbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=J2OCl/J8; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=J2OCl/J8; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1763408685; bh=maDYVAw3NdZd7Yq2YnAUo3PJYzmMdCYL5n3QL0+uiEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J2OCl/J8Nc8TotGlvXWe9ddEhv8yMq421/w/QqAfDRBHl1FNoHSVnix0EWybUPnVM
	 UeFRH6p4v9HztYjWIIBc1AcvO2+/LVsVGogZlvqARwSEblYKHBxs5X/GHPsgv7yEiy
	 MrvhPS3wsfjGog2XTkfBfHKS7M8LBOMiW6RlSZjpoq+avpUXOVWGKaOwmGjz4EBhMA
	 Fg7u9jxR54WEsbeAJhIruOIdSnp72y2hWar9LSGbgaOMUx0y/fcHxaT8A6kCnKohRi
	 maAL6ZDA4TFkUGtgBSca2faNCfQzztLoTqULevWS9dnKNkzZMnkaD+8lQdIMEGh7eL
	 z6Gzq7RxRzTcw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 4EC1F3E1D1D;
	Mon, 17 Nov 2025 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1763408685; bh=maDYVAw3NdZd7Yq2YnAUo3PJYzmMdCYL5n3QL0+uiEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J2OCl/J8Nc8TotGlvXWe9ddEhv8yMq421/w/QqAfDRBHl1FNoHSVnix0EWybUPnVM
	 UeFRH6p4v9HztYjWIIBc1AcvO2+/LVsVGogZlvqARwSEblYKHBxs5X/GHPsgv7yEiy
	 MrvhPS3wsfjGog2XTkfBfHKS7M8LBOMiW6RlSZjpoq+avpUXOVWGKaOwmGjz4EBhMA
	 Fg7u9jxR54WEsbeAJhIruOIdSnp72y2hWar9LSGbgaOMUx0y/fcHxaT8A6kCnKohRi
	 maAL6ZDA4TFkUGtgBSca2faNCfQzztLoTqULevWS9dnKNkzZMnkaD+8lQdIMEGh7eL
	 z6Gzq7RxRzTcw==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id A43FE3E1D02;
	Mon, 17 Nov 2025 19:44:44 +0000 (UTC)
Message-ID: <1ebfc59e-dad5-40bf-8bdb-869fb5b06a1f@mleia.com>
Date: Mon, 17 Nov 2025 21:44:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp
 driver
To: Alan Stern <stern@rowland.harvard.edu>, Arnd Bergmann <arnd@arndb.de>
Cc: Ma Ke <make24@iscas.ac.cn>, piotr.wojtaszczyk@timesys.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stigge@antcom.de,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
References: <20251117013428.21840-1-make24@iscas.ac.cn>
 <4fe5b63e-072c-419c-a1b9-bc21aec7e083@app.fastmail.com>
 <9834be77-29e0-4a65-93f6-b61bf724f922@rowland.harvard.edu>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <9834be77-29e0-4a65-93f6-b61bf724f922@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251117_194445_344946_6003C871 
X-CRM114-Status: GOOD (  27.93  )

On 11/17/25 16:56, Alan Stern wrote:
> On Mon, Nov 17, 2025 at 09:53:21AM +0100, Arnd Bergmann wrote:
>> On Mon, Nov 17, 2025, at 02:34, Ma Ke wrote:
>>> When obtaining the ISP1301 I2C client through the device tree, the
>>> driver does not release the device reference in the probe failure path
>>> or in the remove function. This could cause a reference count leak,
>>> which may prevent the device from being properly unbound or freed,
>>> leading to resource leakage.
>>>
>>> Fix this by storing whether the client was obtained via device tree
>>> and only releasing the reference in that case.
>>>
>>> Found by code review.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
>>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>>
>> The patch looks fine in principle, however I don't see any way
>> this driver would be probed without devicetree, and I think
>> it would be better to remove all the traces of the pre-DT
>> logic in it.
>>
>> The lpc32xx platform was converted to DT back in 2012, so
>> any reference to the old variant is dead code. Something like
>> the patch below should work here.
>>
>> Other thoughts on this driver, though I I'm not sure anyone
>> is going to have the energy to implement these:
>>
>>   - the reference to isp1301_i2c_client should be kept in
>>     the hcd private data, after allocating a structure, by
>>     setting driver->hcd_priv_size.
>>   - instead of looking for the i2c device, I would suppose
>>     it should look for a usb_phy instead, as there is no
>>     guarantee on the initialization being ordered at the
>>     moment.
>>   - instead of a usb_phy, the driver should probably use
>>     a generic phy (a much larger rework).

Since I'm one of the remaining users and holders of the LPC32xx powered
boards, I should take this task.

> 
> Considering what the comments at the start of the file say:
> 
>   * Currently supported OHCI host devices:
>   * - NXP LPC32xx
> 
>   * NOTE: This driver does not have suspend/resume functionality
>   * This driver is intended for engineering development purposes only
> 
> I wonder whether any existing systems actually use this driver.
> 

The LPC32xx OHCI host device works fine with the driver, noteworthy
there were some issues with the LPC32xx UDC though.

Any pre-dt leftovers should be removed from the driver, as Arnd suggested.

-- 
Best wishes,
Vladimir

