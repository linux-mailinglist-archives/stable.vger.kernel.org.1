Return-Path: <stable+bounces-194472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5762C4DE36
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E824FE738
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 12:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B5E54262;
	Tue, 11 Nov 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d3Su+iTk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kZVXO7OZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74C3AA180
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864676; cv=none; b=tsyGWjk5IaSrY5QqQJ09TV8rYzq76NaQyn3ThfO0uX3FYn4Ot0aE4iulH2GhDJvXlonz4EL0dDwVzVKdMqqIP5HqiKcWZzN2yqm/2N7LfzZbA2ED82EfA8LDDdeoHx9XhIiJPHkiEXAk0m3wGS33gsM98obxiM8usuVSdfUmtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864676; c=relaxed/simple;
	bh=F87/smNyR6Os8dg4MgBs0/IhscooYag0KN2o9H6aHs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5oFRxnj9YobXfBjZHAioXyb09P7ppRlhlbSjeH+g/8yco1KSQ0DcymfE7uQ/J/mr5WiRDn7fzVp4EObwbB5FnSvtiRNYPk9JrocnC3oU2YT1GV9ZF54qh7MFUZ4rvhmP4SRcZ4oE2pwX/QQ0aR5n+cbu74fZuEAwevxtAME4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d3Su+iTk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kZVXO7OZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGsaT2298371
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ia4arzq0yyKzPIBuGzO+k/lXgqxrQlfO0SI55RDLmg8=; b=d3Su+iTkvYK2ew1w
	jWBUOujSVltPgR5efWc25takI4/oTNjJ1DbVL1TQsmHoanNvuBC9T30rXEmmUSdo
	D/PkMjbh+9K3OP88QI2vIx1vhuzbxPhI25+sTVhcDJreewlJ9r+nQIHaFv4eIhoZ
	auDE3wCzFFbk7/ZEgVxstnXLxx74DuNwcoEh1H/zwnI5eimK6A/Kbe9qzpm6WF+E
	mDh1KK8Ktv8gp2TpnPktcz8+zrzEyYVY4CvZ072qd73Oco/3ROJV35nYlbpoaAOv
	XIWz/YxzFhZ9Dwg+MPMjbSp3hTNV1jdCwi6wfxUiy9rBkoQoft7aPr00jsIy3JQQ
	GzIItw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abm4a2xry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:37:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6cdfb42466so1031300a12.0
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 04:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864673; x=1763469473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ia4arzq0yyKzPIBuGzO+k/lXgqxrQlfO0SI55RDLmg8=;
        b=kZVXO7OZP8qtR9PF8y/Sj9FHv5rUEGwr7QLfyZhHk+/PE7LEA+GFZPYhcPQbAk7B86
         yG2kmYOtCklIO3VFm9VMFYuzGRTMReGiSdpw2eVV7HWPKLpwkZXPb/IrWS8Mqse0ISwx
         +SqhsToHZicXDWhGRzjDnIfhEJSupmMwJCShNCMZJSfVkwD4AWadcAxDuPat+qltgBjA
         fHTqlv/scLvs2gBvsee8zuspOelUQMj9PI1K8zMs5tvDhy4oWwAB+zc6JBm4MWpu5mZp
         lMqsBy3G1rqHyqM8N4DXXcqUr1AlBjQN7URppv6+5Hx/E8/sDrONDK5QZYEfDM7/feSL
         PRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864673; x=1763469473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ia4arzq0yyKzPIBuGzO+k/lXgqxrQlfO0SI55RDLmg8=;
        b=tCDPH7e6IQS3fnR0F//DK0mE3PfGWoXq8pGi+Mh4mTBhnfjkJ2FWXYsqPj/lAKWtgj
         lD0AvHuthOfxr0fYQlyMvucYf+c3DWBtXZKK1jNVhfZq+LxJ39BI+lglPGf6Di40YOSV
         zA6HxlSENLZtn3B3NeiKJH/Ocl6GUKPwFC8z5fvmfcDoo1vRGKzSGgj3S75iB84RjdH7
         IVJjm6aUS1PfBi0iH/5vpfAnDFOrSRPzv9I954fyfL0LU+6k6yAO5yEKXtts3czqxbaf
         pUMvtI+OJwSK0IAQwsxOjnwd8dS0SsybPLVpF1tx6AK6QN6XcdlcF4Iw8eNdtPRl5FX+
         hnBA==
X-Forwarded-Encrypted: i=1; AJvYcCXLVvGyw3wYAu7/JE1matcGG+vs6za8Nc0EhfbGxA4qPlGOXQ5qwjSR4ctDADv1Rx42cQw9cfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9t1n0/ElN8RTOwLhUawkSfoEOGYbZk2j+U9t3OeutqhGNuGa
	lX0AVQ4XSyZCyq06q/E+CXFExA4XCIPPPVOa/8X091bE0RgEKRupJ308DDZVmRlX6z42IMT7QiC
	z5/ObwENMUX79stZUvDM7AEpkx2/ia4cAGv98NZvIZge52TE3jiE6X7SA32Y=
