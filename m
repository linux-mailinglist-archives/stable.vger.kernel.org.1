Return-Path: <stable+bounces-206272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1323D03EEC
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5441430B8A4A
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FCC34D4DA;
	Thu,  8 Jan 2026 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="muJlowqL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E1zvan0o"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C234D4EF
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861510; cv=none; b=R441e8ZVqW84EcVb3s/xI89E0vuvWMGfZisiw19IOC4ztPjJsvHo0RT+m/8scmhD6/ugcwQVO8JIt+Ace+Yk6YFGf2FFJv+Y4fEiiODQ1MEPjMeW8gBKx9Aby/qpWShQuFIQ7CxEt7/XJfNQ5RFprneoZFtHw266b+ltfS++7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861510; c=relaxed/simple;
	bh=dnxiXQYK80rSiXRNHY/VGckOGY1aglKhHVXjrY71uj4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r1D/jqtungk7dNwcl6KrBzdj5yJDtLpD8rWxAG5Vd46Z+0jYmGRv2UL5XMBZhOlrmw992YxlWLThQDH12ffKw3rdV9VIbjXxdxupKn6XaVWXOjWgbvqRRXo5jLKuJGQL99ujUHimVljnwZT+St+Q5UrG1sxBa3nlxwdh0ky3qlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=muJlowqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E1zvan0o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6087VNT81837902
	for <stable@vger.kernel.org>; Thu, 8 Jan 2026 08:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W2QAqBe4+df3ACm1vz0AjqspTh3AnoBx6LJBN1OW9aA=; b=muJlowqLr2D2Uq0e
	uDLhom7zbbM1Bq1fUSXJARL0tYzzpZJdYFGc0qDp1tjkpZDM1IxuFlyqfFYnXUNi
	hhayzUrGVXBPGbN5HCLHYj6yKVNaqUt8wmX+vm6R04B9exfCz2Hh8CTMPtLMbNoW
	swCiTwz+rlZWgFh4ssfH7OsmRp6pM2OcvcCwVl1UUAkhWHi6y0eXYrLSd5dY3Rgc
	O9BL8XP9KBQl1SFfAzVntqA2k8VbMnXIYje0lSSvy1cLZXaKmEyNzuBi2pf54iwd
	WX03pWZaBOQvu8IujDdHKiJRsuFETQS6gaC7xxMJd/KXuOArlxtIwZaK5+BaVAww
	nSSj5g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj89205yu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Jan 2026 08:38:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2dbd36752so763590485a.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767861498; x=1768466298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W2QAqBe4+df3ACm1vz0AjqspTh3AnoBx6LJBN1OW9aA=;
        b=E1zvan0oyR8DRxHXwbzSLJXvyetZmsHfWSQCdybYyvH7TFpvz+OO+fIIfC88UECIEG
         p9Ik40+/myoPDwozPf9V+MYFBnj45fl7Fi31T9xunTV2j9HpY7BJPkfvC+Ya8S675CC2
         xnwwOlLHWfFgFDTgJ5pzAxH8TySCCXDXq+GhWhxMTyJFlJHcAyV0AH5wwFHz0dDnYcFF
         vITwzClNvawA8g18+pZhU1ZL8MhySpmkoXaxEqEqyilD3BjSWMmDxp7VqFvGQaIaQepX
         uxclUp/ExWf7vDhezBr+cz6J385jdVq5BCnpbYs6BA/Zem7Rs8pkDPOJbTlIUHRLs3Bj
         GcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861498; x=1768466298;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2QAqBe4+df3ACm1vz0AjqspTh3AnoBx6LJBN1OW9aA=;
        b=Dxpi0d+4gP7tBFjFw3Z7EoWiUTFTiN53ixZds1Nht6sF+4snQwoYKkNRYsnwnfkQYR
         coy5fu/PaSZnk7BWUcMRObF2pX714rVE+E1d0n/1+cP7Y8seXa3gMKXLqioUcy6HKf88
         3oYYWZhn3i74BErnRMhzKasr8we685UnNe8a0sLjws2Hn4C/bxGL27vtFa9uNlDrIqim
         Oe35vEIwRUeAJZ4Nf+DDJIZT186dpAaqO1eJXvAWqsMZRwE6zi2EZf7yWLZnZv/H6c2T
         8Ye2FIeI+SQk8dV9qfo+g877Fg8wX/6kcVgaZ50zEXHJ4ctoWexEu00Bl2bhOLuu8Lku
         0OwA==
