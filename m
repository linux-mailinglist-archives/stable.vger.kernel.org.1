Return-Path: <stable+bounces-192918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA1C457CC
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B83F4E2F22
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BAC2FE050;
	Mon, 10 Nov 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oBHsj9cH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hDN87T2k"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722642FD7BC
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765289; cv=none; b=TLueFzKRvf46+bD/rJTZ0BFEYWbm5SIK7l8dkuAHWTf7Jqlx6MwJWASMucyFzTd/7np5vt2Wt7mFewJGbHEDNLnG/bBSRfAiI4/heP6SZca3HLeq1F3UAf1JormMRliFNR78+eRmxKCoa0m3moSPkfjAhw0GEWURtDLcCO4XONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765289; c=relaxed/simple;
	bh=ccU9+qFZKZ7fCj6QGTBAJFQ2jYzt7LtNENdW2LxoxZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMbdKO30ozK+LYsnjyF1bHVYw3lpIazYLht1Y1dBy3AKfRpksBuBRj2mKjfVefGt8Zv05bb7Dav8u5CocPCe2U0gzyxh31rpf8PaMojNajdtY5BfgcG4JUQNjZ7CJzFr00AIVogFxzwvdEkoBtGi93iCDwOdxEymA58Q618cv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oBHsj9cH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hDN87T2k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA0XDRH1808952
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 09:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VjFJkh56K7+vszlTQwAFFoNDcHFHTbltKiU2coQ24F0=; b=oBHsj9cHNfV3LU1I
	sFoJT6aShUeZc8d0f3vdWt+u/3N//1Fvm2dr2uxQ/eyzcpGLKCgoaZ+MsiLFtMOX
	FoRTXJv0qDDwV3NymRDkiKs1d5QGm4+qElBFpSTEwSPd0ZcLr116MIeMiHl7xAY4
	NLj53CAMe+0qoZa4//1AeqaJi9hznbIjj69OiDDpTPxI/gntZ7JS7yDzKX0xPV6t
	M4TCsYocoZU689koXIdQPhpVugaztfHNkZ14ShVS2Z5y5ZOZGq+hc2LXwp97DrYa
	EEPgMLgL7RspzC/nVxFFQBqko9HPf6xn+f8ChMDAzitv3wW2Q3D5xNU/4g6AeeN6
	SwgJWg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1h4vp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 09:01:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b043e2790bso7225399b3a.2
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 01:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762765286; x=1763370086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjFJkh56K7+vszlTQwAFFoNDcHFHTbltKiU2coQ24F0=;
        b=hDN87T2kp6VJqO0OvbvXMVw0HYNpKhIuZwr5aS9HCVCLAjLR4/LSv4/YIinliICBzP
         zoRYB8HKA3NPhJGmXqOJnJARb4gV6fcnpocsaZ+A7kTU1E9Rfc1HXo4ZknGYf8h9Op2Y
         icODd4koIhs81idVQ4MbvWVFY98HA576uhjFXLnsFoH1tXy1ACLnGjL6yvYBnhA/6BoB
         IqxGjDFO4kXQhPZuYSTVl6xiOhNuRJk6Ohb89s/iVot9gsmkdZZa1YbO23IZwojCUaSW
         hKVYguEjTdLiDtlOZDzvfdEZMmSv/7BteTmsB6/5uZTlH/T9o+DckffTm8W3Ot1SDo69
         hwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765286; x=1763370086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjFJkh56K7+vszlTQwAFFoNDcHFHTbltKiU2coQ24F0=;
        b=hFwPgsu7I4XoskVMLKkoSJTTb/ITuHqcJrAMGIy8feTVYgpq5jtlyRJaGg7JNCz9cC
         tHZcv3V8rHUUerKO3g1Pc5fDFzyPqQ3pVJcDGKOC8TMANoW4R3scV7qBUpuB8++UFpST
         jFXEx2vxoUNwO5Aeo4S5L0qFv8QrhNO4X7l9t/im8CAaSsRwfOMImj+UKyASAycl3PH4
         U+stjEUSOPy3rFyz6r0XP3r6qhPN9sp37VvLqYyIq1xznWVtlOdvcHtW7rE7Vicglsfl
         /V3XDBeRjwMP4BPWgPaZrhfuSMjtCkc6CzbreXbMjPNsubLtBwW5S6TD/mdy19DG1XRg
         86yg==
