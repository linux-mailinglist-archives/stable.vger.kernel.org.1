Return-Path: <stable+bounces-204449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41851CEE14E
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B052B300162B
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE172D838E;
	Fri,  2 Jan 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZOXwlXQp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMp9wCT+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA9273D6F
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347032; cv=none; b=LUa/11QdyAbe3HyRGHvxKcTmAp8wYwdTsD1cFfiGUugg6sjilmVZ0Lni3dn2LV/Q8phnxG4+MeWdrEfXtFb5brUnU6WTAfnHNqi0fIR22aripsWPKgWL5ePOPbXwOpAF0Z5xUFmIR4jt1JItOh5rLZL0ybVbCaqPM+nT+QI7MX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347032; c=relaxed/simple;
	bh=u7E+JsBFtSP2Aq79SX7r0MLZ8E+3lGXEhvVfek+8kDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsrXdYtF7sfphvITTfncmOJqUy3kvjj4Uzl/PbubAs8cYAlapYS13TJBNleGrG6kcfYjUWXKnNpHRwolTy+q24z7nfOXMUecAPyP95lhXbziYxxJYSfLYoEp7Q5UrvoCAiaX14P4P0wHImgmdqLK3iEwKoWLxKXwnBJY5l37Jgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZOXwlXQp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMp9wCT+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029Vwpm2310173
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 09:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	viTJoTt+fY6CVrcrdzVYmyIcj6URFL2FJNsEU07SeTA=; b=ZOXwlXQpzJkqmYIE
	ZewEzVPQD7o8JJDY7VP2F1ponzpxQ9N7zF3H5xN6CEgz7ZX7FPi2IAPm1p9rpLJl
	Ozy1Nr6AGhB5ONhm/1O7QVJPrO1EbuOBcEATd3U2ZHzd7NPkUbMoNtQUM4lGcaj3
	Gnf7xgtt6AmUtd5BhM+31txCkMvpLRvjQ7TgnBNeJkdt3LJxH4ob5ozmKD1PFUw2
	POLA7yWLbFDJxKquyUwRQUYTCjegj2u4KCSN47pO9/bNrbCipGkl4Rp9qKdyMeJV
	27Wtfx66/LZ5ZgCe38Db/al/WE08i8eciX+lvSGfMgJnYZ86yHq5AHk1hZaIMCnb
	hUajRg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bdsc9spp3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 09:43:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so290803475ad.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767347030; x=1767951830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viTJoTt+fY6CVrcrdzVYmyIcj6URFL2FJNsEU07SeTA=;
        b=kMp9wCT+nl09A9T+Ui8BCHfGLOcxugyX+op/wvCePEAyCfR41sV9RWIji5LweTCk0N
         hsVIZ46KhuS1qsmOlxHij6MKFsf1W16+24Z+TO1WY89xqY2yDcG6fQadlkNWe8VMGTXV
         wilH6hsEPpWhDC+zJGrfFqtD4bW5lzsEuf4mboAvlLKsX7nmgxanGHWzP+7f/x6aaaM5
         GlLkt/zdlVi8SIydrzp1/M2JWPKLjRuUnfMWZmlR8/h9fiaU5k+OaFVxyZeh5xpZbqNy
         5zF9Q9kZRwWAy+ex39EC+zXohCisTBwyOBrZynzd0h/NYbSj5BNCgqe4A7MX9uiRibmH
         4iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347030; x=1767951830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=viTJoTt+fY6CVrcrdzVYmyIcj6URFL2FJNsEU07SeTA=;
        b=AXqZzNIGFo+hKvkA2Z2r/IXoed09ukyw3pq4opcAUZFZJW3IJZlkkjIuRtCy9vF/gq
         /C2h7YTpbrIWsHfDRaiOQJLZV1dyZKI9ZJFdXM04Aaecn5mwgpDs4eIjsHbs5DotMQUv
         98Ii4vhM89Ksma076kjoGc7iVjIhUmwbMR+zYFJhQWjP5JNKhhGoQ6abJleowmdxxV1C
         TRNb9spVu9dfxMNTnDcuD0/DOr3IbY8LIdmUeuapjSTI5jpheN0hXM2uu4+NqFlIc5CG
         r2qNPnkz7Bpq1oI8u7cCl24IKtINhTc8k29DZrxyGeqqMR2qgVNv6fgLAYWg51n9lups
         eP6g==
X-Forwarded-Encrypted: i=1; AJvYcCVFex0JJtQc21zCl+v8S4T8BM6hWFGPH2pPeKLHYtFVTs4QdVnf9uMnxwRWthER1nB7oN24eBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsTxuIiW+eb7vQzLgxMfDTXAdv8D/iJ/5sO89OHfq5PZMaVfJ
	7xxa7y4OOt9dSooexnMujLaBp7AqlFh2+AaBSFfCkCaUG9EDzcN6SK5HUwdJXO+7+Tuv7edOTEf
	+xkFCbLuerKggnLNzHoL9p4N0blR0OS8B0k+9090tGqMxo/B02YRMdua1sZk=
