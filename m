Return-Path: <stable+bounces-204450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA63CEE187
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1D8030239CB
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EF82D876F;
	Fri,  2 Jan 2026 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PxQnKX3V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FvZnHEu1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2F273D6F
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347040; cv=none; b=J40VvH0kxRx++2bnuBB4Ee3m52Wzp07e+BpEbNd5xsNn4JSa3ZEfDDbQKIK3F2LcEgdVXwhjk0XuT920w6B1qGVzAnayxHDfpLsqbYo2skaFp6uUXajixbahSR0/oH7JqGq7TX0cwx9LIXWNxhgy4zT+ZqwXdORCwmO0T2bImgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347040; c=relaxed/simple;
	bh=XOkRcbE8VNIcaH72U7IUKRFd2thHuZrA+nnkmZR8f54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba51zQ+3HKyIyh0BaD8KAxAAMh2sK20NKao4/uNX/sUHDSpYAqCI56KQ5y4Z4TblP5L8zYtMj+0MWla4RuvNrVQrEIvErwTxeVfYqBHbY/81rCaoLo7/FRsCna/cPq/B/+QYLBcnsHBwCjc+FhlQ2IOkZf0CHAqokI7tC76jrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PxQnKX3V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FvZnHEu1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WFkF809537
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 09:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VOB3/Mj6YEEp2iQxLvfoYJN8gYJUopTS6O2MzTLgi4U=; b=PxQnKX3VyQiRuG0G
	nSnOLCfx5jkOruw24HWijrmFHmjdovTfpsWMRxbMIPK9khBflY0cGAT0q/C7cV3x
	sCrIxLKagRfLnRtEccmzAO3t6/za9hdZ3v1RKy8VhY0dep4dyT7XKnINcCe0bfVj
	6WNp9VwLnU+2/1h1to4i4NvhDMkIgwtmR797jgM3hkA/UqNWzfghV9EmU+vv8s5K
	iafLOXC7lo8aEnKWzYczVkCSrdjttdwU+LBCLWjBlkjgOW1QBPbZrq1PzzQQsWfy
	OW7Frw6Xptwux2I3I/3PzgAvSlXu7D4Z3zdliQAx2uQDXnDwLFnYbgB5InZ362U3
	4ro4gg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6am1h8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 09:43:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso11167698a91.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 01:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767347036; x=1767951836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOB3/Mj6YEEp2iQxLvfoYJN8gYJUopTS6O2MzTLgi4U=;
        b=FvZnHEu1xZKOvP8N8hMNVQwN2G1PbpC5xI80J0oEeGcHoYQ2oY7PuV84hbhv6XKizX
         8DfM1aLGWo19oMksjXzQrFEGRd7QK0T6iMEnhtwlT6ZF2rcHmudoqZ1LiXCQnfVMpU2W
         ngVz8BZr9Zw8AUsfrDLA1nSkBd4AmSUR5uItMQY7vddPQHUw5QtBQgCe7WOlOd+fnNX0
         JUnhWkrUPp38S3BProLIqW4KhHBOeotwmaqBtYNeKGCy6zGgy6L5h6jp7Q62jLQ33Esm
         QLz1NVTZFrK4FsSSOCXFn95MgcakRZr0iNtdGMkpjhquWJCzT7iq6czQX3N61SjfeGD8
         8vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347036; x=1767951836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VOB3/Mj6YEEp2iQxLvfoYJN8gYJUopTS6O2MzTLgi4U=;
        b=PdLbs2hwYKU9Gzu2kMrgVKvF7lfA8o3RS+XxWqYPqu5bWgg7EfhY9cdMIIqE3J0Wxa
         AjGjWdZlvsPymztqAvpzDQ4Dx7zkFfWFlT0x9eo7/B7SGiIWLClxO6O3Whe1RIQ7X9z9
         OijIkZjFib8UI5sHRDPzgEsOCrV8aqzLb5tarmAUGyW6ppDjsBVBi+AIzSwJTevR4Twp
         wCjhn3XLmLYAFZpZn/XlcKfB2E3oD7M5rWbPsOTZKoKPxYn7EsUyp0IIgBWKO78ZjuXj
         CBZ28Fs2tYucNLkoCoWjhD46KygTTncutAbTVZZ5zP/NCwhy0SE//OLq2zxYMe0QCpzm
         /ezA==
X-Forwarded-Encrypted: i=1; AJvYcCX1TAZhnChVqEauLiDCjo8hhdNliJ+yJRuG5SxXINRK0es7NECcOGmusUi1AVpvD2sf2IIKz3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNn0LlsIRuIA4FHwnXjcS0k60C7EMtGd+4vBR4/hANhM4ewGCE
	2u/OtFXktIdUe6aDfSLdghP2ptNgix5cUFgqf110vxi5OuwJvvDGCVDolPlf0JuTOJnfweb2hgp
	8amkev+OtyUOZVkamMp2IO7YYmr6plBcuV/rSmL3O73+maZs8Hfd5l/dPKiE=
