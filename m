Return-Path: <stable+bounces-195051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B200C678CA
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 06:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95B0C36420D
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 05:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF72DBF48;
	Tue, 18 Nov 2025 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pxpe15Cl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CEjKUjSJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCB2DAFD5
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443194; cv=none; b=RgEdXVFOt7/WCMZYQYdUhafXA2VByR645Gu/eExlMR+fP88jXuFJJ8tnApOEYcwLyQmwJdW/qvS0t5bvhN/vcYJ/bPTSwWOXcq9pwihsLAtI21y+izu8dTvewZ61hUQzHNPSh6t5bULVK7Fyn9wNpb81N2wsD+gSHDsUBTMUqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443194; c=relaxed/simple;
	bh=y+hNdMziUZsXoMTDqc6UvVGzGcUSGcuFZ9JnzJrcSyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reYV703c3HbiVB4vEdBsZek22vyPGXOEWLBY9cFM10Mj4JX+/xWP1uDBZHTp8WSqPl0Q6xGTIbvLRXaSEesySGEhextYtE0Y8bq56ZHYpdFYvGpLdztpXGiwW86LBZ9nb9aRgCzVk4zziigd14/x0poAI2g/NPxgSH1xrEzp+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pxpe15Cl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CEjKUjSJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI1LsQa375896
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 05:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	57z4SrKQM6TZzN7beQkVXWrXc+W6p5O++YcxoOKVJms=; b=Pxpe15Cl5ncVnNFC
	Al6eEaOp4QDrEKr5IPidHS/6GvbM4IOtwYHDj8Q0BAoZYv6RYEwdTJrWd4xEO0QG
	Z9cJbfgUWjFdh5rPEmJqQTrltMACdKsMpW/f8PsmHgnSkgIEwO82nxMJPq1BqdoO
	LjdtU6lryevext+IT1sRUGVPGdEMhepBTS58XXBO4B/5H4cV8QF2ZWQyHjHdJl5L
	e+m5RSM1Vw4USMWzQp0CHiLQLh6UHSigxlx9RaaV7m1WhcwVSaPw9mtDfSzLC5I4
	5YWDXMgVqh5XzZ/DAr4DRmTn1gA5hyCvbzBnCPTids27b4GtM8Y6tckVJoTHsZ6K
	5uDCyQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag599a8rw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 05:19:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2955555f73dso57633695ad.0
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 21:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763443190; x=1764047990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57z4SrKQM6TZzN7beQkVXWrXc+W6p5O++YcxoOKVJms=;
        b=CEjKUjSJ6BUYpdXdmVa1/NEvhlsvEvdshQ3fLEFlE6y7wJhCDi7AGjHAHo947ZD9HV
         28XxYFjY7m7y5b3VgXPFFHQkAULH4YfYz7FSDKDbF8yCuri4C+7hjXy5Z4T5upztMWQW
         d5IuEnueYhDYiNBl9X4Rfj68vrYqwFWJNToy1/aLp5qi+YM8G66MVZvqIj+EHakkmqSK
         LeycX6gt3odZ/d5rGwb/txA8eVubUoaFpZHI6IKsLzbTiDd551uSaLrNQuRWwd2S1Obg
         q3bqZ+ZjBDcwq8SZ54jxHKGVvkAJ8VG59S1uwiq8ENBbUKefJrOf0OHWpa6b9oDIpIa7
         HCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763443190; x=1764047990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57z4SrKQM6TZzN7beQkVXWrXc+W6p5O++YcxoOKVJms=;
        b=AqN3hJlHNiChKunU9U3LaEmE+Rwdmodz0bIYTTZNhO7EOS/1/IXNxAOSg/jY2F4Bj+
         j3fnxjZ/ocYwXGr8ywcKyolpXm7WSuAzmTnLk9tw4RzAVf/0u50MQXaAmvqo44Cf2Bkf
         UvMbxR53PIJLAFX/SvrgZK6xnBSmlUeJjCDoSodDvA1inBkM2TO3W2A2F02drFcZZ66r
         GFloacLG9gHrZUgg9SokI1igoDIlQUBuSM9ozyHIsxcpdPcChiZJpbyR2vFjDl23nKfq
         JLY8b+M5r5h4Cx42BKHQn2auuHDwqdmN7arBCKe7M8UZTfwwoRrp61TqWZ5Refs1lPa1
         NulA==
X-Forwarded-Encrypted: i=1; AJvYcCUkt50uMYd/JPqIm1fQXvbilqMsD/5bl0HS47/wTj75hwsQ1JSF0ew7lhEzKZbzvrF2wgEjVKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvoA5FV8mHki3UcyoWJmqPncydl22WxANBW+CD2B3ecF8fKgu
	KQcA9746U9EiCqBbhtNn6qZadOa4QGS/7zOdHwLAXyYVz2rMJJL1Z4JiUqtn7UWFAvgYfn7a21j
	OPzHOQmSJ4y7DPY2BbJnBTFg0zGs7HujHnCZ5Mgb1zNNIckU4XNMT4U7X8ys=
X-Gm-Gg: ASbGncvjkwi2VhGaJEaSEbqPAI8DX1Em3IQQWsun7iJyvlKfq/AW7LOhaJsOFH1LB7V
	9kic8NzhQwyrktOjPwB8bQcP2MbpchPO92dJ1fYaCHmRjga1Uucz/jX4bN7uLqqtcKjWaVrc6/+
	DgyFuweH6f767oQ8Z9rTzH77Xc1JJ/D/q3QoCODf8ZLHKPsSVJ+58+KMVZNWqq66Oc0OCSGcJCw
	o1BKX3ykwDwF+J5ysGrRQLz5d7dPLuYxe3Qzw2ZbBxdMBbq0rbu3/xsNPSbvfWD4oCAjV66hP2e
	mvn+8qawlbkNVm0CeE+P3WI6vKZKpEePa/dl44Xx4otvlc/WQqOQjxpnjiilpx2i1tYA07IS9qU
	ZC9ZAQ1Qi6y7r7ZiOS4ChQK4wtgcf4De4BvahcuKcnw==
