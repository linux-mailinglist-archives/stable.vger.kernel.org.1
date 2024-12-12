Return-Path: <stable+bounces-100907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F09EE6B7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86FA1884AC5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B32080FC;
	Thu, 12 Dec 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A5EvStvZ"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1732063E6
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006498; cv=none; b=GIRBQYxr+BoxWaHXKJfNYxy99H9rwPoNm1h2wNMhYPEmOi1rVBTFMYsJvAbxwTXvMQjpWq5IGOEG1i265Ds4Wa5QJgPypQv9n+ZkCS1TEQEvc7MNyFKMcdAcwTZHAmXBvMdRroRaQylvq75JmY7w+S4+IpnwJHRPatxPT7Udno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006498; c=relaxed/simple;
	bh=+0CelrxvI59suzX7cscXydX2igdqhVoKqCyo/W/yaxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=dKJhKngovzHZy+kvVyyFmuXRSuoUxiPRgkT3oFCixmuFKwXBwDDlx5MVIzghF18q7zjpVezGoMzspv8DCnyruxoW02EMLH+wEHJSWtjZhQwzx+yPHwR2LwNy6k/s3lvqCzX8h1WuU1nc/EXm1aAdCRZw6Sbws0jHyoZbu5ZNtDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A5EvStvZ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241212122813epoutp04c2d3ab37fa34a3c91b87bb9ecc5dc764~QbbgFtKb61685716857epoutp04a
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 12:28:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241212122813epoutp04c2d3ab37fa34a3c91b87bb9ecc5dc764~QbbgFtKb61685716857epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734006493;
	bh=+0CelrxvI59suzX7cscXydX2igdqhVoKqCyo/W/yaxw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=A5EvStvZLDsFWbgozlMigr9OgdQGoJQJAaJKCedet2AhbyzSw1sbI7XfcuX/fNYNY
	 FhpAkXSFrjPqlfg5YhfhqhP9YkYT+6kJfYmUVu9kXkaTt+O2yUkn8NeoN5lmBFNpQ0
	 S0704HGvI7zPhWlf7KbpSxsa4h7yyqzs1edl5SV8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241212122812epcas5p2ad013b4b83ccf617273d608da7dc8493~QbbfTejya0114101141epcas5p25;
	Thu, 12 Dec 2024 12:28:12 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y8BZg4jGRz4x9Py; Thu, 12 Dec
	2024 12:28:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.B0.19933.BD6DA576; Thu, 12 Dec 2024 21:28:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241212122810epcas5p353940d4d5450310e32192a4603e987ac~Qbbdlb8yn1235312353epcas5p3D;
	Thu, 12 Dec 2024 12:28:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241212122810epsmtrp23c1128d2fcfe6da208b7ca5115d3666f~QbbdkVjzI1695316953epsmtrp2Z;
	Thu, 12 Dec 2024 12:28:10 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-d6-675ad6dbfeba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.05.18729.AD6DA576; Thu, 12 Dec 2024 21:28:10 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241212122808epsmtip1d0e8a5537e1857e4847c94bf2542297c~QbbbG1oov2447224472epsmtip1C;
	Thu, 12 Dec 2024 12:28:08 +0000 (GMT)