X-Forwarded-Encrypted: i=1; AJvYcCUBhel2KjGoM2KDkxfv98516E+kDozajS6LINMBIwCOzaj4+B48oadrcj6r4NKtMJLzdo/coc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTkWZgFag657YjrbKTTukro/xN6q9PZ2/OXNF9Z0aO+BI6fcA
	VaQ+5FyRFH4ij+JP8PJjWjfchZ+JS6oD+IFLyrRwrqQcK+DwoSbg5G+qIbicSJAFDB0T6IVGahu
	EYvasD1w42Cs3uh1EUFg6n6R5yF96HN3eWrKKcz8iDIrCxcGtC6LBihVhZHo=
X-Gm-Gg: AY/fxX4Kyp28IT/xcnZMSVr3TnCwV9TlQO2qIK/3PXXoHd1D6JP/8ddZ+adVOr+p5MH
	eILFbitak+nQVnwlHKaip9FxS0rN6/sG9vzyLrltyUErtKl1sMAsgS5yA8rMg/nA6Y78wDch/1N
	c5XUKmP44J45+MfBe8rF3n3FZerWA1B4SVRDXzpCp1dOZ265PhlpQ7JDyw2z3YNoqxpRsMXxwgu
	bRImCnqFZJucs5/fBtBtxQC3PnChBey4Jivu7CMXfwajMWeASejt4y1WzdFQyzEBJFVFMd0aCJo
	2ltIUX3618GedUYnpS91IF0887yrhoDi+9+y7BBD7y/YOYGgfwcrlZiwBc3qrR/di0vW16HsyOi
	wk5qCF7KeJY6cG6xAbJqqQpom4VofoIdCGQQWt9pZeGk1613oUt+rni0tvmIB2r77WKWwQH8A3f
	/lU7+t7YXwcPCMqcQwNCEw+V0o8RhAHf/gOLRZh2FOiDeeN+S7Csy2o3Xarl/Ut9/ydMQqfFqxw
	7RA
X-Received: by 2002:a05:620a:1a13:b0:8b2:da84:7810 with SMTP id af79cd13be357-8c3893eb539mr681308485a.45.1767861498448;
        Thu, 08 Jan 2026 00:38:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUNx8Wpqvm/m8SkAAORxgp3y2mSrLPAiDvqPTKidErTtjL1Oa9i8NOTlt39F66vk9wrhfc7g==
X-Received: by 2002:a05:620a:1a13:b0:8b2:da84:7810 with SMTP id af79cd13be357-8c3893eb539mr681306885a.45.1767861497998;
        Thu, 08 Jan 2026 00:38:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b84591b6240sm202995366b.10.2026.01.08.00.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:38:17 -0800 (PST)
Message-ID: <4f42d0e4-6595-4838-bfc2-e690eb9e046f@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 09:38:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/5] media: ov02c10: Adjust x-win/y-win when changing
 flipping to preserve bayer-pattern
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans Verkuil <hverkuil@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-media@vger.kernel.org,
        stable@vger.kernel.org
References: <20251210112436.167212-1-johannes.goede@oss.qualcomm.com>
 <20251210112436.167212-3-johannes.goede@oss.qualcomm.com>
 <aV5IH7PIFnySHhYC@kekkonen.localdomain>
 <082db370-e6cb-45fd-aaf9-bcd9f80dc242@oss.qualcomm.com>
 <aV7R30bSVxXRxCok@kekkonen.localdomain>
