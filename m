Return-Path: <stable+bounces-219583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNr6GDjUnmkTXgQAu9opvQ
	(envelope-from <stable+bounces-219583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:51:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EFD196050
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D76F3073A4D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2918C3939CA;
	Wed, 25 Feb 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bJNYOFPM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hsMvS1fn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B73939A6
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016519; cv=none; b=FCOVgeJv+Y6DsammZ8VgkMpqFXRemgK/zGXpB/sxxzOe8aZHKWfT+exjM9fAQjLTLmfJ2uEJCLDdJv56PTodZJuHcZgEYe3ShrwPpxrYyL066KUetUYxbCeaxLV0SWE4Q9mdcYFqmYmeh98ZUctPIpm0QYXjIZNOybrhQQz7atM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016519; c=relaxed/simple;
	bh=U8F4hftcy2685oOybweH3eevPSFoJSj/GAd2RKXzJrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBUpb+pT4B2EEeKIN8e8zebfwgRRkR7eqAe+26/AsszJEysRDGrfKVxg8mLXhz9vbRpVt5ulEKnzPva8O88KloewBd1tKUdE99sh1SgmvDwiqsYZ8sYi+pAFwPS5VD1d1USjG7+YlRhw2mtWb7AGjV+5fEPnuw3PkMgDhLzLtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bJNYOFPM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hsMvS1fn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9Sr9D2691923
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 10:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	asexqnFyFkaUecgQLxvKMFLjNlOwun5ZD/JgnhKqz5g=; b=bJNYOFPMoVkrwUGH
	q8VqaChnncNNAL9KhiurTorI36tFsTdMqWtAc8+JUIR/8cSDkStb8DnezRRskB6X
	q61ZDMLuP7fo5o4EflJDlcc2SOl816huVSISzBwWj6YXvsxg0xTN4BOwYWd0uV8M
	ZWd0QLTvR/n8MCLKQ+3yX4nw/PBtHJXQ6Fk7JROJkvoiECBAzmWmJkLUygCsFxOA
	HIGCiMV1eKpAO0p27htQDpdy2lkjsn6q31j900vvvhZ07lNDCpXk6n5J+7pEqx5e
	0uRtiKfE1IT+R62wisrAmVvvgXV/4U22J/GULLvnzyaVzEJk2jGMIsu/WDzs2CLo
	aVxAdA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chg2gtxf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 10:48:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8ca3ef536ddso6322788685a.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772016517; x=1772621317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=asexqnFyFkaUecgQLxvKMFLjNlOwun5ZD/JgnhKqz5g=;
        b=hsMvS1fnsWMWPKjmjq7kaNL2hG1WUMNBctTmOFVzyI9yTuMaYkjoPkJrfjJpG5XyKX
         sXdDWK12eaRRbGHjoGk/3f+J5wdybyIz19GKGmQFnyB1qlJ/xZJ+fUBtfLEaul2ZjYNT
         sj5Y3l90sbb89VUJ5LOt7sdKvWAV/GbgatD84RkS4pWluveYvB7GEQOlqY+ESgy8UB5D
         g17sq6wP5Qtyxtuj69BLYsJqy5raR4yiXNBp1vxGuGVbCAQ9wC2um9J8K0jymq9+1hn2
         WkFoDLi91VREAQ6a01rre04gPpxNqzHQ6OGX/0dmRS3mCOEbZegZdNVBQvECUAyrH3J7
         5Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772016517; x=1772621317;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asexqnFyFkaUecgQLxvKMFLjNlOwun5ZD/JgnhKqz5g=;
        b=HMn7vKhWY2ZfEXYnMR/NpIW/ZsRX6obWFscAhiGVia002I58njVU05b45Eg2sfWQLD
         7JoEGRTgGBgW2SnxL7xKR8jWRZPbagMKgFeNQpvh4NuwLE10bFVrEnJNcM/iDJbXUFv/
         WGU5XxIYQ/P6icVCvDTQZrrBmdQBTmi1Y2eQA6F4G5hbkjTMvbzdKUEQRJEbtcWHCsPp
         YFC7+VjMdDLQxRVNXcj4WGsvHMvk+eDJNxE4DY0EeLsdKHpW18IKSHLMsPYtwvn7G6FD
         7VjRnUnIy+uINo8uNsbNwYzpoRcM2JPMaL7KUVv7ds5flC+qgnIkE7Ld+GvhB3AgTWSN
         j1Eg==
X-Gm-Message-State: AOJu0Yz30qsCcjKZg/hzLniUOCTyoNhVvpijlgTzhmSbPOIUxeOyLfP3
	RGA8XZh2Wb3yvqEEC1Ypp0ftx2YuT3LjSNJ1GzyqUIlub9jv2GpFkWTvtIPfVqV6qldC/1XkOjR
	O+7+PAaWVIpPSyY/T1NRjubMhJAOMn3nb9jO8DYUfbfiPl8rNRHUJ3W8qEHs=
X-Gm-Gg: ATEYQzz3tLV4qf+kNggztBSefE1RJEVCw/aer0nDqGWnRw/L5kgydR9sBnizuuWl/+9
	TJuex/XjDDXXf+rrPqvumOSfRgxRs/6D7+LGnJkduWHdV89rU6VJpbALJfwzTR4wIAkgOjdqweu
	Ytm3Ob3bReIbUPHjUuB3x/zu78981oL2AEZQDxgGhzlSbCatV+DFLrvuh8sODxdCVbmwP77B1kL
	UB9dHbZSd49tiJGTmSOb3VzEB3M/EXcQ+1w7SfxBPXA1ttWTeLGkGJPbcBXbHTSKdeyzR6SMmWN
	GyNuyfdIVUWxRJqj6YbbhHl67Ago+oQotMU25OVYajEYtT6qGMKPPhac/t2xhMGvBt7LO8jSL6V
	BGkOzGugVw+KM9zzpcjcwLWBHmB/N5mNrBob/DarNX2aix81Xcg==
X-Received: by 2002:a05:620a:4554:b0:8b2:37ff:de74 with SMTP id af79cd13be357-8cb8ca048d4mr2023794585a.34.1772016517008;
        Wed, 25 Feb 2026 02:48:37 -0800 (PST)
X-Received: by 2002:a05:620a:4554:b0:8b2:37ff:de74 with SMTP id af79cd13be357-8cb8ca048d4mr2023791885a.34.1772016516425;
        Wed, 25 Feb 2026 02:48:36 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm58897785e9.6.2026.02.25.02.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 02:48:35 -0800 (PST)
Message-ID: <3e5001a6-ea3c-4304-8db3-bbe616eb4015@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 11:48:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: exynos-acpm: Drop fake 'const' on handle
 pointer
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20260224104203.42950-2-krzysztof.kozlowski@oss.qualcomm.com>
 <b083e950-f54a-44aa-b587-eec2cc10460b@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <b083e950-f54a-44aa-b587-eec2cc10460b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x5Grk85-pIlVIjs6opi-gmeQ4Pwg1LnF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEwMyBTYWx0ZWRfX1axNVK7116dg
 v13ZzGaxdVHM2el6UUyFgxYClfPxYLH+OYjHcp2O6q+18TAPvnMJAE1YyZswHPPgSVhIo2c574n
 /CYq/Naj6kJxkkNTJ2vcZdBqrKQLW3frEiXqn1FL/fUJzQzergX6M4E2HSnZvC3oozQCdyCR7OQ
 GGqtwtbp/kobVLMu42LiRRTYyKc0bDRWFXKAqC87QyC14zXgeKVv4U/axjX+302SXb8lXC9Et9t
 5s2zoEkU+x4mhgxwsNIuQ2rPAnjxQtHoxjYN4TKNdPZFk1b18vtUXSO+5cm+0BbMYOzX06+L6YF
 vxY+IvNq1naJ2lqNj7fN79g89pJc5fPCCNmUmugT8zxmkdBIMlrFbSdydB7GpQ8ZWRaXrhgZgyw
 gyl9RWrrBdMq/n9YGco8ut7OaHpjS/Cj5RdQaZv+WJ2nM24L3TKmtIJT3iiXADbHrgflL/BQ47j
 xl6Sosu+CX30rvybC4Q==
X-Authority-Analysis: v=2.4 cv=ftHRpV4f c=1 sm=1 tr=0 ts=699ed385 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=CFJn5XCy4UlJ5aEQFSIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: x5Grk85-pIlVIjs6opi-gmeQ4Pwg1LnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219583-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D3EFD196050
X-Rspamd-Action: no action

On 24/02/2026 13:57, Tudor Ambarus wrote:
> Hi Krzysztof,
> 
> On 2/24/26 12:42 PM, Krzysztof Kozlowski wrote:
>> All the functions operating on the 'handle' pointer are claiming it is a
>> pointer to const thus they should not modify the handle.  In fact that's
>> a false statement, because first thing these functions do is drop the
>> cast to const with container_of:
>>
>>   struct acpm_info *acpm = handle_to_acpm_info(handle);
>>
>> And with such cast the handle is easily writable with simple:
>>
>>   acpm->handle.ops.pmic_ops.read_reg = NULL;
>>> The code is not correct logically, either, because functions like
>> acpm_get_by_node() and acpm_handle_put() are meant to modify the handle
>> reference counting, thus they must modify the handle.  Modification here
> 
> You are right that casting away const via container_of to modify the
> parent's reference count is incorrect, so dropping the const from the
> handle argument makes sense.
> 
> However, to address the underlying issue of the operations being
> writable (e.g., acpm->handle.ops.pmic_ops.read_reg = NULL), I think we
> should also decouple the ops from the handle struct and keep them strictly
> constant in .rodata.
> 
> How about we apply your fix for the signatures, and I follow up with
> (or we include) a patch to do the following:
> 
> struct acpm_handle {
>         const struct acpm_ops *ops; // Changed from embedded struct to pointer
> };
> 
> static const struct acpm_ops exynos_acpm_driver_ops = {
>         .dvfs_ops = {
>                 .set_rate = acpm_dvfs_set_rate,
>                 .get_rate = acpm_dvfs_get_rate,
>         },
>         .pmic_ops = {
>                 .read_reg = acpm_pmic_read_reg,
>                 .write_reg = acpm_pmic_write_reg,
>                 // ... other ops
>         },
> };
> 
> and in probe:
> acpm->handle.ops = &exynos_acpm_driver_ops;
> 
> This way, the handle safely reflects the mutability of its container,
> but our function pointers remain fully protected.

Yes, this makes sense.

Best regards,
Krzysztof