X-Forwarded-Encrypted: i=1; AJvYcCVsDrK83zyyUfOS0HlEBVuXSCXkRcFOSDOSYScHWBrDq3ZVTjmy+y1/xm0cM4Lk6sq9nuG1uXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXXrOimifVDyjEKhStTxVvmZMy7NIWsaeGUxH+eDjJSN0WjthY
	UdxvIqYOpHezgWZwhlL2QxNJEC4tTdanwfaFB+l5h0Ibe0H8hUGw+BqbUkX14+R2Ohq9W8pWgVX
	ZuJ+KSyPBR26FQG4Q50ZeX3Cnm2EFX8tXxSg13w9mXjxTIXtfKhDZHzB3u3M=
X-Gm-Gg: ASbGncv2HD7TnIO5/CEJ1CzlzZ3n3+aICQ9LXVp3K2WuuHhOq2uzE9NjVjVeM8nPlx3
	8DaIBz1+0pbxSynzcnwgnNBqfW07xSrfAVXUiT1d1hQpaFSx3ejYcFwYzNZTZ1OPA3UY0cVZRQ5
	1vnlmakL+ioH/LVmtYg74u4cvGkXHY1pD4ZsRJ4VkdtnJOwHDhIHIFTvWIB4qV3E+uIlMHsdUiC
	NdngD7L+EB2iNn9b1uQUBi9+ROy+zKO6JdM+4PlHG2l7Au6Z6ZhSGniSY9j6hTNA9KKo5iLOefU
	m07++SjqWRlSSFtuZgcLtYyMdvRxpi1thfwUyrn9fTNk/0l3wY13QeZL4NnWFsaB9NxvJ/jIpWP
	Ah2xKPlOYUxXr7GoRDPLbVf7UJOHjE9M=
X-Received: by 2002:aa7:888e:0:b0:7ab:f72e:8f9b with SMTP id d2e1a72fcca58-7b226b90d5bmr9656067b3a.25.1762765285788;
        Mon, 10 Nov 2025 01:01:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHosFOAqp8NttTocVa+upK1X6V+G4BalraqG8mZS3F39o6UgfwXEKMpvqi7/lIqmyWo+/KjJA==
X-Received: by 2002:aa7:888e:0:b0:7ab:f72e:8f9b with SMTP id d2e1a72fcca58-7b226b90d5bmr9656005b3a.25.1762765285176;
        Mon, 10 Nov 2025 01:01:25 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c963586fsm10881884b3a.10.2025.11.10.01.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:01:24 -0800 (PST)
Message-ID: <220c9fe4-00b4-3b42-0e80-8730a6388bde@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 14:31:20 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
 <2uvinljz3gevbusjrz3bzi3nicelv3t6a64gliv4mdv6cbllvp@fz3qbyukypho>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <2uvinljz3gevbusjrz3bzi3nicelv3t6a64gliv4mdv6cbllvp@fz3qbyukypho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3OSBTYWx0ZWRfX/LO0gFt2MJUU
 MWqDcvunef3ndqURh0Z+2T3oE5d2VtgiZZ8b+L/1S0zI7T2s+7z1YmcPTjEz/wCZtRvXetzwAdK
 C7mqutd1ffAFu10kgKrhcjDcs9XbznoRFPAvZJ4JWsMxQIZcIbHANdxgRsclBAwjICRnRWtifSX
 SXQSUWIom+tskBK35zONtF+sZnAf5SexfTkBzzzIIFtbbKeqUGCPk08edo+psQ/XI1WxeOkcFXN
 Gw+KUkN1VhKadtPoxZX7w7J3hzmZpQ5xBzJvaedpeJn5Gtr3ovwTK3aGHKnEgh8+2fZ28q6ZFhM
 TVsRyAoudbIdvthsQxB9Ev+h6qjd2ghb2exwzxJVzVCV32TKbgF7DS+qlo7+NHSDvPo//tj7SGs
 FonXE+EGd+6GHkAH1RSzPugGgcYKYw==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=6911a9e6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=xnInQRZk-M5WjpmsOPIA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: ZHVks0fa9Gv2uBW4zIIXht-AWnsiuf6N
