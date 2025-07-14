Return-Path: <stable+bounces-161878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CCB04703
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 20:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E13B4E0665
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CF926A0EA;
	Mon, 14 Jul 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljfRAkrH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EA524886A
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516084; cv=none; b=hn9ogeK3A6NrUaaaLBstvID40hjYaP7EFO8oaUJ0DcOUL8SCQ489gdK0tUNQO3N47lZJfkIDmfeFaDJCleBVaOxctU4CaydTA9gjqcWQR1KU79gnddwQYn+74g3DIOXcftFm/9nJa9bFRnn1PFDP0MdQGfHKdSjyPBdXnnak0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516084; c=relaxed/simple;
	bh=rK1mHRwfLofxCrHg/hy4DKXz7ak5yRST/iNSGy5d/GE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pHz2QAmfk2EDgvkSMvIl5LnrhHNzYKzzl4vw/jwr6Q163XACn0Jz9I+gR3462QcOa6spYIEHKAS9KGUdMb3xjRuH9OzIJ7S8njgGW/oypzeg/o0GLsDr7Gq/Z02UqyA/bQdThKHsqRljZxWTcbhAU+GJOAeVTz0IT1Cwyym4lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljfRAkrH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EA2kWW000703
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 18:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ohJyu1geVqwV23Bgi/9wQX
	zmFnqB141Eg+tm/AJaoKM=; b=ljfRAkrHLsROSFC/Yo8QSj9RRtS86W0e1oaMaj
	tMgPIgF+B+N1urCMmNg7Wr64UbCoSJpRvMClL6T01nFA3ZDv8qvUiXbTIZ76489J
	YkEB28r1ppgyH4ohQ2o0ak1utKDGZgj/qf3qO0Fy58FRmXLVpTO7vIDfUOlCOBaT
	U/Zsi4JZ1j/CMWfGzGthfGiU6wTnpZEJJeNXw9NTk+ICMGrYlMWQKGFdRYOj56Kn
	JFi43RBtAFG4NGIA95hoNOLW0uLgOk0ehCwXJUo9/PbtODaZt5Kh1G6Eo/zBJAKA
	iJSmGj+xysYZbx6AtO814Uz7KP1/a37HXgwU44Q3VPAGQdEw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufvbdffa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 18:01:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-478f78ff9beso156778551cf.1
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 11:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516081; x=1753120881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohJyu1geVqwV23Bgi/9wQXzmFnqB141Eg+tm/AJaoKM=;
        b=j31Z6+L0ScpzNweB9wtgGhc1glWYN9P5M312WSbYf+PQyJeFe3j8ys8jd4cWno67vT
         hRsYLQ9WhYW1qUEHw2G4waj7Z6oEiaCqMUC30aigUTfX15neJ8jKdEKMWeXWO4PSX2tE
         gbiKp6oGYrKCImcXBJAZleSgimWLz8ol5FVnEZpIpkNqYxTnNUYcuCgQxzDwR4fXgy92
         zdzRcRiMvlV4AQh8H35gaT9eVLTJenQ+/poWxgYqNc2Y5j+jwXGiPF32V4bHTNKe7AJg
         njgaTzfxq2or6XPP9IahaiVZbELJToYXsN6jfze2yqougFA6/2z6FtEwCEubCsBGcoqf
         Xe3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1iNz63gQT+LxZ6RxeLTZuVsEkW6qH4aEF/ea/2bH47NBDmkw7fv+9W38WB3T5QmJwl0N2gpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbB3n4VuYkvAq8nt6ZAtbzbxhjpxxMyiD0Ab94Wr+u1yxdlHW
	tRuYF506JnSnWe+nos3PWan40S7JjmazFnXLk7Zmjb4MFHDUlKvdYZJUR1LBP4cZai+6Zt+bjIU
	RUqgBAQk2aR9QRox2jTaogULjV+T0ljNR7e4P77eusFPvMX5JhXodMj/Nao5o7eNPjohnqw==
X-Gm-Gg: ASbGncssmr8SLIOiS3BV1x1cZ0RkKeQZE5euVFfI+HyImRcaJrTqXfvlh5BkpgVdQsW
	YlnxQmNbhVIiRH3eNN6yYdieJ7QxCWtQX92rgeULw2eMSB6gXjApJ+HwZBaQ6/CggJhMRIgD2h8
	+zL7/meCfcG1x2i06zyti7gBVPehFp8eZjy6kV3NUgqgN+dhyr3sdhT2QHBi426rpbhCYg6XW+/
	n2e2YD7HknbQqGABiL1vcVcCleFEkUxoYC0gKeNxo+++g9CzVEh9L/qRDC2+j8eJp9ifcn/Jco+
	vCv43kcmwOELW05HfT8yl/jD0wJ0OD0wmqo1vEIrUNUBIMyWs/FlbZlalCdQS5K1EqA=
