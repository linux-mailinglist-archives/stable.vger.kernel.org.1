Return-Path: <stable+bounces-253624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG3DB9FID2ptIgYAu9opvQ
	(envelope-from <stable+bounces-253624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:02:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844395AABDC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11F43095141
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86B385D85;
	Thu, 21 May 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jldDL0Cj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FeNO116A"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D65349CCB
	for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385589; cv=none; b=CB0Uz7Im0NfwKE/hH2Kg/MrUziGNXv01bqWPXtbTt6fVqxc3FcxSNk+UaIQjgXm//iQpZtRRcgQrDpExy6l5+3dQVyrdZGgn46nHfGFYSPjdZB4Hw8zL096RldG0zMwUckhyvOBHbXd3WcTdHIcSFmBTVK09Ggebf7nDvymCVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385589; c=relaxed/simple;
	bh=5/Eh6wPCHUm0+jZOa1kqxHhpX+N1+kXps8MKam+3SrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UG0uqXM3odZgx2iwiTLGZqEclwRNuEDYvMJ+JL4Wsw+dmZtv6pJrXxgZ2guNXx8pUchv5I2U1WGQp+zHWUs/V9ZqiY5RZqzbLLpcYsYct/WVcnnEfPwvyInWjW6mxNykRQr9JuSY3TZU/SwaKd6ai7P17CIuQxeCdGGsEK5Zl00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jldDL0Cj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FeNO116A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGkROV3532657
	for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1Tv1KV4V2E+d6FJx3XVzNwtiiaceB2O+rc7
	MvK8GBfQ=; b=jldDL0CjAzWZaDr4IpaevONG9zxLBxUPUNy+zoLbCkLvKV5U3AL
	FVV5eQQZsIq7vxULMooNclWz5lm7Xw0RTebVTM3PF29XJ124Jv60sSvPT1+ds+d2
	+aXqFz5xheNzUyx2X9bg05mbLWfXuOb2bX1zTdLMfRbwLHE9XIYWa1jUuk0RV4a6
	bJkNttPo8qD8NOwaFsbcCa3pNIltWWgNAqdvei9jppRhh2TPV2VRyCh47evGqMda
	JmN20jHZ4hp9IMRgIsjNx1nuZ+DM2E63YPP5cYylGd1T+w69yvx0NbRiw962Occg
	PKNMcEnKbTNEaUh9N6PXcuUgCBpHZxvE8qA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gs1k2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bdaf8567f3so44245455ad.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779385586; x=1779990386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tv1KV4V2E+d6FJx3XVzNwtiiaceB2O+rc7MvK8GBfQ=;
        b=FeNO116AikZrCRuUc3GvY4tfbIaKIsQQxc1TL9/DdaG+d+KTsSb3cc8MbCYNcVDoJM
         7kCYwn7khRDJM2UDiGF/MMBFRHdTsYTZuJGa+jjhvkEJsW2EvydJRcBYoKe3s8AxZGP3
         Jg8N/1zdp/0T1uq24+/t5mM4zH9zgdDY8g/51RXbo9rYANwvhOMCfkUaUMl/RBXLOTuR
         uhzVbt60EWJXV1bkmyasYcV37d8l+pTE/anhwfVVFo2SQtSqF0fiMJ+5Vn0cOGF9xJ/G
         pwiKI7oc9NvyfAAgH/d2/GYLVv2oxJxl89oV0Md6/JUfjgo65HugEOhldrqp3FSk/3TD
         6RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779385586; x=1779990386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tv1KV4V2E+d6FJx3XVzNwtiiaceB2O+rc7MvK8GBfQ=;
        b=BJgh/+nchISRflugdhn2f/ynsmb4TioPQhcE8+sDrxJx1MG0+GoOgkNhuZ3C9t1ZQ6
         jWk4Sb2wBsJXTrOyoxNhIejey9rhDi5lG8aCGN5Kymf5O+Ht8RRZEyeOGACWvPPSbq34
         pLg8BzO7pBHWVMsvCZZmBIQ9im7Ty6AQfRFlhgxF1Xz3uFX6c12UO/yLWavvIA0Oub5G
         8xyyEaSyFpZRY2hL/bdDUdbhNOr2pI36bs4hSQ6wabRVTsvdcFhqUT+HOEUDa0xROSD8
         7sVLM2n/8lVk2u8o+Fo6nE/han8Z0/HAN0coZK7Ahe2nsiZzEEuNjqyKUnVuOjws1Poe
         2dJg==
X-Forwarded-Encrypted: i=1; AFNElJ8jINmvCDxErgUX++QWtm1q2CsgqAj4AEry7sD3a2llIrh9Rmo7uNk3jripNOENVHqvPmNfn1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdqekdzEulVyLYoQEgThIYev0DiwIUj19gXAFXU0IsNxkvbR/
	vRn6aqs0EFYu7gVojserDq2M/SmlrDFv0FiSLfI/zQStFhaaN3w6F3bbze9Btp3k4NrwTZL/lPd
	qfo1TFHY64IgrurgncxeR3IDx0jEhPzvAgIFKH2/agmdEtW4zKZLgt+6yFhY=
X-Gm-Gg: Acq92OGyJXZ/YKVYOUDTCiCNqtZuk7YY/JfVNSTdpBijuf0gwmgcEYPu8Kj1pQ6Ufqc
	wPilAEvp6PYKi+X8XW9fiX6vJ1qzXqjnulMagpneqFEoxZOMBNiJv+nDnDniT0zxcrXikYl1B6+
	svmCrNdxF2xwHL1LEeUkJKtLij2D40EyKGcttHw5PP2eivrXvAayR8ubCJp6Z6r3YIFhZTMpwIV
	FsT9CPK+cUeMSF0jK3PV2mvsPejH5NcrB2pF4kZwK1LCBePJEDnE6/m/EwcOE8uw9XrCBvGru5w
	FVJnZA0Fhcj7jD2hpUMjiDSAIzg1aLMRNQ+na5RN2ZBRpRThsdM60+6oERZ+8pMx7SMmK+JQIGt
	hH92BR2s=
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bea22b759amr37526185ad.20.1779385586425;
        Thu, 21 May 2026 10:46:26 -0700 (PDT)
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bea22b759amr37525755ad.20.1779385585704;
        Thu, 21 May 2026 10:46:25 -0700 (PDT)
Received: from work.. ([120.60.66.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea990105fsm19011775ad.55.2026.05.21.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:46:25 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, mani@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org, Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v2] PCI: mediatek: Fix IRQ domain leak when port fails to enable
Date: Thu, 21 May 2026 23:16:17 +0530
Message-ID: <20260521174617.17692-1-mani@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a0f44f3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=F8mVszBSU3svo1NvbJWAvw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=qMEm_45GddOWhgBJpCIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: jZ4o2rT1IBkDVJyKdw8niFdpDwwDtOFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE3OSBTYWx0ZWRfX/HyavETF2YIy
 pdvO8EECih+B8q/sFfxDHvIKN51ln4y9YwhQCURycR8FI+QHGZlGvt1GQuu/l8mSyixtP3C8B2u
 VoP0VjmQLDuHYnjMk5s2hKk1giEeloSzSMR8L1UgVYXNNdHfb8be+sb77wFCBCwCLe1OMiTsReK
 S9DzaSfh94AJ3ZowRAYB+GMKYd4VrW6c0v5oJutZxPIvvAvGE/AMJbbXHnQGShTIIeihKVpP6ZM
 CyzEj1H9W7AMUjhUBh46r4GUFzVs4NS+yH4QhBNYDOYSjtF8bmkKVZcP8L3V5cYdppHXczIf2gt
 4FO0HA1iOmWjlpo2BL7BuonrE4rxaD3kCJCMDrejvYhxB7d1ZCkKyMYtYREQz1TT5QxciVHg210
 EIi5UdQWQ1OQX+kRJY9zZS2PXDTrPdGFzZdNDIWYU7qBrhK9N2JX1ivt1rsEnqSFdkUCdlYMCe5
 FE6LxOCgF84M5iIvDRA==
X-Proofpoint-GUID: jZ4o2rT1IBkDVJyKdw8niFdpDwwDtOFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210179
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253624-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cjdns.fr:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 844395AABDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

When mtk_pcie_enable_port() fails, mtk_pcie_port_free() removes the port
from pcie->ports and frees the port structure. However, the IRQ domains set
up earlier by mtk_pcie_init_irq_domain() are never freed.

Fix this by refactoring mtk_pcie_irq_teardown() into a per-port helper,
mtk_pcie_irq_teardown_port(), and calling it from mtk_pcie_setup() when
mtk_pcie_enable_port() fails. Since the IRQ teardown must only happen in
the probe error path (during resume, child devices may have active MSI
mappings and the NOIRQ context prohibits sleeping locks),
mtk_pcie_enable_port() is changed to return an error code so callers can
distinguish the two paths and act accordingly.

This issue was reported by Sashiko while reviewing the EcoNet EN7528 SoC
support series.

Cc: stable@vger.kernel.org # 5.10
Cc: Caleb James DeLisle <cjd@cjdns.fr>
Fixes: b099631df160 ("PCI: mediatek: Add controller support for MT2712 and MT7622")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Changes in v2:

* Used a different approach by refactoring mtk_pcie_irq_teardown() and calling
  mtk_pcie_irq_teardown_port() from mtk_pcie_setup(), as Sashiko flagged some
  potential issues with v1.

 drivers/pci/controller/pcie-mediatek.c | 63 ++++++++++++++++----------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 75722524fe74..907ae4285ecb 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -529,23 +529,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
-static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+static void mtk_pcie_irq_teardown_port(struct mtk_pcie_port *port)
 {
-	struct mtk_pcie_port *port, *tmp;
+	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+	if (port->irq_domain)
+		irq_domain_remove(port->irq_domain);
 
-		if (port->irq_domain)
-			irq_domain_remove(port->irq_domain);
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		if (port->inner_domain)
+			irq_domain_remove(port->inner_domain);
+	}
 
-		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->inner_domain)
-				irq_domain_remove(port->inner_domain);
-		}
+	irq_dispose_mapping(port->irq);
+}
 