Content-Language: en-US, nl
In-Reply-To: <aV7R30bSVxXRxCok@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M45A6iws c=1 sm=1 tr=0 ts=695f6cfb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0plRyFmWAAAA:8 a=j7Eb9WoC1qn-KjlAcRMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=4tO_KGIOfzmgBqjB6OKc:22
X-Proofpoint-ORIG-GUID: liexWJ_qFmvsK4q4R4_N-0Ogn9xOgGWc
X-Proofpoint-GUID: liexWJ_qFmvsK4q4R4_N-0Ogn9xOgGWc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1OCBTYWx0ZWRfX04rZuzVgjUay
 JtCV9JSPqEYlwkc0qOmBRzlPX+whC6jS9oCdmZ7OjOC9ilICKUGiyJQ0gzkcfw2tcBduDHAUrAL
 trsBK6R7uIRohegHCxF0X5jGkwL79cvbW+nkwlLhvHP7um3wGasH4N6cN/QB9qpVeqLYGjDgYL0
 RnCDIvMyvJdnkNTmnY6ckDT5vs2H1W5HPNfQhHIMnKcovS7hrAPXhw6xnAZeYpY60ng5kLGEyz3
 fbcNeTrry5zE3d66QFy30yXDF8t80xyWujxzS54r+t9HUNfiCZzoSLpHIHqCxrYInDgBRAl1qOG
 qFehOtynWJh451vvQyKzm7VZHKJvvSDBeXQ/MdkI0UWNVRNS207y/juhFi35IYWh3ZD1c0tLrrA
 /fS3pKLnJavzHHKRlUJ0GKjCgwTBMUcT4zTm8TGrOgYoKRWp90LNGmsxZ3emk5CtTfCMGjWMQaf
 svOTQE35hwBul5AvpSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080058

Hi,

On 7-Jan-26 22:36, Sakari Ailus wrote:
> Hi Hans,
> 
> On Wed, Jan 07, 2026 at 02:45:18PM +0100, Hans de Goede wrote:
>> Hi Sakari,
>>
>> On 7-Jan-26 12:48, Sakari Ailus wrote:
>>> Hi Hans,
>>>
>>> On Wed, Dec 10, 2025 at 12:24:33PM +0100, Hans de Goede wrote:
>>>> The ov02c10 is capable of having its (crop) window shifted around with 1
>>>> pixel precision while streaming.
>>>>
>>>> This allows changing the x/y window coordinates when changing flipping to
>>>> preserve the bayer-pattern.
>>>
>>> Ideally we'd use the crop selection to configure this, but given these
>>> sensors (and drivers) are generally what they are, I guess this is probably
>>> a reasonable way to go.
>>
>> Even in sensor drivers where we allow setting the crop selection
>> to get arbritrary modes, we always round the coordinates to a multiple
>> of 2, to avoid changing the bayer-pattern seen by userspace when
>> userspace changes the crop. See e.g. ov2680_set_selection().
>>
>> And then when doing flipping we might add 1 to either the x and/or y
>> coordinate to the userspace provided crop x, y before sending it to
>> the sensor to make flipping not change the bayer order, see e.g.
>> ov01a10_set_hflip() after the v2 series you've here:
>>
>> https://git.retiisi.eu/?p=~sailus/linux.git;a=shortlog;h=refs/heads/ov01a10
>>
>> which does (simplified):
>>
>>         offset = crop->left;
>>         if (hflip)
>>                 offset++;
>>
>>         cci_write(ov01a10->regmap, OV01A10_REG_X_WIN, offset, &ret);
>>
>> IOW we are trying to not make userspace be able to affect the bayer-pattern
>> through setting the crop-selection and/or flip.
>>
>> So I'm not sure what you mean with "Ideally we'd use the crop selection"
>> because we are actively trying to avoid to have the crop-selection change
>> the bayer order ?
>>
>> Generally speaking I think we should avoid any settings change the bayer-order
>> whenever possible.
> 
> That's up to the userspace. The UAPI allows to do either so why should the
> driver decide?
> 
> As noted, in this case providing that flexibility probably causes more
> hassle than any benefits, so I guess this is fine.

If we allow setting the crop selection with a 1 pixel precision drivers
need some equivalent of V4L2_CTRL_FLAG_MODIFY_LAYOUT for userspace, so IMHO
the UAPI does not allow this at the moment.

Also drivers would get extra complicated by needing to figure out which
bayer order to report as being active based on the crop selection.

I really so no use-case where we need the single precision crop selection.

So when you say "in this case providing that flexibility probably causes more
hassle than any benefits" I believe that statement applies more general then
just in this case.

Regards,

Hans


