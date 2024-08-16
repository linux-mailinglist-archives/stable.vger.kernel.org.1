Return-Path: <stable+bounces-69339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8BD954EF8
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 18:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22F81F26ABE
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918C71BCA1C;
	Fri, 16 Aug 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ePcj1LDH"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F177113
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826225; cv=none; b=Dz9JP8lk5H3m13h2He5C8HD+9QL1sykq2ZtvUM9rx9vJYPzVryHToLCwtVhvAglI0Zhh5ZeOU+CUklm/okQAwMPlp2s6Yayk6H9ljqNpfB5N47d41Xpn7UzMUVxT7HkTH4RTmLX5pPwI25wFjwHXgRCHE3/2QnrskWOVZVsoFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826225; c=relaxed/simple;
	bh=cZSUAWeDd5rCM+qAD/LVzIvs5CQlQpQNp66n+o3c3Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RGHJYhp7SksO+i4TCh53Ngz3cPQUfNaX3h7adbk2lD1D99xEeA+nBYujPpVtgAMRSbKcF9SLw5di3EuWwKbo9RvDs8hZwgjL/pKd4aggYD9wdiLKLTdeDT6r+mH1Axh75oupyKVnqgzC7lVzhxoAHTxMEw5wKz7gEwaFgCsFJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ePcj1LDH; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240816163700epoutp03893c27a2db3de16f0700904f79337011~sQtB8FozB1476414764epoutp03M
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 16:37:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240816163700epoutp03893c27a2db3de16f0700904f79337011~sQtB8FozB1476414764epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723826220;
	bh=TqPPlQaKUArbuhJTxVDgQq9zqm+9VIp3Ca3AX7bpk+o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ePcj1LDHj7HvJ9EzsJG0px2h/UlkKoI4+wiLRbS/0HdBnjnECj6eDCH4yRNB/+DA3
	 MPvrsa1CoRn2YgjDu2MEmTiTiizJSmi0deiHW4Rn4NFuZI9XUsq0uMRXMICHWn7/Fi
	 5o9QJg0bwFBz9/lVp4yrBVgJqgWTW1IBzRx5gQnU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240816163700epcas5p433ca7d63b0a9f4c98750499f1d36e4e8~sQtBlrTuc2435224352epcas5p4o;
	Fri, 16 Aug 2024 16:37:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WlnhB45rJz4x9Pp; Fri, 16 Aug
	2024 16:36:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.75.09743.A208FB66; Sat, 17 Aug 2024 01:36:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240816154312epcas5p3b282d7cba06fe54e1aa9be216452b143~sP_DdiH5h0211602116epcas5p3R;
	Fri, 16 Aug 2024 15:43:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240816154312epsmtrp2c964e674b29bcb79c77d561a0c4c8cf4~sP_Dcsv9x0744807448epsmtrp2E;
	Fri, 16 Aug 2024 15:43:12 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-12-66bf802ada82
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.04.19367.0937FB66; Sat, 17 Aug 2024 00:43:12 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240816154310epsmtip19c177cdfece7ba449e0946e137a2b101~sP_BeXm3l2660326603epsmtip1P;
	Fri, 16 Aug 2024 15:43:10 +0000 (GMT)
