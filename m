Return-Path: <stable+bounces-104099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69639F1019
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F89D16A821
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271431DF759;
	Fri, 13 Dec 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fusBVjgN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C31E1C1B
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101823; cv=none; b=oaLnwRT4fG4wfhnpfvmvEhBpB2aR9pL/941QzLpqYO2C6X8hYkNd29Kh4/QU/qmo2IWC7U9332AdwaoGcFEiQFIsB160D7pNFO3l4ngWddn/+X77wXAD4TfgVDv8JkFO/A68y39cnb0JQxGH2yAv9E6mhloeFCDpcjqkBj3KX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101823; c=relaxed/simple;
	bh=CK3rLLzpiXhXNZv2awCI5dlzwKLn18KynIqrlKfIWS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1m9uI+3QOb39n4st0oZlnUCeGh3lbT8BDZJEI9PbDJMROGMmjs7NYQF//M6nZvTTpVGxElx59l/Da5KwgqEcVgoNQeJx9xDGgJ62gNFqoMwUieBEcxjJzVsyYQpnq2sw7w/pwz+cABf+ZcM9w25fml/xSeFVodHL5Fqm/rOW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fusBVjgN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9pMKv018942
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ic4TkTyxhhqanbmclHumG0uyeTN9c7JqFV55yYmF88A=; b=fusBVjgNwhYqW4ig
	YOl27Kb6kcVo6ckdg9nFu+xV5KOTdlE1CpRDnVYBfn0Ow1NFiufaWZ+p5h/gxDS7
	DdB5GeqILVAbkbbunHfRD9XzrpH0gSiFUc2ceQLBoiJEPt0m+i8J1l5LBlj5xrKP
	FEJiwgyjaztvqbCqE84vYI7vRx14/IhIvQ/NnShXu/T6/UskRJ7vXhFN+kcXjxyt
	QLLBhOW0GvYlDnK0L+tpfR47paPPE+JT6Q52KhS5LISiA1bbpuhbDGYQkUTENAjc
	idgIcsPOPI7mfpc3LEoPfXgAeFuboZa31XXXFuj9RdsDph6svWkvDYotxu7BJhzk
	kLuz+w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjnb0ug5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:57:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e5c3a933so28841985a.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101820; x=1734706620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic4TkTyxhhqanbmclHumG0uyeTN9c7JqFV55yYmF88A=;
        b=tN7egtnBD+9HmCBCdcyUQZK5SohicroCgVeRIHfms6TBZDe+QUORaWWHK7QrEDhq5/
         7vHegIexklCSLqoAUBW+0KsZibK9k+CgFjNuOiHvn5oPTJE5InHV01/gw7sNnByOzx3p
         GFtOqWcIvv2zzggI3FsKXC04Iqi+lpkaGHUrrjVlseFrPbvelB4dLDlnScl9mqTUW804
         eK88tbRmHh5ibwHHCA7Dl05aT906iqGJdw4ZJpd+Vor3lGDom69p/t8B0rydZKY3HJ0H
         qRA9dYkHLrr3nu+1Ucw3sa0NcNjNLb9iRgrZ1VbUz7Sj1WPiNhHKkLIK8VBHe5dHy/KT
         cu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4URjURYGyLmfjaBICDzueJwUPRWQ65L5Xrmd5zt/y2zRkNYMjnXOiae6p6PFQjGv54tcUh0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRs+Ag1O1jEWO9T0LN8MqL0/aJohrc8VF3Iv5lEXO9sxoE3hw
	WQ3jUvdHKBDrCt/+n0YPyNSF1zVFdDivvepwy7/zyIjFeALbijb4qtHvqaVKSvi2nk8s66LFQpz
	qLv9YMToVx52IDUYHpvV2wqLFZfxEdtURTtaNkApG2HWQ/UxT7sJ2nBU=
X-Gm-Gg: ASbGncudp1/QxBqLa7IcjwwP1+Wbday//drh01ePLrYKtHDrkqx5/Htri5gtuEDKjXa
	0eP3zvs8Xulr+M5B8csSdCFlRXGRGmm2vpKlInc12hmgyqA+NK5yPnBguUzFyjkbZ4JdYUWcKgn
	Z7F937AMhA8kHZKKVQZ7frJHkVYd06v5yC9uiqy7FKZOJSY2F2aB9nUADsVe3+AqrfZ4jzozQ2g
	4C076K2eNU0G7lGGAK91p0f0n3Uvdm6jRBljo9u44WvFbUdW8VtSwSOrNg8cgW0Cik2p97MGfgE
	n66DDkoOldO2DmhPPtIBaF1RZtmnQhcEty92
X-Received: by 2002:ac8:7f8a:0:b0:464:9463:7475 with SMTP id d75a77b69052e-467a571a0f3mr18700571cf.2.1734101820373;
        Fri, 13 Dec 2024 06:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHODc20z7j/rJOwWgwD5YBYqoVh/j9s6j/7ssKsXE/JLg/BfDiEG2ghMhwDfPjVViS3TL+jcA==
X-Received: by 2002:ac8:7f8a:0:b0:464:9463:7475 with SMTP id d75a77b69052e-467a571a0f3mr18700361cf.2.1734101820032;
        Fri, 13 Dec 2024 06:57:00 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a394d380sm501367066b.77.2024.12.13.06.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:56:59 -0800 (PST)
Message-ID: <9a7f43fd-a720-481e-b8ca-68150c202b74@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 15:56:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/23] arm64: dts: qcom: sdx75: Fix MPSS memory length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
 <20241213-dts-qcom-cdsp-mpss-base-address-v3-20-2e0036fccd8d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-20-2e0036fccd8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m6trtdvZyW3RY2NdLFkszIUHDvFI8kPA
X-Proofpoint-GUID: m6trtdvZyW3RY2NdLFkszIUHDvFI8kPA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=912 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130106

On 13.12.2024 3:54 PM, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
> copied from older DTS, but it grew since then.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Cc: stable@vger.kernel.org
> Fixes: 41c72f36b286 ("arm64: dts: qcom: sdx75: Add remoteproc node")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v3:
> New patch
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> index 5f7e59ecf1ca6298cb252ee0654bc7eaeefbd303..a7cb6bacc4ad5551486d2ded930c1a256d27655e 100644
> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -893,7 +893,7 @@ tcsr: syscon@1fc0000 {
>  
>  		remoteproc_mpss: remoteproc@4080000 {
>  			compatible = "qcom,sdx75-mpss-pas";
> -			reg = <0 0x04080000 0 0x4040>;
> +			reg = <0 0x04080000 0 0x10000>;

I think this should be 0x04400000 instead

Konrad

