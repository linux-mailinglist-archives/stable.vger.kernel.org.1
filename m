Return-Path: <stable+bounces-86963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C279A5365
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C0D283099
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645B84A4E;
	Sun, 20 Oct 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ksgRFxqm"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9379F6
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729418250; cv=none; b=T1IlWJrfuD1iCcqPB41uwlg9HT6z2fy3m3bd4gELUVrRE2Kut3DUJPU9evY3BmkZVh42ZElgn3wPzse6v57eOkX6A88M6bkzgXML9aTHDMOFzcRaKsq/uTtSo/BGdCwLl0JXxuQm9GfDffWa0jL1r0VdrYTFClSP9UVUS55k814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729418250; c=relaxed/simple;
	bh=LgPXBjzX8PbJLbITTYq2V2BJykeardUriI373knrMQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dk3g1Xrn0wHGc6E3V7LQkT4AVtAWQihZ+ZWzqu4d7P6TMQpEEHavYCfZb8Kqhd4deraDrRhvFmPur4XrfMYcWN23a2KC6/ODl+XiLZEpvbRk0NRHND/fIooWrTZtWBUfG4MbEEqc56owzUrTQTaHcwvr2H5c19dBXzPaI8qupEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ksgRFxqm; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729418248;
	bh=FhrdYFOvstRecP2ZKmMJqGaEIjevtvQvDh2O0fTXTbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=ksgRFxqmpf7BJskMZUFm37BEgWBH6aojJuT9UohySRjZnrbrIgKlDMXKYDLgIqZiK
	 unpm+u0QycRvx63P23gIDZH2ooaeH5WeQV2O2LWqXarEIetWXjMFcQFhD5VE7sSYpk
	 B97FQM3IM8B5frxvjkgcyhf1I0YMUCs1p5coUV93wL5U2EcI9e25dQPXWVs16X67BP
	 pAF/BFKszqkTFvoYcYD/RupOwpxgeBLS7klmDq5LsbHsxDizJGaidFHNOm/TwP+cWz
	 x8jCLI9UDHlDFX44zNLkfXp2RehsT2PgxlhvvQBai3qlFx6lyQtTVKRkX/m/3M7+Ok
	 IpV5nE0mf4LSA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 51DE23A016A;
	Sun, 20 Oct 2024 09:57:23 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Oct 2024 17:56:58 +0800
Subject: [PATCH] PCI: endpoint: Fix API devm_pci_epc_destroy() can not
 destroy the EPC device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-pci-epc-core_fix-v1-1-3899705e3537@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOnTFGcC/x2MQQqAIBAAvxJ7bkGXOthXIkJ0rb2oKEQg/j3pO
 AMzDSoX4Qrb1KDwI1VSHKDnCdxt48UofjCQokUrUpidIGeHLhU+g7xoDa2agjVeGxhZLjz0v9y
 P3j8Yve5VYgAAAA==
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: BdJXf0YaDzhouuutKbfZLhYBHe0r3UQo
X-Proofpoint-GUID: BdJXf0YaDzhouuutKbfZLhYBHe0r3UQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_07,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=586
 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410200066
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_pci_epc_destroy(), its comment says it needs to destroy the EPC
device, but it does not do that actually, so it can not fully undo what
the API devm_pci_epc_create() does, that is wrong, fixed by using
devres_release() instead of devres_destroy() within the API.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f007109255..71b6d100056e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -857,7 +857,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_pci_epc_release, devm_pci_epc_match,
+	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
 			   epc);
 	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
 }

---
base-commit: 715ca9dd687f89ddaac8ec8ccb3b5e5a30311a99
change-id: 20241020-pci-epc-core_fix-a92512fa9d19

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


