Return-Path: <stable+bounces-240313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKwzFZ6r6GnEOQIAu9opvQ
	(envelope-from <stable+bounces-240313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 13:06:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3864451B7
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 13:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A49363033D30
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568343CEB95;
	Wed, 22 Apr 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LAYTeyj+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T214GSNZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847083CEB9A
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855891; cv=none; b=RulXdVbYX0uLYUcvHcLuBRhw14Zlw60LQMsboTT5EHPmi8KxYJVW0YpnDBtbNsLfHMCLS8GQY5fdtjaTlEYeWNhvf5UOjLoOKP1LdBT/gPrdxtg1gCGaCDp+ubAV5gNBdJ/l3O7bgrJZcS1a6yUwCXQA/yLNWYhy71+dwyTsVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855891; c=relaxed/simple;
	bh=z9lv9+r5ppYRjtDnLSoQ9OQK0S2aqiF1TS2qN+3D6nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU7QNwJ2eiF0ifTF3+vQ2OyUEYfS8k+zkVn6TvD/gIiNO6fQ3n+5z1+rxe7X3pYfFGdXF7di1QdKmD8ugmUf/2qS6dUg1aA1bV9+iorfSJg6bM0sX+hBPabNr/EP3yzZW8guxCHZryKfy0psAfBwrWF1F7SSsMSvkDmLv607a2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LAYTeyj+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T214GSNZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MAYFZu3083500
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 11:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FWXy8OcOaaCu3NIsYMYMqkmcBsT+jSpnay3Mi7lFK98=; b=LAYTeyj+ptuNJaFB
	aRLA6KxE0DbvHbCDFlxnbJ7ybD781xIxypEtyep5OEawh5lYYWIL9DebLpxLW9cu
	d9YHlV6Mc2ZHNps7lS4S+78CKuJytUQyogmGy6tm/pi+Bslq8HPms4YeUlzmueF3
	Jt64oButKmbrr2Dfx6Id5ZXP9AO2nDKoZ8rp+XOypW5eqeLnh7/RBHg3XBN9ZBCR
	BYYkJcqgpIs0lpQv/CY83BbwstZfnbwZZKVc18qtZL62BU8CJlXeKCgQDkNccTxQ
	9iA+agStwJ55CSznWHaWa9zASGS2Ce2x+Htv4PaMLDhqRJGLdazy20b8z/GZlfHB
	wDPHUA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmk6m0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 11:04:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2ec948174so49788945ad.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776855888; x=1777460688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWXy8OcOaaCu3NIsYMYMqkmcBsT+jSpnay3Mi7lFK98=;
        b=T214GSNZ4cZ5ATz1IqN20jBowEYfD2Mu1DE0SL8ujlAsWTokUv/t0s0aXYg27xS16k
         pW/+NJyMvgQgh7C/BvXO97CdUblTwFAhtMuiCki/hvyz/xr10bw7x1b8lAUaAsPPuc5l
         dA1EAITATLIeMwuAqg3+z/P7FF2vBuud/ywfwSiXrMLoH/7u7/+nalE7HDxf4aw3yD60
         fNTBqwR2jVaaKEGqloHHLfPqbQf96fKJa7zEGoASxotyzrOJLcL0Jw2Dg89VTtdxQdq4
         6YIewLx1YkO/icIdj2l8afMcKqnZSwoWNV5Zfy8KJPD9U4+y+p1e0KrXlwbHpgFyzHs4
         MRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776855888; x=1777460688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWXy8OcOaaCu3NIsYMYMqkmcBsT+jSpnay3Mi7lFK98=;
        b=b8UaoNDI5XPCRgWbU2iUnx0AcvZG0CVK3sYwEFTBzJRMG6BKNcapmxDR1DppH7984n
         8j9erDTe3N1bjwMS1EX7q16k27eDrelmZypIERElYrm7uLZEnJ8EDIYoJFNLoiX46Wzh
         7BaZYAVpBnoahxUudJJHb2QPl6+g3F1+4cx6yoHGSFHJrx9KSJu01qDH3TNaxAYqMyjB
         Um6RG8j6VjgYVLDGgvpjtXdto/gAsYgzvdqXEw3N5U/n0qJjhTH2zFHHozCMaXq+P1o9
         kQKlQbOMftSK63s6nkL5Q2EY/V9MzGBfkGWUyBbw4S2X4W1Swvkb8zYx6BMqwilh2yy2
         x25w==
X-Forwarded-Encrypted: i=1; AFNElJ8TuSDY4UDkhqijrYQZduyuB6VurHlkEWpkmU7hliBYs+fsN5jx5+T4xvclbVx6PkJbPb0HMHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++cwnEzhhi1KwMIgmEIuN2kC7d0Z3RuOqJ1/IYT7EYM7pRVkK
	RR2B7l1/S2mloM8Xt519dSbPbsTsSdXYAAlJG09jtHSH6AIgFpVuHfZhbDCNT+JQjezKFc8lZML
	7SESAHf9q6VM3R2nlRSXd8on8Mw8G3KkEDtb2fYEALHTYbtPRiCsaxfn2tgA=
X-Gm-Gg: AeBDievBugKXS1VWJe1Ki8ma8/MQ5FxG2cCJGauGZtcWeKsqZTA6L3A8VObsW78hmBI
	NhTRbJkjj/q/0vSVm2qC4fbqvsnEifapACM7Q0KF8iIYM3zSCVtIA7ud47ZNLJdov+HFhbixD3v
	JprqJyDcv7LEENjVsCfksAWmlsUi0BF4XjrTDtjEBUDlKaCv0r/E+kcWWIjJARwoOs4wBu44+ZL
	Me7fNqdazXa9xNtDa3SJFqcR0dlHk8XLkxSyj1dcDoenAvHSy8OhRAhIqWD8oG6nkSThmM/6m7n
	CmgeAP+ZtcKH9NthTxIS1o+lTIbOYlovNRxW2Rp6560PqeQIQv2AMtPGctadlWJqneGp+o4AzRq
	kfpUCJPXzlig7WcE/pkyUlWY7K6ygQdL8oF3Wth/iU2X4ZYxuSybegJCRa7XP
X-Received: by 2002:a17:903:3c70:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b5fa02f3famr239283885ad.36.1776855887741;
        Wed, 22 Apr 2026 04:04:47 -0700 (PDT)
X-Received: by 2002:a17:903:3c70:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b5fa02f3famr239283565ad.36.1776855887265;
        Wed, 22 Apr 2026 04:04:47 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa4f092sm163267555ad.36.2026.04.22.04.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 04:04:46 -0700 (PDT)
Message-ID: <79926b02-a892-4e59-b794-e8534136fe07@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 16:34:42 +0530
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
 <8cb5e28c-1c6e-450e-855b-32491ee73885@oss.qualcomm.com>
 <3d50f17c-060a-4a1d-b539-1bea9b3e6cd0@oss.qualcomm.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <3d50f17c-060a-4a1d-b539-1bea9b3e6cd0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sKk0xsUkkCqMXvDj7ho8KPMV-8fDai1R
X-Proofpoint-ORIG-GUID: sKk0xsUkkCqMXvDj7ho8KPMV-8fDai1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwNSBTYWx0ZWRfXwtSqf2xGQl+/
 2n3oCK5luHF8Vnh8l1x3jFlb1EtJ/sFTwvdZmQ8ZhdXPBK/kdhpFy2obWThkWQ+78CfTrynqJNf
 r3JTroU/XHLosF7F2vnhaQQ3edl5D4b7NcxTbw6Idn9/rVIum1qE16tZm59kNpV1atTWdHebtMa
 NaOC6Bhw9/y8TkBOCJuEatX2N/Eohn3kIunHodibm3rBfNcAxr55lIBmG5+csLN/6CumYbSuafj
 ZBviRTzGdFdgxinFVJ+I7s1FRYRb5Iou1E2ktx/Bn0uusXmcNGfHHuXMOEl4goUYZ0Yt3DF/uxD
 qUPQDOs+f71O3xwj/5yxVQw0xHshICjl63dtsYVWVBdHt6gir4zN34eSSrJhFGVKqKh4U7rcZ+l
 A8hLkS+cFkGxE4V7LFDknc0HH8HpXIbBFuvUg/usGCN6vLai+8j7U+b2DPkV7ovrDT/8AnA5RzA
 KoWfJwlWUuHO2MW+wnw==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e8ab50 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=tEhQ0zN8AMmkZOfa3WAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220105
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240313-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.1:email,0.0.0.2:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prashanth.k@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AC3864451B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/2026 4:13 PM, Konrad Dybcio wrote:
> On 4/22/26 12:32 PM, Prashanth K wrote:
>>
>>
>> On 4/22/2026 3:56 PM, Konrad Dybcio wrote:
>>> On 4/22/26 11:39 AM, Prashanth K wrote:
>>>> Add the retimer for usb_1_ss0 port (USB0), in order to enable
>>>> super-speed enumeration on that port.
>>>>
>>>> Fixes: c11645afb0e2 ("arm64: dts: qcom: Add base HAMOA-IOT-EVK board")
>>>> Cc: stable@vger.kernel.org
>>>
>>> This is a feature addition, not a fix
>>>
>>> [...]
>>>
>> Sure.
>>>> +		ports {
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <0>;
>>>> +
>>>> +			port@0 {
>>>> +				reg = <0>;
>>>> +
>>>> +				retimer_ss0_ss_out: endpoint {
>>>> +					remote-endpoint = <&pmic_glink_ss0_ss_in>;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			port@1 {
>>>> +				reg = <1>;
>>>> +
>>>> +				retimer_ss0_ss_in: endpoint {
>>>> +					remote-endpoint = <&usb_1_ss0_qmpphy_out>;
>>>> +				};
>>>> +			};
>>>> +
>>>
>>> Stray \n, but you should really have a @2 port here as well.
>>>
>>> Konrad
>> Can we ad port@2 and leave it empty?
> 
> Why would you? Just connect it to port2 of the connector under pmic-glink
> 
> Konrad

Because the port@2 of pmic-glink (pmic_glink_ss0_sbu) is already
connected to usb-1-ss0-sbu-mux (onn,fsusb42). This is different compared
to other connectors.

Regards,
Prashanth K