X-Received: by 2002:a17:903:234a:b0:297:dad8:f25b with SMTP id d9443c01a7336-2986a5fd92fmr183070375ad.0.1763443190497;
        Mon, 17 Nov 2025 21:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGv5jY0zpKeAWA9IEVwbsWiYKJ44Tawy9pEXbBERoxGM1hA76PxMEyJAcPgQzAr283dziYRQ==
X-Received: by 2002:a17:903:234a:b0:297:dad8:f25b with SMTP id d9443c01a7336-2986a5fd92fmr183070015ad.0.1763443190027;
        Mon, 17 Nov 2025 21:19:50 -0800 (PST)
Received: from [10.0.0.3] ([106.222.230.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2c103asm158597555ad.96.2025.11.17.21.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 21:19:49 -0800 (PST)
Message-ID: <6f9be486-364f-cfa8-0a3b-ccc3967bbd5d@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 10:49:45 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: iris: Fix ffmpeg corrupted frame error
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        vikash.garodia@oss.qualcomm.com, abhinav.kumar@linux.dev,
        mchehab@kernel.org, hverkuil@kernel.org, stefan.schmidt@linaro.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <9UYDQ7nzBQ9Uqb5q4mG8WWKGLEZNPSvgV1vw6mmYS0wY2VKS5F11n8IaesvJsKYBvndy99tKFqGoak5MzQVZIA==@protonmail.internalid>
 <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
 <3a07850b-90bb-4035-91ce-9f361c635df5@linaro.org>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <3a07850b-90bb-4035-91ce-9f361c635df5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vqbu_dHe0ufkvLQ7y-Vg0xndpVTmqVdb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDAzOSBTYWx0ZWRfXyG6CL1x1L8MV
 ig4sh/OvWTLXbKRCEJQj8zZZI9RHXTugsbU2eJuK4QLTxB7sRyT9LNiHu5KNlQSiPv9z3YIhYtn
 cUE8HvbgZ39qcCzhOyWRuJkKE3DvuHsXCSCBSsQsYUpQ/8sOell/kKo+qGnN7iLl47RSLU3Wftg
 ktS3sw1NcKRvrTtZhrh/xc76ik6HY5UfmFRPkVG4NC+NWee7GN4mD3sm3YMFFbvJE51nI4XxmSL
 RS5ZDB7SBcaCz1vLW0NnPfS3mIoTxYcQfyA+e5rrpQ4/1rk0DIwHmp3ehUjpf1NfRsBlTJ8ldvB
 TVxAm+Z1vgCQL34iT+vqXrZioKGySPHnJ3lh0OvyrSirNtnPkQGncN9Lquo74RSJ+UAoafFRmkX
 WV1FMgzW1Da1HXFsU7Iu9FHJag9H7A==
X-Authority-Analysis: v=2.4 cv=HaMZjyE8 c=1 sm=1 tr=0 ts=691c01f7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=XxUhHey/R60E+S35X0VJGA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=Rloj6LPKQydGzzJWqtwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vqbu_dHe0ufkvLQ7y-Vg0xndpVTmqVdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180039

Hi Bryan,

On 10/7/2025 5:02 PM, Bryan O'Donoghue wrote:
> On 06/10/2025 10:18, Vishnu Reddy wrote:
>> When the ffmpeg decoder is running, the driver receives the
>> V4L2_BUF_FLAG_KEYFRAME flag in the input buffer. The driver then forwards
>> this flag information to the firmware. The firmware, in turn, copies the
>> input buffer flags directly into the output buffer flags. Upon receiving
>> the output buffer from the firmware, the driver observes that the buffer
>> contains the HFI_BUFFERFLAG_DATACORRUPT flag. The root cause is that both
>> V4L2_BUF_FLAG_KEYFRAME and HFI_BUFFERFLAG_DATACORRUPT are the same value.
>> As a result, the driver incorrectly interprets the output frame as
>> corrupted, even though the frame is actually valid. This misinterpretation
>> causes the driver to report an error and skip good frames, leading to
>> missing frames in the final video output and triggering ffmpeg's "corrupt
>> decoded frame" error.
>>
>> To resolve this issue, the input buffer flags should not be sent to the
>> firmware during decoding, since the firmware does not require this
>> information.
>>
>> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and
>> firmware response")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
>> b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
>> index e1788c266bb1..4de03f31eaf3 100644
>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
>> @@ -282,7 +282,7 @@ static int iris_hfi_gen1_queue_input_buffer(struct
>> iris_inst *inst, struct iris_
>>           com_ip_pkt.shdr.session_id = inst->session_id;
>>           com_ip_pkt.time_stamp_hi = upper_32_bits(buf->timestamp);
>>           com_ip_pkt.time_stamp_lo = lower_32_bits(buf->timestamp);
>> -        com_ip_pkt.flags = buf->flags;
>> +        com_ip_pkt.flags = 0;
>>           com_ip_pkt.mark_target = 0;
>>           com_ip_pkt.mark_data = 0;
>>           com_ip_pkt.offset = buf->data_offset;
>> -- 
>> 2.34.1
>>
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Can you please pull this fix for 6.19.

Thanks,
Dikshita


