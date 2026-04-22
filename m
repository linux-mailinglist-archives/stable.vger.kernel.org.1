Return-Path: <stable+bounces-240307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNFAM4Ck6GngOAIAu9opvQ
	(envelope-from <stable+bounces-240307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:35:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E899444C76
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81DDA306BC73
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB3836A022;
	Wed, 22 Apr 2026 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVMv3m59";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AaE1pbCi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9223A5E98
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853968; cv=none; b=Et5OrAesUdf1+TmEbQbf+wUV6whUo/oKUpbTId46RWcMCfrCE81+k7Tpyq+dDbFKifvrBorFCe7ACowJQSVDFPYqoqOVSH5iwuxIK1rvtPRc1z/g93PMUwK3n+2CmZq1nnaTX7wtYq+u4WuhnB0PBVcuVNRIdSZvLFR/1zVq/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853968; c=relaxed/simple;
	bh=rIFfrXsNqItade2pDyhej3CucOfiOYuuR3y4hDhrMAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OapsiCspY2rq7MJ+8s9bwI3OvVm77DnaHRhtxrQBPeK9om53wpuUNSwnCo5TjCna6+Vo4Paovsedqb0LXDLMIeed0cz+JZx9wHFjoSyNFby8Fnofv/n+BERzxknn1cKtRgMwbWmbkege/a1BWLYH/1UMmb6eEMDhjdpSkaByGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dVMv3m59; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AaE1pbCi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M96EHL664048
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XS8rWs2PV+b0Pwye+4y9eJeB+rJFDeOBFQOuGjsERsU=; b=dVMv3m59G9nSMnzg
	U6TzqNDpje0grW0dIFlVs/6Gyjp8HD0p48T/KkOTkfy+/eSrATna9LM0Igwrw3Pw
	Kf7JtaZme86UtaEkuqfKVLjOyTZMG4Cw9DwiFVIRa3qZpAeQza8hJpb+p5pt9GZJ
	JwdJZuN/FYEELGL9L6bv+NRiTO5eSZOjhKIqr62zQb8CrolwhQ4jgvIMPcode9JM
	ti69nuse04NiAK69GqLS6fZ8HURXAZsvvk6jz2j5mvGCH+g61/GPin8mUhIwblEo
	CEqiKlwWEg/ZsYL0kALBxPRMdvZnTT05WEh0gWO4Wvk+GtoDke4AUtGnYNH1ljo8
	YPvSTg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgrba6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:32:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c798e905c29so1620212a12.3
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776853965; x=1777458765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XS8rWs2PV+b0Pwye+4y9eJeB+rJFDeOBFQOuGjsERsU=;
        b=AaE1pbCiU8EDC4GKBqoxzgezdnv1kdjvNKqSnqNNG2ibwsS7hsmX9EWFPat0JKcyDo
         GDxKzUppsf7IHnZQU/eA2uW2KQrBkqoN9je+wqk6OehKSwU+q7d3PymreLiHt4JUQlQm
         ttzx7ywSmXWGhUVDc3SHWk0F5liZYNj2tdTYOhJYQl+IGO5PfA9FyEo4TjB7iasIlEmI
         y3ZbIix9AMXfNapoy7mr8KDt2jWPHNSUsReqChgKD5ds1e7b6ZZAR01BhOxTkMQaOJhx
         o9XZ5JdZrl/Eas3wv8V6kIz10i6Pc7odzQk/+oIvpsRU2LUlFbEJaJZ+AuigifXRAO2E
         Vhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853965; x=1777458765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS8rWs2PV+b0Pwye+4y9eJeB+rJFDeOBFQOuGjsERsU=;
        b=GbYnympiafb/7JCTGVP3e4dxEKLI1k4y5l5BUDR2X6VQkfONTLbvU3rzs3mPuWLsXC
         7LhYEEOsk0e7KQI94/sLI48cnloWby/Z6BylEs2XTdqoqdfNXV7IBYQxBz5rnV2rngsC
         rCI19OifoPfDK3jX4dgdbhFFx3F6gSNjXkQjORhTWufyPDxkr6peAx1vZdEK6V+L35QD
         oMba/LSlO420UtBAsdZA1DA/pJqbp+ydCg3DXdBCtDlv/rfVWI28vxDyWtlOxAIWc+Xz
         ZaizC0vgCP1lEf+F1ebmxU8aPmOfuIWXY9u+puciVi5puKyFSPWb9Z++xh7pnpiavLBY
         Qkkw==
X-Forwarded-Encrypted: i=1; AFNElJ+iPdwF7lK+2jo1WZr+1mcBzUq6GAOERty7hSt+oeD1g/WrGY4hgChWb66nMj3VsrujMQymmuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyONXtTzJxNdm+mFPMd4eY1F1lwnx1WkEqTaDD8Z4++aR3ocWjf
	8Yth9VXNkz7jZ9eeTnBIeceoLamO/Yiyr60jRJCsmfs4jhc0iJyKbrSXw7dKjuZuX6EBqw31RcP
	ctOtkueki/JwFvxElBNmhtq1cKhW3UZK/avQaPOBcP5dOTG5U2IG34hbvDJY=
X-Gm-Gg: AeBDiev4IWYWWgSmla0jvlK0uI+6vzMu6+vkC5N9uj71f9blrkGXaSz8Cw5397QTtwu
	/C1mWH0/LEvL5kD3yyRF4HwVTcJ0zVzGyk7COGhe1l6Okf8SE9eKpV3dNsgZfyENuNQQWlJk9S6
	MHZzJoT0BjEEqnqpnZn1ofQ9C12TqmAAWtEHTVGy4YyXY3Y2K7G9dVqyPMrcYyy/noFNHBNfx1J
	DYBA3oPcqcJALnxHK7KMoQdSs95zainguZg6Jm2AHYr+qBWcB4cTeVUOOZK/nlQDweK/kDUXhYD
	T3oEyBaK0Afv0icmXQJdk/uRhFU6k4f6KsJdzYt03XJNEUN4jGGjua4jVWeQMrW7OaaxsfrhUUn
	qtmJUm0HDBAM/ZrbnWDOsWr7SdYsXZekSIkXdMCEwELEQ3L79sViQseTYTdM7
X-Received: by 2002:a05:6a00:14c2:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-82f8c856e48mr22036480b3a.14.1776853965256;
        Wed, 22 Apr 2026 03:32:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:14c2:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-82f8c856e48mr22036453b3a.14.1776853964794;
        Wed, 22 Apr 2026 03:32:44 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981829sm20345091b3a.12.2026.04.22.03.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 03:32:44 -0700 (PDT)
Message-ID: <8cb5e28c-1c6e-450e-855b-32491ee73885@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 16:02:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: Enable retimer on USB0
 port
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org
References: <20260422093924.2976069-1-prashanth.k@oss.qualcomm.com>
 <6c2c5fd6-c032-4658-9a15-039c77074c4b@oss.qualcomm.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <6c2c5fd6-c032-4658-9a15-039c77074c4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XaF2utqG8hCrAypa_dRINTRUeg32_DLZ
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e8a3cd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=SFoN1qW29ypxsV0XCrEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: XaF2utqG8hCrAypa_dRINTRUeg32_DLZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwMCBTYWx0ZWRfX26A816kjzKMD
 V/GRg95yd+tyohw8VcX+nRBrkKNtzNqlmFd9RxUeY8DDnSP9YdF5le3jCwc/HrNPZohYm9qIAJv
 kKuZwKcY3Rh0TMNgtK/e2jbmkfEmB2Y1YoLWYJ8cxn6/DfU+O96vVp6gwzP4cBMfKQn9yH6mYca
 KpvNmGOjDYiivpK9PH72J1WxEXjhwojsJRzz/lpnRbfyFm1t28kb7/fUMr3xskBVfN3i0MR2Dq8
 5nKmSVAcdaVqzkkWVY5RbNxgNXEc7ybw0inGF+4K2mHBHRX9S5KG7gZBmK1dQf0PxGZxiuDubYr
 e+z87C3Zhqr61LzEQM2tlPGqlPbRWRVrX5v1+cADQiRvca87p+Pkc3bQFMGBm63+4HijpNVaC4x
 IPUt5SubviWYoWR6ja2BHclPZx8MWufCCBsA5Oxtw8/27UIZLf/WCIJn8WaNZpSdxcR8NMYRHet
 88sIdHKVPqlTtmjkOVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220100
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240307-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,qualcomm.com:dkim,0.0.0.2:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,0.0.0.1:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prashanth.k@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E899444C76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/2026 3:56 PM, Konrad Dybcio wrote:
> On 4/22/26 11:39 AM, Prashanth K wrote:
>> Add the retimer for usb_1_ss0 port (USB0), in order to enable
>> super-speed enumeration on that port.
>>
>> Fixes: c11645afb0e2 ("arm64: dts: qcom: Add base HAMOA-IOT-EVK board")
>> Cc: stable@vger.kernel.org
> 
> This is a feature addition, not a fix
> 
> [...]
> 
Sure.
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +
>> +				retimer_ss0_ss_out: endpoint {
>> +					remote-endpoint = <&pmic_glink_ss0_ss_in>;
>> +				};
>> +			};
>> +
>> +			port@1 {
>> +				reg = <1>;
>> +
>> +				retimer_ss0_ss_in: endpoint {
>> +					remote-endpoint = <&usb_1_ss0_qmpphy_out>;
>> +				};
>> +			};
>> +
> 
> Stray \n, but you should really have a @2 port here as well.
> 
> Konrad
Can we ad port@2 and leave it empty?

Regards,
Prashanth K

