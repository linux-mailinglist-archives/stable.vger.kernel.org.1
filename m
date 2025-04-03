Return-Path: <stable+bounces-127534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E14A7A549
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C6B18857BC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E590A24EA8B;
	Thu,  3 Apr 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6ggs6U2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795024EF65
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690927; cv=none; b=La11BEQydk6cpEMKoFju54iD7tvggyJNLp0jrUnBLzLRDcvgsIuze2PjAoGQATY/7MShyUXaUMYdBv9cr8vmeVEi503Trw1uvdY3izj5W/AFcTjf8h2+ADqWFTx98vwsrz/z3ibKxJY6hCVySI8Kcckx7157y+WGy6HBAApufPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690927; c=relaxed/simple;
	bh=EW9VbBAnGJMqGYckvcoodiF8tU+RnUBYV8MLLw2zRlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdvB+q1UZwNPRFR7+9yc5fJKX9K8+jDt93ofhS6eIW5ALI4bqvwpkkXHx3gjlKTi9KjF5KdRPhAlX1eenEYPP/R42gdwCt94afCI9hoFwCMSJZxJyjhMOO7AzabHifJqYRRmQBGq3wck/MgqrZPUYn6rNXuT5V73AOhN8tY6VOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6ggs6U2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5339rvwv008169
	for <stable@vger.kernel.org>; Thu, 3 Apr 2025 14:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4hN25K+WqnT8AgmAy88dVAnZ9Unzl695s59Nx2FCZtc=; b=L6ggs6U2zpALEVS5
	SXYkalFjWmP1y808zvmDQmjtOlBn+kLRamkGScQrpHflTCOOdQo6nMCBclxIXYis
	EI+m4zDqeYDg1WSbuJ9kYWVZUxNQXZHS9ewpWmzH5AvQ5rtMFl9I3BjysrO1bX9l
	T4f6toEqt4M8FlmP9hCVGIcHlLkXvxl9TMzCabLLb/w6O1iWlVykTF4J5qg4EW20
	JYocz1rzfZ2e7DwkpZPG/O4ss6gTY6krmLACiVEGUXWqmzniCjYJMU3nDM6R5EpT
	qS7vdLDFNIOdMjObsBgg+XcpT0GbgzG1ftm8soGJnAFq5gTq83gcZ456nPLO17Nk
	4wwOvw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxbf4wuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 03 Apr 2025 14:35:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2254e0b4b85so8972735ad.0
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 07:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690918; x=1744295718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hN25K+WqnT8AgmAy88dVAnZ9Unzl695s59Nx2FCZtc=;
        b=bZYornyRelbI271IcUzC2mOgfpGa7+0VLtU7Hj8yBVRJHutBcBXTzSUWPrcCvegcoZ
         zrue27YMauSQuIsVwmNau/TA/IAaNq6HgDogvwplqYzMS/nXK1moc14Bezv7qjN8XH5V
         gQxdQRujtmu7HqxXJ5nZ0kk5W1gjGvBKM7IYaGD7iJYVExmrcGYsPyyJ9dODoJ9C0kIT
         xQ9lYhKhJ5V+sXJ/74M9ZoeQQlgmKt3dxmEPLTQ4ccX+oUE7RY+WnVeTTBj1zvImTenN
         PIjiTNNhRz1xJBScXOKBou10WwybqnudOYQKSW3/cBBxP0uwX+y1R/EQY+CG8ZTI7YnI
         kXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuHSryvAR00ycokMRSAfsSvxAj541Xv/oNpd1zC0zynClj4PlvyalnQ7D9/9utOd0V3HN5Xpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYY8aaR+kMvQZMeigmOsGAaYA7MWsW/X6Wdg+Os+favzJ/zOPZ
	wEebF8viXsbyVuVB//4argV/3Mi6VHtiMgreXRrC2yvdHkcG/u0jnP7gJJz3G+/5ohnjRonPIBk
	O3jC0RaIw/NzjGaDGaBXnTaZEFxe2+dX7RkKQx1tPmlmqP17/lmkux6U=
X-Gm-Gg: ASbGncsXeM9SVzIbAxPG5m9wdk0fG/5Rw0T4Gd7J8imTVbvXCwo4siMvpZMXtAziJ5G
	9dFIJYHtaczrLhR2cYZemEjxzSYGMDBpFujUfsbKx9goWqW4INmB7o5mJgysT9Qlmx151R92yUY
	vUUm0LtZHD0V+Nc5Veq4WM+/x9b0Z6E9MglImeCI/rvPkSMtSfKwORskVbsG3FfRXI5euKler5L
	Mc9BohqP6P98MsRaQUl8Bkh9yWtPfdTpF8Uy+dxcyUgMSFgvekAEgfoC2Tnn1EHZW8FmDb9rovU
	iHfD6flmC7Q7pUiceZGOuP6tb5j/JkqSTp4V5ELg9fLAZiFc0gG3L0oRfaIer5gf0A==
X-Received: by 2002:a17:902:d4cb:b0:21f:1348:10e6 with SMTP id d9443c01a7336-229765ebe94mr59160605ad.13.1743690917662;
        Thu, 03 Apr 2025 07:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd9eUHHmSWAC1zfq0v0x28hsyaqI0u8qIZg1XWVmZbUZYXlR7f3LYAZGNzL6sddb6XBExjlg==
X-Received: by 2002:a17:902:d4cb:b0:21f:1348:10e6 with SMTP id d9443c01a7336-229765ebe94mr59160185ad.13.1743690917231;
        Thu, 03 Apr 2025 07:35:17 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297877266fsm15150255ad.215.2025.04.03.07.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 07:35:16 -0700 (PDT)
Message-ID: <8579bca2-c3d0-452d-8e8c-d25c44903e1e@oss.qualcomm.com>
Date: Thu, 3 Apr 2025 08:35:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: mhi: ep: Update read pointer only after buffer is
 written
To: Sumit Kumar <quic_sumk@quicinc.com>, kernel@oss.qualcomm.com
Cc: quic_krichai@quicinc.com, quic_akhvin@quicinc.com,
        quic_skananth@quicinc.com, quic_vbadigan@quicinc.com,
        stable@vger.kernel.org, Youssef Samir <quic_yabdulra@quicinc.com>
References: <20250401-rp_fix-v1-1-c68c9d81a56a@quicinc.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250401-rp_fix-v1-1-c68c9d81a56a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: a5JyHHUp4JtEG4L_z4ZRUf78FR0rR1zH
X-Proofpoint-ORIG-GUID: a5JyHHUp4JtEG4L_z4ZRUf78FR0rR1zH
X-Authority-Analysis: v=2.4 cv=F/5XdrhN c=1 sm=1 tr=0 ts=67ee9ca7 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=Mw1Om9em43-oCLZg1R0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_06,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030068

On 4/1/2025 1:12 AM, Sumit Kumar wrote:
> Inside mhi_ep_ring_add_element, the read pointer (rd_offset) is updated
> before the buffer is written, potentially causing race conditions where
> the host sees an updated read pointer before the buffer is actually
> written. Updating rd_offset prematurely can lead to the host accessing
> an uninitialized or incomplete element, resulting in data corruption.
> 
> Invoke the buffer write before updating rd_offset to ensure the element
> is fully written before signaling its availability.
> 
> Fixes: bbdcba57a1a2 ("bus: mhi: ep: Add support for ring management")
> cc: stable@vger.kernel.org
> Co-developed-by: Youssef Samir <quic_yabdulra@quicinc.com>
> Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
> Signed-off-by: Sumit Kumar <quic_sumk@quicinc.com>

Looks good to me.  Please post to list.

-Jeff