X-Received: by 2002:a05:622a:2308:b0:4a9:c9c6:ae8d with SMTP id d75a77b69052e-4a9fb9612d9mr215365711cf.35.1752516080601;
        Mon, 14 Jul 2025 11:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/6Pul50lfnYF7kucBGxB7MrwD9ARcmggCN/hiK8dl/0nzcXDqTO0GXrPd5FCOVdGXTFlOow==
X-Received: by 2002:a05:622a:2308:b0:4a9:c9c6:ae8d with SMTP id d75a77b69052e-4a9fb9612d9mr215364991cf.35.1752516080005;
        Mon, 14 Jul 2025 11:01:20 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.67.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab659238a1sm16999381cf.17.2025.07.14.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:01:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: qcom: Switch to bus notifier for enabling ASPM of
 PCI devices
Date: Mon, 14 Jul 2025 23:31:03 +0530
Message-Id: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBFdWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0MT3cTigtz4tMwK3dTUFGNLIzNjw2SLNCWg8oKiVKAw2Kjo2NpaAAZ
 JW2ZaAAAA
X-Change-ID: 20250714-aspm_fix-eed392631c8f
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=rK1mHRwfLofxCrHg/hy4DKXz7ak5yRST/iNSGy5d/GE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodUXqUyWYINFENbIxjWYt3rEs1gx0E/tbUSEcz
 SpppJ9KEpGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHVF6gAKCRBVnxHm/pHO
 9Up/B/9t5OmC953NndUYPqjfz4q/od5S20svRDDr+kRniUGMD7d6tqsfC62t8OXVGb5yRdFwyTc
 it9owf5qfbPyvKAk2EldZ1pPQaypwqUGbN2Cz3wQIEOBOT2obnIeJNv3nOVtUzMxVZXsKEhjbRk
 gsV2l/OF5CJQtgxEdfx4Dp/0hM7BwA/DQV6D2NsVjxIEmUAggQOl5zK/ICCIYrQUzdAiDFeA17A
 40cPcZSwZhLbLMrmSckpCLRt/tq6mqKut2pjIcq7vs3eG6xMOnS7L56Tfp6yw8gUpscOHIIW4Xe
 oIuTKql+lue3GRVMHIdgvfJEycpEJoWWi+amwwj52tH/5DGK
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExNCBTYWx0ZWRfX8Oc/qhtlxFMo
 fhfF7ah5HRlb5O/EqK8leg9XS3S3Y/MWBkPha1CueDWtk3S4qka55N/NoK8pnLW5Og3TruFKJfX
 O4WHSQpiZynxNh39ZEUqdfSsjLCvJC1cpBjlRNdsDZfvzdrMvyieZhzPbiR5GysmNzSnqxG4PyK
 AMI8+Z2Xlb56aHObXCWTXBdnxVc8H8Yi6fl/O0QDct4LinR5lZiUCRl1zBmxJMqiw47GdIcRbpN
 7raOQdofOHdeKWuF7yuLdabJL8toDkuqRNEMgWXFxsHayqb9tSrFaQGOkrMIjuPipKRJDe+zOGf
 XYE7S7vqVNxSFldE+qhgjilEDTbQmsbWZp3ntPTbYOY4Y1Wwig+LktOPc/sglMd6iW+AjIi60f6
 m1YUjEbLWG5DW7vokV22oRxfakrQRGltPXRYayxpL8AD3v8GPXLfh7yJlPFiw8ZtgOxMlBXm
X-Proofpoint-GUID: pzhtZMRwTorolQQLih5eE76nXrsskcbJ
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=687545f1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=fXYZ39HhpiwvwaHYBd8ing==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=djgaaEycexjLLnWtpDoA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: pzhtZMRwTorolQQLih5eE76nXrsskcbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=867 spamscore=0
 clxscore=1011 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140114

Hi,

This series switches the Qcom PCIe controller driver to bus notifier for
enabling ASPM (and updating OPP) for PCI devices. This series is intented
to fix the ASPM regression reported (offlist) on the Qcom compute platforms
running Linux. It turned out that the ASPM enablement logic in the Qcom
controller driver had a flaw that got triggered by the recent changes to the
pwrctrl framework (more details in patch 1/1).

Testing
-------

I've tested this series on Thinkpad T14s laptop and able to observe ASPM state
changes (through controller debugfs entry and lspci) for the WLAN device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (2):
      PCI: qcom: Switch to bus notifier for enabling ASPM of PCI devices
      PCI: qcom: Move qcom_pcie_icc_opp_update() to notifier callback

 drivers/pci/controller/dwc/pcie-qcom.c | 73 ++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 35 deletions(-)
---
base-commit: 00f0defc332be94b7f1fdc56ce7dcb6528cdf002
change-id: 20250714-aspm_fix-eed392631c8f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


