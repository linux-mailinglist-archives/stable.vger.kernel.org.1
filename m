Return-Path: <stable+bounces-240312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFjpI2Cm6GngOAIAu9opvQ
	(envelope-from <stable+bounces-240312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:43:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D767E444DCF
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E238E3006D78
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A063CCFC1;
	Wed, 22 Apr 2026 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l331lwpE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sr1DjKyw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0C3CC9E4
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854617; cv=none; b=i+rCtVvwdKyuvVxrzwiEAQkM2otdYAlfv+ai01JG/wJrctWm7kvlKtchWl0qGnKEUQM/VwX3rU4NdM7AoCdENZR8Esv7E7WMvi0MlrcOVYjWe+FV/TT/8PVK2X6VAl2g7816HnURrTrs32/ANx54nH4kAyRMFS/N6UODAyf9pIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854617; c=relaxed/simple;
	bh=Vac8R/pnoXXWv/sp0RAq4RlOi6uIOf4fA0u1PWbPNOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgA9WWjIz2Auxj/aMfr/ULD0V5xsmE04Xyv6YNAy/sfqGA/0ZiFnKimoP6YY5lyoJ+r3MBDEABW+0ItQNsvMBtq3FXZdCtJPGqLXRvbGsVdz9EE1Wg2k3OXRDCmxgFjjZOSupquTiHM56YRcC/bqMQ3Fq2aZv3963JOexxuC5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l331lwpE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sr1DjKyw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M4xVhA727932
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2COB/KfnyQdus17jKNLMja3RQe4vqA+L5nHYjjYpqiU=; b=l331lwpEa3QuVn80
	zTLqb7iN3ucCWjx+sPvKyZT8pQHQVQUo/rRJ97RMmYjv85FgCpI0slRkTjjkkCdz
	LxqP200GZfDnhQeD04LNR8I3+Jj0D0sLxjFUfPnW+BeMq+fCVMZQWA4J5+1NVTy3
	DQSgFsi+8MdJ/jJqyHuXsmYrcupTFuPX7H4INDbG2DLq9vPbUxOzoc58hIvrnvH1
	DS6YTqgNhzIXvrPVRuSdx/7hkl5GbnepPAf0M4d6RwlSO85G431BGpZ5mTO1h4uN
	bpRWwdH6yMk6wfin/BcbSglbhsrbwOnb5ljH4O37kqTA2viK+3CO3iQV5ZWiBlFY
	BoePbA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenhay5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:43:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8b047093195so9520146d6.3
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776854614; x=1777459414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2COB/KfnyQdus17jKNLMja3RQe4vqA+L5nHYjjYpqiU=;
        b=Sr1DjKywAFNLn15gEOC4FzDqJCninnYzp8AzP2WnpuYeDAHsU1jX6oRsDKvDxkp/lF
         ZKlq0M6Ox3szSce/fTRK1s/C/pR/4KssZZoL+Pp6jxXRSjl+wPZxbNBQ0OShTUf2u30P
         Et1zupql+rZhckGViXrfbaQzWNtLPsM/6VOgH9haNIG7sjCvZaw9wecWPUZniD6NR4VK
         0GzyaswbeXVGGvz6Kdsh/LFwxrf3GGAGRsyZyE/dDhzQlFrpOqoDZc+42AeH1iohKkyk
         9Yclo8SXVBMDlARGkDGmXTmdRuMN+HuZ2nUxZLv9lBptXCkBTMGI2b62qHy0vw4cJGQO
         Isgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776854614; x=1777459414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2COB/KfnyQdus17jKNLMja3RQe4vqA+L5nHYjjYpqiU=;
        b=mzVS6lrnqP605heVaa3hqLn7coT5sgq8IHKeinEW9hDH0ssXkslQt9wDSTh3bJrUEh
         J4d8Q4jYdNvzzDhA+Mm86BLb6AlXwTG9NUNBLC2zk8WG85sQP4sTKz0FLv5ALIc+IfFg
         hbzq/YVa9kEPkl3v8s2e7MWZ0A9kz86lCJP8B9P9zcJ2Yo8hUFArh4uMAAABNWchFoBU
         3zka2pPvx1SCU3ZcIyzaU9qjbhoaypCMYtA/LNnOPLqp5BfienIlbciSDDZjAYe+Ja+r
         a/Dr2szjqC6dVqLYx3+sCGByC1VGxgd2iYWqtySQNmgSzCGQLjdAzrxRiasyoDW/HNeW
         ivdA==
X-Forwarded-Encrypted: i=1; AFNElJ//uc7khwvC4axyLX15RTjVg9ouQ/oaQdTwaXh5yudRbhhKdllDIH5giokN4TRqkW6VaHMa5sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxspHB72R9rEI4mAubfxhQjVIevFQOTa2wAogsdIy+3dWRKscv
	DUh1iT+/hPDVyBexy2odYJmg9HaQgw14sDC6bPoWX/NUIAuP/2Gj6rgoiYaMIgF7Blp9PBjSMgV
	PzI+45B2w+SM/nU4TQ8DQ8fZGASch//KZcqPUwZAsvS+AyReI9nNXfvFfH7Q=
X-Gm-Gg: AeBDieumRz9oamzLBGWJFmVYuOGMCbhVDu6ahw2S79YbTaVcxurtOtfVkBjL5Qpiae9
	5S51vs22RlxOPPljXS0eWm2WDFAhIJXajO8T88cHvvF+x1VQN1mlyoVMIJAdfFE+IFFfJ6HWVUu
	VGyIGEtMcesvpARfRjLZ++vtL4mmpmt0SqrAlBplEoqHReZhqXE8SpSvCM6DVaDtcl1G5qIcB9u
	f0Q/NmoDqs8ZloF9ONxSU0xQEJ3/jcOQWeul9mQbu+rlQgFaXlQWjjd/M+t1O62j5EZozJ8s2EM
	gKKpV3QACPOCXQvXNVrnjAOoAMP7CHd5U6NQ9vX03IUYlTssEVua4+CEYxDM8AuQq578prTiQ73
	L+dn4jBiGyZADoPSF3aF97KJCBZOZ6RfuVmasPrh6en+F7J7NNeo4DYjPKJTnlo2lGFn1r62FR3
	Bb9ECPcp4nCNRD8g==
X-Received: by 2002:a05:6214:411a:b0:8ac:a91c:c9c with SMTP id 6a1803df08f44-8b0281fe001mr242061226d6.7.1776854614184;
        Wed, 22 Apr 2026 03:43:34 -0700 (PDT)
X-Received: by 2002:a05:6214:411a:b0:8ac:a91c:c9c with SMTP id 6a1803df08f44-8b0281fe001mr242061056d6.7.1776854613845;
        Wed, 22 Apr 2026 03:43:33 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451cdd2b8sm535272766b.25.2026.04.22.03.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 03:43:33 -0700 (PDT)
Message-ID: <3d50f17c-060a-4a1d-b539-1bea9b3e6cd0@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 12:43:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: Enable retimer on USB0
 port
To: Prashanth K <prashanth.k@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org
References: <20260422093924.2976069-1-prashanth.k@oss.qualcomm.com>
 <6c2c5fd6-c032-4658-9a15-039c77074c4b@oss.qualcomm.com>
 <8cb5e28c-1c6e-450e-855b-32491ee73885@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8cb5e28c-1c6e-450e-855b-32491ee73885@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HdUkiCE8 c=1 sm=1 tr=0 ts=69e8a656 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=wI2HHqrEW52EUbEo9zwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwMiBTYWx0ZWRfX/MLtP4pgMsyB
 +rCMwldIxieE5/PFoajMmzsoYalnC3uZP9lDQOYN+HcZTpKGBEJniNr6ssMAJQz5PeVt/1cEE5E
 UHPzDLbpC28odnlAt6DGElkWiKBJIkhQ/eBj8SlEzR1b3SRgH+gf0RiGzc98WAXwJy6Ogy/iwB/
 tgBUY+qSACAqWDRqtEcoXEQn8INPaQYvYAY32j9A4MWx7dyWv49dFa20CmOO+5GC49GRid6dHMw
 v/hMSdNfRmolHUYfh2QkcWhfItcHgZZJSWjgOAckq3CWQDHViaInHhpQ2jweMzSnEaHNKItOZvJ
 JZ+aNfrQmzL3ROf5L06MAiqe2OGMn9fKJf2rS1ogUdeQOwQ62bcSOEREkAq73QHGU2dcQC22ysn
 Toav4AP1EXaj1huGj+2N6C+MVVOqgKK9u2uy54AcPqZLpvNhXiZKdo6S2feTUnZMdMwFgeiZvIk
 GSeq021WwMP2YTz2dXg==
X-Proofpoint-ORIG-GUID: LY6L194qtJD3YVd-fVJP81XvPdHnVneE
X-Proofpoint-GUID: LY6L194qtJD3YVd-fVJP81XvPdHnVneE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220102
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240312-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,0.0.0.1:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,0.0.0.2:email,0.0.0.0:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D767E444DCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 12:32 PM, Prashanth K wrote:
> 
> 
> On 4/22/2026 3:56 PM, Konrad Dybcio wrote:
>> On 4/22/26 11:39 AM, Prashanth K wrote:
>>> Add the retimer for usb_1_ss0 port (USB0), in order to enable
>>> super-speed enumeration on that port.
>>>
>>> Fixes: c11645afb0e2 ("arm64: dts: qcom: Add base HAMOA-IOT-EVK board")
>>> Cc: stable@vger.kernel.org
>>
>> This is a feature addition, not a fix
>>
>> [...]
>>
> Sure.
>>> +		ports {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +
>>> +			port@0 {
>>> +				reg = <0>;
>>> +
>>> +				retimer_ss0_ss_out: endpoint {
>>> +					remote-endpoint = <&pmic_glink_ss0_ss_in>;
>>> +				};
>>> +			};
>>> +
>>> +			port@1 {
>>> +				reg = <1>;
>>> +
>>> +				retimer_ss0_ss_in: endpoint {
>>> +					remote-endpoint = <&usb_1_ss0_qmpphy_out>;
>>> +				};
>>> +			};
>>> +
>>
>> Stray \n, but you should really have a @2 port here as well.
>>
>> Konrad
> Can we ad port@2 and leave it empty?

Why would you? Just connect it to port2 of the connector under pmic-glink

Konrad

