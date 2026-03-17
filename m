Return-Path: <stable+bounces-226093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBeeFAxwuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:15:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FFC2ACC98
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36031310325B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47FB3DCD9B;
	Tue, 17 Mar 2026 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TVzRsgYt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YhaMXh96"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A23EAC69
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760015; cv=none; b=SgEAzdUHEDwxPakieniP9yFh3f6atjn5yyk99yuRN6B9KMrXfu3qx26pgsMEBZ8z4fPvN0DnuUnivyQ5swK79EHzc6ezDHKGoUsSBrEca2Cj1puN6QnBYMnCJpqvS4ttOsnxr6nwH1xYqa1aAA64JHX07pgJOK2AVBoMwSIvBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760015; c=relaxed/simple;
	bh=eSmMrMrnVMKz1nRXC4PqL+mXVL4uTd82t9e0KsNYTdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnnpPLZ+oJ/+SPYqnSuZQUZfSYmJyxJtUArlPGzdEyBucNTX+WAjHJ8IvnbH2JcBqO+QUMocijskcNAgdB5FSMa9dWRtgJTRd4hJDOGCmjX/pBnuEtD2wPTIEZ03U9193lDk9mzvd/Kd0vaac2XTcOOJT0B6YZBjmc2QRUsg95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TVzRsgYt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YhaMXh96; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H9IPM73102148
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	viuuphi5xmv4GBJcFw1fL3vLWW/8NotINZPLyUiZJJE=; b=TVzRsgYtpC7W2UrY
	9sz8p/VU6fwdgPdLOeJPyWrSxewZWANWaFkneIHohYj+G6/D/8gyXzePS3N5qiC6
	TeniPNu62TlEme+6oiqvHb3VVRmiqdpBDGkiQxc5vFXKckdVG6VF/uZarcyg9TN6
	xONOqaa0MK3ro5cOJ8g2lvXxBoJRmtkyJ8iUKV0qq8jw/KgheQAMpMZHn53+H+Er
	iUwvxPTgTLnnCwO10oedgBjpt6oOcJsATPvURlDUXO0ZcshVPmtOm+N7bVIA3LfL
	A5ZBydTXLSc45UofS8ZYNS9a0gd+nItse5u0Xzg3n53hb5UrSGd2jTbv0dK+Y6Td
	kIraNQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxnb7cb58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:06:53 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5ffbef72dcbso1080107137.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773760013; x=1774364813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viuuphi5xmv4GBJcFw1fL3vLWW/8NotINZPLyUiZJJE=;
        b=YhaMXh96KIxxOfHDWlfuv3x/6S4G2bRZXqD3THEbb2vFuAZUa7Zeq+YPF070OBt2N0
         M4YKJHM+38UI4uLxU/fYmKryefl6Uw/EAmkZ/ZhhvAH3uaExQJjMkWFciMw8fsTvdVHO
         QfZH+I5pXP29+ga00vloLQxb+Z1ftQ0yYEta9rPj20P6KHTO30QnwA3T6SHvuQIEoutX
         Os28rFq4MIhT2J/IupkGOzOnWtb2xp+z8yqPsjssojFxCCs3CHMCIDpvy/+eRslP9/dK
         39ZoxKMgX+eSvEO8Z2T3TJV5/SKarVbPBMjviOo+xdWn7GfEOvC/a3AMUcl6J4WklXAM
         JawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760013; x=1774364813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viuuphi5xmv4GBJcFw1fL3vLWW/8NotINZPLyUiZJJE=;
        b=HViXtqwIJhHSltSlhgaB8HXNfiXTDPNDbD3yHvImAE2CZuDD+Xdou4SU86i9FUDoYQ
         9MB3DKrKLFgj+6a08piyRv+gaXGwgohYh4p5ioaF8DwT8QcM2WzwbeMe5P2N02bEm04N
         KkMcUtKlVGITzfEJPcujPeB7V6zToZO/+KJ/HM5nXLNKLSF2Ypi6U9VClv4kAw8X2Ndx
         mhIvv7CHl9N1ZL4PiF1ZmXBmuN2StLlWQ5OAesK91a1A1RMDcZdElKcTUlUT3+e1NteK
         ZLNXTLKKVEGMfY8Fpdh/LxcDu/qFxx6O75Jl+Z3GViN9Vkn9kNVpccCoXHlmWQbOrp+3
         WD0A==
X-Forwarded-Encrypted: i=1; AJvYcCXvNIIM5pySmJOhbTMQ4Aq7ENUY4Bn9sLv5C28I/U2YI0lKkXiWE954e4MmHtC82veYt8E7n8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxw/tF76TBpiGqjj4RfUxL+WlQYAMEXZ8N03VOzOhzMlAzBx/
	F7EAV63BIycGy960eHifznHfKxZV+plzfbYyMhSc0itZ98SFozL078XJE9meSUr9dwrvSBGs7dF
	RmHydrroadKBTmN9PQcy94ZZdPFyArK/ESBGl5jTj1jBw3SHI2/wGJk2xskU=
