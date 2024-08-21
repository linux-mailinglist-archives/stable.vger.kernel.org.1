Return-Path: <stable+bounces-69777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67FB959438
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 07:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D59D1F23A8E
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 05:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20074166F24;
	Wed, 21 Aug 2024 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BVx0UbgQ"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54C8121B
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218957; cv=none; b=jd3G0ugExs/D6Hyt6oy6cHAeUpXjYbtMfDgSMcFOpzgDy57tN1828Tp8vJtfce2RUDT/AEPVTlf6TJfIYRYzOevmpmmqMQ30YxUjLpf9MS5/P+cttqbbGdNZ1WoTf0tHYzeC4zaEnDzzzQrOmNN6s2VGO8jjEkky1EBX+PGPmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218957; c=relaxed/simple;
	bh=24nKDa2HoDT3211Np8XRUv0LTMaNqoDReSyYeOmRIkI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=At3S7HuFTrM+wAzLXwWkpcEFaYmtczzFqJGNcZG8yM4GKup1JdbUbea/Bfk+Lc+fh/Mb1xKnK4/yd4wAf1+FAwwGcYwiD8RIjGRB4SWWJtiE/0aPzjkbIS5ni/kr1gqDyezD6STV54ffrtOfAcGi30DVwXV9ibOLyaRT0ybwSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BVx0UbgQ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240821054233epoutp019ef06283246bc13e1604904a7be04015~tqACs1v941027610276epoutp01e
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 05:42:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240821054233epoutp019ef06283246bc13e1604904a7be04015~tqACs1v941027610276epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724218953;
	bh=VHnNMvIcdgjE/R1tIeGb8sDSSqEjSXXpwIjbYZHbxFg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BVx0UbgQ6wHuCtz7rWWC5dWsHepcdQzCHJYeX6jt4JNgAxTD1uWnDfHIrMHwiNXV1
	 budcwwGhcP1bs+NoFP0FRF0iqbpAVDXUm07z45XbCop1kTZdv7ZHjDJY52d+hVnAze
	 eUypUo2Kr644jpTBFvmvxISXCeLhh0iUADXeu/wI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240821054232epcas5p28262726dde43d01dcc22944e9a68b69d~tqACBMZ4d2238122381epcas5p2z;
	Wed, 21 Aug 2024 05:42:32 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WpZwl04Thz4x9Py; Wed, 21 Aug
	2024 05:42:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DC.B4.19863.64E75C66; Wed, 21 Aug 2024 14:42:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240821052925epcas5p28f55bc6fed2ce4689c4d52f45601ab7f~tp0k4tO7a2051120511epcas5p2I;
	Wed, 21 Aug 2024 05:29:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240821052925epsmtrp1c967157b9a26a352b2e18ae79284a4b3~tp0k1TkSq0077500775epsmtrp1k;
	Wed, 21 Aug 2024 05:29:25 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-9e-66c57e46299e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.74.07567.43B75C66; Wed, 21 Aug 2024 14:29:25 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240821052922epsmtip1298c35023b69cce3f07e3caf14c16159~tp0ivpEOt2498524985epsmtip1X;
	Wed, 21 Aug 2024 05:29:22 +0000 (GMT)
