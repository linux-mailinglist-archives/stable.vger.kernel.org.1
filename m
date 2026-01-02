Return-Path: <stable+bounces-204477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5FCEEA97
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 14:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B16F130022D8
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF22E091D;
	Fri,  2 Jan 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nq3daW5D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TshRjV9G"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEB42AB7
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767359977; cv=none; b=TTK74Ed2yxgnLpCr3NHbp8DKn6Xtn+LUsOEqwvFXcdGjIauyCf1fNF5nCD7OEVEHTNF+l+kLGO4gu68juF5tHtjjqwzgh6IK9OZcv1Z+Y6bj7K56x9AQwroPDnmYMFQXYZ4NvIyVJw1fw6zzree6P3sr1cJh+p2sBTT11oxsPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767359977; c=relaxed/simple;
	bh=LSAf/Rk3TdAEWsr3WqS6XJD+Y+HBBtBELhHh+tH2vUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3IGoPdxu7NR8L9RpekdmZlLT71COl4EAgqBh6QNh6V54LEAZ7FKfTh+bfBz+VtuLMj4AC8uJVH9LIMT+f7Ta1brtVhP4kpBnIMkRxIGerEjQSsrpA3e92XZZlpcszhk0VI4tvDBu0B22pDnSbWr00u9n0rzHfXexVni9OQcjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nq3daW5D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TshRjV9G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029VwDx784387
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 13:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IZw/JJiAn3POXEdzsiw5cZbc4vxiyR7ZYVaBih2uKcc=; b=Nq3daW5Dr+ltfedU
	ClwLEDz1gERd71jL3x3HMIya9oQUymeAtf/WMOUFWX+oGODH+dQ7YqDeGP3z+2jb
	LBqPVJ84Ti63+zMDI30CmDvVjT0E3RsnyroK54ijTUB4ro+43aGBFif5dRNUQ2Mj
	1SPvtXCQ8zJYTZNgEEZf5/524ltCZslP55uiuEfgFhpfUapBgimBodgVAdvVX4S7
	a+mW46+rAlu9RlZos+ssYtYO57P2J8Z0UIARAEkFTYBYizGNMIcNdkGFTFVEm0Zz
	GJbQhskDQ4QE5ddBymvJE9lhrXLRApu7/SjBxVzrRPo46fBzdcQhS7g6pFJ3FpSf
	jjeHlw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd7vtkfhg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 13:19:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0a4b748a0so280877555ad.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 05:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767359974; x=1767964774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZw/JJiAn3POXEdzsiw5cZbc4vxiyR7ZYVaBih2uKcc=;
        b=TshRjV9Gp3NeAQk3NuxF66GE/UHIg2/gEBz0TMITmL4km5J+1NJS11J1WDFXs6VXNv
         UsDiNyQFriR7vkm0mE/YDy3mjy8pB/41+3wY5Vz8saL7O0gCevY3J5R8tKsfYlmb+BSS
         BGRO87VU3xbsfYd1y5lVoLqc0lVIp2z7mnlaD0EkiKR8L5R5hXHkz7KS1yWU8GF4PUCv
         2NHGQQEuIZW19r1EtnmfB8519pdYC8L7Hjz9f9xAm2gQEKdI8UE1ogSDlnEiNC7ER/9F
         l3vQQ1uAI97no5sKQE7SJYZpnx6X7oa8ujNwEDMij2BLFxBNyh0j9eEIK7HoMwB7w2/S
         IzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767359974; x=1767964774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZw/JJiAn3POXEdzsiw5cZbc4vxiyR7ZYVaBih2uKcc=;
        b=UN3typVdSvKa+dwNZX6uNB0Il6dPg3HhB6x2wyy8I/+fNOFJ4ya9cc7JSY2RY/PshJ
         T8p/ACtngwKTDMeUKL+OaQiZ6V/x9dyC1pLnq3eZj0ViXc727eev9o0e9RCdRDOQIKlI
         E3MLC1c03OttZOHhzMdl9VBeWjgxjvS3U/kPMFiUhrZrM5/umx6ERKS1zVDkwp1n3ekK
         rrVy6xXens1FgtyREiAOqzLaphvHjFLyx5yLl2UDQirlX1//weX4FQMdFU016welWXMg
         21BUI3VKrnZmtQZmsbhUwLh7rZGzuPU2nXjrO7RQGpwdLqRHHuBmPHLlzKhXzEqA32Rs
         hkhw==
X-Forwarded-Encrypted: i=1; AJvYcCXZOPUzeQNeltlvC1YkWCHBIiFMPa2KiBf4ONm8kS41ccrqqSd0w+ODfmZaU4PYRY64t19jg+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4M/GTT8bSXmqacswNfpau3R+ljTR74IlnhcH4n5ZcTUjCmyz/
	Wv4TPiffA+Hm27yu5yIB+eXO2h0pvANxU79K7EPSMzZr1iCcUj2mLW/109Jxg3vAojTlGqA6yFO
	Cj0xU97w7tY2CXWtRbpiYC03FUJqyZ6fRXodM2A7xVH8MsbT63dgzPwGpVgk=
