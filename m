Return-Path: <stable+bounces-161879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C684B04706
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 20:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D618F7A4800
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85325D1FE;
	Mon, 14 Jul 2025 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zsbnlh1a"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703B26AA94
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516089; cv=none; b=PuQ0cJF8T3oAx0ZO8imdD2NRBn/uF8dzsKQ1hBQEsL6fOHHz89PordAqf3oKhFSrIxplDJqB/Bnke9qNfUEm+GkdSD2V0fnS7a0FLP3toKRLoCmGib91G3xsm276yuG6p6hfMoNRRbO2jiSITxsiKMxllRQy69+p9cWzMCli0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516089; c=relaxed/simple;
	bh=BaEHz4SigSFy/JoDQ5gfDzTeiTADTlZoV5mYSrK/rF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCOVQGTrSLMbbJvYmfyavT8cTVe3o/Y9H5fFCLFbaZZIvdt3a6/wLB5KF9mZSTr0xxAfFZUb+Ew5Vb9JJdax+yNvDbAM02LygoSG0MfaOiean1kaylQdBwxMeEYi+HmgON+n/KFCBUIalOh5l9BLvPkXsk4D/9o2C1nav81MpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zsbnlh1a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EExWm4024867
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 18:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VnJknR/ZXoUt72vcKJEpjugod2iPT7zi6lFjv3b+a9A=; b=Zsbnlh1apv5zGFP6
	pIyJ/EHbRlFd1sEIlIbc3PQD8SlUm5sqJ5WjZ9+T7BPcBd7c3v7x1BRtlLWar0IG
	nVDn8DeBcaST6amYTGTJMg2BiPG7Ubxtp1vYvyOdK5edFyYcegombbRPOyA9KEFU
	8ihfbgg+/7UfSJ8OPCGUHYEAA+nFUO0K1/kvxOMW7e9X/lvMc6wG+kBEjBZl/AOf
	FumBFH6BBOhnRvikPPVuls1H+UyEMT7EUgxtqeKsPhS2tzmOey8GHg5J9P1usW5C
	cFkjWJqxCq573vNqRCVH8qSmCCC6W3TMCmO9XOD03JYoy5tLe7Pko57RnSKAyMiK
	L6SgnQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut5eae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 18:01:26 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5314c884472so1612718e0c.1
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 11:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516086; x=1753120886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnJknR/ZXoUt72vcKJEpjugod2iPT7zi6lFjv3b+a9A=;
        b=UBohtIiYdqs+oFDea3ia+3WjA2qNi6EmdhB4y3d+NU5bTGMEtOKGROnMUSDckOE3XS
         z3DCgDUs3F4gsV40cQfXxW4CdLZmLqcnIQaW/FyFAhNoeQQbUgkVEqne/CwCP1bJ36MO
         SkRnu+J9lxFHIwdUqSuNLXhee6NnyS0M08BraSuTQmGba7kgY7L3ZIJpO72LOpBP7eB0
         VV34uZH/aSH1J1t3WaqgLP/n66wClEvk2YwAQxDTf0Myay0GpIz/ZKMExyQ/+XzKEtbz
         RMdMO3rGmXJzL39aJXdY8j7nE//uqg9C091us+A8MGTHBTBcnDgQ1RSxdjHv+i7eJE6+
         tqgA==
X-Forwarded-Encrypted: i=1; AJvYcCVuCtWSPK1jEr/sF5XMJdeP/MYBc1V3Wtd2cPc8IFjBqxndFsM0Y8dIn3iyx5ym0m27pdVnHbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4wuoqltj5mfrWorC3+8altxJIfCF5b48xN3XtvrjjJo4vtvm
	Zk7NATiY7Sn14YRzSuWTphD8wyCFHvsUPqJJrNKqULJ7mBvGOlEccOi0tSoBZFk+gCptn71ZOD6
	0BBQUgCR62TTqOZUl9/Tcb6rP9+ocFBz2cRXqgH9y2ScwRFlwzrVnkX/7HIo=
