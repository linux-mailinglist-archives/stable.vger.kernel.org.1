Return-Path: <stable+bounces-127377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A29A78757
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 06:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890861891F9D
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 04:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C419F22DF9B;
	Wed,  2 Apr 2025 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5h3c8EX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0FA2F4A
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743568976; cv=none; b=SK+TJIqNJiZKTWAUsgj3fXe1xtc0NzSwLSwy7QghBsEp7WZlJpRSwKZf19Os/GkTI4UHX56r5pNQRlGvKDp/2ju7u6fgrOT3Z9fQvcf7vpG1qV496D0rSkQH4dAYMqNFreFrKUIfZX4z2hdXrdTnlwxm7ARCUblZhjetI/9yWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743568976; c=relaxed/simple;
	bh=qZYwJH7+q22j/uTOz04w3vnQHZFCKfxkJPGcjgjE6d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDQwTErM6AEVASAYxCufPuTwJkZC9MCStpmBxuLppjdvV0EThFLEG2nTXaAdULbmkY9d1MTUMOKnomYTye+sZCztlfbrYDhB6WsyQTUTKpnBCtStTc8TNmIYYm6YQxSNpE9jREK53ystqFA+f9LaYEPDGYlcM4VTiPJXtGHDHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5h3c8EX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5320TpKn032704
	for <stable@vger.kernel.org>; Wed, 2 Apr 2025 04:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fsc/ia+3ekoWiUvTYhDO0IcUlCjl3N229EoDeW2bErU=; b=B5h3c8EXGjZroHdw
	b7U54eLHGo8qm1AioH4ij9Wslkp1ranXN+kDGBJtXf73+cW0PPwOc1beCzxegwWY
	UL+cRMAY3LW9pvHBUh3OVvn9twbkKotCNw2a5yeWKsjjCghRdbD0fm7/MXQd6C6v
	B8xrU4Bfw7XCaxDxAZXRkA86XBWV2zS/Rel5/HJocZAUe6msvJKRJq1IUwlP5cdX
	Ch2uMldyEBOxiP4hDGxiqZ5+DWWhFavmhOZEI3e8YJcE5KLV0gXD7HtsAc1bcIOX
	Th3e5yXXN7mW617xTJb4uXssjcbd9ofbefwFl6Q4tGrxMjDbgE5X07o4G8UQy46W
	RheGQQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qjdgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 02 Apr 2025 04:42:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227ea16b03dso178399095ad.3
        for <stable@vger.kernel.org>; Tue, 01 Apr 2025 21:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743568970; x=1744173770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsc/ia+3ekoWiUvTYhDO0IcUlCjl3N229EoDeW2bErU=;
        b=QqcVf6+96iukA585GvgRXaDv5DBR+bxDeiCXGVNWLg8V0a/VG4/TQjUOE19UmEE7tC
         4ACIHY62XIRT5vDRdbdh4P7rwkSu+1ZB5TxBy9lOTww4Gi8+YXFuuDGABTL0XvQeBfoS
         D/t0XkWLHaK8yeHpAuNU8qzEzJ2D8o7J0qTQbeDRKewSgFonO2K2UPC7Q/TXMztWlINp
         d1MKyNfcMxQ3qttd9K6xMJiQ+izzH55/KBwy3miZDG4yUAAl/dnjFQbNzPCgepHuIDK+
         5yPjPUpmPKvtp+inovAId/dDAXlKNu0JgxJX5nHqhnO8xOHS7am8URI1XVVFE4rvJZwe
         PRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtM9CXErOQa9NU1AClsucxHWvowK37bLhFlGzLh2goY/rQBIPaaetL2lTr2xk+dYa85sTk5XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/G5skbnPTTx9K74gpGDzOySrZ2pvekOFa523LR4ysh7FEtnY8
	4+Wx44cix/3HuPnHHcfKA7W4/KkJ/oaj84W6LXoIolDhzzrXqky8ahOnX7IJErwcDyYVMnOiULP
	scFODMUCAXrG+pkgjr5t5Z0f+QOw7lfC7VeUBfKTH+i23GCnfxZFoXNY=
X-Gm-Gg: ASbGncv8TPfaGWxylQSzARiazZobTYutGbu7fscDxr7Mo7Z6Z8Pu2UvRSvkj+5Yyj0s
	Pjpbfv5XmwfgjSBDTQFvP8UZdz8fvOaO5pumUqF8hs/mIel+bTmK45mUWHZMh1goN8+T0FffDO/
	EdoKcohbnhTINFIUxk0LJ6P87uUxirtgEwWp8WNNbfOOzduVQIezorShVI4C6KszAs299Xbc8Su
	9izoARaX2zG/QzFC4+tVsGRYwyG9Tvsmmbekm81D6SxQ4GWJUnD5qrgvmgnNJydCNuA8kOsvww9
	HvCFRX9JfLhS+UhedUk6kpYdTSVyHu3jN6q4TnY2qufg
X-Received: by 2002:a05:6a00:852:b0:736:48d1:57f7 with SMTP id d2e1a72fcca58-7398036737cmr20072275b3a.7.1743568970533;
        Tue, 01 Apr 2025 21:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ELsL2QdK6nHfiqIA5vZv80dty9X8RSjij14cKDuVlA2qtjsFx42IogqS87E3RtSAUR5DFw==
