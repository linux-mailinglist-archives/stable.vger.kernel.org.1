Return-Path: <stable+bounces-204444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520DCEE133
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CDB13003F90
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB7214228;
	Fri,  2 Jan 2026 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="idcYAhKG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLGCuss8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB7289358
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347003; cv=none; b=dgsxdwm4KjZufyGrJLhs6bYli/U0BnwprjLwk5itOh/UyzET2ui6rzbGBAwmGSGyZmi04NVv7vHShUVDLFR5DXyGKxb5MBv3uLM2odfEiAhp+VJ1kiW8kxBs1dobm35TRkdT01qQi1hoL8Okmo65+y4Z/8HZbT+wNBUdq1VdAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347003; c=relaxed/simple;
	bh=3qEjXTfpfPxJwNXPUcopGq7QMiHdWpFPIFbYzag/qgo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QQcECnqCGKwn7t+gAE+gKiTGELdd8T2Yird9v7z+frhJk95BKIa9NFdDQ3Gj7Dyt60kUupqybyMJa60QF/Uls/To4sVLbMR0B4/ImFveBvvQPhpxL7WnLUUxqrCaR7KTsRGCgRTYoEC9yqqb+zDSqnvyTrFJ12yDv+T0KkbXZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=idcYAhKG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLGCuss8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029W3bb426888
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 09:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RchF6Uw2hATAz7C5kI0Mo+
	7CgNCiyMK9RKLhpwaAY7o=; b=idcYAhKGgqOKHhnlIIRAhfBu69fJf+zL4RmRFH
	GucTjL/tXv88PdPWMyl4cSqoF5UdarwypuRqAVpYzw9RKrPDiiTKw8qHoUKLcg/x
	ROKe80+3aWzUBMv6FoMNPr1omfWbvxbTwap9zotRvAbkRly7kQHCvkm8XSR8Uj3a
	Xzc1KxOKgv/jtevIjW6SdYF2jw6LnOUf0tMRV5nG6Qq5wUwjWib/QrZqmALzsoZJ
	MaDtu0WwIbr+LBH4rpVI1ikFnBqzl1TBFWqgpyLlLZp+mi4Kt/cONbBZi1lSkmJk
	pPw5ma916E1waiqAoEa+FolKbRHjFnIR4WSs9+nVXeWbz+Gw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4be6fjrkqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 09:43:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0e952f153so405310705ad.0
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767347000; x=1767951800; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RchF6Uw2hATAz7C5kI0Mo+7CgNCiyMK9RKLhpwaAY7o=;
        b=VLGCuss8+CPRAx1AN++SLmLvh2cXKjgr/f+4IP9EHDpuT9rMetVcMEmfWLqTXNZWt2
         wiAWysGZT1aSN/2im6FYDI2LyPVVjNhF6UJQfS6rQZHjkgq9mPovAO+uubNoGJacQDVc
         PHG75eBqUp8RHzV1a7MSDA7I4Gm/lhBZiJzoIBGn4Dq/mqQVK4r+CxE7nGevj/X7QGm0
         +Y5cl99gF9edHmpBdk0zsjEyzPGbtMkxh60WRiVRBrFiHZfdzG51Bm7T+FshZ5LQXfwB
         yFvzy8azAaF5y5gFFOHFDgH2vYgTbtRh8k7IX9g8kWYD4jKtVYFhU30vnBTLuPOBFOY1
         qNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347000; x=1767951800;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RchF6Uw2hATAz7C5kI0Mo+7CgNCiyMK9RKLhpwaAY7o=;
        b=s6hz6yA+61jRIQDje5DLO8T5ZrLA9kpGyzeynkwWxLK/KsKJgprck/GdDXEwtrmYdz
         J/FJTUPULm79+iKQ0EJM5og3lO2+vzMAns8nHHn7v6BotJz0vPsRLkj+iCWoViZLlixJ
         aCrSlx8X6oyJr7Bc2d/ElexOM9zlZziGm46SZSZ6LwjjBuJ1ue6aVA+JslvDFz9RLlob
         y8Lwjnw42cQq0R1e40UPJmbuNzhpz4qjRD5iA2wddMVAZ+OwtXiBIhopRPGappES8Ikv
         4rj5YedqmvWfCUdnnRcj774ckkW9OeGZFEpaeZBltXio4s7pFKJ+Mx9QSeeH/200IBRG
         ZNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx1C4gvbokw4B3AscH3W4PIzbi9nuatNmJVUWxVSBsAtmM7I6Zm1/CkuXeY8EKO1zZ3nHBRCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVugUS7fUAyf5hvWqhVobDWNMOdauFRfJoOCc1tPWOjVmuFLyS
	iYgeRHDLJiG3JJI9aP6C3u+Y8Sj5vkEnHFHpdnIrzwsLWg4IVHyP36/CudBNvlrPHAxKSBD5UO5
	HjfH8mKpum1O4HqRNRl+MY9000xYcDmJpwn4Zy9o8PDA/Rc8FGd6U6ejQuemsM+cPalM=
