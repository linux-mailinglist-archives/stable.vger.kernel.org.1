Return-Path: <stable+bounces-100435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C789EB2D5
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A75C162006
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C651AAA2F;
	Tue, 10 Dec 2024 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AJSUtyuR"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1711AAA16
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839925; cv=none; b=DzVq9rHuGi0Bw/5oRyk65k9gcRae5SUe49ODAr3AlWD874aKsJeFpUP2n3Ekt90t4sJYbh0pDWGGUnsnNFTtUeJiKDOaa8oBs71uT9owhIB/i20banQaxfekmH8ZzoHEYEcVtwM6gMkiIxjPGe2WAgoOlFPKUOL0gjCrzLSmey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839925; c=relaxed/simple;
	bh=zTzEWizpRaM8ODZvWNOpxJ8TZzIGu5NbRBoMbnMFbQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jNo5kixNkdtAfFsvVzD1ZDTR3I2NjEu2sT1s7ScZWy9bMDRtWJIlQTN9ntQy0V7XHW/zDcTvkYziWMRL70P7C8gamhwhhl0PWj8Go8e7O2EyZ2RJejFbUIHCLLmb7MxrrPwGj2RVnD7BerN2YdXy5O131pBobtph7Sj8DGDX8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AJSUtyuR; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241210141200epoutp04dbbf87685e434049b949e6dfd0102ac3~P1jjDfr2o0548005480epoutp04F
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 14:12:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241210141200epoutp04dbbf87685e434049b949e6dfd0102ac3~P1jjDfr2o0548005480epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733839920;
	bh=HfwqOcrO3Cvy54+XQ2mqcIc5mAMae4tZNeYE/5TOFLc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AJSUtyuR01TIKiB9qiX5y4nHwh2m6vDfgk8YjY6Rj1YQ+9U2xrFURXk1mshfboSof
	 wR/WK3vJ3FyU6UWmsZ6gU6VLXAsWgF8u+0pVvcSJyKAM/YPmXsxdlpDhqQ7h/xGHOk
	 U4bzE63SmjzlOSa1uOezVKQDLM9jecod4Ef0T7L8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241210141159epcas5p217de40b5a6a540752a998faa14f2fa07~P1jiJ6Dqe1988119881epcas5p2G;
	Tue, 10 Dec 2024 14:11:59 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y70zL5XKnz4x9Pt; Tue, 10 Dec
	2024 14:11:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E4.7D.19710.E2C48576; Tue, 10 Dec 2024 23:11:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210141157epcas5p2ff173636946d70e2b6d0a44cd7c087be~P1jgCIQj10084800848epcas5p2G;
	Tue, 10 Dec 2024 14:11:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210141157epsmtrp2922d6521234b8ec8c5d3657f0a4bc104~P1jf-PUeU3088230882epsmtrp2L;
	Tue, 10 Dec 2024 14:11:57 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-13-67584c2e12e6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.B7.18949.D2C48576; Tue, 10 Dec 2024 23:11:57 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241210141154epsmtip22eb775c181d0f8e44c3ead32f983c546~P1jdghQqC0507705077epsmtip2h;
	Tue, 10 Dec 2024 14:11:54 +0000 (GMT)
