Return-Path: <stable+bounces-202890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39246CC945B
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 19:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26943014596
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9D2D320E;
	Wed, 17 Dec 2025 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XX0FTlGh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnHvZqcR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D7261B9D
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995525; cv=none; b=SfQzBsBFUUs3IZcA4CADML7VanASPIoNC5PkO2YvxkcV6Ihe3dDcePq3FQFeY+2vJsTZYn3z06BLcrmMFD9R7ouaLjuQk2n7DCTfQgmtKnNqipUljnaSKKSZq2gCQe/p3mLuGPmi5uRJtRJgpgdVGegXlrec42gHeKn7RmTNf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995525; c=relaxed/simple;
	bh=KPCoPks2Y2/j+fWOc0DjbN2flfAgVDX5MiFdzCmlPxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhYk1LNV18D35x8a19hJkeGUQk5TNBnboPbDNRZFTM1qHCFW/FD1CcmfdTPIL1oUug7IZ3m/f/t2lgGeVXuuPGjBw3pX1SOs8mv6gLtJDbymoWLQrXs7hFuR3H7VGd2MiPX7LAYOhIHvyxzIwNVM2GJzGq+UnWu+u4BTIzCJCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XX0FTlGh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnHvZqcR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCL8a13204360
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=; b=XX0FTlGhGcl0GgQl
	ByTU7cTPlDPk/BXambHGMBBrAFNZaJfIcs6xA6ew4ZJ9tR7UJQS+gqePcy3CuHsP
	vAotqv37mohmAfVk+eAvIYj7rZG2V0YacO0NNdP0m9w3yE0WWFoEoPEvo6maf4xs
	6DWw+J4IIVBayH2jAWjYTnjijGyHuVPMpR0JkPMA9P0/h03K2SoFh/RKObvRsWpV
	eE00BccsGUxbyFdW7MIQrXSXW3cfy70VmIAoj7vErrMdAHU142riKXQR00XrVdgA
	bnC0PryPEaCZPZzqHVwAwn49yCO1jVtKSjP0r7hhODK19mvYysQxYak3xA0We1cb
	FKeYhQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3j39k4b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:18:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b99f6516262so16143313a12.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765995517; x=1766600317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=;
        b=dnHvZqcRtWDUre1eSfogviBxCN1JzyHdKmapu2M1qOVC3dThbDQ2E46ZVgFM8YO8co
         cnHlKpe30HIkVhPSD9wk/hsMp7B1QkWxRU19JFcDyyIEzwYb/ZIAijsxKCuCW7fxxnqf
         H9TdxfWDcUZ21KsJEqIsUeHy3o7IW9H17uzg8Zet2kh9fuOoeTaHjx7WngyiYzksfqyy
         vco0eLOEwX2L3/1Nph1uWmmQ/tK47ynkdnS9Orq8mVDCZK/eaQpSg8H5Um57U23qJsua
         uWPp/Zo9/eMIL7nV83cZ87zQ+ybvd9sjX+wf1Kh/XvKANbAXYDIRumejZZVbL7vshHdZ
         T0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995517; x=1766600317;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=;
        b=Z45e3JWqTXrX/tWAdLvElFSLMUwVHBRc0ipqqvF1NXgj2bpBF0YKfnNGVTmRfKvPfj
         BTMZ6ZsE4uZzoiourjAI5349+1AHuz82XF4NnjKiNnDGRe14SCvlM9EldprAqu8O1YaS
         vjruCfqi9p0S3slA/4M4DPIh67pPYJM8G1/wIYWm8Ep1JdB/7Tx3v9of4Fv4Z2e02Yay
         beg0ObILMnBOZK23gxPhPFwrJhjUiKKUKzqVl9ZyszlW6knvAr36CSOy3eovq9RT1GfK
         Zc//hiEbPFrlCF8jLp0T2Da/oZgCZosrV8mAJbPRNhkB42+4bD/3EkvaDMwPPecnEzNg
         IdHA==
X-Forwarded-Encrypted: i=1; AJvYcCVYBOyflM56XshGfMFSpppzO2UNNyVCvUT+8XNzH4XXv2t6vGFSwlES78InWfNEpE5qjyLTps0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+axEEePMC6vaeHZe6pYtyLo6XYYPM12+2PYqKyFtTB7yGKxL
	ZUXVOoPmqGomE+XKvR2GuOOSI8l7Y4PdtShSSt1t8IvPt3jUDdK8B47Gvotrzw6B7fm9c711jq0
	fSd3Rpjm/FK6ojvVIre/NjeBBa6IGQbS8LBSLdDI8C8+Q0qq4EbYE6xLumfc=
