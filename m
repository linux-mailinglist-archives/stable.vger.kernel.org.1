Return-Path: <stable+bounces-192958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B47C470DD
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA433A527A
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868303112B7;
	Mon, 10 Nov 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KzjsP0iU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMx9iuqP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA0307AE8
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782722; cv=none; b=SJJOpCYoPnPscCqIVxMCKfxVFVBIMyH81IEqM/UAEvxtj3nm4pFaHAwb9FE2NTgq29RqBPRcV9if4NrU5G6mES8jI5KnILXnsJYcbuzbr9Z/ek026t5VlXZpY2joDgqA+2uVT1drhOt9q1CtAyvhGzDpy/XZg8zg4rZLyBVWroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782722; c=relaxed/simple;
	bh=4H2fw1nZerKjCesvxPE/tv7CG+Zj55dfVDI0escuNWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJa8iA9v2EiSY5q9p1OjFtaQqM2PaLuASoqy38mHk/LZJZsm4Qiq0jwxuvhfovgWpfeGDA8GNM3fzQ1XFIGtjZwzuL8q+KeTJ/CNs+INWof1p+dqx+wjgw447IStCpRkqEDRGmFxG+fNYjdTCOfFn0d810qD47G8mgI0RRuIKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KzjsP0iU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OMx9iuqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAAwb682547013
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 13:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NZlV3jIxROciPtUCqpcLAitOvegR1QpOAc5SMbgsl7k=; b=KzjsP0iU+L0zRHhL
	Z0MFLqIYsKYfVMR418odKMNhC4UYcKfQVBqErdGlrvXdAYI4gx4qzTGpDdLMlkAs
	F828rcYyNa1j4PAz2ZlpGIh+0wDD3FEUlVau6j3tXMBUsvlL2HyMW6SpHVMhVWYy
	UK9mAFTKrkH2ZTQ1dMDJl/2RlrVNjYZgoZkDIHhM5ikQ0S1G7wnkC09QSGC4USW5
	4zk3MGw+76iUb6wuQsFABEUD1T1mWczuf786DKmT/+AKVzBZ2kziuBhdmOQmEMei
	QFzMG6V1pyet4V5kRZt3WxQsPtbRUiqmYQRbLNt18ikznKHjOpbundYfMqFyWnxw
	61GU5w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab8ea9nau-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 13:51:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29557f43d56so39387865ad.3
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 05:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762782718; x=1763387518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZlV3jIxROciPtUCqpcLAitOvegR1QpOAc5SMbgsl7k=;
        b=OMx9iuqPENASHMh9jiIpA0ouxHqXs8cgxWB9Gmq8GAXbEAE5ROiKU+OnlcX7GqFzmo
         +v/9HvrnkmM4EE1+l4xkxAKWZaPoSKD28BC8ncPpRYnDGPeWqbBCCijafizFY+vuqxZ0
         wuq2jCj2yHHBrkrSWQ/tRFW/TRAsFvHpU5bM4QjRrfSdNa1XYUZrL9CvdamzCTp8Ceuq
         HVTJS6lO9Ec6mTJ4M4rYSs4UnxIAN2G6HWgk8Z90RugUquFG3zIHIu7M6u+SY2XPXXx6
         x0aLUqmp+PAnMkFD+fKcdxTF2cFAheAbiZDaAV66Z27Xnr+3drLoDbf/XU4m2udboHDZ
         oGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782718; x=1763387518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZlV3jIxROciPtUCqpcLAitOvegR1QpOAc5SMbgsl7k=;
        b=ac8PJLuN92NKSu3Tow9cRadIrToXSmsAwhZOv6BHgwFERM9ccnnhmo4d8vOS8nwhWR
         GKrbzPyTEDSJW5a75suSVCdw9mKQIgc1KvQMx5Ks+r+MmhYBokoLm/L3VCSNdwyuhGGD
         FalfFZjidLj/ZKyX5PVSncVDhelOTqg3y6364FmwWk4bfafzcvOovFwMA1UmvWt7sdzO
         m4j8u+Aq6myMBkW4nLw5krRgK6nIRKxJY4C+z2eLeGFdwt65A/JA2jHrvvVwu3RJNelx
         A+XXkW+zGSSji/GDC249RMCmyfDCONvy1H3QlfwOK5Ai8EeKlQZ7gc+Vb/V3eFlgn7/i
         fl6A==
