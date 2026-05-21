Return-Path: <stable+bounces-253463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ez2NTuyDmosBQYAu9opvQ
	(envelope-from <stable+bounces-253463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:20:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6795D5A0043
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D3DD304C12D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0BA3998BA;
	Thu, 21 May 2026 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jYw1drq3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EIIJVXTX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D73822A6
	for <stable@vger.kernel.org>; Thu, 21 May 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347964; cv=none; b=CJftfxrUjud3stJmUuW0K6QGAgswMcZ+hNHLgdguzPFyaKTdHOuhrDXl0qyud9Wd0hTb+mSJxoddiw6+WGd2jbBy12hz2wU8oBlwUgegj0XHAnC3g2RJmcQ7Oi8wRvzENzh1IAZZ3QQeEYpp8PjDY4eDbqcLSFIVTOc4vSTQixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347964; c=relaxed/simple;
	bh=3NyQcX6UtkQinDdPKnEDpzF+Nwl4fBqZnu+f+acQlPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGenXhCnLTn1u47dFDXnMxgwEeg59SkKV677M84Ag4+vgglCUclEHw6qBWKVmqzAMHfxCyjP9YfhAVSOtMDrN5hLk+nHkW3ePXjFqfaNfI3xRU6LFgbs123BOi/4j7/hfY+6IdWX0yNsDTV+/nAVABan9+OZJntv/HhEekEz4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jYw1drq3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EIIJVXTX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2TCdW3816873
	for <stable@vger.kernel.org>; Thu, 21 May 2026 07:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nN956VWUpzaipasyvgQamUM/S2X7TTAO6ec
	b5GJgO9w=; b=jYw1drq37Aa8pNMI4dzSEE8mYokUb9i9XcsW2AJywqngw/X5t+x
	9WAYNSboIZS+bK+L/ylJKwL64H3eyAD6fxq3oVp+LO8gmXKHSxc/pau1Y8ZDwMgE
	HYKoGf6BZS5jvRSiaK2SqYPdCseTZvDCn0T59kUVlneBMv69O5vqdcRamNTxylH8
	7WeVdAHeEMQvqbnkdjrHNdyQA/D0QU2SuOs2r1EQp/JSCgI+Ur+m8zZT5unkp7rA
	P0HR/Ouu3U06sA2IthWJhcueLlvlmXEFZhvQIYmRqRMBtIH+cjp2bAtldXnt0SKV
	hnT1B2lfEEMshOXrX8sx9wCyeYNABKxgdhg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa0y5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 07:19:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3662990c03fso4912138a91.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779347961; x=1779952761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nN956VWUpzaipasyvgQamUM/S2X7TTAO6ecb5GJgO9w=;
        b=EIIJVXTXQsot58o68W9dQeO2/j9JBjY7scZAULu/WUh5aqGuXqTQWwO4hhcQ6kWXee
         lqmknoku/rr2xOE52dhciqJ1PNdVm29dw5u2xh3Yoo9d5Au5q662bwDEB+LD0b7wPjfL
         I+tPcXCJSXb6L6KW6DSgqZqHbSPoQv2TwfHvm4Jv3tEW/7WYzNfQpssgoZa1YTK9qOql
         VdbY7jgGYudyEaU1EXTEcBddXNTRw8dd80ARQCuTsaMVB5TGyGTXvatrfYrxi++8X1o8
         KYSkEzEuOW3DB/hXZ+KNrpYDR03xwxrLCpcVc7rl8L9TVrbiliW89WYSmTNg135j+xPE
         PFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779347961; x=1779952761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN956VWUpzaipasyvgQamUM/S2X7TTAO6ecb5GJgO9w=;
        b=lN1EP2aB8FX6pWv2qoQWPZpQH0zIzbmxDmxjkaNQwA2Lwst9VB1qwQWzfi2Ap13z1I
         uq6/85PtgIoiR0uOaZ1DU2xfsFPdfIH7r/k+5os9UdEjqK6TWRfP06c1zjL1H2wDUCBA
         03GeGJX/lfKDF6uPoo1aPxOi3imFtHquRTDVQMFvnA1HsIyXPvm65c5Y9FyoiukwCKJA
         h90rhJHivWxRAoelRjIKxTV6wkIzwgKbkQhxBaMZCgvFBg680sUetFU4WPN/BwLoV0hu
         Y+GPEBmJDFJGA7WaKKFmCaNdhTqIGoTuu13klOkUlLxIvHLpMFMI/k6gVVveWRG6/qOg
         A37Q==
X-Forwarded-Encrypted: i=1; AFNElJ/w9DPawM4wm+/JNnmkGYCGfEqwKP0J1ZZApASq7ySwvdOA+JSYvfNgQPJYYz1RctDO4ocH/z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QSPbEsqg7KZ3BMKENeYIElqtYfkhTlvj3MjbWbpWa+ok6cYG
	09eZyC8rwxe7u77RoMSf419DOE5J0BRmIhB2QfnwdzcBuIGn6iHsj4+WKosnOkCPie9LcrNdrzF
	kM8doYzgo8hETDe1BSyKV+a5wUj04w/WoPXR+n8d0aHtlN4YC/02pn2YjVgo=
X-Gm-Gg: Acq92OHLTQeYFnTLRoueqLBsHRJaYhRjNvw5mVvQZmx7NjLm7u+C7oAulHT1TLEh1Yv
	7K5PhVGJE/hA9M9RSEpJQQVzmgraETif3suKlxCmKBVgitpN7zsxkfWwcmgVFd260iGG+qxJ0Fc
	s3bbpTTGn7EcjfSBMgNw8/5iOZBhG3tPEgWTWUp+M8RhrLWkV3x+d2P7s+JuKyZ6ZhVGB1Lm08P
	P8kR185qBXD8FWcbPmA1DaGgHgfwTfegIcOC8ZMCUH6TTDgIvpd8xj9okVbVah1v2hKndJhodDI
	cbeXGxV1s1ZDMQ7r2zTabYlTECO5LHiit5Ak6KlWdXOdzSZYi2+8BkQAWCteg35ee1GpTzqx18K
	RVeRKbpEBKvlivvvMhQmcllaDUF43GOkSo/2LYhrGQaPY0CxZDxbx1Smdaw==
X-Received: by 2002:a17:903:3bd0:b0:2ba:5f24:caeb with SMTP id d9443c01a7336-2bea229bfd5mr15735465ad.19.1779347961091;
        Thu, 21 May 2026 00:19:21 -0700 (PDT)
X-Received: by 2002:a17:903:3bd0:b0:2ba:5f24:caeb with SMTP id d9443c01a7336-2bea229bfd5mr15734965ad.19.1779347960462;
        Thu, 21 May 2026 00:19:20 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:ef8d:de79:6e34:4a35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98eca29sm468475ad.41.2026.05.21.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:19:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        ryder.lee@mediatek.com, jianjun.wang@mediatek.com
Cc: bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org, Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH] PCI: mediatek: Free IRQ domains while freeing Root Ports
Date: Thu, 21 May 2026 12:49:07 +0530
Message-ID: <20260521071907.13614-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2OSBTYWx0ZWRfX+7M4WYkWOlmF
 0APqNk9RwuBeJTt9gNX4eqwejalVDrI1LQL+fxozwRxCaH7GpFpjIjsdpTMCV1749OjA1U49Gw7
 zuI8D4NYHpkwCyQwNyIpnbUbV6AF1zZOQkxDiZX0QEeHBuXQDU6C61896em5N3H/L2k+kRbQGZ/
 6eZN2KSPQ6R1yKnGaXVIAlMxYUAbEUeUSLamMozzWBM8r0ZPUQsHRRSUmVZFG6AbyODYSBz09Pu
 BK4UKveipiLazf7P2ZXaxarH5t4szh9yOm7GWbjAN3IAwtAbByy31LbQMWJM/hOXuCAb7e0FLjC
 aJrCHh5htYlY+iSp2orkB+p0jemYdoHHVG/eCoHrOzCFiLrP13MzWtU9NztuZuQ/+yww1HStqiu
 AkMzQI4xnPnX2/v2eCw6OU5lbQW+wYHPpFtU017Xrnuz8vC425KkvoPnHAcYOdnOgjOgYR8uERw
 B6zzTb67kr/7f23ovaw==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0eb1f9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=0GrS9vw-3MyE2OudUf0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: wePcdiXvmZsqMYKBnLv3gsYYC1QrDaft
