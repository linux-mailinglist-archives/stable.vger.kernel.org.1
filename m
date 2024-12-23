Return-Path: <stable+bounces-105596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A061D9FAD55
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044E87A1F23
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC762195985;
	Mon, 23 Dec 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7kH3aJC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7AD2F3E
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734951169; cv=none; b=FijGaDTxXWaF76fx4o0WeBJzVf7JmuQX3lemEc1YnJ/PPJ9v4Q+Mh6L6LJll8YuMk+cAh2Mr3iIM3iQEVa5OfZDRWGEctxxjsK/AI8Arb5GkyaEwWvHoN5+kHk+IWbIayuSlhR48xJ2tLDYLid1WXvOoIWwiIQnEQ73niX9p/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734951169; c=relaxed/simple;
	bh=LM8OSrUOYwCNDYvcciKV3jtUOXdDHD5fBI8wPPy/WcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvEt9LA1Xx1Hmk776f3sptwTU5Ca5SL0L3df7CwqR26fK7ifNNhyZ5J/1i1wJeoOyMtm002Kg+csMZEgeIkJ7OI4XsXGClvk9qX+Z3JR27Mar/H6IKqNefJEDNc3HJpLc56b130knymx4JaD0xmW+9vvO5iI/zjNunTQvjX3554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n7kH3aJC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN8oUSp026562
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EMRdg/OIqQNr7xAUZNOe3kvtmJPvcVqbFUcCeJgfvLc=; b=n7kH3aJCy/Ag6ORj
	h2VESAr8H2fIwzzlcs1NnjhUnsY2gRho6saG11RgqmNZBeTh6OfG6i7zfqHoauVA
	gJRq71lMsvfBngJlg/KMNbqCBIhewI0SWfKqHPfUYchPyIeux1QX0+Xxr+isypQ9
	BLKvxqwU9zKOQhN7685OWjjkIytLKTKYPjRhukmuztT3LJCaweW75OCJ8md1fRaU
	J5I4ArYcR+BRYOP933wUpHWEwlVFcIftV3y0prSBAcaeyVQAn1Z8aif5SOKpSxaV
	rYhIiwquAKoQcaiDs1Li7hQWp/R7le6rxwUa4kInvQfL/RsjtdjGWP8NHCao1ejJ
	V9FiSg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q4q4rac0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:52:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8824c96cdso15013026d6.2
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 02:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734951166; x=1735555966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMRdg/OIqQNr7xAUZNOe3kvtmJPvcVqbFUcCeJgfvLc=;
        b=JnLR/uhkl05TTKftABfabDoe1tv49jk9hlpl3wrX26+3WahnUqO3JFTuEIABB9X23k
         fz7ljuwQAWp5O2dD1JPoBVsgX3TyyS2H1WVQUvJGRAkg9eAZQjmcRQc6FCcJePoFxaNO
         B8Y8wuh+PUW5mfJL1XkE+OOK0asdLyRAwF8bExvndNWzX0p3cVDnHPsClomRSCGDR8K5
         9rxNV2uk/Jy2MoUJX8eHU2LGFRLxIH09hgSNZ6q3PlAGCp+xHaJh4+3CHdcPsxpSYSJz
         6iquQxrDgwBMJ/x3DLImECNBMQINsXfVMumRYORqxoVGy2LfSUgbPkSbAjzlKO+dp+Pv
         hBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBOjrK9NGkxkxIjFt+wLcTg8GkAQ43yb2iDbs0Jo1Hl64EwfCNXLKS/p6o07n16w4TEo6PrbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3s4f6Wgd2NEZICqMazPZW0yALEp6gJp55cNUaxkFT/168V+I
	wGUaqZA9U5kNjmu2QKPZh29GH/mHTct9pcievKRDpWza+qeXOVZ/Sdb41mD4/dB3JDnZAb/B9U0
	cM2Kodjlazr9jQd8CqfXPx9N+fFhofYvXVcTBfS2UPiBs4untHhoQaok=
