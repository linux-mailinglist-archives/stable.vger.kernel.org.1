Return-Path: <stable+bounces-183841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40896BCA249
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 080CA4FE27D
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968EF231A21;
	Thu,  9 Oct 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hv+H5D2O"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DDE230BEC
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026092; cv=none; b=jXfdfDojjShLCp+SsBJLnFu4CH3DC/vC/YFPuy4l+Oc32YfDDwQEnNb48AC/fOG6GhWqNfVgfk11Fa4b73Bx0Qj4g8cq8yUSPTlEFhjnwvguwokWbcSAnfwKEmTzijOxC5u/s/rAUy+++MwGKB19fgfdqViOTCJpBQVeS3D68X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026092; c=relaxed/simple;
	bh=wnjQVG+egmK2IXhzGH82IGBpeDw+1s4hu8UVsW7/sgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0VjW6qPUABbcj2syFGV3Fd+gBQNGkSte6pKPcqP5d1YnvqiCRTl+vV2KBzSfNME4F1nolToRQEyOmwkXdbwFY33MXvpvzBPcvdMG//QWf1V1tpKtYOtCKWdeXYRMRsE58eiICGXQBCUNj5zLOcL/C61yKknTnFX+dwMOi1y8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hv+H5D2O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EX79M005222
	for <stable@vger.kernel.org>; Thu, 9 Oct 2025 16:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jJ9LcKuZ6RaI0QjDWk+WPpGF97bOBxFsnMcVmm6o4g0=; b=hv+H5D2OfGlqf+y9
	/PSpdxaTYKMxoVN4k62FgqHz1rxKKD8aXMnTm/nVgPli+9kzdF44iNUMObioxUbj
	81cbqg9t+GtCxT/kARnXsIFKqQwGytBQHCZfqy0otpD5b+uoUX+uPbywnlDzmk5G
	vw0FOBA6ArmpQ0crQLT9aZnnNypjRA/Wd35s4/CnTjlHoRLMHRlhx3JcTikYmg6y
	DP6wonghk3cJ1loKcHTIWJDFYNHFakUtzQVKr1PTDn2rtQVXGxA3y3mbULJZP+xd
	X+aqo9oerBPPRCgRTORlwaNY9JKoOU0hexPP7SCdAOETGhicUqnfkvO8wPNkdDyS
	jNCbvw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u3htb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 09 Oct 2025 16:08:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d8c35f814eso3797141cf.0
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 09:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026088; x=1760630888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ9LcKuZ6RaI0QjDWk+WPpGF97bOBxFsnMcVmm6o4g0=;
        b=TqpbVqoDdtScJ2hLSeyKzMfMLFRgLeUdobuaWJdHnYCgwUZ7L+AxXUNYL6qZhLkFw1
         vpFDYSpGmmspln+QUSPU4LsB4GWTVyQKfTDXwO2MBWrHtJovafZvLnMRLdrLFy7UPIeN
         3zr82BJbmDJMFksB5PXYg3iSZ9P/jzWAUKiEW6bccJktpDo+/bYpDyTfgB/rEHJsPoIL
         sAs9DxbbPhOpOSXCmo7JnU8aPuya2EbXmCzFuDk4V12xGg84Ig8oLdIhMl0ySCgp6ssv
         cLifOiTNabgUNSnLmRuA0sj8ih4gHVS698kXx9/hqDsszgPHugMLnfoYCB7otg/B2sfH
         2psw==
X-Forwarded-Encrypted: i=1; AJvYcCUDmEhc1xn2AJJ+MV361u+H+otv7lfPlC2bB0oFlPNpE+/95uJC/5xR1HHpCdsv8jZED9ch3bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeYetJkMPD+U0Jc9+MdYMxkJqWioF7PIyG8L4dBqbAF+8WkyB7
	FF3fVd4HRQnVk/iONG4yEi+LlI8erdMqxB5csdcAAftB4J2ioDg4yYQqZJM0fpiBTchgB40Ij5+
	X7bs/4ybi3uPmCP3q4mgADqlFX0YNCDi7E8ROLSMW6hV52oKKZnCSD5P2PK0=