Message-ID: <4a0ada8a-5247-4c1c-b938-a6ae034b04d9@samsung.com>
Date: Wed, 21 Aug 2024 10:59:21 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, stable@vger.kernel.org
Content-Language: en-US
In-Reply-To: <c477fdb2-a92a-4551-b6c8-38ada06914c6@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmpq5b3dE0g8lzLC3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
	eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
	JbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZPxb8YS5YKlyxoF+lgfELXxcjB4eE
	gInEu40BXYxcHEICexgl3m5/zwThfGKUOH3lJzuE841R4su+jcxdjJxgHeda5zJCJPYySnS8
	b2GBcN4yShyfe4wJpIpXwE5iwpG3YDaLgKrEgvbP7BBxQYmTM5+wgNiiAvIS92/NAIsLC8RL
	HLm9lBXkJjYBQ4lnJ2xAwiICGhIvj94Cm88scJJJ4urSZWAzmQXEJW49mQ9mcwrYS8w7CdIL
	EpeX2P52DjNIg4TADg6J/W27WSHOdpF4equJBcIWlnh1fAs7hC0l8bK/Dcqullh95yMbRHML
	o8ThJ9+gEvYSj48+Yga5jllAU2L9Ln2IsKzE1FProA7ik+j9/YQJIs4rsWMejK0qcarxMhuE
	LS1xb8k1qHs8JCa/2MI8gVFxFlK4zELy2ywk/8xC2LyAkWUVo1RqQXFuemqyaYGhbl5qOTzG
	k/NzNzGC07BWwA7G1Rv+6h1iZOJgPMQowcGsJMLb/fJgmhBvSmJlVWpRfnxRaU5q8SFGU2AM
	TWSWEk3OB2aCvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamGbt
	e2Jz72vqyc/r5vKYvHJNieJKVLge+/3t07O8Gjm/XtclJLRJful1WbQ7YH4l526NZJUH58yD
	jW32vb59oi82OTHBddev+ODLOiu4nsxP5H2pU1L99/mP1MqJmyquVy/i/zRHpjrgX9m7gEOz
	JKIZgv+/qeq8KeD7qKGz5zhT1OlF699W732rKn1+2gm9Cr/u0En3977/fEFzBt+cgBRBNePF
	lhN7Ln1v+TktNrbK/OMSAzt94a3vlkrLq7wTvrBJIuQ6N8PS//0C5nNiGkIV5eoyr1/gML75
	/90C56VbT0YuX6pwV1SudV6Fv435Pd6a0JTLyS3GARsuX8uVEg2UbnlUxZ3oy2uSorglSoml
	OCPRUIu5qDgRADW3Y5RMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnK5p9dE0g/nTmS3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJYoLpuU1JzMstQifbsErowfC/4wFywV
	rljQr9LA+IWvi5GTQ0LAROJc61zGLkYuDiGB3YwSk9sOMEMkpCVez+pihLCFJVb+e84OYgsJ
	vGaUWLjKFsTmFbCTmHDkLROIzSKgKrGg/TM7RFxQ4uTMJywgtqiAvMT9WzPA4sIC8RLNk/cD
	1XNwsAkYSjw7YQMSFhHQkHh59BYLyA3MAieZJPZd6WOGOOg8k8TUu7vABjELiEvcejIfbBmn
	gL3EvJNLWSHiZhJdWyEOZQZatv3tHOYJjEKzkNwxC0n7LCQts5C0LGBkWcUomVpQnJuem2xY
	YJiXWq5XnJhbXJqXrpecn7uJERxvWho7GO/N/6d3iJGJg/EQowQHs5IIb/fLg2lCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MJV5rVBf7WtROfvC9gNc
	j2O05gvo1PAFlWY9um53ZMaZg6KzuFWTfgjOeiNzmmNzpv+fFZtiTRm7/ZjZ9WbMNxZ/dlJ2
	gaNjQ1OAZuW57+VHhYpvGEpwmvDJn9nw68ahAw3NBoruU6f/0BMreOIrZ2i87NoexsfBR9Xl
	rBuYXP4/UAlg5pl1f96O08tnbDxRvuHruweGB/Yb2h/oK+4p3db3pDNWqOZT8t9m0bT999hu
	CXo//niEfcMSE/sPeh/mtxsEsn56tqlEhFW9fbsX06MnWzPOn9nV1bopQY+j7UOaw/7QtngP
	6fh4rzrTSsYjYfI8WVOTpkp3NCxlc7hza8rRwK0bOM2ZTMR0db0PKbEUZyQaajEXFScCAAhL
	WlsmAwAA
X-CMS-MailID: 20240821052925epcas5p28f55bc6fed2ce4689c4d52f45601ab7f
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
	<4f286780-89a2-496d-9007-d35559f26a21@samsung.com>
	<2024081700-skittle-lethargy-9567@gregkh>
	<c477fdb2-a92a-4551-b6c8-38ada06914c6@samsung.com>


On 8/17/2024 7:13 PM, Selvarasu Ganesan wrote:
> On 8/17/2024 10:47 AM, Greg KH wrote:
>> On Fri, Aug 16, 2024 at 09:13:09PM +0530, Selvarasu Ganesan wrote:
>>> On 8/16/2024 3:25 PM, Greg KH wrote:
>>>> On Thu, Aug 15, 2024 at 12:18:31PM +0530, Selvarasu Ganesan wrote:
>>>>> This commit addresses an issue where the USB core could access an
>>>>> invalid event buffer address during runtime suspend, potentially causing
>>>>> SMMU faults and other memory issues in Exynos platforms. The problem
>>>>> arises from the following sequence.
>>>>>            1. In dwc3_gadget_suspend, there is a chance of a timeout when
>>>>>            moving the USB core to the halt state after clearing the
>>>>>            run/stop bit by software.
>>>>>            2. In dwc3_core_exit, the event buffer is cleared regardless of
>>>>>            the USB core's status, which may lead to an SMMU faults and
>>>>>            other memory issues. if the USB core tries to access the event
>>>>>            buffer address.
>>>>>
>>>>> To prevent this hardware quirk on Exynos platforms, this commit ensures
>>>>> that the event buffer address is not cleared by software  when the USB
>>>>> core is active during runtime suspend by checking its status before
>>>>> clearing the buffer address.
>>>>>
>>>>> Cc: stable@vger.kernel.org # v6.1+
>>>> Any hint as to what commit id this fixes?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>> Hi Greg,
>>>
>>> This issue is not related to any particular commit. The given fix is
>>> address a hardware quirk on the Exynos platform. And we require it to be
>>> backported on stable kernel 6.1 and above all stable kernel.
>> If it's a hardware quirk issue, why are you restricting it to a specific
>> kernel release and not a specific kernel commit?  Why not 5.15?  5.4?
> Hi Greg,
>
> I mentioned a specific kernel because our platform is set to be tested
> and functioning with kernels 6.1 and above, and the issue was reported
> with these kernel versions. However, we would be fine if all stable
> kernels, such as 5.4 and 5.15, were backported. In this case, if you
> need a new patch version to update the Cc tag for all stable kernels,
> please suggest the Cc tag to avoid confusion in next version.
>
> Thanks,
> Selva


Hi Greg,

Would you like to provide any feedback or suggestions regarding the my 
last comments mentioned above?

Thanks,
Selva
>> thanks,
>>
>> greg k-h
>>
>>
>

