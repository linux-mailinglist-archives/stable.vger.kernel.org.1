Return-Path: <stable+bounces-203074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B92BCCF914
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 12:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BBE1302EF7A
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E94311C09;
	Fri, 19 Dec 2025 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YiMdrmX5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XWDpKc7q"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B352311958
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143587; cv=none; b=oosyxToZ/8KVYerTntMjEX7nqZ4i94N2DWMWdbQ3cnTV2B51xRHewz3Ppka1p7utemw9TxOcCZ9n6seBJreRTjh4vIo8m6W5wE6NYIIMhNaK5nfVbIypzvR/sEcBqDx3T2CV2rTz0ylnPuVhufm4SEWwf5AZ5N5cy7HZ4aIYPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143587; c=relaxed/simple;
	bh=8pJSuO9KIUWmfdi7w+3+9HoMOfbr+58miWs+1C6zH50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPnSHgMlQI1ZsDj6jXJvzD5WqP/fzI1VDibNelMQRhBObS/qxeirtemdPjJZKcmW4qjiP2VGTbesAPrUbt4FuuLKs6b/vdCNCrbL1699yO0etmbGA0oUOqo36btMlhQHHGozQ5jijnKOuaQahUP09F0jFROgpxkWvsITevdeGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YiMdrmX5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XWDpKc7q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJB83rV3939127
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 11:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgIkZckTvFqsmG+otJwpZvPH1RpWL7olKv7lb9pkgWM=; b=YiMdrmX5HvbOCtXI
	Gjd8vb97B3RzuvFYodaQrjZ1/HifKixRGBTy+0g5jdiOox4zgXgd+QY80U1M6loL
	nG9gEyzSJrf3xUlV4Z4G/4N+0P1CpCU1sRYZTPxEY4JKMClUen77thCyq+IeNzzZ
	6C+TvsAgAoN+LT9fSbU2rUTEGC9WNQzMk1erVcnVlN2hEuB0FJ1HCYQtjw44b2pd
	RkDrj5j9csFBC/N2mj8Gwlfzybsb/rHsNoY8B0ShrdvP08HtJhYAIBgx5PKHmgc/
	AwaYc5rqBfx0GvN8rvo7cmG2GkD9rXgMfp48nEsG0yc6IbNNx94iZZI28byRzlYF
	cjQ8pQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c2fnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 11:26:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2fd6ec16aso35931985a.1
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 03:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766143585; x=1766748385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgIkZckTvFqsmG+otJwpZvPH1RpWL7olKv7lb9pkgWM=;
        b=XWDpKc7q+V9OtFSDL7bUVAbxxx09EnAgWlCVf8OmTH6x/O+PUc5ImhZVKQALPTQr+2
         KS/FMZDYgBYqTWhbFW7OnYDEOGbteglEv7IPHPND6K8WJLB6WaleFSSbrXzLcW1ibgqG
         9DQEaB4plV0HYW4fmCkCCnotHAGxaUfEm6UPGIXDi9rw5vlANlgPEiR8XtIzHkHpapF1
         nC9z+SeWbVFTZIFF4kkc65dzlM6IdHen0blx9KeiqzXZCC2jwALGZJ83nrNKelT3s2rL
         Paw6l1c36WPKvsC8N9FnZtUeKZJ++pcRQ2uAYSzmP+hdDEQ6ttzV7O6mPDj46rxahPT9
         Boig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766143585; x=1766748385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgIkZckTvFqsmG+otJwpZvPH1RpWL7olKv7lb9pkgWM=;
        b=q6iQdfph0nDtuaVJV2SDOqSPff5V0yibNY/f9TfDiVYvQbGg9mbDh2bubUPxUlVlqm
         PtJNNAXi4npZpie99C/1Xa1UbMecFyIGAw+tb8rpSo62jluLYzajcfHBpJNYtD7QZjOX
         SqWroGKdflRvZD8iK0IEyIUsLGnlMDToGMGjetNLl4wcGsBYUMo9MS7oWyBY1A28J24G
         FiJeAfLMCJYkUv6ZQFlOgb0fHLpYctq/qukbf4uNXDEKECe/V+KK4L6v3Bce94Cerz5A
         Fpwp7nHUAijuY4TZakkVaL58c5uIK7FtyB+Ky6DzQhP+5YeWkpR7GntMrBQ+YbMwZgDy
         X4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVQNj2Uh9tE6CGNAp3jFNDlRjmfLbaDUWVFaV1HED7V+U46/lqVIeijtTfZMpprfW2EYzYC0eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4QTUr6n7Agb8+Jbr14WOBhLlQg65epT42jSoiZ6CopMNAHA3
	1mbDQ2Z0radseE+XA/FE9G7SaZFaDIWGUuUWPjwa+SDFA2Py1He8u1qEfF6QCS0HuPKehhV6OCb
	9ysIqEcFenLVxZM/Cmd6OEUXp/9yEJQj/B3w7z1TwPtCQykZPc+QJ8muXm2mnH2oJRWo=