X-Gm-Gg: ASbGncuy86hbVKhvEP+kYsm+nUBaknrHJzkEoN7VHzJP4N01El9jFflORsC2InbLMDL
	KW9GxCvF14t9Ch8CLwsT54i/2t8mAD5IkTEezVp8Evk4IGxyfn1u3dsW7XbU1bmBTlxVZQ8sCpg
	qz7wQ8w37VJplnk+I+/SKaJB2HAouk1RUefeqFNR4eIW2MEek1OhuIgLflYXFRNYjJ33wONK1Ss
	s0cLch891zgNZog9WMqaeVQPDARGcTmjNqi5h4QE0p67yIJDolSvamhjKIDTw+Vo3MelF/cCXB/
	jYsh9F0NSd7n6pvYDH1sTMfEk2u+1ApxFGBVyhRnd/iV31QK52KsregSScLc0vUzqlBur6KGe/M
	7eJHl7w25LzCdpkXUXOf7
X-Received: by 2002:a17:902:d490:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-29840fee954mr19743335ad.4.1762864672955;
        Tue, 11 Nov 2025 04:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0q+p3aApFgfFXqkFESOn3QG4Gvbs1jnstOAi+s6mYdXc9o8PALRvTBIKDC6BrvFmGzWhTuw==
X-Received: by 2002:a17:902:d490:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-29840fee954mr19743165ad.4.1762864672475;
        Tue, 11 Nov 2025 04:37:52 -0800 (PST)
Received: from [10.233.17.95] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm180165815ad.102.2025.11.11.04.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 04:37:52 -0800 (PST)
Message-ID: <a3d1c1f1-ef52-4c68-b3a9-8b394da32208@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 20:37:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
 <lr6umprjjsognsrrwaqoberofivx6redodnqwnuqtpp47axhiv@nho74vyw2p4e>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <lr6umprjjsognsrrwaqoberofivx6redodnqwnuqtpp47axhiv@nho74vyw2p4e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ln08EDyGZ5rj-jmdFLXK6js8U3CPlE1S
X-Authority-Analysis: v=2.4 cv=G6kR0tk5 c=1 sm=1 tr=0 ts=69132e22 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=F864Gg6nNBeLBzAGB4AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: ln08EDyGZ5rj-jmdFLXK6js8U3CPlE1S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwMCBTYWx0ZWRfX3wh5ReFXC6aV
 dppy2UzflwDNvgaMgeXy/AxxZovf+0zuMOxAZUPE+u9YKDt/XUrh5ivDm+zvzsaSEUZn/bwITn8
 MsSLCakEuTd3DVbH/ZgkunZkgNT/tcs3HpC0FuDPLwogPwzPlia8GTFwt7Hlr6FWJzoJqfk7Brp
 9R9YGa0YPVWfZL9UV6PKXn/98bpLKihNwWpJu6lrhXFT7Hd2NQJXAspQSFu8o8RWmle/mQPejJu
 R0keFwiuepGEB6kD46NqAyUM8bfIzMbnAOJXqQSY0HcsJV1CsiRgCJuir5vnVmkLcgKdQvdWPIx
 uKQQK3dy9R+BFGTFOlK/ua8XiXm76mRFPNT+JRNyG24jtgjaVQXldU0H+GnQpL3fEj2H9iaJ55w
 YZI+yqJoyeGDu9T5GmdTpsY5xtzw1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110100

Hi Dmitry,
Thanks for your comments.

On 11/10/2025 8:39 PM, Dmitry Baryshkov wrote:
> On Mon, Nov 10, 2025 at 11:27:09AM +0530, Wei Deng wrote:
>> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
>> Bluetooth work, we need to define the necessary device tree nodes,
>> including UART configuration and power supplies.
>>
>> Since there is no standard M.2 binding in the device tree at present,
>> the PMU is described using dedicated PMU nodes to represent the
>> internal regulators required by the module.
>>
>> The 3.3V supply for the module is assumed to come directly from the
> 
> Why do you need to assume anything?

The M.2 interface provides a 3.3V supply, which originates from the main board’s 12V rail. To represent this power hierarchy in the device tree, add a fixed 12V regulator node as the DC-IN source and link it to the 3.3V regulator node.
Will update commit message in the next patch.

> 
>> main board supply, which is 12V. To model this in the device tree, we
>> add a fixed 12V regulator node as the DC-IN source and connect it to
>> the 3.3V regulator node.
>>
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++
>>  1 file changed, 115 insertions(+)
> 
> Why do you cc stable for this patch?

I will remove the Cc: stable in the next patch.

> 

-- 
Best Regards,
Wei Deng


