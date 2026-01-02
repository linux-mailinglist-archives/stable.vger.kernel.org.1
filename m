Return-Path: <stable+bounces-204451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1161CEE190
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D07730336B8
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1B2D876A;
	Fri,  2 Jan 2026 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pStqnwwa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EMuYYIjj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42612D8793
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347044; cv=none; b=Qbp+IyM0aaW+tkSpENkcHtQ17fBixTnzdGc+F/tpG7fO59jNUmaSC1AoE1o8qMwPv0Zl4DLmUGTAADzSBbq2KFQEjbFddSlIuiJrVnq9zOlb4A/04QjXYOO/AphE0oriuC5+V+ueczIr0ZOGKv/Kn33expUvpOe9/VqZjw18Vu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347044; c=relaxed/simple;
	bh=FqGhFooRf3dVZrhD2545Nbq1W16XkG+oIz5X5zYASlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ty93hgz8V/mUEyOtCgoTQC5tUF8wLNQed1bKYgmOqeLVPwlk5NVZ8ENDx5F8M8WU5CnP8W6ecvSldXiFKnPaxWsWYl9/HxQxGVgL4vtguGJWhl45nILmix6qUyhlRVx1J9yt6T6c/sXLQODNks6TNMPW5yb3t7GMP+Eza6PZrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pStqnwwa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EMuYYIjj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WS5c618624
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 09:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5NO2ywtEGxXnmmSDCb36UkShK/n3vc+3TebRaQCb+gY=; b=pStqnwwa9UAMD0FQ
	9oEvOSHACcwjer3xAJHDXYyewB3FMs+J/xRaN7OboAI28hq0wuCWWusHc27upbcc
	i+ia8KL2BzUxQu9toRvcT/LlPcXEwBreoonmbkZKnRWFuOwwRPZPt4GV0I6OxaGq
	Qw9FI/Q0+wyfSIurs/15DdJgcQ4JKOQueelUCyWNyD3gbruoiJXW5bShf5jr63i2
	6ZuIEVJYN9yJ7uAG0e7wJEDYC+XDBSsvoGxwxGNVmygNlJGVvjNeGDAEZ0nbGq+D
	3K6zeNPEsv5FGkcedtPPV9gKnsXopJwvV5prAmjnW46DY/CI1SAezv9OVyyUowpK
	gpsWiQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beb4wr2fp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 09:44:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a08cbeb87eso194873495ad.3
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 01:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767347041; x=1767951841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NO2ywtEGxXnmmSDCb36UkShK/n3vc+3TebRaQCb+gY=;
        b=EMuYYIjjqGfIVlwduD+OrEu+gf7PHOZShYwiWkZ/O/14GOGxXW9EnpMWvFpAHjvI3g
         VFdozFHCF97d7ytJHxZ5ywovVNqIsnLeKBU7qB9psaUceIO9ME0z5b1jrYsG8ZREigkH
         8q8bGA6xgS8nYie6xUwBRVe1tPnb+lzoy/k3wlOh9GsGOl2T/+pwKTDg/TuaEWhXCDS2
         z5Jyl+HCw005hts0Xyw/aDlaHRioY62jc+ftds5HhM48xN1uPiojzFMUmcP2+VHLTev3
         amMWxkY2EiqMceDgem00nbFnXYa2YXngjSrx8MjPZam/s4DJrzK+nhss3wK2p4ewSM8B
         wK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347041; x=1767951841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5NO2ywtEGxXnmmSDCb36UkShK/n3vc+3TebRaQCb+gY=;
        b=BDpKUmasH39dpJZ8VvVIetjVtsPlj6ZYFaNwq98zOWqFgiqPc6Adp19zYFRe0wqahc
         1quz6KO35nfl+3zrkAHP2b06exSaRTeCCxrzvmzROgWMAibdUJGFHneR8inw6+YxkaCL
         RRYTpGTKiKh+sE1J0bjniPUpvV1l2KT0tDya2F2AmWDXf1Qt1e1eOKR1UT4+RcXthl9F
         o7kdHVm6NH8hyw3O1RQguYIpo6MsTrDzz+VGNaH/yQ68OXt95nFeG5lBr3rReNaHlToN
         U2cmmxDgD34V5kQfgJBBYdC8rgd0iVtiPuPjtvwQV5vqE7qxn/vKfr59fbQam4YtE11E
         XHrA==
X-Forwarded-Encrypted: i=1; AJvYcCVLdSmPGqzwOW7BwjrMe0gaIS1IIEBJIgzGdK366qWPh/qMRHfh2KTEKMtvINJqYwA4GSkmcXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17Qd2i7eRCGHajv4xFhi8X7bLesT3FN9A7MePFrjhVSf1gvG8
	a+E0STt/cs86pGTjP7rv5haFJexS1ykrl3vWUMhexWNhfibTQQWTWVY9im+MgaZbg8Y4vwoikoz
	TsAbLW4/jSmr+PanEtD24SlwR6tTwV1xD0PCeMafzfn/8sxaFXQqEV3eAXSA=