X-Gm-Gg: AY/fxX5FQw4HXJwj65PLs1skBSCQ6HLP81mcT33tNWtFffoFHgiRlVEDg/659OdGsdb
	274BvQeR9h3tLHl6M9wbpeqS0CnHkTmQHnM3CyX4wKzdiGNIoAQgfZ0Nfvz16WvAGbsqW+8U3vJ
	KTaMWXwhkc8v4gPVUDyQGVt6OgGNOeYY7T1chqE5FBHw2Gn3clWrtm4ZEECSPE7Pr1Lhd1lax+C
	gmHF98ChFr8zgt9SGY3cdkrDzE4sF0kTbm3HXTwMrl96hYfFfTG6MoXXtWxCpe1qFLYrO3c8hQ+
	XnKnu1XIDx0S9WW2EVJIrLAtpzQkJXaZBxrDIQOdd5dDexbcpvTVteCSk2BXG4+AfDKQpkXH3GY
	rQMafX/cc0OdWjLAeU6Y1BSZU/zBsczxM789yTaHAinhfNvXLhFN4jQ3nEwIEqZ0PMw==
X-Received: by 2002:ac8:5744:0:b0:4ed:b7f0:c76e with SMTP id d75a77b69052e-4f4abdcbf88mr25276421cf.8.1766143584605;
        Fri, 19 Dec 2025 03:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQYdnxNsnG1bLW+kQ2/cqPw9VinGQT/IzvI6aLregUbGRCz0G+G/WNWgUTZ9OauQUxpPN6vg==
X-Received: by 2002:ac8:5744:0:b0:4ed:b7f0:c76e with SMTP id d75a77b69052e-4f4abdcbf88mr25276231cf.8.1766143584203;
        Fri, 19 Dec 2025 03:26:24 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad83dasm211412366b.25.2025.12.19.03.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 03:26:23 -0800 (PST)
Message-ID: <328e0750-29f8-4020-b4fd-e2e70a38005f@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 12:26:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: qcom-pm8xxx: fix OF populate on driver rebind
To: Johan Hovold <johan@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20251219110947.24101-1-johan@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251219110947.24101-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GlvOAKT0byNyUgAp2GD-YsMjG8DOdWIl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA5NCBTYWx0ZWRfX9hzmskh0rdqx
 YdCTimVjNlzFIRn/RBrhcdtACuUoCBe7ii6QYE+BDfTcKwvIohYHSZ6tJ3k2kl0gKQMghABTwcy
 Ia07XtxtjxgqWDmIehEyWAOiB/knAlrdk7vPXDGgDP2EaywJ4T/iez5E+XXDMnYKnauvcvJIpcM
 25VPw4X8tGF0H86Cqmspdz4KzFde11E43NVR9nDEF9ySHSXQpPym1Ftg4Ua2tRrclD25yApoG2I
 0CEq0mUnFj4jV0fTnsX10jzipwkO7C2mf+dNFevE1tJXdR6MoGUUEOEc3DObaAEtjluuqsedLY8
 ZkFkgIFxMS8uHdTZ9wPdWKjYn3IkwBRIIyyokc3Rsz32Bionb2idWzSyQ+yVlkAUpaXHY7zrZfW
 E22+RhagN76U5r4BNjqaWqMabPDwc/iYojWQ56P2FjNvrlGWN21zeXHlDP9mycARugwbZCPH4Jx
 8VheAfj1zp6cSy6Jk3Q==
X-Authority-Analysis: v=2.4 cv=feSgCkQF c=1 sm=1 tr=0 ts=69453661 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wTlNtMXEErMED71dkKYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: GlvOAKT0byNyUgAp2GD-YsMjG8DOdWIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190094

On 12/19/25 12:09 PM, Johan Hovold wrote:
> Since commit c6e126de43e7 ("of: Keep track of populated platform
> devices") child devices will not be created by of_platform_populate()
> if the devices had previously been deregistered individually so that the
> OF_POPULATED flag is still set in the corresponding OF nodes.
> 
> Switch to using of_platform_depopulate() instead of open coding so that
> the child devices are created if the driver is rebound.
> 
> Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
> Cc: stable@vger.kernel.org	# 3.16
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

