Return-Path: <stable+bounces-210306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A428D3A619
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEE7530042B2
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54E3590BC;
	Mon, 19 Jan 2026 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3IlmLkL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLr4PIye"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099C3587A7
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820615; cv=none; b=ZPONOMU6cpDMixAQFYiH3dCf5FwVFLFmfiuaUpB4DZTRlTIGuDg1bFJTCsz8Y9chFm/0AbMUzhh/UGHtRPnOK9JxjYskB8rxtTAHa3udSoaclGyFprQ8i64KJMU67fUZkKvsAhzzFqEyCKJNToCjAhujW+I7Qwpg4loCNzf34s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820615; c=relaxed/simple;
	bh=qdZow0iIRdgkfYhOnDo9Dex4GvP/UuCwNCPNEWFUyoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGpV0hWef9cNckH35e4YpZ8pKFNQj6/u0AQE5LCAY+FfnP/jLGYe692iduQsGDky57Ry8/ppRWW/GHrTOdTlIlw063c3UU5InTD/n/SkUtH8BblgYR/4owb5vAj//D95SK53NLUtXUyB4HQkqsWPPT+B6LUoZs6UvSKRRtA2KuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3IlmLkL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLr4PIye; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J91Dfx1150083
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c1LOQNTiDOuTEop/KvOGER6fTNN+/DBF3R/IDkhgQ6s=; b=Q3IlmLkLDuPFJOKm
	FLbMRjbOPhn9e1QoktulrDirOtvqsbdpWfNaLu+/O/69+Gk1G/RcX1bQr8hCg/zJ
	WK4yUxsr/JLv6jx6jDreP2Fzj9Dg/JEF2w78eAgMJlOZhDpZIF12oBtW9xV380PN
	ePXFr8RwaE77HuOuljKhBjVu7NGIFdXotwQI4yOtBj1r8wLgPv74tDP6cw5TJo/o
	a8xyCvoGryQsFJ+3ULphI7r0cNZRF02APM0wgxo9SU1mubP9Ld7f456nQEZ8u0Z9
	m0SASsS/SkzvzWYBrn9jkO4GmBIHriV4u/vQPQGxw4eQaq0AxJ2w73djQVWPdBBv
	ZRRPkw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br04e56nm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:03:32 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f53036ac9so3213549b3a.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768820612; x=1769425412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1LOQNTiDOuTEop/KvOGER6fTNN+/DBF3R/IDkhgQ6s=;
        b=cLr4PIyeWziOH8tzB6nrkGZM65x2pmKrfc+YJ8aYmKEoJJA4mHp6eQ5k1TVrN6S3Mz
         48XfsP1Q+yrnORM0GIzKD7BJ3TSeOPOW+YkF7pRXd/AVTOudkt/Mibcj8ASPAPnYWR/i
         /aVwNpgwTFBUTgBrCWRJv+3mUpPIuJjTGDACen7RdX2xVLtg1lbYYuL8aZBH/CoJY1DQ
         iwL1y+2Z0TWeFNtO3WPwvbAnj9SRiU6fKTv5nG7wizCkuPLbz+WnbxiYiIDYQ440waFP
         pXyOm+3+MoZkeTPP98w9UHPvZWtIgAsrFgrYRnnUssS5dXIdkSsTEhY2njSdSHX1ZxmQ
         +3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820612; x=1769425412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1LOQNTiDOuTEop/KvOGER6fTNN+/DBF3R/IDkhgQ6s=;
        b=CoOzhXJuU1NwXzxLwjEEmN4aIWo5WWE8wsGWNzeKN0FBHWNIkLD8dsJagFIuHFk7By
         whXpUn58zdH1+On5qtWmCMKb07w/fa38XcbMgLYABsITcwAri08VB2rwtxIci9MNOe85
         Y3bF/d3GEaLgJ3fUJBTVa/1l6IxUoHQ3Yr/RcQem3CAcRsPBz8igWJL11rOkNIVpbGiJ
         NvBs4B2+9fAj2XE/pem/pblbrVLiKTzBRAzNVI6YF34Jffy/fmK4mbd/qiE5HjlWRwcH
         R83v1H/ar8E1UmPzFmp74ZKCuvCXmJI5G+AB5wdYscdGdFxepxxc0Fd5Rr5i47zHT2Qj
         cXBw==
X-Forwarded-Encrypted: i=1; AJvYcCUUP0lNl53f5WwW692j+Jx51DoEkkR1y/aunIQUFFJjO0YVPTR5DVgQkc/KesU0idXbJMy/MRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK77maYVNxWduMrDxxqfdPJhpqqhka2vkPzGfofgkDZzhs81wf
	oYDUrvfD2AOgcC+8vNZ1k5xJWW4MvwjvUyUplRx51azoCa3JuAkAqhNemKVkVUuOj2icJD4C+GR
	sU7t9vZvw8c3NlWjtOOKMEokDo5epIf+SUUgsYlo3dKmVuED7X7HLwTxGmZI=
X-Gm-Gg: AY/fxX5D1vE4COsxBnY11ROTG55EZ/0wv1shd7GSaFyuHIxsYj2CIlHeJbIsplSHK/M
	UrONC4CjXkHgujqb7RGHxty67faOv+izOdtuJERyhFl+/7mIOGO/kkDCxbtgXZ3TSVRkfxjiIoD
	r8JyViEZItlCPYi6VrugoQDFEKJmlOqsBAI6qDFKvF68MH+8WLzPDVZ+i8YU8Gd2iNUYbEDmmAU
	WSeGMEnLrd9TeU8rQq6GPtc17nckNWS41IFbwHxfnH7rrCozsPyGfJnFDlcqS1i7eM7NOlVYgtX
	WqlCMGrDD40n9AxUu0E4V99AJumbKqllztdseB8AOM4O/HocRhodeCIaHwyJdVoDzzR9rZGuSIV
	fswO79K3ORn2swRUI4pvFqK0x/OhFdd4fO/o=
