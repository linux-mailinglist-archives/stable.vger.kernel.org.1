Return-Path: <stable+bounces-204461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B166FCEE619
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 12:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1C43013943
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077D2E1C6B;
	Fri,  2 Jan 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YI0L8b4k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T9t6BISn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4DE573
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353791; cv=none; b=HiDrbttMnpj0FHTXG91GYEhMT8OVFa7B/6e0f4dzT4rJlEU4dDpkp2dy/Fxb+kIPdQU47JFtR7On1D65iq5NxwAqbUI8UvH6eUeXKx5xXxq08qHRGHxbwvYbjMTEimeUPBEROmYw/RAFKzMVYXc8JWDGwbtuc/8/OuI7LM3E0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353791; c=relaxed/simple;
	bh=nSliwPNjT4oftCTMMWiGcKSgnUest2J6kjtXXtGvhp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPO5piyB5w3mlGD8be6qljUxOPDuTshi0XlKZC4flkI/UnWzge7HTR0Eus6+09v03FqM9IQ9VsFD6mZfx3Yh4LEol7zGs409J5cdUonu4SjG9Nx7aLzrzBBKvOeCZimOLpuWeQ1ZC7gGuwChbjInu2if/UdupNtsK88exdhOIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YI0L8b4k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T9t6BISn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WM5i427841
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 11:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hwXrtNERsjNmklkU+FSw3rYFszuTZ8y2ON4uXFW8TMU=; b=YI0L8b4krzjODQeB
	AkcqSrIgpRuupNRoo73Au/475MEI2PWPccGdlJ3g89ranmWM4J2/B56K5AJ10zaZ
	zxF4tI518p7LHXp/40piPSB+0/PkL6fqxdD2X4mdj7/SUW79DpyxZ+nRz8zP0qiv
	WOe3NrwYvL0DWS3UkXZgb21HaodbHYT6RYqjiBYnN2fJ0prrbrHmDl9t6PfVFClJ
	KtD65vJX9YzcFhooDWAQxKxqkWBzXT48YeexiBwYzJoYb/ZAmroAJD+rQc7mTV5g
	mmpGg/o4vX1SdmPt1bxDfKWOpr2rYb+d7WOcnQ55xOsSgvtcipY7w59ymgegC77m
	NrBcrw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4be6fjrtrr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 11:36:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34eff656256so11202668a91.2
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 03:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767353788; x=1767958588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwXrtNERsjNmklkU+FSw3rYFszuTZ8y2ON4uXFW8TMU=;
        b=T9t6BISnrxd0Mx4CxWxywC981zkj7I7bf48NqEFHY4fqyIVj0nQm4/fkV0itzbmHSd
         bizwRXqoH5iiG8bA0UeViR4o/v+SXPdHrph8X+bpovZiYAgoSZezzDxGlTRqUAUKkpHy
         CKoL0SlJmCBTXBjAgHRJ46XCr7MEQLYu3mljFt0c5F4IQBWojz/hsXtqewcVL8vtx33m
         nBk1IVT2NWDVqHoqWTyinJmrROG60QMcWtIbebVQwAbwBFASws40x7xZe3E5JwpHJtAd
         Gva5YCASjWrJPuo1+IziTxqTqOfekfGA2BSeMXZjBQ1l3f68I1VjtIzTvJ1V05nhbj7j
         /OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767353788; x=1767958588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwXrtNERsjNmklkU+FSw3rYFszuTZ8y2ON4uXFW8TMU=;
        b=GKGaAfxqcIM2EAC8xhFsOjwHkJKiqfS2nDhJsVJoXns5Mx/Whhi+l1KZ8+FtbfrC2P
         lRdFnAEkyaVQ6kGD15ZBkvf7/K/adj6RQ4eOSLvXtap56xetcxH/Q/p4nJKQXMVf4KiR
         SHDxJCRtKTvj2Aip/jTgrz8faY68QIXPVXEmJiEt3pJgQ3e1/jFbpOcWBaLqjE22o8xm
         4n7ZRdQUl+z/Epc97yd0mzcNLafqp4ZyO2U4WRoAVZFckeeVQl2yX4rV/5ex0013yMoV
         P0jvDo+VsZL/0YJna+VoaY3fsPpjQo0IV5ySAWwOyMSYrLh+DqXOR0Fv/5xYFnk6SCm7
         rBhg==