X-Proofpoint-GUID: wePcdiXvmZsqMYKBnLv3gsYYC1QrDaft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210069
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253463-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6795D5A0043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the driver frees the IRQ domains only during driver remove().
But when mtk_pcie_enable_port() fails for some reason, the domains are
not freed. This leads to resource leakage.

Hence, free the IRQ domains inside mtk_pcie_port_free() helper which gets
called in the error path of mtk_pcie_enable_port() and also during driver
removal.

This issue was flagged by Sashiko when reviewing the EcoNet EN7528 SoC
support series.

Cc: stable@vger.kernel.org # 5.10
Cc: Caleb James DeLisle <cjd@cjdns.fr>
Fixes: b099631df160 ("PCI: mediatek: Add controller support for MT2712 and MT7622")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/pcie-mediatek.c | 35 +++++++++++---------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index c503fbd774d0..c45baf681cf5 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -250,6 +250,20 @@ static void mtk_pcie_port_free(struct mtk_pcie_port *port)
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
 
+	if (port->irq) {
+		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+
+		if (port->irq_domain)
+			irq_domain_remove(port->irq_domain);
+
+		if (IS_ENABLED(CONFIG_PCI_MSI)) {
+			if (port->inner_domain)
+				irq_domain_remove(port->inner_domain);
+		}
+
+		irq_dispose_mapping(port->irq);
+	}
+
 	devm_iounmap(dev, port->base);
 	list_del(&port->list);
 	devm_kfree(dev, port);
@@ -531,25 +545,6 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
-static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
-{
-	struct mtk_pcie_port *port, *tmp;
-
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
-
-		if (port->irq_domain)
-			irq_domain_remove(port->irq_domain);
-
-		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->inner_domain)
-				irq_domain_remove(port->inner_domain);
-		}
-
-		irq_dispose_mapping(port->irq);
-	}
-}
-
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
@@ -1186,8 +1181,6 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	mtk_pcie_free_resources(pcie);
 
-	mtk_pcie_irq_teardown(pcie);
-
 	mtk_pcie_put_resources(pcie);
 }
 
-- 
2.51.0


