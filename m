Return-Path: <stable+bounces-206149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49926CFE137
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9BEE30FF4A7
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E0330666;
	Wed,  7 Jan 2026 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCc7Z91m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YC0z4Dk8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD532D0F9
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793524; cv=none; b=hfPjy9TOl07PP9q13+CvDxdsv+AHc+Io0JURbflaLs9S1+lR849Kq6W4VnK7Z7QYSKLnu44AiZvKtHBMv6EbeaV3CMrXiyjehyZVGf9W3/eTlFjn9ZWKgGUyzwYrR1sFExA+q9SRFw+jIz0ZhlcuuAsC1d6uhzOdcT7nbLJfmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793524; c=relaxed/simple;
	bh=aGCwiMjQucIVEWY0xQeLko/RXdpi58+4bzprc6n0/A8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nhdEXHFrQzXOec+YxcsF9qp1HmQs9lxfY4aNJH8OdI+INUNAhEKgD3sngV4j7MtE1S9sKCzbycpFiW4v1JX5UsDIMIHi8NA8U4X5OWVbvUPbQqKlGT0gvENnXlPh76/hN92LPe2lM2GG8VKJloZFEMif0/q9ENkx0s6biu9el+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jCc7Z91m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YC0z4Dk8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6077ZmbP849477
	for <stable@vger.kernel.org>; Wed, 7 Jan 2026 13:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	reb7P+Z4F9Rso1KjoO5FFqyUpm285MI8JPuG1ZEw77Y=; b=jCc7Z91mv6uUGycu
	yyi6xxGoeqVIOjqiJooPhO25kxGXMufeqjiWYKU4uUgOJM870+bEbEB4gGu4oUkM
	s9cRqg9HjHYtrwBuwU0BkeCUeao60RUSG9c55XxeT6QEIqKswDcXXpPKlhjTZsvw
	At42zgByjTwllwd5LCa7lcHWKSyh94ysBIZc6xO2F9wavuEg5bqRiOA+BUWCkjzH
	A1+IoJ8O2epuzNbXkO6HvSRLs8me6kH4XOPyDzp9ahDsKccGYGyC8ATc8yZhxOSF
	qVnwFBn0rATjbBENesTBJsDybHDXb6vpasw8qvPYn8GM1tXkwxRIQ/23V1TnZ434
	CsTPzw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh66e3f9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 07 Jan 2026 13:45:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a360b8096so55609646d6.0
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 05:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767793520; x=1768398320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=reb7P+Z4F9Rso1KjoO5FFqyUpm285MI8JPuG1ZEw77Y=;
        b=YC0z4Dk8onwzWXo3iUqKgG7tDXkIE8/xNkIxtTuCouEUwxTM+bLPrle85lZYnvNF0E
         n4WFUoGMNexhwAn8mALEbHmA0p0B9OWE6mIeraRyolIkVtfIY+kMLJUf4Qsqg8d/15xd
         vnIf3IL1vSKLS5t6YcIT52DTPXR5faa6eVqqL9/U/oOZZ8gvBu2mc/4QYyM5Isfiv+oK
         kn8sTS/92ouc6xuVf/i0DNOIbjopOoB4a+HPA8O8xy9n6ZGqBklXT8974l4pVhbuoVZl
         WGBAY7t3X2ek3Y03U2esNq5qv9nypJgEG4U3ZCJObSBIH39LID0c9GNF7YPvICUssqJD
         5FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793520; x=1768398320;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reb7P+Z4F9Rso1KjoO5FFqyUpm285MI8JPuG1ZEw77Y=;
        b=FbHXNemhP05j3YCKV0w7ID9p+9C1OV3tQTxQW4EiM4N7SKLpXfST2npCl++wu932ff
         BhZsh4qFQrjXgAnsTemrnZy1MwPeKhJ5iyU1480hp/qAZ6PfXksyaIxrWsbVAMZbGQlm
         NW+wu0qnRf1bMrznnhZI2gUIN0FeLc/AxzTEqa/mD02QNOrIf6z26ghp4EMS98ZVdMkO
         cmQdDhcZ1H8H445KJFRmqP6mVo898RzoD13q1pnobqjUA51d7dU4qjCML5TSCf0odQIw
         fJS2SSITCWc99E1KxVkq19lZcEFBfkgmIchPu/kjIwqqQCsFVyz0ph4B3UFSda4UscGb
         nS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8yPOO3rWx4RIN9jndUQfVtcRd4AbtaUPzvQW+DeW7VKRj7KfskyJjrK5dUUle186pHeGanvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEEgde2xp7PJ7vrdXuQJfNkyc7lqJQqsdBuVM9TIKsT9pYQZH
	DHJfhfyAn2pR7sUiJLC2wyV1o+OdYHwO9+w2+5f1Q5fQdOV3nZQy/QBXYp1vjvjPLQLkFhlRDBO
	6Y4HEjpIe3CzzCvSecgkIHEc5tpWfU6v4vcCRGGASRO6wRpWzVPIV52gLboqcZTgVUQ4=
