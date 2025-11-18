Return-Path: <stable+bounces-195052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0ADC67BA3
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 07:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C40C4E99F2
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E22E62A8;
	Tue, 18 Nov 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llZKZR04";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZkjCP+pN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCC29E10F
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447178; cv=none; b=Sdia0v+am1UsxuIdzhFAORKp14AqCrZkF9cWjj7SOdVbpO7ti0YStSbNKBNYUFewMpTbjL+Vu4dROsf+DEwIVvkWgjILkJj5wAB3k0ijtzjegM23Mz9KmH3FtAVhPxXrDs2k96tidbbQIA0HyuYQPEQGWOWTx4ywIEaqN8rwrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447178; c=relaxed/simple;
	bh=xhv9sPWGz4HE4NPCXyeGNL8Yk6KTaJ/N5Bu2WnaIqQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djZ89HQ3gSEeu9AEPAWKnhNdcaotVMCT4duhVMDT4RUYXkIprhNUs3kWXiGQ+/tt6ZPrjtrV7xI6cAeQqwKxrQpPiiV/TexYkun4IszUgelCtjsW1E2ngVnjssPTHyZ5GJp9GJKwQRvWLRjK16o86jUqrhFlReysfmlTmdEtlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llZKZR04; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZkjCP+pN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI5kcqS3920786
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 06:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lEaIIGkepzw4etmLuWJDtUUXt829lIeGN1TrIUN6PXE=; b=llZKZR04NbRrCPZp
	NvgccbpCTSTmZ3xzlImjC8jfHE+a+HBWtZtbKQR5UfsjWQr2z989m1ksTEukguwv
	HQS118uxY969rOWROOy0Mg+ubrlj9dQnp7l9758Xw8/5qKTm1a2qs5QQVNV6DO6S
	W416qFSfqFBK5jm2n+r9BaJpJQHhCEqR1Lm5fS73z2OHu7xtH5AyyPM5B+CKVXfE
	dQC0FXn/OMRchFI26Kbr1SOOE3YfjQs9Pt/O0I3N78Hxfo8B/j/m88yzvqKfOmmH
	TC8ZAI3OA36KQZl9jbgl7SZPYtAI2weXJCkw/6o4Yk2zkY5AQ2plDD91NG3gr/Du
	+LNqRg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2ayb0my-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 06:26:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7bad1cef9bcso9209687b3a.1
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 22:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763447175; x=1764051975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEaIIGkepzw4etmLuWJDtUUXt829lIeGN1TrIUN6PXE=;
        b=ZkjCP+pNgelY4Sm3XZi1Ez3aPBSX6EiJb0k3GZ0GXifA5bzyTSk7mv9eZlnjjLHwHP
         05gI+NeGzppImT8qa+Op6LLpkisTedprWRT3s0CPxD3Llfm0k8Obek04LWvBDK3wF26P
         h/lw2Yp8FnKYczB6lHiwCQka9krydinD/VpFbMvkhHb7XllfPh6oIe3v0QSw9XIjtJmn
         cG9i7NGWdnEJreHmW4i/bcZkqwSLJvvEswmJhZALIaOwIQ79BKv/mtRBfLPVjmOgX1WT
         rMwWzRcBnUZ7p/ar+AOyk56S2DV0qI+Ahi59GLTVqkppW2snje9CMcEuc7NXeva/kxOm
         KJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763447175; x=1764051975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEaIIGkepzw4etmLuWJDtUUXt829lIeGN1TrIUN6PXE=;
        b=rOBPMi7ibFwHmM4H25k0bqW/3DQ7/0xRQury5NhGaKtqY8JzF9GrEoagZGDo7624Q9
         KuEAVWqjWsZwDpY7jcYnSmOeSMkX/ybi+t4ZBltsKG1JjcFP/zdS5FszaZXR1ntuXjcC
         NZT4C/0vGuPsAGC0ECJZxB+qpZ+wOD0Vwjs+F6azBLZjm4bsWDt4B/GT+1V4er9vpSV9
         RqAWOxmXGoAu+K0+9AcYa8Et3WKuftncCbXjEkTlCtSxXoGGMPgeqQlU4GgnAxS0Vbl/
         odx1X/ACQCPkiP0KWIhWaP4M26EbofZv9GqEM03FiCeVy1jz1FmOS96lkuM9e4TFucoE
         zekg==
X-Forwarded-Encrypted: i=1; AJvYcCWYsf65w568cuSnzCLQdrKxwFGo0WJbKu6hlziXBfATEqByiADCYZ7A4eEMxmfLrY/lUVrwjWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzshIN3ZcNRMjhS+1LrtUUfN3Qx5I7en9WpJCSi/3f3zGt1kVQG
	fNbm3NxKCLvl3RYngqI92VJWeCzuJMxw5Q7XcA+162QaOibJFWRS90cEyNWqHsbwp7RcldqCN7b
	wvNdDXpi8bZqd/VIEJ+7+IN1QYe4C3pu38BZEE1h0IdugCap6VtEY6GgA0mI=