X-Gm-Gg: ASbGncvleoDSukwR1ckr7KhyBzURFZ942pGHgb1qiBeq5T+XHzwE8Pg94cuJoKXso+4
	46UsH09p/g/SthbkPYhXsBbjP1z7vjRtgxdpnnctF0gHWxuV0KP7mMbCFem41xnS9nz1Os2N/r4
	5HXllTVsctlDziPxvtiNqCcWfc0pwokqB5VlelWtsHsi4AyyJ8c09Umj7ZgXKQTkcR2QreDpmRf
	9tP14sgWyKeNReJcVKMCz0bHC1/OVE9wV3Y/vgteNCUytB8YRIPAqsb8rWRBaYHU1ta2vx8m0FT
	htxnxK0ydKEASH/4uwU8r1s7umStbIOPzvD+yBNagDNcLVrNjhaAIThO+eESH7mcjeg=
X-Received: by 2002:a05:6102:6894:b0:4f4:b401:d04b with SMTP id ada2fe7eead31-4f641faa1famr8556297137.20.1752516085454;
        Mon, 14 Jul 2025 11:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm3GxR4EIJ1G8vKkhpp/SX2/bRO0DPWUlOfQp25eVLkuBk5rTYHi1ujsDxx5I/1TnPOK3d1A==
X-Received: by 2002:a05:6102:6894:b0:4f4:b401:d04b with SMTP id ada2fe7eead31-4f641faa1famr8556143137.20.1752516084774;
        Mon, 14 Jul 2025 11:01:24 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.67.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab659238a1sm16999381cf.17.2025.07.14.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:01:24 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 23:31:04 +0530
Subject: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM of
 PCI devices
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
In-Reply-To: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7344;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=BaEHz4SigSFy/JoDQ5gfDzTeiTADTlZoV5mYSrK/rF8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodUXqSRvQeHmSfAgzDk3GrZnFSZKJV7pw/ZX8H
 1b5ye4Hzd2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHVF6gAKCRBVnxHm/pHO
 9aBUCACKYRPy0ZNObukNDNYcr+IVy/luKZzZTTqjbX60514TOp9OCuxKobn2N30SDN6G/G6NC0f
 bygTUasMqpDfXr3hBy7m1KfskrW2WwESuKX6RrpjciTQeyK1IQ6JeeKYhPRMUmSMb44wKpFonKy
 MOnxk54SqsTYQiWE6h/cV1TURdaPEzKvadcW2C+OGXX14Sq1P1YJP9w7/bKqU1HrEIgtiWHsBRp
 uyNtlOyHcATcCLN7YPwzp8sl0zACiStvq27ZoPyqsQRmxlZQPqIQWXJuDgTGuyN1YG9QqVn7pQr
 hBZfKmae16lDxNgJnPwbGTpwG/ULZNINet1FGEvomOkBnCoA
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=687545f6 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=fXYZ39HhpiwvwaHYBd8ing==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=96MU14pyfgFxr5UOt3AA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: 45oOwXJGbO8oKy_fa_6OP5jd1SCUBzKA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExNCBTYWx0ZWRfX+dGkU8wgxsdj
 huh/3tBDY+EjHdv+uL2Qho0jVq5nmzMOIA/3kue8lYOOFfyhDpNsDvp+EOHnMbHScfMQcWqllQA
 ybzg21MOHhy6IRC7EQszngl3rpVv+nBgvwFFuWeubsSeV1kM5DWJykz4ShiT0GSPpAHWb7v9KuP
 jMQ/kt9GwFC6vSV2s/3DTclVKbRoDn2VY6Dp8rHNmn5BMYJKGjeSFvsfALN2o2ZHSt8htujvgQy
 Q/T9g+vlIlqvgDXyzRIENkXDA5T/J9YFf/drsIspJh78r3gI0DbZH+KGTotGh5eJzqWHyOMmJAh
 0oR97ViAYyBrIYo4FKxWuswL0Fj6dHNjeEvRhuue9eoRPXnlq0DZPkI4S/BeO8eUH0shpI6BUyT
 0vuknBgI4w+/iznxlk9gMPfd4jVNxLwtrMry48dLpx/rntvQQPtqKo6WBo5grhb8GxK4BaSh
