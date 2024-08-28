Return-Path: <stable+bounces-71365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0D961D6E
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 06:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82F81F240C8
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 04:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08221411E0;
	Wed, 28 Aug 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FjXnBwht"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF21494A9
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818352; cv=none; b=pxb4OHOx9QuGpquxRnvqycGINO/Vcj11t1ljoqBqSFcrebIBwSPx2uC+00pLjv1Diqb1ugDxNE0KcbtvBSXuS+uaXGtML/qR+6nDnIAPQamqxO5W9jDUyDuXbqJDXFrNRFnyw4zISXtZgqIOY9vVEe0o1ZWnhIbK6XQNfQ0J6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818352; c=relaxed/simple;
	bh=XTt1glJu0rUb8owyLnA57AYtub8xBCVVnILF+wSZyrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=cUpPkjID7/tM2kHEIJq0WzAScJoHaL5XguNqOGa4F79fg417jr1X4/l1o2EsmM/tiuAyef3cSe8rExM9GdUo3wUlMmno4AcPUNH9fxnasC6akbXCW/apDkJxclyoe33hp0Y+GYl5X266pkVS/R1agVl6wLIqzcFYAiFXDS2csSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FjXnBwht; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240828041222epoutp014755ea216e5c277adf938efa334eaa37~vySTI6BNc2468524685epoutp01R
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 04:12:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240828041222epoutp014755ea216e5c277adf938efa334eaa37~vySTI6BNc2468524685epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724818342;
	bh=xY/5bssFJz3c4MH21yr5Lg7t97Fz6p4kSqYdRPCosQw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FjXnBwhto2WPTiS849OiIrbg4gMm+x9EVOJZy0js0bKRhXnP6xmgHbMZl5h0+lyq8
	 LU1hSokl8UKYWskiXQXysLdcgHaOh88ebbEpVjUOmrrtHv4CBmLfBIla0j3zt+9h6U
	 Fxt0D4dUdgWVTTIHlksVsQ4W2ZqbgaLQAi24hOrM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240828041221epcas5p25eab363bd19fbe63bb5ccfff560e2c82~vySSsN48v2954929549epcas5p22;
	Wed, 28 Aug 2024 04:12:21 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WtrbR1tMPz4x9Pt; Wed, 28 Aug
	2024 04:12:19 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.05.09640.3A3AEC66; Wed, 28 Aug 2024 13:12:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240828040823epcas5p47149c92b86596bd5f39a52cededabe29~vyO0saBr01187911879epcas5p4a;
	Wed, 28 Aug 2024 04:08:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828040823epsmtrp12462cee2a5aaf9c562f3e23b21d0b366~vyO0rhHJb2266022660epsmtrp1m;
	Wed, 28 Aug 2024 04:08:23 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-30-66cea3a3e29e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.79.08964.7B2AEC66; Wed, 28 Aug 2024 13:08:23 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240828040820epsmtip18742cfc0b437319cebc3c73ebe4cabb8~vyOyKE1c72270122701epsmtip1j;
	Wed, 28 Aug 2024 04:08:20 +0000 (GMT)