X-Gm-Gg: AY/fxX4Q8ZC6vlIHgh++Tg+3iR4Hz1sTT2H0zURCPEoRUhihZL8VKQPrrXXirUGEaC4
	OTKOnFO28z5iABXTi9VOcm4RWWEaMbFqFyT8+z0hkhJn8xoA03LIpYPEYbZKwg/Mz9z4NbLNI6q
	NTM+ELcvRlXh+TYsuDgly0CZNrmTotZ06y9ffQuQD3O/7E7fsq8bIsd7Xy1/qKkOZy8gWw9ptMj
	PmKFhQ5WkiSwPzM9K4Tvg/vBM87J0+cBhciwFIAuioQl8rImVl5T3wqhC0+Fz8j4qISXWdbQEIe
	4eGDyDByED3z3ez0XKA8Blqq4Uh3Vv5/A1ho83gqs3Qo2A/b11G4JPw9P4lU2/gHTs86auJz1Vr
	eNS+eXOGg+A1x7p4KvY1E932NmzBldNdObLv0al8ZccrMvCEDK0j8o1IEJjOXJN7wDiRgCfv/bF
	aBDsXUXuB6vYb96xo7k3d1+QWuH5dWm4kbMVX6fI8TmMkl8OWAQvcSTiFBw2ABUiE8a0OBeou8y
	tTd
X-Received: by 2002:ac8:5789:0:b0:4ef:c5cf:ec0e with SMTP id d75a77b69052e-4ffb4a2e169mr31482971cf.55.1767793520426;
        Wed, 07 Jan 2026 05:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGMKq0mnAStTW1LnpwiTNhIj2O2iuqd6K21QnslKXLwdTmgSebkevhEPXoAvVXGMXqS4aslg==
X-Received: by 2002:ac8:5789:0:b0:4ef:c5cf:ec0e with SMTP id d75a77b69052e-4ffb4a2e169mr31482481cf.55.1767793519817;
        Wed, 07 Jan 2026 05:45:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51183asm524113466b.49.2026.01.07.05.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 05:45:19 -0800 (PST)
Message-ID: <082db370-e6cb-45fd-aaf9-bcd9f80dc242@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 14:45:18 +0100
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
Content-Language: en-US, nl
In-Reply-To: <aV5IH7PIFnySHhYC@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMyBTYWx0ZWRfX2WgucRC4azMB
 3X/uGsYqMrlQDt8HATLxK83wOc5KCsdThm6CCigQ38RrMQyaxzWYAOI62UAdvtZaDg+vVsR4Z6f
 Trtusplj6gt1jqpBg2roKuyZ8rkaSiuo+h5Up7m6+HFFNbxizbnajEQwpoih9u010PaoZmOca0W
 ZByGJSRAY1vhzEDchgMPse9e5/pP7Yx2LvSeBjuFjaniJK5D+6asoFGCJkzB/QQOUt3ebMd6I9F
 R+OtIzO3gTCN2fbxPxm/bvR6p9LfpuD17nX8u/iPv+XhUPZr8Pbdb/jCRcR9w8iKeOwddW2Wk4h
 5FoVJXSdh+bAOMVkTayYPjB6yiMnFQY2G7E8RS6l3JRWhkHSXeITk4OknIszYbewZ3CeW15Gqp3
 vrj6I6f63nWDLjij2MdXlIFKrubm2uDsfxg06E8trW6CKiyxlCBGZ97fqgft/kSm7+bFB9IPzm1
 ZJ0q6oCwAQiORvA2o4A==
X-Proofpoint-GUID: EUgf0IF60muH4nKPDrwd70ouYGvy8axX
X-Proofpoint-ORIG-GUID: EUgf0IF60muH4nKPDrwd70ouYGvy8axX
X-Authority-Analysis: v=2.4 cv=evHSD4pX c=1 sm=1 tr=0 ts=695e6371 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0plRyFmWAAAA:8 a=ZF_BEzhm7KkGSk9pD-0A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=4tO_KGIOfzmgBqjB6OKc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070103

Hi Sakari,

On 7-Jan-26 12:48, Sakari Ailus wrote:
> Hi Hans,
> 
> On Wed, Dec 10, 2025 at 12:24:33PM +0100, Hans de Goede wrote:
>> The ov02c10 is capable of having its (crop) window shifted around with 1
>> pixel precision while streaming.
>>
>> This allows changing the x/y window coordinates when changing flipping to
>> preserve the bayer-pattern.
> 
> Ideally we'd use the crop selection to configure this, but given these
> sensors (and drivers) are generally what they are, I guess this is probably
> a reasonable way to go.

Even in sensor drivers where we allow setting the crop selection
to get arbritrary modes, we always round the coordinates to a multiple
of 2, to avoid changing the bayer-pattern seen by userspace when
userspace changes the crop. See e.g. ov2680_set_selection().

And then when doing flipping we might add 1 to either the x and/or y
coordinate to the userspace provided crop x, y before sending it to
the sensor to make flipping not change the bayer order, see e.g.
ov01a10_set_hflip() after the v2 series you've here:

https://git.retiisi.eu/?p=~sailus/linux.git;a=shortlog;h=refs/heads/ov01a10

which does (simplified):

        offset = crop->left;
        if (hflip)
                offset++;

        cci_write(ov01a10->regmap, OV01A10_REG_X_WIN, offset, &ret);

IOW we are trying to not make userspace be able to affect the bayer-pattern
through setting the crop-selection and/or flip.

So I'm not sure what you mean with "Ideally we'd use the crop selection"
because we are actively trying to avoid to have the crop-selection change
the bayer order ?

Generally speaking I think we should avoid any settings change the bayer-order
whenever possible.

Regards,

Hans


here?