X-Received: by 2002:a05:6a00:440d:b0:81f:3f6e:166 with SMTP id d2e1a72fcca58-81fa030fcabmr8923182b3a.46.1768820611449;
        Mon, 19 Jan 2026 03:03:31 -0800 (PST)
X-Received: by 2002:a05:6a00:440d:b0:81f:3f6e:166 with SMTP id d2e1a72fcca58-81fa030fcabmr8923164b3a.46.1768820610869;
        Mon, 19 Jan 2026 03:03:30 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a15sm8994060b3a.42.2026.01.19.03.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:03:30 -0800 (PST)
Message-ID: <148f8566-2d99-4fc4-a934-5b7d1bcd5a20@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:03:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
 <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com>
 <212ec89d-0acd-4759-a793-3f25a5fbe778@oss.qualcomm.com>
 <CAMRc=MdoUvcMrMga6nNYt8d-o8P-r3M_xY_JHznP3ffmZv8vkQ@mail.gmail.com>
 <96472b7c-9288-4f81-9673-d91376189a18@oss.qualcomm.com>
 <CABBYNZ+5ry0FWFSgOskw60jja9mE6WG5AwOi2pKxrkzqMn9bkQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+5ry0FWFSgOskw60jja9mE6WG5AwOi2pKxrkzqMn9bkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J5OnLQnS c=1 sm=1 tr=0 ts=696e0f84 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=oRiKqNWV6AETYgLPPlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5MSBTYWx0ZWRfX2E9BOzJAvY5L
 dPlI+hZ8DvhCcHYD0zR+eKgaR6jU/uZkoqSUFnYaJcaTNzKTzXSb/BECfMlzwkS8UMY1wJZo6ia
 sUwOAgSapP9ZnqrYBkNU6MfWURsOulqZucbi0vfUV64PabKdI9ub0Tow6Dlyq/RAZBfP15bDijn
 FS4Vesd1p0Zup5dJY22sk44eojdXdmr5aYyQLLsbiswc4q8MI+Eb16/rLplouTzF7dX2vBO++UK
 jvIuCugexz8W5U3SQ05eiSSuyW32sILOAdqR220xUD+vA4AjcTkUae9z0EjDzAKwkTXZOpCAPml
 Ex/31bVH73BTbAA/xSbGdfIFfr4jr7JUKYHFFn2f0sPinUb5TaWouzB37p3ystdnwAyWw6+2+bX
 GVBv0upDPDMIkUp8FFZfpLcDFgCTwzHfQrpjWE2JO2IkvyzVRFpTWCX6RIgg7NT0JUNVfCW2E5W
 hYfefKe0nq41MZ4QYPg==
X-Proofpoint-GUID: TFFeSC5VOl6Y1gUiHk9pk-MLhvUbH7tU
X-Proofpoint-ORIG-GUID: TFFeSC5VOl6Y1gUiHk9pk-MLhvUbH7tU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190091

Hi  Luiz

On 1/16/2026 10:42 PM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Fri, Jan 16, 2026 at 4:48 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> Hi Luiz, Marcel
>>
>> On 1/16/2026 5:20 PM, Bartosz Golaszewski wrote:
>>> On Fri, Jan 16, 2026 at 9:37 AM Shuai Zhang
>>> <shuai.zhang@oss.qualcomm.com> wrote:
>>>> Hi Bartosz
>>>>
>>>> On 11/7/2025 11:37 PM, Bartosz Golaszewski wrote:
>>>>> On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.com> said:
>>>>>> This patch series fixes delayed hw_error handling during SSR.
>>>>>>
>>>>>> Patch 1 adds a wakeup to ensure hw_error is processed promptly after coredump collection.
>>>>>> Patch 2 corrects the timeout unit from jiffies to ms.
>>>>>>
>>>>>> Changes v3:
>>>>>> - patch2 add Fixes tag
>>>>>> - Link to v2
>>>>>>      https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>>>>>
>>>>>> Changes v2:
>>>>>> - Split timeout conversion into a separate patch.
>>>>>> - Clarified commit messages and added test case description.
>>>>>> - Link to v1
>>>>>>      https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>>>>>>
>>>>>> Shuai Zhang (2):
>>>>>>      Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup
>>>>>>        during SSR
>>>>>>      Bluetooth: hci_qca: Convert timeout from jiffies to ms
>>>>>>
>>>>>>     drivers/bluetooth/hci_qca.c | 6 +++---
>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> --
>>>>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>     Just a gentle ping. This patch series has been Acked but I haven’t
>>>> seen it picked up by linux-next.
>>>>
>>>> Do you need anything else from me?
>>> I don't pick up bluetooth patches, Luiz or Marcel do.
>>>
>>> Thanks,
>>> Bartosz
>> Could you please help clarify this?
> There were no Fixes: or Cc: Stable in your changes to indicate they
> need to be applied to the currently RC and stable trees, in which case
> it will only be merged to next-next at a later stage.
>
> If that is not correct then lets us know if that needs either a Fixes
> or stable tag so I can send a pull request immediately.

I saw that it has already been acked-by, but I don’t see this change in 
linux-next.

>> Thanks，
>>
>> Shuai
>>
>