X-Gm-Gg: AY/fxX4JnvGPXZl5e8Wq1yxv4oUDHUSXCEF10nB9rejE0wyP928fep1ZvaWMsQAacn+
	gEQsUy1BJAOiKpgZYGyJ/Yr7eD5xB3msH3OHtXIyVSCrpqc8KjaGq5YR0fX+fiNthzb1oALLOiX
	LCkxr9QvSkYjADTrCdVJKu/ppDUjER6Nlkgs+RwmNdB3dn5Wx2HKVr9PE+ra1JPBJFNgF3YrTgP
	25dT2C3AEYoqsGtqznFja+YACJ4HyKZZINE5SRm+EV7+9mV48RvZsbt97ke+qNKQYAoUSlUeVyT
	HAUhZS1iaLCHheVPshjE0RWAND2BJ2wO+IpVxZ/LBIXpLpOpwuhPEwAkdj7AKpM6C+7sMBy2kqn
	GPqzjMKmv0NMSCBeFMSvHxb2n+ZXF2cODFbK6eKDhM09C
X-Received: by 2002:a17:902:e552:b0:2a0:8360:3a74 with SMTP id d9443c01a7336-2a2f2835cfdmr296990645ad.51.1767347029737;
        Fri, 02 Jan 2026 01:43:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG99w9kGvmU/akNsiKNiP9c9Yd1UyuMwX3o8fit0vRApV/y9Gq7EiMqWPo3SKK1au30ydlmww==
X-Received: by 2002:a17:902:e552:b0:2a0:8360:3a74 with SMTP id d9443c01a7336-2a2f2835cfdmr296990465ad.51.1767347029272;
        Fri, 02 Jan 2026 01:43:49 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66829sm376154255ad.10.2026.01.02.01.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:43:49 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 02 Jan 2026 15:13:05 +0530
Subject: [PATCH 5/7] clk: qcom: gcc-qcs8300: Do not turn off PCIe GDSCs
 during gdsc_disable()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pci_gdsc_fix-v1-5-b17ed3d175bc@oss.qualcomm.com>
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
In-Reply-To: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        manivannan.sadhasivam@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767346994; l=1437;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=u7E+JsBFtSP2Aq79SX7r0MLZ8E+3lGXEhvVfek+8kDs=;
 b=RJFKvTyOagR67CMBwF37mQF7o3oIncFgOLlUIkbsKuTa9uLUqkCjDQVXtCnQRYot8z0Vw3LTO
 xvzwJxCZF1pA2j3cEBmCY5mhEN0Fy1RWGLOdgMCpaT/qcRRz3z5m7cP
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 6WC3Wsv8kDLavFH1guJFjj-7Ec2RJmpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA4NiBTYWx0ZWRfX8/uGyY5HrTNz
 HplmAcIZh3UD54pA4Cufwqz/5kGCYcEvH1G6C0fSUr8JZHlMQ/JPSggpRZDe7QGeOeM1dWNvXCb
 Gr/CN4YilJB8MGB6/RQg6h3/xaW4ATq0LAW6rLKFuB3zN6npw+Pa1g06gXa6kZWExSf5mEhk0V7
 JANHIfmT91k2he36OUSPHQO/mNCWK9hTbTN7xL8tccmxjc2uBHdS3QruaCeEAg/cLv8AuEpaZej
 pePsGfq+2VJn0j09olIaE0u6Hv22KccLHyA9zc0jSZGorM/NVrDo6ZZj551F9gIfjm6DFKa/SAM
 ueZG6O+B2uo57VdXE8FUBmkzq6lr+9hKZGwFdpBCrJs4xhk2IxzwF70XUPcT4gRqkKGgUP6c4js
 u9Qqg5PJhwIe54a0KmyAgpDccVXzHyqv4OVGjD5W5nDwAV0qcqhIQNgJIlDJV3crXJA/XSnRnty
 xKL3tFvWvrEv+7gplvQ==
X-Proofpoint-GUID: 6WC3Wsv8kDLavFH1guJFjj-7Ec2RJmpW
X-Authority-Analysis: v=2.4 cv=Hq972kTS c=1 sm=1 tr=0 ts=69579356 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ByFm4HHrRE6C6VNyrcUA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020086

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Fixes: 95eeb2ffce73 ("clk: qcom: Add support for Global Clock Controller on QCS8300")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-qcs8300.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qcs8300.c b/drivers/clk/qcom/gcc-qcs8300.c
index 80831c7dea3bcde0ced46054783df02b07a985db..009672b75fb9099cb0c6db7af3863654f2fa6648 100644
--- a/drivers/clk/qcom/gcc-qcs8300.c
+++ b/drivers/clk/qcom/gcc-qcs8300.c
@@ -3268,7 +3268,7 @@ static struct gdsc gcc_pcie_0_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE | RETAIN_FF_ENABLE | POLL_CFG_GDSCR,
 };
 
@@ -3282,7 +3282,7 @@ static struct gdsc gcc_pcie_1_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE | RETAIN_FF_ENABLE | POLL_CFG_GDSCR,
 };
 

-- 
2.34.1


