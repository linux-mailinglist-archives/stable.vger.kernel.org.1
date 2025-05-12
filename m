Return-Path: <stable+bounces-144013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472FFAB43AE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A444A4AF9
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABA29711B;
	Mon, 12 May 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkBqZqMn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB329711E
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074980; cv=none; b=YqQnEr/lLXiZQaaJs9XdOAGYcDm2JqTySOChlfKDQ8j0HU4Hx6YycB7/C+osBWQsq+3XGAivGaKRp0Y2jVOtIoeY+SF7P1iV89x5043W4ge9zPQIBhZ2FpbkCXKSaGnwzHiQ/7X5+pLjEfIyBR8VnDUfVKq7sm85Ia1hT7nk9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074980; c=relaxed/simple;
	bh=jaHk7VrQ4nANABdlOUICEMjGVZ7+26En29DDJCb9Weo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTWZjdcAfVTnUMoZ2QWFLS9PYOd/ekQ0TR3IkkJ6+0UN+NHHrtcdyq70BrEL2ckdl3xWCltsDPX4sIBvEfd/0L+HaSfTQNkf5eyYkyTJTAYWKZRCkNVqrldeBJ69Q7vT/ExOAXo0kIclBdnGDq9OuNjPIpxrTXwuETOdAhB1VNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkBqZqMn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CDsw0O010634
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ua+j4+iYABTDoLL3xkPGvYtLna9rjbpRaD3utkRBGyE=; b=dkBqZqMnXwWQhD05
	0xW3SO+47D5/01khApaIXKjaopHda1iNNSfej1Oc41A8dRBJUvpms+JmiZWU3wtu
	vNukqUtXYabMuZKXEaSS6WUuFglIZzad8ovSJoTtBqK/Vf8gxSXZVNoz6w+m6Ots
	x2pmJgOeVDIwgXdlphiix5LPrQ3rTGkJzoenA8KNMcyl2aJKQdAo0qr2vONW1vei
	p+aIpfCaw6sorLz/jyWWXHSEbInlyEauUOL83eA4FG2oPrWSgUQLQIyQsQ31KWWC
	l+tclPC4jKgfiUabz9tN5nNhi9EUftaD6+yEP2anwqzReqqANagyJxAISIkJ4/IL
	ntWr+A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46kc3mt3f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:36:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b269789425bso1963098a12.0
        for <stable@vger.kernel.org>; Mon, 12 May 2025 11:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747074978; x=1747679778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua+j4+iYABTDoLL3xkPGvYtLna9rjbpRaD3utkRBGyE=;
        b=uwor9yrI9TQjxvGHRVMwfSWIFg6MxWI+SHt+E6N8PZ90v4xQEDfeI0vpbHUHgIygP0
         SMyAPNyM9aviGvkuB3txLHuDaygyjGeVJ+XIkEyvhzgsyghM4mOPww4pWECjVlmtuR2F
         cqwiMtIRJL2KJk65qhe+nKxbwaWL1tHxEhTLqdqZPxEQhtgHAiOURGsvLl0o3SvdU6W5
         dOkrT9lpj9QzWhro3i4sv7dnN9FE6XPLRvEeRuurZodJggEgYU77fIPJkm4/rCUTrmfO
         yEoepTMGy+e9TjfECsJ8ZJDy/AhPGSsumHGNuA3zymdw7Z0dSX1kEHxJwL5IXyR8Ru9g
         X/6Q==
X-Gm-Message-State: AOJu0YzpWxfzBxklj3JgK9/kNeP83kuhVNgTgqcMEi99pyLWCf7cLakC
	nrC5OAgcwi2Z/oYAHitT4OEMuRfW6eZ1wicK0Is4IVPMQXwAuk1Xik781Vr3DdLhD4/USv6gCh5
	P4QOvxcQQh3BGqeezAti00YPj4wee26R1LN8FG5sej1OZ3mdxxAFCNMI=
X-Gm-Gg: ASbGnctF05BBn+1ajY5YonDeM3U8U2ZN94jwT+0S81MlCvb3tv3fooaCCw1PHt0PnHW
	E9ePPVqrwiHq9j/DbhvmbXVoOoauAjnKonKpajuhoV8ZmxjW2FZ5GLS41qE7la77i0AIBx+RiYB
	uVLQI3Rxs8dmERXJ9fmbo9PEdpvDFDVWHyHxL5vINZ5X/7ulsYWohpkxeD0Jf/jX0w23xNqDht2
	WYIgJYNzHYI0FpAOUIPOVMtnAKag7PFtueCMhVQZWcAXKdNfWobEOERMzn+NIbPx7xmEJSDI78w
	ggZP38uMnDuy5RmfKD7TIfVJGnztrPcA7s/AN0eS/fmhMtYktIaKJbLcmzTCGA==