X-Forwarded-Encrypted: i=1; AJvYcCUctYFKlYWhAoi/U/OjzlIMvfRovOzOm6MXfoznPWUFNzVjIiTDX4/yf9701ENUnek/ry5Qgao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOy8H9dFKRCt3gv826vV+3bivY9CmXHJLc73zjESn8JmVQoVvi
	dFkxso/ZPUMIMkgRH9dauiXWQzjtLQyHMnV5Seft5O1S1IBTcal559fgAZmIP47WrBhM8GixP8i
	nQrwbkGwMh0i04FF0vZ36giMfzQj3DE/b8sGk/Ej4Myzw3aPkOqIvXu10HVY=
X-Gm-Gg: AY/fxX4PyRRxn80oDqcUTlNtjTSPaIKRztZ4jCzmEM9QincIQEygmoA32q8N92vL/iX
	tMVLC+Q1dZWcEyW7AS6H5X4I7Qxr5tOIUiZt6KKot+ScB/ZGZKagh5RpnhpH8R4KphKFvApYJjc
	thnU4ciHJaV8WstGe7g/f7ffzUbSk6atxJgt7I7ivtvfAN9bD+du5/++Ee18b1XJgteXK0qzJBh
	8TOA30PfKZOMssH5j7YJgGj79kVRuhfiEz05hq20gWp0FCo5zF3bvB+JkuKe/w5qnrpjkY91g/i
	isurxxvX9pGNyi2NH8/dWSnfXKqr+J3hd5+irklyA3JUaEFdoNbgdIOU8kce+/R8smvZiryQAeI
	pBUPbgj7vLLuW2vUPBKHmn/whxlPXPNGgugcpKj6cwA==
X-Received: by 2002:a17:90b:4d87:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-34e921371c5mr34545174a91.5.1767353788463;
        Fri, 02 Jan 2026 03:36:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm8V3rqEQ+TuWLWoj2vpoFRdSYbK5rrHoZh8wYqUAETd/WZYKmhaTEeOqBr9WpxXR29JKi0g==
X-Received: by 2002:a17:90b:4d87:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-34e921371c5mr34545139a91.5.1767353787824;
        Fri, 02 Jan 2026 03:36:27 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e920c9a7csm37441154a91.0.2026.01.02.03.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 03:36:27 -0800 (PST)
Message-ID: <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 17:06:21 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        manivannan.sadhasivam@oss.qualcomm.com, stable@vger.kernel.org
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Av7jHe9P c=1 sm=1 tr=0 ts=6957adbd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=J0Aowk1ytulczOLfjhkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 2IsjaDLPQXUoQ_FGXh8zQFS1vdVoJQaW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEwMiBTYWx0ZWRfX5oYhDYFCuhfx
 WLlRFtwDMTrRFPdBhW3eIPmEibEe4ov7g4rWV9CwNH8Add5e0kbCsyQjxtY7Yc4DVCktCPdcxXk
 cW1HzlJA7fiM580Cl4XjDputznGRn8vvqgFMVjTdz+DYj3fYznMLaEoOIQWC4Z53WrU7liT9TS1
 TYgIzqK6ec2h58/RdD7xCSrYfP4lfkEM9GCs2ergllesRFNPzgZ4XNplftRWp1vizvTS4PrAqHH
 +++IvRg1PDjQtIBKhfboLfGmBM6SG+Nia1o7qdaYv8FcY0g0BZZWGOoJv2LFRJOLQHq0ZcD/H8P
 scrf1Cl0hBoHfbRY7JvZe/SQbdEIjBXLjGhdcNB2OdOrgWmOrlbJJ1J9OXat4PV/bXtDu4/FLEN
 jrzYcP9BZ4G9KFV80+YN/Bj2NLQ6F4h3DGSUcP4VH/ULP9QyNIBnKLHMR3LI0rMK8gfw7DLaUtq
 3eraWkg3vOWUw8gHd3w==
X-Proofpoint-GUID: 2IsjaDLPQXUoQ_FGXh8zQFS1vdVoJQaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020102



On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
>> can happen during scenarios such as system suspend and breaks the resume
>> of PCIe controllers from suspend.
> Isn't turning the GDSCs off what we want though? At least during system
> suspend?
If we are keeping link in D3cold it makes sense, but currently we are 
not keeping in D3cold
so we don't expect them to get off.

- Krishna Chaitanya.
> Konrad