X-Gm-Gg: AY/fxX48Y/WmlVIQpm9t/bSWxG7OwWyxXpbfDBR8tc1BNncb6KG3bPACoEsViYNOrAv
	TU6G8EUD+nH0kJjpKpOkJCrUm3Kvw6PouyWYRmgjB3z6WekYKBh8FeabNNQMfytBVp54xPXZMZN
	kMy1TW7tAIRpe8opu7uTyeW4dm7vzSS6EjH29OhONo+kItmIuDkm98Vs5vZe7nvwsfc1m+XWoBK
	LH3I36olgfC+jGkZLgqbGA004aQBiXHqruvRg3zzJxFaeXy0Elj6UP5rgEmnKhtyGXVhebSRCbb
	+WsIHFijR2Xs5eEAI+QnwcedrYUexsepCe4S1HIuWb2VDUsxV93e3cmO1qQSRmsgmF3GE+bcOpj
	cUb2Kz3VIsU+fdoaAFNYlcE82ummsLKdPKo8dbSGnSYKS
X-Received: by 2002:a17:903:3c50:b0:2a0:9040:637b with SMTP id d9443c01a7336-2a2f2423178mr429122655ad.26.1767347041416;
        Fri, 02 Jan 2026 01:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlAfJ7GPX4WaV02+Q6/Jii6uP9NcsKWMUgcvCnfmuvI0T8Wm1INga2Wpus+2H/d/9fftVldQ==
X-Received: by 2002:a17:903:3c50:b0:2a0:9040:637b with SMTP id d9443c01a7336-2a2f2423178mr429122465ad.26.1767347040946;
        Fri, 02 Jan 2026 01:44:00 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66829sm376154255ad.10.2026.01.02.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:44:00 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 02 Jan 2026 15:13:07 +0530
Subject: [PATCH 7/7] clk: qcom: gcc-kaanapali: Do not turn off PCIe GDSCs
 during gdsc_disable()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pci_gdsc_fix-v1-7-b17ed3d175bc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767346994; l=1214;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=FqGhFooRf3dVZrhD2545Nbq1W16XkG+oIz5X5zYASlA=;
 b=0JXIyA4A3ptKPWqvekt+GnVKHf05nsknUmZQS3bwYlx7RZdB5HqrDTuiGBpawaWnuJVCJESLO
 OzZ1UrjVbwMCgUpJFwHuHXOsShb+Dx+bp8WIM9psPB8oH6XFa3tR9P5
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: ewzMhx8VOQaIDGQ5zh3WMEcFERBx38-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA4NiBTYWx0ZWRfXyZPmOJqGxz78
 i7YXSLyBpz5pqbYsK1giaUzs0e1xSPJm6clVwWmkMLLPkcnkAHFCMgB1HFoki75zdT3CLdsyZpj
 gPs4oRe2Ksb1Cg1XDV2Tpyfbsyy56OZDj6/jxcSChvyHGElE1IOx3W697+Flcgv3lfN8LN4GKUa
 mQGAUUzU4wIEKv9n8wJqWOde/sCn/UIVGvJfF31TLnihtMJ0UM/47TPigJsKKpvBGdsjSKWvp0I
 YY0OdW4dJ3du5EU1QxfVpW/DzrWwjMyUMyOyEd13u5/c14k73zmHOLdxo5oawr4eK8HDY30N4fn
 1RTv+SREhzahXq69KonbDvGUolE/4O8ugiohPUF3smhYBodQRiCsfBzM1C/UY2JuZxmmmFL/Edz
 36aQPO/h0rw57iosFZkrmxuB7LcOZTEsdIORGNd775xXp1qrVbKTo+C85SIZG7eJrajhuBJsMdQ
 e85pBh7csogdOwrdwqw==
X-Authority-Analysis: v=2.4 cv=I5pohdgg c=1 sm=1 tr=0 ts=69579362 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ByFm4HHrRE6C6VNyrcUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ewzMhx8VOQaIDGQ5zh3WMEcFERBx38-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020086

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Fixes: d1919c375f21 ("clk: qcom: Add support for Global clock controller on Kaanapali")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-kaanapali.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-kaanapali.c b/drivers/clk/qcom/gcc-kaanapali.c
index 182b152df14c252035fb28adb2e652bbfa22114a..1bae1c9dbc7764996e7c0228f9fab72d5e630cfa 100644
--- a/drivers/clk/qcom/gcc-kaanapali.c
+++ b/drivers/clk/qcom/gcc-kaanapali.c
@@ -3141,7 +3141,7 @@ static struct gdsc gcc_pcie_0_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 

-- 
2.34.1