Message-ID: <4d6b2af3-7afe-4da6-b96e-ed1ea60eaed4@samsung.com>
Date: Thu, 12 Dec 2024 17:58:07 +0530
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
In-Reply-To: <2024121054-pregnant-verse-d8d5@gregkh>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmhu7ta1HpBsv2K1lMn7aR1eLN1VWs
	Fg/mbWOzuLNgGpPFqeULmSyaF69ns5i0ZyuLxd2HP1gs1r09z2pxedccNotFy1qZLba0XWGy
	+HT0P6tF45a7rBarOuewWFz+vpPZYsHGR4wWkw6KOgh5bFrVyeaxf+4ado9jL46ze/T/NfCY
	uKfOo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNT
	bZVcfAJ03TJzgJ5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al
	6+WlllgZGhgYmQIVJmRndMy/x1wwk6NiSdcm1gbGjWxdjJwcEgImErP3nmfvYuTiEBLYzShx
	dP8UNgjnE6PEq8P9jCBVQgLfGCU+Ho+H6fjW8J8Zomgvo8T5vguMEM5bRoldd+eDdfAK2Ens
	en0EzGYRUJVY+v0gVFxQ4uTMJywgtqiAvMT9WzPYQWxhgUyJr9O7wGpEBDQkXh69xQIylFlg
	DbPEzS+9YMcyC4hL3Hoyn6mLkYODTcBQ4tkJG5AwJ9BFz/beY4YokZfY/nYO2HUSAi84JA7u
	38UCcbaLxJIJV5ggbGGJV8e3sEPYUhKf3+2FBkayxJ5JX6DiGRKHVh1ihrDtJVYvOMMKspdZ
	QFNi/S59iF18Er2/n4CdIyHAK9HRJgRRrSpxqvEy1ERpiXtLrrFC2B4Sp9q+Q4P6ApPE4/Mr
	2CcwKsxCCpZZSL6cheSdWQibFzCyrGKUTC0ozk1PLTYtMMpLLYdHeHJ+7iZGcBrX8trB+PDB
	B71DjEwcjIcYJTiYlUR4b9hHpgvxpiRWVqUW5ccXleakFh9iNAXGz0RmKdHkfGAmySuJNzSx
	NDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgUnrLQfTzmPJEhX+fafU5z2f
	/XqS3K59N48rXaiscNrjXP6SPfHafOZofzPlip0+HBMC/JO2/1L48DyhxKV659InydLCyy3u
	HbNvn7m8WurNqzAxVvGsSQs6vX1194v/fBWWGbzbvGb+iUXG2f1Gy4pXlYhrvqtM692+IfNS
	aspHQfdbepffCmdbn7P5fS1YqP6ixXaXWV3nG6ynPQ60UHAzjN1bM32NYrRXZd4R0eNOrULC
	y26LCzueCTu3YKp3f8sR7q/WEdcO99c51lirfXbQ1XX5nSfFxuzD2pm0zmH5g7sL1N+zGfVM
	uR/98/NWwceu+8oemZwTOPn2X85C9YpVv39wXbr/wURm0+L2e0osxRmJhlrMRcWJAA/RnEds
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnO6ta1HpBmeOmVhMn7aR1eLN1VWs
	Fg/mbWOzuLNgGpPFqeULmSyaF69ns5i0ZyuLxd2HP1gs1r09z2pxedccNotFy1qZLba0XWGy
	+HT0P6tF45a7rBarOuewWFz+vpPZYsHGR4wWkw6KOgh5bFrVyeaxf+4ado9jL46ze/T/NfCY
	uKfOo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDI65t9jLpjJUbGkaxNrA+NGti5GTg4JAROJ
	bw3/mbsYuTiEBHYzSsxctBMqIS3xelYXI4QtLLHy33N2iKLXjBK7/+9nB0nwCthJ7Hp9BKyI
	RUBVYun3g4wQcUGJkzOfsIDYogLyEvdvzQCrFxbIlLh3aibYAhEBDYmXR2+xgAxlFljDLPFr
	RgcjxIYLTBK7n/wA62YWEJe49WQ+UxcjBwebgKHEsxM2IGFOoLOf7b3HDFFiJtG1FeJSZqBl
	29/OYZ7AKDQLyR2zkEyahaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcx
	gqNWS3MH4/ZVH/QOMTJxMB5ilOBgVhLhvWEfmS7Em5JYWZValB9fVJqTWnyIUZqDRUmcV/xF
	b4qQQHpiSWp2ampBahFMlomDU6qBaWqK/r6elMi7sS9fKAd3L4pP8Jj5sC7eU8tHRuW/9ufS
	50fTN0S1OC+6OJEnhPlIWH/+8eKtHxoPWH/4MyWY/cvUquDvm2cZsfG84RP7/SG3LlPx2/dl
	kwJDdY9/sz5Q+VRU7+rE7oL7m3OSdrtINF8OEbZzXWnRtplb+Oe8vz2VBkaWDor31337e7BK
	rris3HXt66u2cYoLwwT3r7RQ3O9Y/n97mLph3uSjLz7eebHCatXh+7JHmpatijOWYuTZHRTV
	FF32Kfwl63mXrOi9X3etnCdcdN5m5k8x+a7IThnvhQteJ6X19dWbWE38EaauzTHNfe09jeiH
	G/v2mlivtrqopPToxJTOyvlipq9rlViKMxINtZiLihMB7kF9kEkDAAA=
X-CMS-MailID: 20241212122810epcas5p353940d4d5450310e32192a4603e987ac
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
	<e3f45175-a17d-4b88-b6e4-5c75e91132be@samsung.com>
	<2024121054-pregnant-verse-d8d5@gregkh>


On 12/10/2024 7:55 PM, Greg KH wrote:
> On Tue, Dec 10, 2024 at 07:41:53PM +0530, Selvarasu Ganesan wrote:
>> On 12/10/2024 3:48 PM, Greg KH wrote:
>>> On Tue, Dec 10, 2024 at 03:23:22PM +0530, Selvarasu Ganesan wrote:
>>>> Hello Maintainers.
>>>>
>>>> Gentle remainder for review.
>>> You sent this 2 days ago, right?
>>>
>>> Please take the time to review other commits on the miailing list if you
>>> wish to see your patches get reviewed faster, to help reduce the
>>> workload of people reviewing your changes.
>>>
>>> Otherwise just wait for people to get to it, what is the rush here?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi Greg,
>>
>>
>> There is no rush. I understand that the review will take time and I
>> apologize for any inconvenience caused by sending the reminder email.
> Great, during that time, please do some patch reviews of the changes on
> the mailing list to help us out.
>
> thanks,
>
> greg k-h

Hi Greg,

Sure, I will try to contribute on reviewing other patches.

Thanks,
Selva
>