X-Received: by 2002:a05:6a00:852:b0:736:48d1:57f7 with SMTP id d2e1a72fcca58-7398036737cmr20072249b3a.7.1743568970031;
        Tue, 01 Apr 2025 21:42:50 -0700 (PDT)
Received: from [10.218.44.4] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e27129sm10235002b3a.57.2025.04.01.21.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 21:42:49 -0700 (PDT)
Message-ID: <4d9226a9-d89d-4441-9dbf-f76ebce49a9e@oss.qualcomm.com>
Date: Wed, 2 Apr 2025 10:12:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Frode Isaksen <fisaksen@baylibre.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Frode Isaksen <frode@meta.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250328104930.2179123-1-fisaksen@baylibre.com>
 <0767d38d-179a-4c5e-9dfe-fef847d1354d@oss.qualcomm.com>
 <d21c87f4-0e26-41e1-a114-7fb982d0fd34@baylibre.com>
 <a1ccb48d-8c32-42bf-885f-22f3b1ca147b@oss.qualcomm.com>
 <20250401233625.6jtsauyqkzqej3uj@synopsys.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20250401233625.6jtsauyqkzqej3uj@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ecc04c cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=VabnemYjAAAA:8 a=m5ogOnp4AejF7vqX9dAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: wtg3l8z_RwVe7A7kZ0I_mosJeymA3OfX
X-Proofpoint-GUID: wtg3l8z_RwVe7A7kZ0I_mosJeymA3OfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020028



On 4/2/2025 5:06 AM, Thinh Nguyen wrote:
> Hi Frode,
> 
> On Tue, Apr 01, 2025, Krishna Kurapati wrote:
>>
>>
>> On 4/1/2025 5:38 PM, Frode Isaksen wrote:
>>> On 4/1/25 7:43 AM, Krishna Kurapati wrote:
>>>>
>>>>
>>>> On 3/28/2025 4:14 PM, Frode Isaksen wrote:
>>>>> From: Frode Isaksen <frode@meta.com>
>>>>>
>>>>> The event count is read from register DWC3_GEVNTCOUNT.
>>>>> There is a check for the count being zero, but not for exceeding the
>>>>> event buffer length.
>>>>> Check that event count does not exceed event buffer length,
>>>>> avoiding an out-of-bounds access when memcpy'ing the event.
>>>>> Crash log:
>>>>> Unable to handle kernel paging request at virtual address
>>>>> ffffffc0129be000
>>>>> pc : __memcpy+0x114/0x180
>>>>> lr : dwc3_check_event_buf+0xec/0x348
>>>>> x3 : 0000000000000030 x2 : 000000000000dfc4
>>>>> x1 : ffffffc0129be000 x0 : ffffff87aad60080
>>>>> Call trace:
>>>>> __memcpy+0x114/0x180
>>>>> dwc3_interrupt+0x24/0x34
>>>>>
>>>>> Signed-off-by: Frode Isaksen <frode@meta.com>
>>>>> Fixes: ebbb2d59398f ("usb: dwc3: gadget: use evt->cache for
>>>>> processing events")
>>>>> Cc: stable@vger.kernel.org
>>>>> ---
>>>>> v1 -> v2: Added Fixes and Cc tag.
>>>>>
>>>>> This bug was discovered, tested and fixed (no more crashes seen)
>>>>> on Meta Quest 3 device.
>>>>> Also tested on T.I. AM62x board.
>>>>>
>>>>>    drivers/usb/dwc3/gadget.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>> index 63fef4a1a498..548e112167f3 100644
>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>> @@ -4564,7 +4564,7 @@ static irqreturn_t
>>>>> dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>>>>>          count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>>>>>        count &= DWC3_GEVNTCOUNT_MASK;
>>>>> -    if (!count)
>>>>> +    if (!count || count > evt->length)
>>>>>            return IRQ_NONE;
>>>>>          evt->count = count;
>>>>
>>>>
>>>> I did see this issue previously ([1] on 5.10) on SAR2130 (upstreamed
>>>> recently). Can you help check if the issue is same on your end if
>>>> you can reproduce it easily. Thinh also provided some debug pointers
>>>> to check suspecting it to be a HW issue.
>>>
>>> Seems to be exactly the same issue, and your fix looks OK as well. I'm
>>> happy to abandon my patch and let yo provide the fix.
>>>
>>
>> NAK. I tried to skip copying data beyond 4K which is not the right approach.
>> Thinh was tending more towards your line of code changes. So your code looks
>> fine, but an error log indicating the presence of this issue might be
>> helpful.
>>
>>> Note that I am not able to reproduce this locally and it happens very
>>> seldom.
>>>
>>
>> It was very hard to reproduce this issue. Only two instances reported on
>> SAR2130 on my end.
>>
> 
> I still wonder what's current behavior of the HW to properly respond
> here. If the device is dead, register read often returns all Fs, which
> may be the case you're seeing here. If so, we should properly prevent
> the driver from accessing the device and properly teardown the driver.
> 
> If this is a momentary bleep/lost of power in the device, perhaps your
> change here is sufficient and the driver can continue to access the
> device.
> 
> With the difficulty of reproducing this issue, can you confirm that the
> device still operates properly after this change?

Unfortunately, I did not test this particular change of returning when 
ev count is invalid. I stress tested the change of copying only 4K [1], 
but didn't see any issue. I suspect we didn't hit the issue later again 
in the course of 14 day testing.

[1]: 
https://lore.kernel.org/all/20230521100330.22478-1-quic_kriskura@quicinc.com/

Regards,
Krishna,



