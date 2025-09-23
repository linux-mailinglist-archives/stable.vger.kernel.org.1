Return-Path: <stable+bounces-181420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C7B93C2C
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 02:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617433B28DB
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 00:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7061C7015;
	Tue, 23 Sep 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZ3nCz3l"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1D15624B
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588938; cv=none; b=tzDKE9RrPI62aFxqpZ+WA78TKwM/3aDPUq/9X9LZYrlIXgtjqWaO4C/uYzcrfxwUVj7VOSgUufJlRO1eNRTWPwo5+jKZhTzzAYOqtFUnkM+55IbeayC6x4TKBy6d30nXFm6xrPC9597SE7J7ffCshXpScBtR63OyjkuRBEv0uDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588938; c=relaxed/simple;
	bh=r3XfxCtze3N6fvQmIZENh4/4/Is2JvXIHoPY2CVVME0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E0gWoGsC/IJlWAetN28rOEWH8p5UAHx/DamdMR/JVBuQuZXf7P4CvHQokCZ365JJtKfraufcrlCkXjEBcwvae1fv+9XCqEMJW/C6yU/WOqzw/+D6nHqPa5+QTw4l+I4j/J3Zpy/wOLNjx1UfXdmS9vBRALGMMNGp4jSL+bsMuk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZ3nCz3l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MINrDS022627
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 00:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NOb1UnHXBdMvECMo2QSGZH2wkRTlB3W1x0spXCNEWg=; b=pZ3nCz3lXzeRJLMp
	6plYcsHUyHfYocf5enSbYSuwcmM3ReJTcpMhk8VkHtfCCPOlYBMSGmagC0QgzrBO
	p19aB+hsdHgSKb1ZpYu24dYu6xdGs2+oXpM2NhShBpKlUOeRAWSz7dytaRnoBxDl
	QCbqzl4xjqnC1oxxWRcgwj/HtcBaGWy84TXDFMXLzWib6hv4rIgWqh7ZGrqT1i9r
	9LY3i75SwnaFLS1ZpQv4PzSY0CgMhpC2TZKKltMHk5Jq2Yu4E6b4tl2JLnp+yzUf
	+Y6nr8TYN+HBZM5y/Id2eCCOUbBY4BIcaNFzNk7yV+wy5rUbYL8iqCGf5jbhRbWp
	flvabg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyadtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 00:55:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26e4fcc744dso23902485ad.3
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 17:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588935; x=1759193735;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NOb1UnHXBdMvECMo2QSGZH2wkRTlB3W1x0spXCNEWg=;
        b=ms1Pg8mFxzoKqHdVDhhh0q5GKsGX3iWaPO1bvhCggKcQo5pItMBE1E0HgGoZMkkMGn
         RpvpOhkwlyiaFA9EFX2FRMhCZRpxu45oVSnv7wwtgR9DceEn0jTXj9V+PNf3Z63FDkjt
         BGpm/t3KjwftnwVb5cAa9xjxiDNWwF9LhR+zwbPIhi1EfnOsBqfnkswcXK6f8jxfC3I/
         XekyzdYyZnr2NDyhvCVlIM0WC2dZt9FeZwovRGUoIcQkoGi3y5L0qaDMpzXAKHHRNtl4
         LQDD9KKeKSs/teVd98kZt+5ytaqbdS+ormQc4tsQw4NgnX3DwxC/mexE1olTKFoZHtK0
         wJiA==
X-Forwarded-Encrypted: i=1; AJvYcCXYCzI5FtSjJorUZZhTBIkPbvkx0/gEAjuFXl52jKj0V2vMC7u8dOF9cjg+PFQ/LY2BmEOjkrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+eC19yEQmnqpWWDsacB3PDI6d2JXpmc+6/qSNCJZfRC80iCC
	xMRN9xn9RJIqo03uzY+CkYKzTI/xXQpumtgwpEEGuF/mwZZ2BDIfx3FjJ7JXrTAr9Cq5rOQfmuI
	RVv8DkLv+8JTgERgM2sTxSh7fpM5z4xokraEnCiLJfr8mwF8LlZ1pdobqCXk=
X-Gm-Gg: ASbGncuDFiutkrVXYMPsE68Gb19UjSxP4NE1iu6OIHtttDRL8oFAQDB3Q6zfz29w8Yi
	1XPww9IEbYk0SOHe9jiHZZbLtAghbm2kVtBXuGumOeRjZiBSPrFsfhfDdRXAjbhu3rJ3hT03TkY
	neT8bskMzmB1V2nWt7OEtK1WT/DChT/fo2gI636rlpw3m6kv42Dxwbh3RkxHVKWW05iFMIj1o2p
	6YTeD67nlAkEOpRPvHE5AKcVc+v2xP6/QMTuqWy1oxPOMbwDdl+zd9jHa1CFs4W2siuxM9bX4SG
	dgxjZzCUHyFgkQQ6+gIZBlaY66R4LKYD684nEJZbOFb3E28Rg98ZKGLmA0bGBfXT5+0gX1YC/1s
	8
X-Received: by 2002:a17:902:d504:b0:246:de71:1839 with SMTP id d9443c01a7336-27cc696e83amr9635835ad.50.1758588935174;
        Mon, 22 Sep 2025 17:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgkK9eoU6vOWVlLO/FmLK8aalMDc859rdHBZhi4f6aTg1dHIeLHmkfnD2xmV3V5/OgUWynjw==
X-Received: by 2002:a17:902:d504:b0:246:de71:1839 with SMTP id d9443c01a7336-27cc696e83amr9635475ad.50.1758588934766;
        Mon, 22 Sep 2025 17:55:34 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm145381435ad.15.2025.09.22.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:55:34 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        kbuild test robot <lkp@intel.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Sven Eckelmann <sven@narfation.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Miles Hu <milehu@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250722053121.1145001-1-usama.anjum@collabora.com>
References: <20250722053121.1145001-1-usama.anjum@collabora.com>
Subject: Re: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
Message-Id: <175858893357.360026.14313486300585429827.b4-ty@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 17:55:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d1f008 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AgmplPYfmL6CJUdp4g8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ti5ba9gDr3-4kXG-30Aw-J4Qm2nTemd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX8CWrKwc4oA++
 fpvm+/9zKkVKDAMmCafsR+jCS1SzfbgqG244oQFkEX0BHWDSX2aCtyZI66Sw9HCPUF57uhZtXMW
 gnlGJqE9iWB5O03EDbFB8amw+5W2zJoh5DnIE7kzNteSmwCA8SjREfd3eHq+BBYA8l6cnBWjAte
 DqQLUEgTZTASf07z5FEUFX+TCGflG6at+nVkgPwFKozp4FiCFL6f78JcBHR4AzwcjR4/kB/gJc3
 ez9vViSoYmPR6o5c8UQH2SM0DnvGwSTOEnda1qZz9QrNSE9rqt14auMlg/xQMioumpoF758SL2Z
 hoxc4+q15mufa1rHX/g9WAVBGyrDFDh0cGDJP1+MSNr02Ea1ocMk42Z8sr1OKkERtE1UW89fQnu
 MLtpC2+U
X-Proofpoint-ORIG-GUID: ti5ba9gDr3-4kXG-30Aw-J4Qm2nTemd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090


On Tue, 22 Jul 2025 10:31:21 +0500, Muhammad Usama Anjum wrote:
> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again
      commit: 32be3ca4cf78b309dfe7ba52fe2d7cc3c23c5634

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


