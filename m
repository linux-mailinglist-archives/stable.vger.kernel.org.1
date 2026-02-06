Return-Path: <stable+bounces-214627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGFnCde5hWmOFgQAu9opvQ
	(envelope-from <stable+bounces-214627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 10:52:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D46FC3EB
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A00300D95F
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6A82FF147;
	Fri,  6 Feb 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gG9c/q+h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eY0itx7D"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26419E97F
	for <Stable@vger.kernel.org>; Fri,  6 Feb 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371476; cv=none; b=mgsExKr1e8SkCNBG8kFXZUCmnp+70eAvHBlsPO+fDpWfOwlhRFOIJEbZ15fN4XQxWgv+LEBtzCwMsOqUT6N8lwgJf8gpB6mwSfSjFUaJZ1pYplGESKUCXfXu0Ls29JURHCrT7NaAW/CqP6SVkfJNPrdhw/XZZjtmpfwafjvs8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371476; c=relaxed/simple;
	bh=PSOXF6PmAHQ+vx7wer/W33tIQNEbK03jBRyuL/M6CQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRxJL8QLvBWcJOPtx9ntNjFrZ0e2SY4G2FZmy+kYw8dkzj0XvotINr0Dgbk4MZ3ASysKWYB2ZoMzsg/0NqOLD9Xw0q5ihcaSQp+eK+A8mG6tfnike5nXc8HD6PRwGI6Qp14mnIxW8gxy0N+PWZdReD6XYHsaTf+iqPBdV0HABTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gG9c/q+h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eY0itx7D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6167bc8g4041993
	for <Stable@vger.kernel.org>; Fri, 6 Feb 2026 09:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Jiv6v4ksPPN+ZfvvPvXPhLM7mDOetAK6b10pE6lihE=; b=gG9c/q+hvWz+PRlQ
	wF0SIRAdSOfqPJX1P/1xKoD5aKAO4Kg35uJ+J6cNaR7ZbcIgw8JSQHMsxgNXtBNr
	b1oiV3IAJoRNU6MsMpSCD5Khg+eIoZev2Y8QkbkdJIlnw7wJxeiy8dEQM1vqAMiE
	fmiL6n40D/Rh5sGCfS7elYuEE6y8HTeRkvr31pQ8UUkewTlPr/YcGg1WImc2/xhJ
	toOIIV8f+mq1mOdE04OyB8rSUnVlH4Z3ytsH2c7licKBX7JC6BUN0IvFmSpDmjj0
	Lig+i/ygZORZHk8VMD0q8LhfkXjRN5lNkXUKJ6Lg6RbWId8PKGJBXdnJzQd6sfI9
	F8JS2g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c2w0f03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 06 Feb 2026 09:51:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70b6a5821so456058885a.0
        for <Stable@vger.kernel.org>; Fri, 06 Feb 2026 01:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770371475; x=1770976275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Jiv6v4ksPPN+ZfvvPvXPhLM7mDOetAK6b10pE6lihE=;
        b=eY0itx7DjtvlXvOeCFWHKDF536OPWQsMgSoGh3Xsoe6G5KfNifcJQxUijK5XUZYgV8
         v/ijJtYrhbUKv21zMFV6L/BQp7mmgPT/0nyH0jo82pglcnqm1DLP6I23nJSdF39qIzo7
         Z5QbnXuS5HG4AcEKGPQDyVJHbb90u/CBE7xAEueRn0tfZBuyv1VYyaM4YQhRlovKF5Al
         RmvsPaVBwZzYVsbFk7gH6nNSD4lvkQsXcO99tpC+LAKQw7ibKMXRMQtGdKhDtW0c/ujS
         OSFNhnKSr839XI7MxNsPQ1pbAXCLwZDI7qpn7RC8WDOm9svCUrfLD/eaOK1Ji4LXhH5f
         V4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770371475; x=1770976275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Jiv6v4ksPPN+ZfvvPvXPhLM7mDOetAK6b10pE6lihE=;
        b=vUU3I3OQZRJMoX6Z6ZWk/C+enkZMwx7a8pAeaHoACQ5GJQxoAzCZCkahNhitSj7/Gx
         kSu8ki/JaTmYRm3ey3lNer1IUTziMjgvw9nE0HutuASA1BH+0cymNXUCzsFkmtGzdc8o
         rGyevauTUSx91/a8awk+rwNneXi8bZBGLLWGjJkTzlgT4HBoeMuu0fR+NgENblOsHRap
         upb24A5EZVXkXQuQ6OT5NKl8jJcBeKLiJbtbl91b7AOBAaGkLVJl5xqsxlzjG7tGssnv
         qak1ZuE7CnE7MuZXzXXyJomBIcVIZX3fM77NuMtYRyMuRPxibwa+/G4eIssmlkLSYezS
         CDKw==
X-Gm-Message-State: AOJu0YwNIi7cVFEzxZplR3C3W0A7IkPM2VYJFho6gPwT5H9Xgrq4dzCC
	RsGp+GFZJQpOUai9zHZ7KWoyd4ZxBi8DbPWRneHQCNNSPA6UydRlET8no49dY2FFDpEbSra3fmm
	B/jfs0NkUI9U/QClHe6UZMG7ZvpHfWAhxzcCIG3OmkXKtW+o5KlY7cgzlbXA=
X-Gm-Gg: AZuq6aI9mCC/ZBRomUeznI5ydq0RDNDCeVADeG9hv6zz9/DCsMAQeuAf+g62hJG3Qyz
	38QuZrTdeADOk/6b42/Wyh4Ux/iHsva92uHLdRzoy4wGczTggnf/VBsyQUAmUc3TUPdzhGaYfBe
	Bpa57gr1PB5dnOgWEUGvRZQBkGIowWdfZ/HRWmJa6DtG9iDS77UDfV6uaLpBPc2difAsLkTrmhH
	xPWG3wkzz3FyHHq/PTNPIymqn5Daa1DZUgbZfPgFnOgKedF9MeTFasiKRyR7YGPpkaYywdvg4t6
	I7FWsdD6xWGg0McTYyCBj9EEuaLV3Gy//QPUReTg8a/ot44nz7xbsZgEMf+eftbrXOaFR2r3JLy
	qFIJHIcl1UgauVK/to8zf9V++HbKCNUILDay5
X-Received: by 2002:a05:620a:4493:b0:8ca:90de:43f7 with SMTP id af79cd13be357-8caf0587204mr231276385a.74.1770371474813;
        Fri, 06 Feb 2026 01:51:14 -0800 (PST)
X-Received: by 2002:a05:620a:4493:b0:8ca:90de:43f7 with SMTP id af79cd13be357-8caf0587204mr231275185a.74.1770371474375;
        Fri, 06 Feb 2026 01:51:14 -0800 (PST)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48317d33f5fsm118957005e9.5.2026.02.06.01.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 01:51:13 -0800 (PST)
Message-ID: <4cefb47c-430b-4a2c-98bf-99a1d0a9c0b0@oss.qualcomm.com>
Date: Fri, 6 Feb 2026 04:51:12 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: q6apm: fix array out of bounds on lpass ports
To: Krzysztof Kozlowski <krzk@kernel.org>, leqi@qti.qualcomm.com
Cc: Stable@vger.kernel.org
References: <20260205081825.11209-1-srinivas.kandagatla@oss.qualcomm.com>
 <e0d678e1-3f28-4213-b2ad-62fbe0a402ce@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <e0d678e1-3f28-4213-b2ad-62fbe0a402ce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NiBTYWx0ZWRfX6ChwBowOouyE
 RbSWMIA5AxCz6b4rX6QLdThcpqZ9RAVYPjtpp8V1mG7w8gHWg/xj2VUf8ukbSnFOHPFySAuxDuf
 zq4L1yIxM4zOIiPv7I1RsU8L3OzXKvOeCYsV2qKcNajKyONUvxFNF2hh4Io2lJy8toIPyx6XVPm
 nHVjxXpF2w4fCcpcwZzzqBHxLA5fVQVpZRo0BXBhfuJpTco+k8clFHk1nEFwJ4r6D42Id5N5BxG
 6794RMduYcyom3H6EHyPhE4Nz142ChyDeMBnIRkVMj4XO1BxDWecpUOBUkZx1TGkXiYKvUYWqZ7
 XHC1n0VKpXCQZLgCdSHXxiQmjxNzfQuhneSPix7xbCInSvFy9Di+HdP6HhBU1yc5e5YpL5ZUdG5
 1WyEItVibm72JBudUOwBONIzd6x0wUE5bMDBV8xvHuiDsTqRvq08jtXfamRscuiqVzR+k3LhKA3
 MK88mB4NKE5iI89xOow==
X-Authority-Analysis: v=2.4 cv=Wtom8Nfv c=1 sm=1 tr=0 ts=6985b993 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mFTyBfix888c6cflm9QA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: sUMCm9O6O_o8zVHT-16nKLfBVNfht1CS
X-Proofpoint-ORIG-GUID: sUMCm9O6O_o8zVHT-16nKLfBVNfht1CS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060066
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214627-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86D46FC3EB
X-Rspamd-Action: no action

On 2/6/26 2:11 AM, Krzysztof Kozlowski wrote:
> On 05/02/2026 09:18, Srinivas Kandagatla wrote:
>> lpass ports numbers have been added but the apm driver never got updated
>> with new max port value that it uses to store dai specific data.
>>
>> This will result in array out of bounds and weird driver behaviour.
>> Fix this by adding a new LPASS_MAX_PORT which is can be used by driver
>> instead of using number and any new port additional can only be done in
>> one place, which should avoid these type of mistakes in future.
>>
>> Also update the driver to use this LPASS_MAX_PORT.
>>
>> Fixes: 55b5fb369c02 ("ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Add USB_RX port")
>> Cc: Stable@vger.kernel.org
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h | 1 +
>>  sound/soc/qcom/lpass.h                             | 2 +-
>>  sound/soc/qcom/qdsp6/q6apm.h                       | 2 +-
>>  3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> index 6d1ce7f5da51..b4856627ad00 100644
>> --- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> +++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> @@ -140,6 +140,7 @@
>>  #define DISPLAY_PORT_RX_6	134
>>  #define DISPLAY_PORT_RX_7	135
>>  #define USB_RX			136
>> +#define LPASS_MAX_PORT		USB_RX
> 
> Not a binding. Drop from bindings.
> 
Will fix that in next version.
> Also, this is supposed to be separate patch with its own explanation.
> 
TBH, this patch was not meant to go to public list, looks like i forgot
to add --suppress-cc as I was sending this internally for testing.

--srini

> 
> Best regards,
> Krzysztof