X-Gm-Gg: AY/fxX6neWfmm/J3W0S2p2oTOJYtO4GpYKol5ptauuoGBf12wsH/VgS9d2dAUE8aR/o
	ENuBHzD+S3zP3UYGvAVuLQIZ2eo/J9eRBMEXOemMCc0Zn2aRnY6xW0I8GlzEJy9jIwVWRVLJPQf
	/++RtRZW3N3H1zkkA5N5+nxZLD7zK++G7g5I/10JYon4jRjK80n6h1i5TX5FGMcxbvoUEzeAh4t
	QeFZuBIHa7ugGAKbVS1vZQx7NeS8Y1Fk4+nGjSoeztVlxO5VtEyO7j4HTSLfob/eNIjefsjpvU/
	sekIA5TyS+4ae5iJdOvpmih+MzZikz577hgZ844GZEWZrgn7zG/xbUxfN5b5WoVPPKx+vbs9NTv
	lPpAmcwVbcN1qyy7+ENgTrY/xRIr06AYn1HXT7bg2kg==
X-Received: by 2002:a17:902:db12:b0:2a0:9040:6377 with SMTP id d9443c01a7336-2a2f242aaddmr409853705ad.18.1767359973495;
        Fri, 02 Jan 2026 05:19:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1hlYxp7YshVj7hB0XX1WRZM787D0V9PpumPlGwEaLRUxkh8qU8paZNSAZAb4rM53RY4rTtQ==
X-Received: by 2002:a17:902:db12:b0:2a0:9040:6377 with SMTP id d9443c01a7336-2a2f242aaddmr409853425ad.18.1767359973021;
        Fri, 02 Jan 2026 05:19:33 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c666casm374709145ad.3.2026.01.02.05.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 05:19:32 -0800 (PST)
Message-ID: <4d61e8b3-0d40-4b78-9f40-a68b05284a3d@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 18:49:25 +0530
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
 <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
 <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NMbYOk6g c=1 sm=1 tr=0 ts=6957c5e6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=_935WOAJMPqh-kFyC1gA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: UwRp2UBOzylPQmLvIO8jSxgnAosoUJVg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExOCBTYWx0ZWRfX6+8WObGCK3Py
 BbKmzQjECAMT+85BtMlJ6CoSjNX3PlkRld1JdNJGsTdvL1UYwHEAthCswTksUS3QY16amwvtVqW
 MFxodDuL/fTRgNhUyOCl4xtRmSXozAvuM9MJbnPEjUG24qNg4hCq/P6Rk/wcb70L8nx4+stt/yI
 ZXMQ6joovdWj+5LH63MIUE2RWUo2BTuSt0+wB0KKhzhrGMqTQvcQxpFfQcc1/qRTlz27B8xDKi3
 sdlSQkXKZ9RJP+SVH1XBszeW/KUz0tlHAQPn9Zlou8J3yNeIjv0mSbZe8Le7adroGy+KNBL5IRk
 3lS3o9f39kYJjDNFkZSAQ4FlXNKteC1H1iPqoQn0H1PUfxK5xcEaYzC0/XexPtgLBUbeZ6ggww6
 RblQw5D/W8yAHlBx1yV5yj7LAvrOoKEJuGqo9Ar0cNpIAZGyhs33yMcJFoqVg1GWQ6NIlUrrAXX
 N78QnOsgX4fxnQonoaA==
X-Proofpoint-GUID: UwRp2UBOzylPQmLvIO8jSxgnAosoUJVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020118



On 1/2/2026 5:09 PM, Konrad Dybcio wrote:
> On 1/2/26 12:36 PM, Krishna Chaitanya Chundru wrote:
>>
>> On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
>>> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
>>>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
>>>> can happen during scenarios such as system suspend and breaks the resume
>>>> of PCIe controllers from suspend.
>>> Isn't turning the GDSCs off what we want though? At least during system
>>> suspend?
>> If we are keeping link in D3cold it makes sense, but currently we are not keeping in D3cold
>> so we don't expect them to get off.
> Since we seem to be tackling that in parallel, it seems to make sense
> that adding a mechanism to let the PCIe driver select "on" vs "ret" vs
> "off" could be useful for us
At least I am not aware of such API where we can tell genpd not to turn 
off gdsc
at runtime if we are keeping the device in D3cold state.
But anyway the PCIe gdsc supports Retention, in that case adding this 
flag here makes
more sense as it represents HW.
sm8450,sm8650 also had similar problem which are fixed by mani[1].
> FWIW I recall I could turn off the GDSCs on at least makena with the old
> suspend patches and the controllers would come back to life afterwards
In the suspend patches, we are keeping link in D3cold, so turning off 
gdsc will not have any effect.
But if some reason we skipped D3cold like in S2idle case then gdsc 
should not be off, in that case
in resume PCIe link will be broken.

Link [1]: clk: qcom: gcc-sm8650: Do not turn off PCIe GDSCs during 
gdsc_disable() - kernel/git/torvalds/linux.git - Linux kernel source 
tree 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/qcom/gcc-sm8650.c?id=a57465766a91c6e173876f9cbb424340e214313f>
- Krishna Chaitanya.
> Konrad