X-Gm-Gg: ASbGncsdSihw8A/zU6ddVKtW9fBYFQVxenSFwJ0NDi9nk46kiYYpLp8m8Co03B5eERV
	ncIzhMaRkAIaKtXyWGBbR2IFZ6am7sSSVmvAU3Nhsds86tKqSQqRy+sknDvpPEqNvWp5vp9CtnJ
	TSXzwlV8UD99CU+hlmB2DbpoLMK3b6f+H+K2ewto9QSTPWJcGtQGvAHxT52jxVUANREU9rnKNUU
	cWwa0LhMB8UsyYEmUedsqV+yPNV8Z8BDQeU/1QNRlLSFyIb7geWa428L9Ukf6bMGEWlcD/f7OeQ
	F7ek4XVr20ohOg7CT8AdAHV49gkdlmqD6b8Jtc8fJsjhRlEFuD0kjD9je+YuwSZ838rnzAzCI0s
	OiXPHqeJSL1VcaLxfSEtPSZrMqD17GHxZGjtNEg==
X-Received: by 2002:a05:6a00:1383:b0:7b8:d607:41a3 with SMTP id d2e1a72fcca58-7ba3a4cf14fmr15652291b3a.13.1763447174589;
        Mon, 17 Nov 2025 22:26:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGssmnkhvBdIUS9ByeV/gK1d1xxT8a+P/xJYitbkNdH2SbZQVn1k7cF/ewEXs97j7J3iGuDgg==
X-Received: by 2002:a05:6a00:1383:b0:7b8:d607:41a3 with SMTP id d2e1a72fcca58-7ba3a4cf14fmr15652267b3a.13.1763447174110;
        Mon, 17 Nov 2025 22:26:14 -0800 (PST)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9271505acsm15223351b3a.35.2025.11.17.22.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 22:26:13 -0800 (PST)
Message-ID: <5ea67575-b279-4d36-a278-6967dc97a5cb@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 11:56:07 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] clk: qcom: mmcc-sdm660: Add missing MDSS reset
To: Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20251116-sdm660-mdss-reset-v2-0-6219bec0a97f@postmarketos.org>
 <20251116-sdm660-mdss-reset-v2-2-6219bec0a97f@postmarketos.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20251116-sdm660-mdss-reset-v2-2-6219bec0a97f@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dL2rWeZb c=1 sm=1 tr=0 ts=691c1187 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8
 a=4KfWIHW6W8MtA3npaf4A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: f9EAEEeeRKSnUyrd_lDQ27MbpkGNt9nz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA0OSBTYWx0ZWRfXx4s7Xs1eBVkD
 YN70q8FHo/B/H63ofLp/AFjYdMWKWmOr5zrQAS2pPoNaTRcyi8ufP30YgA0P+lpb8ZOddV2a8FE
 0E4pSpJDXAWlJfCaaKBQFmOdWtfA3F14Opq22fJICFHPkx2VMHN02psutwyBwFaO0g0st0FBRUD
 /S/MeXEOQb/2QGxo5WDOgbDsObNqj65QyJ7yegQ+HXhVXiFI4UlxKkzUR/qlGf2Bp4inFrDr9kD
 QaXf0WRzo/fRDzdQO3eFiMDmz6sWV51UPTvzulmDZuFP7M/LiD5oHMBAk0L1cYatdZQg35IcsMU
 qg/tG/KtNSj9bJOo1DM9k1YltkCv6gWGXWIxgYsJogMNEUjf3XukLHoJHrRSH/kfRD68T79Pbli
 NRpiC1pKJo04113oKXn+sPC/8OeFJw==
X-Proofpoint-ORIG-GUID: f9EAEEeeRKSnUyrd_lDQ27MbpkGNt9nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1011 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180049



On 11/16/2025 6:42 AM, Alexey Minnekhanov wrote:
> Add offset for display subsystem reset in multimedia clock controller
> block, which is necessary to reset display when there is some
> configuration in display controller left by previous stock (Android)
> bootloader to provide continuous splash functionaluty.
> 
> Before 6.17 power domains were turned off for long enough to clear
> registers, now this is not the case and a proper reset is needed to
> have functioning display.
> 
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Cc: <stable@vger.kernel.org> # 6.17
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---
>  drivers/clk/qcom/mmcc-sdm660.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/mmcc-sdm660.c b/drivers/clk/qcom/mmcc-sdm660.c
> index b723c536dfb6..dbd3f561dc6d 100644
> --- a/drivers/clk/qcom/mmcc-sdm660.c
> +++ b/drivers/clk/qcom/mmcc-sdm660.c
> @@ -2781,6 +2781,7 @@ static struct gdsc *mmcc_sdm660_gdscs[] = {
>  };
>  
>  static const struct qcom_reset_map mmcc_660_resets[] = {
> +	[MDSS_BCR] = { 0x2300 },

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

>  	[CAMSS_MICRO_BCR] = { 0x3490 },
>  };
>  
> 

-- 
Thanks,
Taniya Das


