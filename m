Return-Path: <stable+bounces-86835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F4E9A4116
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D638B22514
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8421EE03B;
	Fri, 18 Oct 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZRfPz9Y"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9318A6A3
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261518; cv=none; b=H81ZK4G77kS6L4bob7jmq5GzU2PtFiptHNQql7NnekLLDiLSdOuyFkTX3mbfL030hrmzFtkDj2z4BTLHjIgt5e22ku/Hc2Joc2BznP0zyXcCFYbwmZowZd62y6QKWWrw9Q7VHJAr/HYEFgsmftSjwNHm5NHPs4KwRGjzNSNbd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261518; c=relaxed/simple;
	bh=MiTxtfFmNVJzlSdi6n1ROJUXDLfg21r+HY2z9GUrmeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BorKXKBTgqd0j6Na+WY7w+Pfy+AbH/EhLF4G4u4xU/b5b9lUM4M4xECYoVuXi8U8kqPzBhTTpDm5V2Bb4y+FEkKp2hiY3MGTlT0UZOKRc4trZ57JZsZP2h/2YfZOYtA1142NFSCSbVeawsVqBk1TE9YJbIIG6zIbmhQKv/pP1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KZRfPz9Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I5EaOX029405
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=950Gln3oRkg1xxQo2JyWMANI
	C2EJJqj9QDHlhqTRV1c=; b=KZRfPz9YOGZfb09zR8K9MKwDk8XUiCKlABimkDHO
	5t6MwiYb0S+ZX5wMzyunKdR8vZ3uJuyQeOGZa59HyTDmqkoh3Y+D9TMPVu97JqUT
	OnTIXzLW//qAJMjo5PJO97Ae4aO7P4tpN0jhUvMfOQIdoxNjcGOMR/FFPoOgXiq6
	+6CXBeIV6s+vV+rMhA9LHi2axH1NCzgwCOeByt9lJ1iMJHxBjT5eqEuqvcxtWrdC
	QpQoZqMyguYuP5w0XvFi61uHQn9YMfDNP6JbDZ6EFzZj4ChMqKgCSCjzK/xngW9U
	t+TDKaIt8Ey4C8Hnd9uDF94zVljBYeqQ9lW8iEbaG8Bmyw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bhbq9hwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:25:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2dcea0f03so2514123a91.1
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 07:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261514; x=1729866314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=950Gln3oRkg1xxQo2JyWMANIC2EJJqj9QDHlhqTRV1c=;
        b=VME4Rg8+Xs6ifJJ3XgVLyq7I2wJsFMQoreCx0ZD1z19E96BtTudYs5wgBXCyqhVtV2
         1fnEPSWfikf9ddG4tGoHotT+cuk4MIYujtXO0JweN4/HjQ3KkxWiGe9rdSksCuedqgwN
         ZL0FPW39pwbU1O9HaTIotsUsqXPp/O1CVriAfSELADZxxcblUYh0uByNZDiG7lqoYNto
         NTF09GJFZ9WdH4y3lifIWBafYrUBYw7RfQAwOSnVclnLEmOTUVxcZz1PR2eS6mKS0s99
         E6BlFduujCliKwQ5Sey41qw2HThHWvrumY9GnvGVDywlhGwj3x9UKnHFjFlmIkwgapT+
         c4pg==
X-Forwarded-Encrypted: i=1; AJvYcCWSIv2XAzLSI4/cqBQPTM9akqH8GVU9lwpsx57cV+EPmwcPG8qTG51E7R39OvZ2s5CcpFOTWbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4xqw9OofB0DSh8aUvwOgRBQcUEA1NMdnEi+jDjg9fi8P2iGW
	yS5g7z4cAmeNbkiWlAJp5NI9osGg5XNzr6pExFrn7FEMBUJ0wLDNHoxEvCPEFehoWUyijcOFwHR
	Xgjxf3tuYeIcEC5a4l8ODUeNm5LzQSRVagZMigRpB/bKBia3u+bXLfs4=
X-Received: by 2002:a17:90b:814:b0:2e2:a96c:f00d with SMTP id 98e67ed59e1d1-2e56185d15bmr2906148a91.21.1729261514638;
        Fri, 18 Oct 2024 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkUHVLnMvv22CyRp7iu7KBlZgU4Zl3vVLKMotZZtrb/b1+LPaa7xhxw91j8nR5f5tNmQ8acg==
X-Received: by 2002:a17:90b:814:b0:2e2:a96c:f00d with SMTP id 98e67ed59e1d1-2e56185d15bmr2906118a91.21.1729261514252;
        Fri, 18 Oct 2024 07:25:14 -0700 (PDT)
Received: from hu-bjorande-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55ffd3014sm1934643a91.0.2024.10.18.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:25:13 -0700 (PDT)
Date: Fri, 18 Oct 2024 07:25:10 -0700
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, kw@linux.com,
        lpieralisi@kernel.org, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        johan+linaro@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 6/7] PCI: qcom: Disable ASPM L0s and remove BDF2SID
 mapping config for X1E80100 SoC
Message-ID: <ZxJvxvxlHuQ9Zze5@hu-bjorande-lv.qualcomm.com>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-7-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017030412.265000-7-quic_qianyu@quicinc.com>
X-Proofpoint-ORIG-GUID: G5IXPeNfNyIC2MdoDkvo9wEoswEOWVIC
X-Proofpoint-GUID: G5IXPeNfNyIC2MdoDkvo9wEoswEOWVIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180091

On Wed, Oct 16, 2024 at 08:04:11PM -0700, Qiang Yu wrote:
> Currently, the cfg_1_9_0 which is being used for X1E80100 has config_sid
> callback in its ops and doesn't disable ASPM L0s. However, as same as
> SC8280X, PCIe controllers on X1E80100 are connected to SMMUv3, hence don't

Would be nice to document the connection between SMMUv3 and "don't need
config_sid()" is because we don't have support for the SMMUv3.

> need config_sid() callback and hardware team has recommended to disable
> L0s as it is broken in the controller. Hence reuse cfg_sc8280xp for

I expect that config_sid() and "disable L0s" are two separate issues.
I'm fine with you solving both in a single commit, but I'd prefer the
two subjects to be covered in at least two separate sentences.

Regards,
Bjorn

> X1E80100.
> 
> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 468bd4242e61..c533e6024ba2 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1847,7 +1847,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