X-Gm-Gg: AY/fxX5RLUsTBxwYAS70WWGRN19VVoRv8e/ar6TsX9uN2eIeo+Zucsc6RXWTtX5/Yjz
	JrmozaGt3TCRFodujNXHHsWr82rj+aT/O8GOBCAZpSscYMceOeFnmfdxORKNYRyk+xCGmS2lPez
	iMJ1193oRxikMF9Ek7FDMvRDuFvt3dx1wKjeA2ARx42+zQyYRMH0CJdrhx3Ti5Z0Z/8Cz5vqYo1
	0GFW5pzQZTJVj9VBRaYYzA800bZ4epH7oDJtlv+ZmoQUd3ZO+lcJYgiT+QtF1qtRXjrqJLCOqMc
	XqmGlzUgjeyuBMZySFxY0OdqEz8oPdNVmtedF+g/DAZ5WpW1p1zY9EweTz4AUIe9i8ZSQMHU17V
	F/ZG75YyZZR94PE346CO7y1/h9B1ZOGmtoDPfYEOvftJy
X-Received: by 2002:a17:903:943:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a2f2a40096mr399639935ad.54.1767347000598;
        Fri, 02 Jan 2026 01:43:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHakUz7/Chtf5vwSGXnO6GNAt32n4eUGOveiUOpdo4/CelbIlLvS3AGDpCpYc72c8Nzb3F/Ng==
X-Received: by 2002:a17:903:943:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a2f2a40096mr399639735ad.54.1767347000102;
        Fri, 02 Jan 2026 01:43:20 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66829sm376154255ad.10.2026.01.02.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:43:19 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
Date: Fri, 02 Jan 2026 15:13:00 +0530
Message-Id: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSTV2kC/x2MQQqAIBAAvyJ7TtANovpKhMS62l5MFCKQ/p50n
 IGZBpWLcIVVNSh8S5UrdbCDAjqPFFmL7wxocDLWoM4kLvpKLsijradgZsRxQYSe5MJd/7ttf98
 PAPwqll4AAAA=
X-Change-ID: 20260102-pci_gdsc_fix-1dcf08223922
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767346994; l=1671;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=3qEjXTfpfPxJwNXPUcopGq7QMiHdWpFPIFbYzag/qgo=;
 b=6PABdqOqvWLT1nIpzSfHMDdCtk+Rx3dUt/cDgJO9P3KXmfY7W1J2n1Byu471uKCDHI1RMKtMZ
 7y6A9GG+PLHABEd5PsxY1gh0w/k0plzVMLekZnhsV+57rSV864U9WGr
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Av7jHe9P c=1 sm=1 tr=0 ts=69579339 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zEZ2UId_wajk7SiTBasA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: lsHwLbFppJQpcnOgF-5CGhFCh87D4u5T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA4NiBTYWx0ZWRfX0OOkDmMFh+g1
 +osRHa603O+KuLdtDCgo7v5t7byNacDIPitjn5ALTRo00uLHfcPEWuCg8VYdNeRW1uJ7Kd2jV4x
 JgNpU6sPuhRJeH6myh+5DZCTpLOVJb0NXgRNSvK3cybHmzSkir0oqcvDU2Kea/F6xc/qLb5vnlB
 eNWVeB7NEv+387TKec6OTmUkkhe/Yhtd6s+3g/xVEgHbErHVvrDwkB82WsazKKIsI8vCUnYUi4A
 FU1lr20haMIOYnfqF0Ip4SmNmIjiA87K3DLsS2/gFcoCZbPSmll5OQAAoXno+aKOJ+Sbi5IYx/Y
 diEH342tUyWdlTZAUUkl2hWG0eRD95H32NBuzQNdKqpPjq39J7RdoJCPYOvmR2jcztM9SFPNvZk
 QmdZepJGnNZdmH4Jgsp3giAHLjsJ/u6RDJfrx9ibj7RjiEli6SOy2qPD/DGC7fYnO7rxsRTc812
 UBmrYnA4vLAddxrPPcg==
X-Proofpoint-GUID: lsHwLbFppJQpcnOgF-5CGhFCh87D4u5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020086

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (7):
      clk: qcom: gcc-sc7280: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-sa8775p: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-sm8750: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-glymur: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-qcs8300: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-x1e80100: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-kaanapali: Do not turn off PCIe GDSCs during gdsc_disable()

 drivers/clk/qcom/gcc-glymur.c    | 16 ++++++++--------
 drivers/clk/qcom/gcc-kaanapali.c |  2 +-
 drivers/clk/qcom/gcc-qcs8300.c   |  4 ++--
 drivers/clk/qcom/gcc-sa8775p.c   |  4 ++--
 drivers/clk/qcom/gcc-sc7280.c    |  2 +-
 drivers/clk/qcom/gcc-sm8750.c    |  2 +-
 drivers/clk/qcom/gcc-x1e80100.c  | 16 ++++++++--------
 7 files changed, 23 insertions(+), 23 deletions(-)
---
base-commit: 98e506ee7d10390b527aeddee7bbeaf667129646
change-id: 20260102-pci_gdsc_fix-1dcf08223922

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