Message-ID: <4f286780-89a2-496d-9007-d35559f26a21@samsung.com>
Date: Fri, 16 Aug 2024 21:13:09 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2024081618-singing-marlin-2b05@gregkh>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmlq5Ww/40g7bJshZvrq5itbizYBqT
	xanlC5ksmhevZ7OYtGcri8Xdhz9YLC7vmsNmsWhZK7PFp6P/WS1Wdc4Bin3fyWyxYOMjRotJ
	B0UtVi04wO7A57F/7hp2j74tqxg9tuz/zOjxeZNcAEtUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0I1KCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMCWeusxTM4q7Yfn8lWwPjPo4uRk4O
	CQETic1rtrF1MXJxCAnsZpQ40LmfGcL5xChx9PlHVjhn+45WdpiWj1/aWCASOxklmuc/gqp6
	yyjx7Pp3FpAqXgE7iad/1gPN4uBgEVCVaNjnDBEWlDg58wlYiaiAvMT9WzPAhgoLxEscub2U
	FcQWEdCQeHn0FtgCZoGTTBJXly5jAkkwC4hL3HoynwlkJpuAocSzEzYgYU6gg9a032KHKJGX
	2P52DjPEoWs5JKZszAUplxBwkTh4KxUiLCzx6vgWqF+kJD6/28sGYVdLrL7zERwUEgItjBKH
	n3yDKrKXeHz0EdgrzAKaEut36UOEZSWmnloHdRmfRO/vJ0wQcV6JHfNgbFWJU42XoeZLS9xb
	co0VwvaQmPxiC/MERsVZSKEyC8mTs5B8Mwth8wJGllWMkqkFxbnpqcWmBUZ5qeXw+E7Oz93E
	CE7BWl47GB8++KB3iJGJg/EQowQHs5II79Mve9OEeFMSK6tSi/Lji0pzUosPMZoCY2cis5Ro
	cj4wC+SVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp1cDksDrxnGNZ
	mw+zwWIP+d9b1SasYuSYfuxXG39Z6NWXgX6fTOcF2YlMscy+ue3WooqY//bskZJ/i56sLLVT
	sGfm7stqFdWa08v2idPgU8niV3u015ZVTxCN5VghY/x+6UkG5oLf7SEr79+/XN6REu7upnvR
	LbPRb2mduaq4oKazBePE7dFtf/s4psX0vP3fbncurnRD9KVSZmEZu8/buc/UXRAsnF6tWKW1
	NSJpRejh2CcMj+UT/M9ven/Z/miEptsFlZrfj/Tzb4kJflDxqeuV2H5CTWPB9JZTuRI3jpTZ
	n09+UndJZf5Kv+aHny+ZFmzc7/DqlP5qIYuJmUmLXWS0UnMknvxs9z4ZZinEp8RSnJFoqMVc
	VJwIABHmJ/NKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO6E4v1pBpPf8Fq8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFgo2PGC0m
	HRS1WLXgALsDn8f+uWvYPfq2rGL02LL/M6PH501yASxRXDYpqTmZZalF+nYJXBkTzlxnKZjF
	XbH9/kq2BsZ9HF2MnBwSAiYSH7+0sXQxcnEICWxnlJj3+SIrREJa4vWsLkYIW1hi5b/n7BBF
	rxkl9u/sACviFbCTePpnPXMXIwcHi4CqRMM+Z4iwoMTJmU9YQGxRAXmJ+7dmsIPYwgLxEs2T
	9zOB2CICGhIvj94CW8wscJJJYt+VPmaIBTsZJbof7gHrYBYQl7j1ZD4TyAI2AUOJZydsQMKc
	QFevab8FVWIm0bUV4lBmoGXb385hnsAoNAvJHbOQTJqFpGUWkpYFjCyrGEVTC4pz03OTCwz1
	ihNzi0vz0vWS83M3MYIjTStoB+Oy9X/1DjEycTAeYpTgYFYS4X36ZW+aEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA1NuQyxjo889uexmpZwYD7/pBSK1
	Nl8VMpYJ2Ldq7LN5Ilict6zW9SfviQtvDTZGGz9h5TxwTD44KoIj/vDirif33bb/kPRIq2L6
	vkTVyPpF1V4prt1M7SHhFYGnVD03RU82cctZrKnrLBp/XFnqxdzzKz0Of2hcJnlq+rZFGfxO
	JqwrJiZcnnHzifT16K4jC8+bLDjoLWvHULBQxTgq2P5I5GEtJT3P3XeuHpK9U7Xm4dJVqbcc
	C2aezOrx/dIbU2Sbo2mvEW68YOc5363feoLLbrWVu0unrq7z7997Tzq3StjtX6qQQF1NkaJ8
	tMPN033WXQv+nsvO2ajZ9tVO3Kbn6ulb+5Y/+mJy/lSaEktxRqKhFnNRcSIAG2kT3SMDAAA=
X-CMS-MailID: 20240816154312epcas5p3b282d7cba06fe54e1aa9be216452b143
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe
References: <CGME20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe@epcas5p1.samsung.com>
	<20240815064836.1491-1-selvarasu.g@samsung.com>
	<2024081618-singing-marlin-2b05@gregkh>


On 8/16/2024 3:25 PM, Greg KH wrote:
> On Thu, Aug 15, 2024 at 12:18:31PM +0530, Selvarasu Ganesan wrote:
>> This commit addresses an issue where the USB core could access an
>> invalid event buffer address during runtime suspend, potentially causing
>> SMMU faults and other memory issues in Exynos platforms. The problem
>> arises from the following sequence.
>>          1. In dwc3_gadget_suspend, there is a chance of a timeout when
>>          moving the USB core to the halt state after clearing the
>>          run/stop bit by software.
>>          2. In dwc3_core_exit, the event buffer is cleared regardless of
>>          the USB core's status, which may lead to an SMMU faults and
>>          other memory issues. if the USB core tries to access the event
>>          buffer address.
>>
>> To prevent this hardware quirk on Exynos platforms, this commit ensures
>> that the event buffer address is not cleared by software  when the USB
>> core is active during runtime suspend by checking its status before
>> clearing the buffer address.
>>
>> Cc: stable@vger.kernel.org # v6.1+
> Any hint as to what commit id this fixes?
>
> thanks,
>
> greg k-h


Hi Greg,

This issue is not related to any particular commit. The given fix is 
address a hardware quirk on the Exynos platform. And we require it to be 
backported on stable kernel 6.1 and above all stable kernel.

Thanks,
Selva


>