X-Proofpoint-GUID: ZHVks0fa9Gv2uBW4zIIXht-AWnsiuf6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100079



On 11/10/2025 2:46 AM, Dmitry Baryshkov wrote:
> On Wed, Nov 05, 2025 at 11:17:37AM +0530, Dikshita Agarwal wrote:
>> Improve the condition used to determine when input internal buffers need
>> to be reconfigured during streamon on the capture port. Previously, the
>> check relied on the INPUT_PAUSE sub-state, which was also being set
>> during seek operations. This led to input buffers being queued multiple
>> times to the firmware, causing session errors due to duplicate buffer
>> submissions.
>>
>> This change introduces a more accurate check using the FIRST_IPSC and
>> DRC sub-states to ensure that input buffer reconfiguration is triggered
>> only during resolution change scenarios, such as streamoff/on on the
>> capture port. This avoids duplicate buffer queuing during seek
>> operations.
>>
>> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
>> Cc: stable@vger.kernel.org
>> Reported-by: Val Packett <val@packett.cool>
>> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
>> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Fixed the compilation issue
>> - Added stable@vger.kernel.org in Cc
>> - Link to v2: https://lore.kernel.org/r/20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com
>>
>> Changes in v2:
>> - Removed spurious space and addressed other comments (Nicolas)
>> - Remove the unnecessary initializations (Self) 
>> - Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
>> ---
>>  drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
>> index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..7f1c7fe144f707accc2e3da65ce37cd6d9dfeaff 100644
>> --- a/drivers/media/platform/qcom/iris/iris_common.c
>> +++ b/drivers/media/platform/qcom/iris/iris_common.c
>> @@ -91,12 +91,14 @@ int iris_process_streamon_input(struct iris_inst *inst)
>>  int iris_process_streamon_output(struct iris_inst *inst)
>>  {
>>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
>> -	bool drain_active = false, drc_active = false;
>>  	enum iris_inst_sub_state clear_sub_state = 0;
>> +	bool drain_active, drc_active, first_ipsc;
>>  	int ret = 0;
>>  
>>  	iris_scale_power(inst);
>>  
>> +	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
>> +
>>  	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
>>  		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
>>  
>> @@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
>>  	else if (drain_active)
>>  		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
>>  
>> -	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
>> +	/* Input internal buffer reconfiguration required in case of resolution change */
>> +	if (first_ipsc || drc_active) {
>>  		ret = iris_alloc_and_queue_input_int_bufs(inst);
>>  		if (ret)
>>  			return ret;
> 
> I will repeat my (unanswered) question from v2:
> 
> After this line comes manual writing of STAGE and PIPE. Could you please
> point out where is the driver updating the resolution in the firmware?
> And if it does, why do we need to write STAGE and PIPE again?

Sorry for late reply,

During streamon on the output port, the driver sets the resolution in the
firmware. However, during Dynamic Resolution Change (DRC), the resolution
update originates from the firmware and is communicated to the driver. As a
result, the driver does not proactively update the resolution in the
firmware during DRC.

STAGE parameter depends on the resolution, the driver must update the
firmware with the new STAGE value after a resolution change to ensure
proper operation.

On the other hand, the PIPE value is independent of resolution. It is
typically updated to 1 for interlaced content, which is identified during
the sequence change. Currently, the Iris driver does not support interlaced
content, so updating the PIPE value during DRC handling is redundant.
However, this update is harmless and will be necessary once interlace
support is added in the future.

Thanks,
Dikshita
> 