Message-ID: <3beb7209-9ed4-4155-bea8-c31dc0d5f017@samsung.com>
Date: Wed, 28 Aug 2024 09:38:18 +0530
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
In-Reply-To: <2024082212-copper-oversight-f84f@gregkh>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmpu7ixefSDG5uYbd4c3UVq8WdBdOY
	LE4tX8hk0bx4PZvFpD1bWSzuPvzBYnF51xw2i0XLWpktPh39z2qxqnMOUOz7TmaLBRsfMVpM
	OihqsWrBAXYHPo/9c9ewe/RtWcXosWX/Z0aPz5vkAliism0yUhNTUosUUvOS81My89JtlbyD
	453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgG5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
	l9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnzH35k7Vgo3BFR8cjpgbGHv4uRk4O
	CQETib0vvjF3MXJxCAnsZpTYN2EXO4TziVFi3qcvjBDON0aJhatmM8K0HFzYwA5iCwnsZZQ4
	PjsBougto8SMviY2kASvgJ3EkfaTrCA2i4CqxJPNH6HighInZz5hAbFFBeQl7t+aATZIWCBe
	4sjtpWD1IgIaEi+P3mIBGcoscJJJ4urSZUwgCWYBcYlbT+YD2RwcbAKGEs9O2ICEOQXMJD6d
	eM8GUSIvsf3tHLB/JAT2cEhcuvGeHeJqF4m78/4wQ9jCEq+Ob4GKS0m87G+DsqslVt8BORSk
	uYVR4vCTb1AJe4nHRx8xgyxmFtCUWL9LHyIsKzH11Dqo2/gken8/YYKI80rsmAdjq0qcarzM
	BmFLS9xbco0VwvaQmPxiC/MERsVZSOEyC8mbs5D8Mwth8wJGllWMkqkFxbnpqcWmBYZ5qeXw
	GE/Oz93ECE7DWp47GO8++KB3iJGJg/EQowQHs5II74njZ9OEeFMSK6tSi/Lji0pzUosPMZoC
	I2gis5Rocj4wE+SVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp1cBU
	v3vGs8xNB3R61ziXJEkvCPwSc0jxvFqPTHDm9jUaK39c77W/rj/9+7PeQy1HP2SvCks04sv3
	6v68ZVmj+5MPzovu7he7ZrNnb0bmjXNT/wr8n/f9+PwErzgbtcdrHB7uqZA/fDzH0CkgKuDH
	xKKjfYZ7Vjb3Sl4RmRCUG7fXdXdOx4U7Bod+5PLJ+Pkzs4iFel5YorNsj6MFdy7Hso3tVU3N
	emb/T67kuLNs8pR9v/RmMDZfuLz88R6XhfeuVuxdZ6x1oOHAvOv6h1l1p4bMv//MwVFp5728
	3OvfH1U8ri3aGmYnOu/fsb+uz5mNZF5f+nLz76RNa1Ibwyfkhy9UPKFkV3k9529w8K3/fQpf
	jimxFGckGmoxFxUnAgCodfrATAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnO72RefSDC6d5bJ4c3UVq8WdBdOY
	LE4tX8hk0bx4PZvFpD1bWSzuPvzBYnF51xw2i0XLWpktPh39z2qxqnMOUOz7TmaLBRsfMVpM
	OihqsWrBAXYHPo/9c9ewe/RtWcXosWX/Z0aPz5vkAliiuGxSUnMyy1KL9O0SuDLmvvzJWrBR
	uKKj4xFTA2MPfxcjJ4eEgInEwYUN7F2MXBxCArsZJXZ+fcwKkZCWeD2rixHCFpZY+e85VNFr
	RoneDxfZQRK8AnYSR9pPgjWwCKhKPNn8kQ0iLihxcuYTFhBbVEBe4v6tGWD1wgLxEs2T9zOB
	2CICGhIvj95iARnKLHCSSWLflT5miA2/mSSWPbkO1s0sIC5x68l8oA4ODjYBQ4lnJ2xAwpwC
	ZhKfTrxngygxk+jaCnEpM9Cy7W/nME9gFJqF5I5ZSCbNQtIyC0nLAkaWVYySqQXFuem5xYYF
	hnmp5XrFibnFpXnpesn5uZsYwTGnpbmDcfuqD3qHGJk4GA8xSnAwK4nwnjh+Nk2INyWxsiq1
	KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDk5P6q3X/pl9VFbilacb/
	4eN7PccEu5jJamVHLmyP+l6ypcNTbQe/13Orvfan1rH7rd4XefDk3cltmpP/vLDoe1UtpOIc
	/tf/O5f65INbF29u3Hx+wVr9gEPNT3Tv+Zl55e6s3X0r+M/i/XO99ySYPTGPZGF8y2JReP3L
	cduAc3O/bv1kE5iaWcy5uDphI4P4646vq57qHt5x4pjYnKuPd3v2mMbtZm5sF0ro1J43+3DP
	i6dFtnwTrXv7qm/axArnX/zNuU+w9lD46r1fF+m94S32Oi8/9ci/2+3cuVkihjseNNTyci+9
	aGF8e9/8JcfmP/lypvLdg0u5839p3Pnj6bvjxMHuqq4WTzanWT1TGmYqsRRnJBpqMRcVJwIA
	AJ8iCigDAAA=
X-CMS-MailID: 20240828040823epcas5p47149c92b86596bd5f39a52cededabe29
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
	<2024082212-copper-oversight-f84f@gregkh>


On 8/22/2024 1:29 PM, Greg KH wrote:
> On Sat, Aug 17, 2024 at 07:13:53PM +0530, Selvarasu Ganesan wrote:
>> On 8/17/2024 10:47 AM, Greg KH wrote:
>>> On Fri, Aug 16, 2024 at 09:13:09PM +0530, Selvarasu Ganesan wrote:
>>>> On 8/16/2024 3:25 PM, Greg KH wrote:
>>>>> On Thu, Aug 15, 2024 at 12:18:31PM +0530, Selvarasu Ganesan wrote:
>>>>>> This commit addresses an issue where the USB core could access an
>>>>>> invalid event buffer address during runtime suspend, potentially causing
>>>>>> SMMU faults and other memory issues in Exynos platforms. The problem
>>>>>> arises from the following sequence.
>>>>>>            1. In dwc3_gadget_suspend, there is a chance of a timeout when
>>>>>>            moving the USB core to the halt state after clearing the
>>>>>>            run/stop bit by software.
>>>>>>            2. In dwc3_core_exit, the event buffer is cleared regardless of
>>>>>>            the USB core's status, which may lead to an SMMU faults and
>>>>>>            other memory issues. if the USB core tries to access the event
>>>>>>            buffer address.
>>>>>>
>>>>>> To prevent this hardware quirk on Exynos platforms, this commit ensures
>>>>>> that the event buffer address is not cleared by software  when the USB
>>>>>> core is active during runtime suspend by checking its status before
>>>>>> clearing the buffer address.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org # v6.1+
>>>>> Any hint as to what commit id this fixes?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>> Hi Greg,
>>>>
>>>> This issue is not related to any particular commit. The given fix is
>>>> address a hardware quirk on the Exynos platform. And we require it to be
>>>> backported on stable kernel 6.1 and above all stable kernel.
>>> If it's a hardware quirk issue, why are you restricting it to a specific
>>> kernel release and not a specific kernel commit?  Why not 5.15?  5.4?
>> Hi Greg,
>>
>> I mentioned a specific kernel because our platform is set to be tested
>> and functioning with kernels 6.1 and above, and the issue was reported
>> with these kernel versions. However, we would be fine if all stable
>> kernels, such as 5.4 and 5.15, were backported. In this case, if you
>> need a new patch version to update the Cc tag for all stable kernels,
>> please suggest the Cc tag to avoid confusion in next version.
> I'll fix it up when applying it, thanks.

Thank you for the support!!.

Thanks,
Selva
>
> greg k-h
>