X-Gm-Gg: ASbGncvbmaGWHezePnSvRvA0E6i5/DoMjLtky29eWQ9MB6/HZ2bGI9qVTqxqUzQkc50
	EujV1gspn7Rk99G/9QM0tksayIJPoyGVasMkvB2fqdL+X/mwSwQc71mNINcnISeyKveJFzDkO9S
	G0tbhcN3gvzaLNFgmPvSC1YpcVwXrQC6s2yGFrD85jkI8EMZg0KAUAMyJSNlzMyMTezyQQMW1wx
	EKBPe8EJNsy5LMlzVP/Q4exOxfkADRTVEKuj+GNQJWavl2ObRWjB0hnCsMD2gMV+B6XDCoQNzUf
	A+CMv54FaGHn0wxtzMbAzWoKz2cS4zRarew=
X-Received: by 2002:a05:622a:607:b0:467:58ae:b8dd with SMTP id d75a77b69052e-46a4a8cddb2mr80286301cf.4.1734951166053;
        Mon, 23 Dec 2024 02:52:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsvK7GklQCrRrb7YKGrDVuB/HHc6ybyiUNNilnmdUhns0V0MSYgjIsvc5OHNCe50TBFwWtNA==
X-Received: by 2002:a05:622a:607:b0:467:58ae:b8dd with SMTP id d75a77b69052e-46a4a8cddb2mr80286201cf.4.1734951165621;
        Mon, 23 Dec 2024 02:52:45 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae4369sm502017266b.87.2024.12.23.02.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 02:52:45 -0800 (PST)
Message-ID: <253e7889-bef4-453c-9f39-19ba0a6dd5b0@oss.qualcomm.com>
Date: Mon, 23 Dec 2024 11:52:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] arm64: dts: qcom: Fix remoteproc memory base and
 length
To: "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa
 <abel.vesa@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
 <94a6b2ba-fa52-42d0-a60d-9dc31e37057c@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <94a6b2ba-fa52-42d0-a60d-9dc31e37057c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Bg311bH8d8_dOBcZuNQVOke392qvGFn7
X-Proofpoint-ORIG-GUID: Bg311bH8d8_dOBcZuNQVOke392qvGFn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230097

On 23.12.2024 10:21 AM, Aiqun(Maria) Yu wrote:
> On 12/13/2024 10:53 PM, Krzysztof Kozlowski wrote:
>> Changes in v3:
>> - Add Rb tags
>> - Add four new patches (at the end) for sdx75 and sm6115
>> - Link to v2: https://lore.kernel.org/r/20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org
>>
>> Changes in v2:
>> - arm64: dts: qcom: x1e80100: Fix ADSP...:
>>   Commit msg corrections, second paragraph (Johan)
>> - Add tags
>> - Link to v1: https://lore.kernel.org/r/20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org
>>
>> Konrad pointed out during SM8750 review, that numbers are odd, so I
>> looked at datasheets and downstream DTS for all previous platforms.
>>
>> Most numbers are odd.
>>
>> Older platforms like SM8150, SM8250, SC7280, SC8180X seem fine. I could
>> not check few like SDX75 or SM6115, due to lack of access to datasheets.
>>
>> SM8350, SM8450, SM8550 tested on hardware. Others not, but I don't
>> expect any failures because PAS drivers do not use the address space.
>> Which also explains why odd numbers did not result in any failures.
> 
> In my opinion, the "QCOM_Q6V5_PAS" based Peripheral Authentication
> platforms may have the register information completely removed.
> 
> There are two types of Peripheral Authentication supported:
>   "QCOM_Q6V5_MSS" (self-authenticating)
>   "QCOM_Q6V5_PAS" (trust-zone based Authentication)
> For "QCOM_Q6V5_PAS" based Peripheral Authentication platforms, use SCM
> calls instead of the register-based mechanism. So it is no need to
> expose the PUB reg addresses for those platforms.

(Unfortunately) not all boards using the same SoC have the same
firmware stack, and it's not obvious that self-authentication is not
useful. Plus having an accurate register space description in the
DT is "nice".

Konrad