X-Received: by 2002:a17:902:ec87:b0:220:d078:eb33 with SMTP id d9443c01a7336-22fc8e990ffmr212504965ad.36.1747074977907;
        Mon, 12 May 2025 11:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb9eNA28YjCJt9lz3SJrMVGfwzv15037eo9H8POuKZy61L+gU6s4TwLgd+vSCL5plOLs8cZA==
X-Received: by 2002:a17:902:ec87:b0:220:d078:eb33 with SMTP id d9443c01a7336-22fc8e990ffmr212504655ad.36.1747074977543;
        Mon, 12 May 2025 11:36:17 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c01sm66156275ad.140.2025.05.12.11.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:36:17 -0700 (PDT)
Message-ID: <2432a3f0-871a-425d-8f89-94577cf0e493@oss.qualcomm.com>
Date: Mon, 12 May 2025 12:36:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Use firmware names from upstream repo
To: Lizhi Hou <lizhi.hou@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20250506092030.280276-1-jacek.lawrynowicz@linux.intel.com>
 <abf77771-ca6a-3b29-f5e7-fbb11c53844a@amd.com>
 <35f0d2b1-e958-44db-b4d2-978cd741c3ab@linux.intel.com>
 <08a17170-b991-f520-6aca-0690a28917a4@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <08a17170-b991-f520-6aca-0690a28917a4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _rgeLhVynzxSZDj0ygxSXo6h5O0akTxe
X-Proofpoint-GUID: _rgeLhVynzxSZDj0ygxSXo6h5O0akTxe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE5MSBTYWx0ZWRfX9HzFBaGzkXoJ
 kdiDH2QNRv+tB4tkygLsuYHvl8NcXFJM0lSLFzTZJvWWlr2d6RSVxqAOzq/3v51DkvPq6enq4Gh
 uQV59vMSeXCZ1JDYDRK+IqHzNcMWrGsXSs/1t9jaq8YFWSXa2rO1nzRIWkDlkps3qu7aLenfXJo
 JyH73LOE8G9OQ/xqLIJSwsFZQ7LF0jfx9re6Xle53O23czjYpNVVkNAiVGGVvczD2svO8KbvjD3
 NZhZ3IvpG94lC5UWNepr/ius7tfZzQsvXAN5PRdd8o0Cw8e58nSht3eeZJw/lL6mKv9QacRSQCO
 5uBi/E0TbP/oeGCb33Q3qgyljoQNXNbboAuhb1B9Hs1yGJwJfxbH4QDYgYA6CDFnp3YujZzHEhT
 6lQEpmM1/J8K7rE93CqwoJCg2Ufi6b053gdcsxmMBUvJ4fSzCcBwIV6NqkT3XW2b/J9BiSm9
X-Authority-Analysis: v=2.4 cv=afhhnQot c=1 sm=1 tr=0 ts=68223fa2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8 a=LTIWpQBfA_taFBiOom8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120191

On 5/7/2025 9:24 AM, Lizhi Hou wrote:
> 
> On 5/6/25 23:59, Jacek Lawrynowicz wrote:
>> Hi,
>>
>> On 5/6/2025 5:41 PM, Lizhi Hou wrote:
>>> On 5/6/25 02:20, Jacek Lawrynowicz wrote:
>>>> Use FW names from linux-firmware repo instead of deprecated ones.
>>>>
>>>> Fixes: c140244f0cfb ("accel/ivpu: Add initial Panther Lake support")
>>>> Cc: <stable@vger.kernel.org> # v6.13+
>>>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>>>> ---
>>>>    drivers/accel/ivpu/ivpu_fw.c | 12 ++++++------
>>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ 
>>>> ivpu_fw.c
>>>> index ccaaf6c100c02..9db741695401e 100644
>>>> --- a/drivers/accel/ivpu/ivpu_fw.c
>>>> +++ b/drivers/accel/ivpu/ivpu_fw.c
>>>> @@ -55,18 +55,18 @@ static struct {
>>>>        int gen;
>>>>        const char *name;
>>>>    } fw_names[] = {
>>>> -    { IVPU_HW_IP_37XX, "vpu_37xx.bin" },
>>>> +    { IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v1.bin" },
>>> What if old only vpu_37xx.bin is installed but not intel/vpu/ 
>>> vpu_37xx_v1?
>>>
>>> Maybe just put *_v1 line in front without removing { ..., 
>>> "vpu_37xx.bin"} ?
>>>
>> The vpu_37xx.bin style names were never released. This was only for 
>> developer convenience but it turns out that developers don't use this 
>> anymore, so it is safe to remove. Maybe it make sense to mention this 
>> in commit message :)
> 
> Sounds great.
> 
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