-		irq_dispose_mapping(port->irq);
-	}
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		mtk_pcie_irq_teardown_port(port);
 }
 
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -865,7 +869,7 @@ static int mtk_pcie_startup_port_an7583(struct mtk_pcie_port *port)
 	return mtk_pcie_startup_port_v2(port);
 }
 
-static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
+static int mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
@@ -874,7 +878,7 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	err = clk_prepare_enable(port->sys_ck);
 	if (err) {
 		dev_err(dev, "failed to enable sys_ck%d clock\n", port->slot);
-		goto err_sys_clk;
+		return err;
 	}
 
 	err = clk_prepare_enable(port->ahb_ck);
@@ -922,11 +926,15 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 		goto err_phy_on;
 	}
 
-	if (!pcie->soc->startup(port))
-		return;
+	err = pcie->soc->startup(port);
+	if (err) {
+		dev_info(dev, "Port%d link down\n", port->slot);
+		goto err_soc_startup;
+	}
 
-	dev_info(dev, "Port%d link down\n", port->slot);
+	return 0;
 
+err_soc_startup:
 	phy_power_off(port->phy);
 err_phy_on:
 	phy_exit(port->phy);
@@ -942,8 +950,8 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	clk_disable_unprepare(port->ahb_ck);
 err_ahb_clk:
 	clk_disable_unprepare(port->sys_ck);
-err_sys_clk:
-	mtk_pcie_port_free(port);
+
+	return err;
 }
 
 static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
@@ -1109,8 +1117,13 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		return err;
 
 	/* enable each port, and then check link status */
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err) {
+			mtk_pcie_irq_teardown_port(port);
+			mtk_pcie_port_free(port);
+		}
+	}
 
 	/* power down PCIe subsys if slots are all empty (link down) */
 	if (list_empty(&pcie->ports))
@@ -1209,14 +1222,18 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port, *tmp;
+	int err;
 
 	if (list_empty(&pcie->ports))
 		return 0;
 
 	clk_prepare_enable(pcie->free_ck);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err)
+			mtk_pcie_port_free(port);
+	}
 
 	/* In case of EP was removed while system suspend. */
 	if (list_empty(&pcie->ports))
-- 
2.48.1