X-Gm-Gg: AY/fxX6k4pdM6tVIaMGI6ktdSl6cBKsY8jE1nAu8zbYmsv9kFIMPRdYsW1ttfsxAVvF
	yhILzyYJzP2FJgGY9trxffbISrfYVKH/vQA6ebi8xXFEKDKg15ntO8+q7oBAZH2hbsMNH3G43Zg
	rNmTpRKp/kwhJ3KON8/gJKIK3hewIQ60ZU5C1V8NywGL6f1mVIc46Lx42NaNoaJ+GGlfallUAsC
	xIZV3VnrscegEGU+uzWavnYVrOVoLbS5YpMDGJOUm7C2SNBmzmGauHDZOaN1x0ozYd54Ntrh9uL
	QgHB1uZIQ5u0hgljFI58/VWHDOg7a1uZF1EywBCwu5fPClbsXuF9AxevE6pUnbBsPKOvVIlcuuH
	aNbX9KGObNtW7U9YAzTODi1fOqyAuAeT4jMTYgeuTUqzv
X-Received: by 2002:a17:902:ce92:b0:295:99f0:6c65 with SMTP id d9443c01a7336-2a2cac808c8mr473754915ad.30.1767347035590;
        Fri, 02 Jan 2026 01:43:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEke919yfCWNZoHyxZwMBFBZAVTXKnc3GjZ0LA3ZosF28wiOBSbRO02LbB0Gbt21fRWjNr44w==
X-Received: by 2002:a17:902:ce92:b0:295:99f0:6c65 with SMTP id d9443c01a7336-2a2cac808c8mr473754745ad.30.1767347035105;
        Fri, 02 Jan 2026 01:43:55 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66829sm376154255ad.10.2026.01.02.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:43:54 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 02 Jan 2026 15:13:06 +0530
Subject: [PATCH 6/7] clk: qcom: gcc-x1e80100: Do not turn off PCIe GDSCs
 during gdsc_disable()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pci_gdsc_fix-v1-6-b17ed3d175bc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767346994; l=2890;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=XOkRcbE8VNIcaH72U7IUKRFd2thHuZrA+nnkmZR8f54=;
 b=0lEpbA+NtXZaGfYZfqD7BMu6USHFAdGSoxKy6fsm8Qv5CX5UPMkw7AeRdMhwVUuKINcq+KX2V
 3Y7ItxyFdHBAV3D28EafXpNBRIZANTx7XWom0Hc4uuwcP5TDNbSu/JO
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: B0JilibnB18DPxDYmA9U2NvdOzwAg7yj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA4NiBTYWx0ZWRfX7sUSefo8izQ+
 W5epTwmGLk4gDcO2IhGfh6XTWf2kcvTu5nCrIH3uPFV/3pN5056gQJupVZ3SvIWhtg7odWqQV+3
 KudmJLC/lniXOZ7vXNwViTX0qhFqjMJS4koAVoLB5E9APuOZkRLBZ1lqm51rm73ibpo086bIB+3
 rzuVDmEayOB1X3FOWxMwuxNy/t3OrVfUJ0cElVzVPcYN85MkVKiqdyI2+s5X7yrKQa7ouYNPWjy
 Dv6cHjzXmXRtzra/k53JKZsY7izURu2TEHu4aV/hS8Aj91UBI4o1683+sFZJvd3cUGe11/qwP8x
 4x1nZA+UTqgh+7B/qtCUlOxXo7LiTYOnOMWGguLd23ZmGpR81l4oDX0EefBCB1fgR15+RB7C9VR
 2peKpjUutcC433nslNjzEQcXj/dLgDfJlrI7FpPcS5HZpOK3teq8q+n6UX4DY1ONa7aGfRmCzrg
 svxCKCUNCDDlMehu+1w==
X-Proofpoint-GUID: B0JilibnB18DPxDYmA9U2NvdOzwAg7yj
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=6957935c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=APsdKiKIpUGVn09es9MA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020086

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-x1e80100.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index e46e65e631513e315de2f663f3dab73e1eb70604..d659d988660ea5e548fcae6f9f2a9a25081e6dda 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -6490,7 +6490,7 @@ static struct gdsc gcc_pcie_0_tunnel_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_0_tunnel_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -6502,7 +6502,7 @@ static struct gdsc gcc_pcie_1_tunnel_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_1_tunnel_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -6514,7 +6514,7 @@ static struct gdsc gcc_pcie_2_tunnel_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_2_tunnel_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -6526,7 +6526,7 @@ static struct gdsc gcc_pcie_3_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_3_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -6550,7 +6550,7 @@ static struct gdsc gcc_pcie_4_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_4_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -6574,7 +6574,7 @@ static struct gdsc gcc_pcie_5_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_5_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -6610,7 +6610,7 @@ static struct gdsc gcc_pcie_6a_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_6a_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -6622,7 +6622,7 @@ static struct gdsc gcc_pcie_6b_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_6b_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 

-- 
2.34.1