X-Gm-Gg: ATEYQzyFQVFeAYKSSEWvoO5kUkv0/sfB5Uw2n+IDEaJC66H1GoR2DE6of2F8ihIzj9n
	Wtxd9EstQARK5DNphKWC84F2rNR75OQLPyntt6TPg/wdD6lRq/1vv3E7dtaq2RfM3WvHrZdaa/6
	jomvZPL9b7GOWceLFLmJR+l+xjrS6Qft9sOiGdiTs0qVtbyRFO+Tlw5lP6VaPFIGv+umASxQH0/
	aAq0cWiblHaY3GukyiQuMpRSx7Lf1P4ZIpu2IGeK1+r7XLhh9F4p8HY1C9T/rpuLrE5jE3xBsU8
	l+fYwAUxERNBobUJCP+A/r4XwnBGsjyuP8SIXEpQkHVwaF8JS5Py4EWiL66ygznhzmb6pnVxQ1j
	CYTEUznGix+Noqjr+jLXJdWc8nspqA0mLcLYP7erSIFQ7U19gmKT4yOLFANsPQOFQ7SUiQPVKZ6
	JNPTk=
X-Received: by 2002:a05:6102:3049:b0:5ff:2425:a0e7 with SMTP id ada2fe7eead31-6020e68ae24mr3172898137.6.1773760012618;
        Tue, 17 Mar 2026 08:06:52 -0700 (PDT)
X-Received: by 2002:a05:6102:3049:b0:5ff:2425:a0e7 with SMTP id ada2fe7eead31-6020e68ae24mr3172873137.6.1773760012132;
        Tue, 17 Mar 2026 08:06:52 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667aecbe63fsm42292a12.4.2026.03.17.08.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 08:06:51 -0700 (PDT)
Message-ID: <ed3fdccf-d8b5-4f57-871c-8a9cb8676606@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 16:06:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
 <2f4e4cc7-2600-482e-88d9-d4b20d328a72@oss.qualcomm.com>
 <drcot4oxpea5lnpa5htrrl2n6tcc4ocxmb5vsho3ocouvajwlo@6ueabivtjy4h>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <drcot4oxpea5lnpa5htrrl2n6tcc4ocxmb5vsho3ocouvajwlo@6ueabivtjy4h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzMyBTYWx0ZWRfXzi49mnTNkos+
 91EDTd00jg8/x460pAlGvi6SGi5NL3luau3qzZ0CIpJH3bSvXt/JNHDvD+Ql3oNxHGoCvseATez
 MaWqfdVql+QE5YD+GnCCIIOYvrXHIQCwarclnWqH1pTr5jpFEV1RrYlySvt2nHsxI7S3U9DiXtB
 rAD6Kqpvg9kZnITe4soNiVOgiD00T/lPkgIulv2qgEEbh+JhoIeaqcLQypBkSyjyqgHdsLE6K/K
 V0GBWYY2JxNeJFSUZqwTc1VshEETW89ySMxXkwIE7WjgWfRtQ1gwDfDtPmEKCS3SNecTajtjnDC
 WePuo/pZZGLkWj4sPvJQDMUu3kiJeUzaSqWBQcyXClEZZd8tVCYDL3WNZr5d4Ehbni6DDhm6UH+
 J3zelipE/skoxQFMX3iCoFgR+ssspQ+Q7j54/AAWw5Kg8J72HQhLGVOd3LT2mREDv8phbOApmrE
 OA4wDJRKETDbInPS1mQ==
X-Authority-Analysis: v=2.4 cv=D7pK6/Rj c=1 sm=1 tr=0 ts=69b96e0d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=i3U1ZhqbavsoaJQYhn0A:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: CC3IgDBwStst3Rd2i70N_-EPB8VDjiV2
X-Proofpoint-GUID: CC3IgDBwStst3Rd2i70N_-EPB8VDjiV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170133
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-226093-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F0FFC2ACC98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 6:39 PM, Dmitry Baryshkov wrote:
> On Tue, Mar 10, 2026 at 11:36:26AM +0100, Konrad Dybcio wrote:
>> On 3/9/26 3:44 PM, Abel Vesa wrote:
>>> According to internal documentation, the corners specific for each rate
>>> from the DP link clock are:
>>>  - LOWSVS_D1 -> 19.2 MHz
>>>  - LOWSVS    -> 270 MHz
>>>  - SVS       -> 540 MHz (594 MHz in case of DP3)
>>
>> This discrepancy sounds a little odd.. can we get some confirmation
>> that it's intended and not an internal copypasta? (+Jagadeesh, Taniya)
>> FWIW DP3 is not USB4- or MST-capable so it may as well be
> 
> DP3 link_clock is sourced from the eDP PHY. I assume there might some 
> 
>>
>>>  - SVS_L1    -> 594 MHz
>>>  - NOM       -> 810 MHz
>>>  - NOM_L1    -> 810 MHz
>>>  - TURBO     -> 810 MHz
>>>
>>> So fix all tables for each of the four controllers according to the
>>> documentation.
>>
>> It sounds like a good move to instead keep only a single table for
>> DP012 and a separate one for DP3 if it's really different

Please do this and resend

Konrad