X-Gm-Gg: ASbGnctLEum1+Z9tQaxv7/YXk4nE3D7btapYPXSPsUiXbXbihfaFUfuvtNThqcCCLMO
	IWp4kQz7KIRJzCPEpjDmdIHq6PFKPFP5EXFwltkJrjifvmqyOGQj0Rdi9oRPiM5yS6lXLrLEtel
	JnBT9Ij1dkBgHKOhPawogfxTVjjmkpetHEOy0OA+aWuC6V9sR6eJfqTn+Yb0PkDZunttNGtzxNu
	g++OXsXOCTdvjPcY4UNPZXfpmtX2H7judqzpZZg7MGjjzR4h+D926U8dB6fOco6+vvwseraoccC
	UZC3KdZ4ZmNwx5Ub68Sp+08J44opZBG9LXch8lRxmZeWB+/cYjD1cde2yiA+F0uMggpmktN0gCO
	9DOf0t8vMHWGcJekOxzsjuTM2bdA=
X-Received: by 2002:ac8:58d2:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4e6eacd4f8cmr74888221cf.2.1760026087655;
        Thu, 09 Oct 2025 09:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2+Z2nuPl0CiMPeaV1ZrBJxe7W45K0/bsiPvQVl/aLb1IdSFCEiGmt6XM4B2I/2P+tfM8wiQ==
X-Received: by 2002:ac8:58d2:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4e6eacd4f8cmr74887731cf.2.1760026087092;
        Thu, 09 Oct 2025 09:08:07 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b71503sm86363a12.27.2025.10.09.09.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 09:08:06 -0700 (PDT)
Message-ID: <1cd57f5c-d829-4dbd-aac9-b07d0e155e4e@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 18:08:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.17-5.4] pinctrl: qcom: make the pinmuxing strict
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
        stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251009155752.773732-1-sashal@kernel.org>
 <20251009155752.773732-60-sashal@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009155752.773732-60-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e7dde8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=FGwjZpymIQ_i5ujK4VkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0Ph8HtqZ-1sUXNF_FDh-neN3OrormkhI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1YwMF9anxJxo
 7JvLttrrAAuLs7uO6iRI+baHyYq+R+qZrrfDjOYrRBq0Vk34vAPu0cugUbi8Dp5+z3Gwlpf0q5R
 FzzUMghyQWgN5MV9MAofIn8/Fz9yPFcuZw9B8zFIO3sSAIEzDzSv0LjLdBnep12RTUq3gMRd/Vt
 EgnQJX3qmJolfp36JWE0kid32CHrpeSV1RuOLcBnTrVX7SkZswedBBnNBOG5Vb3PlAPaYmoq4Qg
 qJ4rDpKn+mNFqffMI8PyigYfRSsOSBgeShSNRFNHIk/S7RcDXZRizzQjHOAzp4R1My5NXYgO5Y6
 D0z+IHlrbVMyVO2x+DLxLZ1P7NNfXisRa4i9KL7/fr6SoeArB0NyI7mkUgfbPVgBRYKHPTP9gxt
 ohDvGcOp9U2NKwXoPu2RWI5q3VyNCw==
X-Proofpoint-ORIG-GUID: 0Ph8HtqZ-1sUXNF_FDh-neN3OrormkhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1031 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 5:55 PM, Sasha Levin wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> [ Upstream commit cc85cb96e2e4489826e372cde645b7823c435de0 ]
> 
> The strict flag in struct pinmux_ops disallows the usage of the same pin
> as a GPIO and for another function. Without it, a rouge user-space
> process with enough privileges (or even a buggy driver) can request a
> used pin as GPIO and drive it, potentially confusing devices or even
> crashing the system. Set it globally for all pinctrl-msm users.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

I didn't receive more related patches, but this had quite some
dependencies (in pinctrl core and individual per-SoC drivers), which I'm
not sure are worth all digging up and resolving conflicts

Konrad