X-Gm-Gg: AY/fxX5YgKMbqOMVvNlMwltb0/UKrT6i6KmThh53Cqj9gUv+ZXTr21vUrEJzDnadlmW
	g4j/hHlWbFDxbWJ/BY4x2sJgHRFlde0AcZIKztqrXwsO38ukVhUrVxreXhzvU8wzNcfbGyYp0Hn
	iIjuHx9od1M8TToj4EelKWmRhSp8yHiAmkGQQmBslBSmu371G9A3GZ/xAUKlzdI5b7x1evc6Ivx
	lFUYOpYVcR/zTUgGdnjKsWrwH8q4OTFaC4McTRx7p6ZFCP938IwQc9IPaNfJ96b/XB9aK45SoAp
	RXHEW7QovDkuo+/1lWRUWNAXr9gr/wi6TASdK6AL9HuUkdepRLE/xGJ7HThTUVdymFXM1sACx9+
	lNx7DIvqRbbWn3InLSLPI/MDX/L6vWxqUjeqEBJ4UjYBniG9q96+l5TLLSyBjJHluwGaSFg==
X-Received: by 2002:a05:7301:182:b0:2a4:3592:cf83 with SMTP id 5a478bee46e88-2ac303958camr10594071eec.39.1765995517140;
        Wed, 17 Dec 2025 10:18:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6ScF6p2dbGaIAlfPTuofAf2/eZTtk6ONOKBGl/Qm27pAQp9ttnZa9kTtvsKTJrPW0AuH8SQ==
X-Received: by 2002:a05:7301:182:b0:2a4:3592:cf83 with SMTP id 5a478bee46e88-2ac303958camr10594041eec.39.1765995516561;
        Wed, 17 Dec 2025 10:18:36 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061a93616sm517453c88.14.2025.12.17.10.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 10:18:36 -0800 (PST)
Message-ID: <5e568034-20a3-4ed5-a8e0-c010e5aa7b82@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 10:18:34 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: qrtr: Drop the MHI auto_queue feature for IPCR
 DL channels
To: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
References: <20251217-qrtr-fix-v1-0-f6142a3ec9d8@oss.qualcomm.com>
 <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0NSBTYWx0ZWRfX59zmWazVDqYq
 hV/mHWg/gJop7pgRvV9t9O8qDGK817sVQmdD/S33hkQEspjB+N9fi0qbH2QQNGhl66eVT5Ym8Qi
 5lqOEfDlfh12y42W54YbwDjNP4kS8oEPmtDlySqP4ryMcR44+Px8f0HCmLnX/k5vt58hx0SWSRK
 beu0Z/viGY75Ecj6XoSRDqFRuMPqKXmmbt+IdVVEfA1F/BYy/XL28no/NXINce5z4zn5IdFeYLI
 NQBwl+dvfdoH3kWIklVLFPamsyrbHCbLunUh5C+qoY2nW7lRj2Q0dUU+R7a/Yo2rAvJcKga9E/Y
 LGjSrhYLcR6eqMGorj2z57ynYVmIC9uuLAavQwHlTuPSBXMc0Wsor32BdmZtl8tvSvvt2UrZlZz
 2wOp4pGJwYomJj6Sjl83n9ouNIv0bQ==
X-Proofpoint-ORIG-GUID: 11tabTa8yIpIyDXs1nF0hDMImHHhcE6u
X-Proofpoint-GUID: 11tabTa8yIpIyDXs1nF0hDMImHHhcE6u
X-Authority-Analysis: v=2.4 cv=ToXrRTXh c=1 sm=1 tr=0 ts=6942f3fe cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=isMaZ9OHK7bkWVW8W2QA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170145

On 12/17/2025 9:16 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> auto queue the buffers for the RX path (DL channel). Though this feature
> simplifies the client driver design, it introduces race between the client
> drivers and the MHI stack. For instance, with auto_queue, the 'dl_callback'
> for the DL channel may get called before the client driver is fully probed.
> This means, by the time the dl_callback gets called, the client driver's
> structures might not be initialized, leading to NULL ptr dereference.
> 
> Currently, the drivers have to workaround this issue by initializing the
> internal structures before calling mhi_prepare_for_transfer_autoqueue().
> But even so, there is a chance that the client driver's internal code path
> may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() is
> called, leading to similar NULL ptr dereference. This issue has been
> reported on the Qcom X1E80100 CRD machines affecting boot.
> 
> So to properly fix all these races, drop the MHI 'auto_queue' feature
> altogether and let the client driver (QRTR) manage the RX buffers manually.
> In the QRTR driver, queue the RX buffers based on the ring length during
> probe and recycle the buffers in 'dl_callback' once they are consumed. This
> also warrants removing the setting of 'auto_queue' flag from controller
> drivers.
> 
> Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> So only the QRTR client driver requires the modification.
> 
> Cc: stable@vger.kernel.org
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...