X-Forwarded-Encrypted: i=1; AJvYcCWa/XLQ6p9OzRMyeJjOHbYmxCpXVaja0QUydyJzwZbo5fES2Sw7/qwSPP5njZcwY28gJQhx5hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrkio0Wgpjq89ct24Op7zGYPmXjsusg4n3M/n5NEIaHJ7WLmZd
	4XjCjYbi3r7PEM3XiApoD1nqimdrlIj2Ghv1iMfk87ENVnF50CpQ+D75R12+rb2QbPg4/7egokW
	rZPzzXHknxFFIrT+mKUkOO2v8i+DOGy2wSG0jSJDU7N4FO8Wfw3uzpqU2FVU=
X-Gm-Gg: ASbGnctWQ5K4AI/Gwqxn5Rsocw2KLYv65lvSN+mdI5M9gKAJwXeqofCVKk2R6pIOByO
	5rdKDKsqEyD5tzlzwX9EvPezGqyaM51GxPWOPuwKvCdiMwsLup+QAEB7Enm2VXRw/oWwcMpNyuv
	XNBhTxy0RulQapmJSfJCsihEUFd2k2eJSRxkuozU3Fl0sDjp49RKsS7sr+Y6+WYdHqqauHlpGs5
	CTplRab3GwqDEWebBlRHvQjJVPgFcvJfn6PsbWsnHp943ysRPcimIQ8VEB2LI3wbfRbTPNG3zCJ
	7GZstAO0pKPQncdETuAbrQNoB8OV032F0vIHvQiAlYotkrahGVMLA5dsH6zJxX95xECB3N9BuYh
	6NrwTRJ3NYRn2sqotSYwVmr+PFwgdgaE=
X-Received: by 2002:a17:902:d581:b0:293:623:3260 with SMTP id d9443c01a7336-297e572957amr115879225ad.57.1762782717853;
        Mon, 10 Nov 2025 05:51:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfqiqS1BOPe+VMlfkJU0zIOGZuKtCtWI9NqPiJ0S4bKUKfTOQjBnZhjxrbV+/OQHnCK4jKBg==
X-Received: by 2002:a17:902:d581:b0:293:623:3260 with SMTP id d9443c01a7336-297e572957amr115878545ad.57.1762782717110;
        Mon, 10 Nov 2025 05:51:57 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c344838sm11109221a91.15.2025.11.10.05.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:51:56 -0800 (PST)
Message-ID: <f28068ea-c14b-8502-f252-3ddfe4eb874d@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 19:21:51 +0530
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
 <l2djrmw5i7dfvlrqyn3a5yrohbtpxr72xwwrgojvsfwo7w4feb@254rjgan2fyz>
Content-Language: en-US
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <l2djrmw5i7dfvlrqyn3a5yrohbtpxr72xwwrgojvsfwo7w4feb@254rjgan2fyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Eo3QoWDS6LDNlA-8PLpTfaVQcspCUaIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEyMSBTYWx0ZWRfX4dxe4sRoNSA2
 tDRL1ScJx4rplV4R4QeTeWJ32Lm6PhU2DHTqkfUiZ4SQhtocTlXfW7MRNyW+q1k68RiGdKTFO6O
 +jpkkgUKB6PRvkyD1B7Vs9+sojmnxRVdXE5knkg2YMZZwGDBs73ATqwyGYRWV2TWvqIj7Q66qG7
 FDp8j5R/6rA7TySS7UYXuurEuRGCDi/usgzqQ05vnbRTal2B8i233KDOXUGAOn7Sh2Ic208yULw
 E4QuhROmByTWiNt5N1cY3+4BkiMB/TgjT7xlK0lQrBqy/P8ycM8TGlZ/e8oYIkm6x+FQpVcKbrz
 FRKDl0oclKRltC2Hpa9+lYp27xL1PLWCtkOzuz8P1/y4gevEp1l9yabKoH30IPdkhrfuzDzU7lI
 fJlYkhFBLf6W1gcrp21N+vlshKWOxQ==
X-Proofpoint-ORIG-GUID: Eo3QoWDS6LDNlA-8PLpTfaVQcspCUaIX
X-Authority-Analysis: v=2.4 cv=QLxlhwLL c=1 sm=1 tr=0 ts=6911edfe cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mVG3C3KJgNa-X6cAQn4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100121



On 11/10/2025 7:05 PM, Dmitry Baryshkov wrote:
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
> 
> Another question: can this now result in PIPE being sent for the ENCODER
> instance?

This state check will never be true for Encoder.

Thanks,
Dikshita
> 
>>  		ret = iris_alloc_and_queue_input_int_bufs(inst);
>>  		if (ret)
>>  			return ret;
>>
>> ---
>> base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
>> change-id: 20251103-iris-seek-fix-7a25af22fa52
>>
>> Best regards,
>> -- 
>> Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>>
> 