X-Proofpoint-ORIG-GUID: 45oOwXJGbO8oKy_fa_6OP5jd1SCUBzKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140114

Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
enumerated at the time of the controller driver probe. It proved to be
useful for devices already powered on by the bootloader as it allowed
devices to enter ASPM without user intervention.

However, it could not enable ASPM for the hotplug capable devices i.e.,
devices enumerated *after* the controller driver probe. This limitation
mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
and also the bootloader has been enabling the PCI devices before Linux
Kernel boots (mostly on the Qcom compute platforms which users use on a
daily basis).

But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
started to block the PCI device enumeration until it had been probed.
Though, the intention of the commit was to avoid race between the pwrctrl
driver and PCI client driver, it also meant that the pwrctrl controlled PCI
devices may get probed after the controller driver and will no longer have
ASPM enabled. So users started noticing high runtime power consumption with
WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
T14s, etc...

Obviously, it is the pwrctrl change that caused regression, but it
ultimately uncovered a flaw in the ASPM enablement logic of the controller
driver. So to address the actual issue, switch to the bus notifier for
enabling ASPM of the PCI devices. The notifier will notify the controller
driver when a PCI device is attached to the bus, thereby allowing it to
enable ASPM more reliably. It should be noted that the
'pci_dev::link_state', which is required for enabling ASPM by the
pci_enable_link_state_locked() API, is only set by the time of
BUS_NOTIFY_BIND_DRIVER stage of the notification. So we cannot enable ASPM
during BUS_NOTIFY_ADD_DEVICE stage.

So with this, we can also get rid of the controller driver specific
'qcom_pcie_ops::host_post_init' callback.

Cc: stable@vger.kernel.org # v6.7
Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 70 ++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 620ac7cf09472b84c37e83ee3ce40e94a1d9d878..b4993642ed90915299e825e47d282b8175a78346 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/init.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -247,7 +248,6 @@ struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
-	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
@@ -286,6 +286,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	struct list_head ports;
+	struct notifier_block nb;
 	bool suspended;
 	bool use_pm_opp;
 };
@@ -1040,25 +1041,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
-{
-	/*
-	 * Downstream devices need to be in D0 state before enabling PCI PM
-	 * substates.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
-	return 0;
-}
-
-static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
-{
-	struct dw_pcie_rp *pp = &pcie->pci->pp;
-
-	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
-}
-
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -1358,19 +1340,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	pcie->cfg->ops->deinit(pcie);
 }
 
-static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-
-	if (pcie->cfg->ops->host_post_init)
-		pcie->cfg->ops->host_post_init(pcie);
-}
-
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
-	.post_init	= qcom_pcie_host_post_init,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -1432,7 +1404,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
@@ -1443,7 +1414,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
@@ -1773,6 +1743,33 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_enable_aspm(struct pci_dev *pdev)
+{
+	/*
+	 * Downstream devices need to be in D0 state before enabling PCI PM
+	 * substates.
+	 */
+	pci_set_power_state_locked(pdev, PCI_D0);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
+
+	return 0;
+}
+
+static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct qcom_pcie *pcie = container_of(nb, struct qcom_pcie, nb);
+	struct device *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		qcom_pcie_enable_aspm(pdev);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
@@ -1946,10 +1943,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (irq > 0)
 		pp->use_linkup_irq = true;
 
+	pcie->nb.notifier_call = pcie_qcom_notify;
+	ret = bus_register_notifier(&pci_bus_type, &pcie->nb);
+	if (ret)
+		goto err_phy_exit;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
-		goto err_phy_exit;
+		goto err_unregister_notifier;
 	}
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq%d",
@@ -1982,6 +1984,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
+err_unregister_notifier:
+	bus_unregister_notifier(&pci_bus_type, &pcie->nb);
 err_phy_exit:
 	qcom_pcie_phy_exit(pcie);
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)

-- 
2.45.2


