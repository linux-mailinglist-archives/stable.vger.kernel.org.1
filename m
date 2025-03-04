Return-Path: <stable+bounces-120356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F248BA4E938
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092118C2BFD
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D33286282;
	Tue,  4 Mar 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LsA4KZb4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115B2857F4
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107798; cv=none; b=OI1RT5zVbd/ui/iPffyKboRumZcdFEu4EdGuLuz4bDrS1x8feOrH/+vbgKg+QgeXjpcYH2TJ2keHa2p/NJjVP3YBldEIpqmEK2hCW+mVuba8m8yqpVAbzMCeTXjCboKxGKXbPSRL95G5DekwXD7TgGgNnwqo3yl8/sUXAmWlsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107798; c=relaxed/simple;
	bh=T94NuQPBHRq+7RffbHPtggg4RzXeb+StCo1orI07SVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zsp60a4sjyBGiL3Z6TbHqpVeFGgx3IqCbC1mePfmz1POZIwY9ebBXpMikVsWEHrdS2guefL4UR+4CB3JaOj8ZppeUEfWRRv8jA13v0g74rwVJ4FTjfHMXcnK2kB+LfZd/J8GdGiMWz3H9Tu/kJBhMPNx1x4LnhuqlTD2mc86c+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LsA4KZb4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AP5Xp020935
	for <stable@vger.kernel.org>; Tue, 4 Mar 2025 17:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XfjJKhXYnPoz5V9fgo7qXBxn3xFBcrjNrs2Q0WyjUis=; b=LsA4KZb4AS/+Md+V
	OZePmJc2XdO/jOCsGCxdkI0psRnyIwyERLG0/CLdg86caI1CW5PcHfmasP/4wIbi
	vaTnDG9RjvQutRrBMmRsmJp3fJMhE3nET47Gv8iP+8W0rm/DrKiqryGb1/7SSTYI
	HaEwGUTDMO1ydcOXnsaZmzMvwLzYT4dEkYuZyx3tQ6wVF4q5WKFWFUaNELMCF5Ow
	W+OouFcWFV5a9TjmrZuBvTp45oiRQOX1MMLI2XViNqYuv/iMt5YnkJVhXFw+KZSX
	V5OdHweoK/+Xfy4cWPOPdQEIDRCby7yLYwqAps1xU+D7D/pohho0fbk3xa9S8LYF
	b9+dCA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tthwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Mar 2025 17:03:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46e78a271d3so17277811cf.3
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 09:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107795; x=1741712595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfjJKhXYnPoz5V9fgo7qXBxn3xFBcrjNrs2Q0WyjUis=;
        b=mO+qfma20W4h0E5lbaJ+gh8rfz1/86ZwVqngq8r3+kOeuu1C/XMBLkHOS6UT+iD4rb
         0GW5pDwkJIbTlY88Z8fC6rWOIrZBmPoKtbvwccZ0fRJTgNu57nbhnniOtkdAMRdxb1PF
         YtE/wf6dIyxB2ldojrbNyZNcgRxEFNRt1lO2bDR5jo2y/tt4GE4X3Ze/s1JI+i4VwKKE
         sqjR+dxQtGnlYkgs1+YrUWOV57oSqLekxvBvIxeWRnNFW4DWaWtxobeDo+Y5yp6RIvCa
         v365uHVMjdgA7cJBdHvUQGevMh6V4XxiKDWjt4IvEKScADrwkqwpqRASkD5OrCghbAYU
         Xb7g==
X-Forwarded-Encrypted: i=1; AJvYcCUFUkK/YUNj8CpxcXYE97frTX0urw+bFbE4YOjZI0aeLnd31V0UmWQe1Vbjy8wdCJDX+DUAaqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymowHVhpZm2h/CekCCoU2NQumiFblAwmqs2hWx1PF+WhhIL1nR
	wKW4xCWlb49lVATNUcJceCUpUDUIEIaFcwredOuhyacCd1rx2fZoF8V7KZS9y4xZCiptisQPuAV
	apL1DzkUZCv4rx5ZejMa+dEuibdmvh9NHzAo8IHs9kWtSxyp4Ux+s/uIPLlnRzsY=
X-Gm-Gg: ASbGncst/x66aGNSALKuaN9U0gW98DqJnCgy8Ng/y+CitZ2onw2MdRDXmapC16mQP3R
	GTFUvpTUplBSK7AY6SzUPvVehIeoRYxD4Xq3WBLLW91bKmOgBhODipq4jiNWhRi941qSEBgZlZ5
	wwgtpUWepxFOUzBlUTWgxSvfw5pC+hZm++Y9SnW0cBJHTKmAmhjSM6bQWr/cS1j1LMhcS0GYK6d
	eMHIY4PeoAZYb86pN60Ij/VIjLx/wvP+BtiuzpEu+gELBuWmiLvUHJhSqozxr73C7IRn6bZgcHE
	QbfwZV725sgE5E6Znd2aNfsIdU1IOhE7+GSO6ZfMZQcylCp5reQ1SY/A0pGuRM36+q2p5A==
X-Received: by 2002:a05:622a:3c6:b0:472:7a2:c3ca with SMTP id d75a77b69052e-474fcf22ee1mr17698081cf.7.1741107795102;
        Tue, 04 Mar 2025 09:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6X4OkNe5Y1A2PTdo9agkkM4vxYz+sQ46VBxO8LchjgkPfcte+pqKgPp5rIaC4TGjWHNZHEA==
X-Received: by 2002:a05:622a:3c6:b0:472:7a2:c3ca with SMTP id d75a77b69052e-474fcf22ee1mr17697881cf.7.1741107794757;
        Tue, 04 Mar 2025 09:03:14 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb4bd9sm8384553a12.33.2025.03.04.09.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:03:14 -0800 (PST)
Message-ID: <887ca307-b0fe-47a4-9a72-7fc720319343@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 18:03:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b
 and l15b always-on
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250227081357.25971-1-johan+linaro@kernel.org>
 <20250227081357.25971-5-johan+linaro@kernel.org>
 <CAMcHhXp2im-55KxwSUj0pV_hmrg-HaV5RYB4jvPOoqOYjJuCYw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMcHhXp2im-55KxwSUj0pV_hmrg-HaV5RYB4jvPOoqOYjJuCYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: j0w1e7Mmo0XLr7tRTQBAfnIl8ubmT67A
X-Proofpoint-ORIG-GUID: j0w1e7Mmo0XLr7tRTQBAfnIl8ubmT67A
X-Authority-Analysis: v=2.4 cv=Sf4NduRu c=1 sm=1 tr=0 ts=67c73254 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=iuD-kgW1Kdg19m1uaYAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=684
 mlxscore=0 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503040137

On 2.03.2025 11:04 PM, Aleksandrs Vinarskis wrote:
> On Thu, 27 Feb 2025 at 09:15, Johan Hovold <johan+linaro@kernel.org> wrote:
>>
>> The l12b and l15b supplies are used by components that are not (fully)
>> described (and some never will be) and must never be disabled.
> 
> Out of curiosity, what are these components?

Mainly dumb onboard electronic components, it seems like

Konrad