Message-ID: <e3f45175-a17d-4b88-b6e4-5c75e91132be@samsung.com>
Date: Tue, 10 Dec 2024 19:41:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
To: Greg KH <gregkh@linuxfoundation.org>
Cc: quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2024121035-manicure-defiling-e92c@gregkh>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRT27W1vLyQ11wLjpRhWS3CjDNZKKRcFhoraDGJIFMX9AAp90xL6
	td4ydVnMmAKyrQIFy0Zg1LlBLM3IsBusdk5r+BgjI9K5CIE5PlSmQwcU5zIctr04+fecc55z
	znPOeV8C40/iAqJCb0YmvVIrwsPZF79L3Jmckl+klty8I6Zabec51N0fHBzq9qmLODVtt7Go
	0e7PWNSHn/filNVzgU3NzP7Nps4tjXMon7sdp0531WCUq/YGi1oZ3OBQ1a4ZDuWob2dTvvuX
	MMp+fg5Q1m+jcviKPkc9rrjS4eQqhhaHuYqGfySKJs8Hik9cDqBY7Ysr4O6rzNQgpQqZhEhf
	blBV6NVZorw3Sl4uSZNLpMnSDCpdJNQrdShLlJtfkPxqhTYwhEh4QKmtCrgKlDQt2p2daTJU
	mZFQY6DNWSJkVGmNMmMKrdTRVXp1ih6Zn5dKJM+lBYillZq16nq2sYvznmWthnUYHGMfBWEE
	JGXw54ZrARxO8MmvAOw6bsUZYwXAiS+cgDH+ArBltulxirPTvsm6DGDzcFsowCeXAJxtjAxi
	HpkNu4/0giBmkwnQbfGwGP9T8OrJhRA/itwOf5o6wQ3iCLICrrUeDfEjyZ3wzuBUSBNGOjE4
	6bfgwQBGRsOphc5AIYLASSn8ZSQz6A4j0+GDlUkOQ9kO+5fasWAuJBcJuD7WzWFU58KW6ebN
	CSLgb8MuLoMFcPWPyziDy6HH6t/0a6DX4cUYvAf22Mc4wb4YmQh73buZXk9Cy8OFkBxI8uDH
	tXyGnQBHq32bFWPhrTM3NxUo4GjtfS6zt2UA29tPshqBsG3LWtq2TNm2ZZy2/zvbAdsBYpCR
	1qlReZpRqkfvPj54uUHXB0JvXJw7AH7sfJTiBSwCeAEkMFEkj8grVPN5KuX7B5HJUGKq0iLa
	C9IC92nCBFHlhsAn0ZtLpLIMiUwul8syUuVSUTTv95oOFZ9UK82oEiEjMv2XxyLCBIdZbx86
	fdc1Vi8wz003H6lZuTXWeX2c7mk13Xv9lcJdWtmyHMvj7zjw6UZxcVbHs18bY9aKfOjLb6JL
	cGG/c1413zQ0V1X3jm1A6E9tXD4eH/HRE/2nDsGRc2XHyjguhG+rkK/HJ9ahmQahLW6FezYu
	cZsb7d1fm1+XPhvpH7FdM6Ra7/H23x7cI6j5NSf+0UPjRGOzeEiBvNMt44kFNp9YTydMXvHP
	r/qGz7SUJvcoIsqSsi/p7JKnVaNOosV9Y4efdzB+LClG80J+TvheS2zR1cIOZHrmtfCNPy/s
	S5rgOR8U8y0vnRiULM5cB2ffetGte3N9YJfXEzvwfV8pn1ctYtMapVSMmWjlv4MjXMpsBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSvK6uT0S6wcHjkhbTp21ktXhzdRWr
	xYN529gs7iyYxmRxavlCJovmxevZLCbt2cpicffhDxaLdW/Ps1pc3jWHzWLRslZmiy1tV5gs
	Ph39z2rRuOUuq8WqzjksFpe/72S2WLDxEaPFpIOiDkIem1Z1snnsn7uG3ePYi+PsHv1/DTwm
	7qnz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroyvjZ0sBctYK3q/tjI1MHazdDFyckgImEis
	mb+ArYuRi0NIYDejxJ85Z9ggEtISr2d1MULYwhIr/z1nhyh6zSjx7MVGdpAEr4CdxPKm9WBF
	LAKqErt69zBBxAUlTs58ArZBVEBe4v6tGWD1wgKZEvdOzQRbICKgIfHy6C0WkKHMAmuYJX7N
	6GCE2PCRUeJH1ySwKmYBcYlbT+YDTeXgYBMwlHh2wgYkzClgLvHz001WiBIzia6tEJcyAy3b
	/nYO8wRGoVlI7piFZNIsJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kR
	HLVaWjsY96z6oHeIkYmD8RCjBAezkggvh3douhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697
	U4QE0hNLUrNTUwtSi2CyTBycUg1MxX+qyjdxPr3XqPb1l9mTFV8NW8zV5DhKpjNERxzLCpiV
	w1BsL37p9t9Yplnx8x09A4OijSwz2jLMD4t6yN3ntjlXXLPH6Fk5N++WCg1+N29HyVk2G4/M
	WbljxlVth+cPJIXyJRdkvJGu1DYQCc5gZHQ48Eb9r4Xuuxt2fz7+2XPk7/Kb7vOYtRY731y1
	00codUrnhi2C6Qz5vxU5tq+o522fzJf5KzE/bv38PW3c5Y67DafWtPN9EJuWfOEL69mERFFN
	fYGEL6m3P30ODs4ycpbzfFSwM5RxM0diXrPiaZlbJ2oWFTgHfr4x8XaurMc2s7NLBNd9f/+7
	7V36B7dnFps4Sp8nX034pruPv1yJpTgj0VCLuag4EQAXdKj5SQMAAA==
X-CMS-MailID: 20241210141157epcas5p2ff173636946d70e2b6d0a44cd7c087be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208152338epcas5p4fde427bb4467414417083221067ac7ab
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
	<20241208152322.1653-1-selvarasu.g@samsung.com>
	<6b3b314e-20a3-4b3f-a3ab-bb2df21de4f5@samsung.com>
	<2024121035-manicure-defiling-e92c@gregkh>


On 12/10/2024 3:48 PM, Greg KH wrote:
> On Tue, Dec 10, 2024 at 03:23:22PM +0530, Selvarasu Ganesan wrote:
>> Hello Maintainers.
>>
>> Gentle remainder for review.
> You sent this 2 days ago, right?
>
> Please take the time to review other commits on the miailing list if you
> wish to see your patches get reviewed faster, to help reduce the
> workload of people reviewing your changes.
>
> Otherwise just wait for people to get to it, what is the rush here?
>
> thanks,
>
> greg k-h


Hi Greg,


There is no rush. I understand that the review will take time and I 
apologize for any inconvenience caused by sending the reminder email.

Thanks,
Selva

