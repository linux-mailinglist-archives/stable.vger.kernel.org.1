Return-Path: <stable+bounces-231367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA7zFyWTy2nMJAYAu9opvQ
	(envelope-from <stable+bounces-231367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:25:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCB1367075
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A747030ACF8B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3743ED120;
	Tue, 31 Mar 2026 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5rzIaPP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GCPgZWFq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9923EC2F4
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948524; cv=none; b=JS9LcCBx5sXRUfFItjXCcP3JrpeaF+FVCyzLCr10eooSuDG/Rgfv5NhafbCjDzfh2dBY80377Godmnce53+x1IBIYmWGquzMJT4Yoh8OT8ckbaTdX3sX3xNE8BiPZsCheKC4k5R0lY/zqbhQhTUibXeSpEVGY8oMBbKOTR29xFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948524; c=relaxed/simple;
	bh=wqEtTcfrnfkB1/1JAggq7TeFTa6jZH31RqJX87K/lOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atKHORbYXVrSzXz3VqCaLxDSjq+SDt3k/fbWDPHY0nOhDFIhgyJoETA5qo9P65i9v8rDCTvPcQJZ23l0H0USXtvTeGZ/tIzLnxLh9qmkDFBzMF5ShFqwRT8yexpFpVna4KtFxdPkbeHGXvgeafxbCcwyEHWDq3rvOOisyIQ1JHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5rzIaPP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GCPgZWFq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V8jtA92049401
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mwgbVgvQHgOopgtkJu/D2bFIW5S1SsBBybk
	+5nhk3pk=; b=a5rzIaPPWYZ/yKSPse1+2tR6kEr3RHcj7ZMNPi0t9/iUPCcSCQt
	jwi2yDN2+hCnDQAdLYG8HQGes5sHE1aUgtpgv33+EzRZSP8iFpEHAy5EsOHaRiii
	A89Xemcdb4dF+booUb0mX6SluqH5bzFHWrDuTwl+pS1JkN9/pfV0uFbKmvvQPepG
	TZsUoMR+lEg1SUvwrZ6BbJN9+J5WT0VqoEpgbV9Q9Exmrso/K9dqvxAjx/e8g3sD
	yZ3cLZhjv44SqvD0syeShb/NU5LQGLmXWZjzCbK2DJGLRXXTfcBwUQSSbBL5mJ7y
	SP0AZymxvlGKtgPfbbCyuP9B0Er1ZC0diug==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b1yr3w7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:15:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82ce0c07d0cso207428b3a.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774948521; x=1775553321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwgbVgvQHgOopgtkJu/D2bFIW5S1SsBBybk+5nhk3pk=;
        b=GCPgZWFqSc8uCivfhvAfTQOZQ0dX6//d7SbJXSmg97qBp7+ISnEeBaqd7i4Y1kKmt5
         e0LSehacH3XU+ketp3QIERtemhEvFfD2ZSe45SDk6VNSJrn/pWrUn4HBBMzhCLubrU5M
         rAV7Lwx2MltYRU+jtjdD4VDZjJQ1VDkx2WK7A1WuNqxajEwCyVL26U3LVuIeYKjhhWXh
         h5YfObkKdvvEK9PjX+RGF1iivnoNvVZUaUcbKpwzFoEnRvOML/p7tkAnNaRtsve+UgsK
         7sJMm0T2+Is0CfjwTY1WKpdAVOnseRAHP33AvWnKyJgDTlZQg9G3zbyQ7080dzIFfP6U
         p/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948521; x=1775553321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwgbVgvQHgOopgtkJu/D2bFIW5S1SsBBybk+5nhk3pk=;
        b=PU4NkgDQHJQXhLj9RKwz0Pn/TimXUbeQZb518f5q4GXDkUkSTaXewv4T/wbKYwC55W
         Llz7hWvWVy6dsn+388GOaRH7S67Amqv21i4ZI/5frE0lNTkazOhcrxGB/86jRcUuNCxD
         GXyiT2pIXN0UM4comceQ5jDNSKIgpzg3ecwrpvOrdePj4bJNiZ6AwfBrHkPBEEYjQfN5
         IFyNi3cF0uKjeMZIjxA6r7qLYzxqLeXbbOiDKKEHX96vvyHMb7+h0eqzlw2oTGvn/iC1
         dH0LzLMiwE3AaSmpS8lILIJXerphMajFMBOvoNzPDHDcsYaYIsFCgaE4Noh8CmnTbi8h
         xiSw==
X-Gm-Message-State: AOJu0Yz49VY1pQvcGlH8sHmpAmKW5Hjt4OkNdSQQOlnaeXPSZuRbxMhx
	ck0EdaHzg7u1WQRR/NVYW2cMemZfWVJ/FtsqWuuk4WtZBw+Mt8whN/wm1Xif0MxajLwbuYguTe2
	Y/sT9Yo9obODUtLeOHDKrC3mYdueJy9CnlgT1oPpM4DWfPwSKDb+I/0YFwqcUFJXuZcs=
X-Gm-Gg: ATEYQzxzSE1phti978UG3CtWO/qmkkhKhr6aF1QteLW45PnHaqAMRGZoaqB7oIE7atG
	aHesXP9ru0QEoHdyUSzlYISthl/CU4D/LBtJt+uXRp3eI9sPZ5HbZyEF7K5Uj/hObXnpALNyJLh
	JefI9XcxEio4zjzU81Y2dRZxNzf1HEPk106BvbrcEVT2KTeoI8H4j4BaQxRENipBh0si00jJAC+
	SCcEf4ge9jDIe+7n751fxslMxR0h+vmM1rCEGSjiPEx72rorvCTV/7aN3ClsndeC+Xy6R2OWX0u
	ervf5v0pPisdPPmQDuZ5itfGWGUztok4v2fPErytwC5hOreCkPJGbM1jVnraho1K2qo9hYURl+3
	lxmt8/LIYpor8BN5LPlimCBHeIbDhTC/fgouOrOc=
X-Received: by 2002:a05:6a00:4197:b0:829:7057:b99e with SMTP id d2e1a72fcca58-82c962124bcmr13030027b3a.54.1774948520789;
        Tue, 31 Mar 2026 02:15:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:4197:b0:829:7057:b99e with SMTP id d2e1a72fcca58-82c962124bcmr13030002b3a.54.1774948520077;
        Tue, 31 Mar 2026 02:15:20 -0700 (PDT)
Received: from work ([117.193.210.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca847ff4dsm9760492b3a.23.2026.03.31.02.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:15:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        John Hancock <john@kernel.doghat.io>, bjorn.forsman@gmail.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [PATCH] Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"
Date: Tue, 31 Mar 2026 14:44:55 +0530
Message-ID: <20260331091455.30394-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pfYLhkZERmIHO-peNZKaxiis3v2K6ezn
X-Proofpoint-ORIG-GUID: pfYLhkZERmIHO-peNZKaxiis3v2K6ezn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4NiBTYWx0ZWRfXzUcfezZ7QHi5
 bygS+x35y3aTPCLcEvsD4HH8UFhUZvAdKSidHuQyRtWl/tWOEDX9meke+P9fwT58oJKNLOrITCD
 CgwlQuBIEHzrRSiqFUBU0s9NK36NAuCFXpRHoIgAmYBRw6ZCGtP7sQpShDF0a2/92hdJSDCSD1N
 rW2s6rPqPT0TrwZXcgp1YV4XOZpK5qs8GfuEzfMHhWjOh6UJvZ3TIAK/velPXtcsDNM7e2zmNx8
 8LvF8qIIiEsUJ+uTmuddTkvbIg7AObLimUdMrZp25WqtGWOSt0amMQyq106apftP202KubVTWva
 U/kk64/oIEBO59FgCh6i9jQKfD/HEiKpX8HIudk3MfdZnIjzSHVFTjzR4wkefQt64s8ZTYo5A7h
 v+8aGhvJCJneNs2nGFZ850f1VdH1VxR8FpwXMd7HE1knaqUVumkiH3kObe/FRsPuPL6IrECgyW7
 GGhSU6JeYHzPIwyQccA==
X-Authority-Analysis: v=2.4 cv=aJT9aL9m c=1 sm=1 tr=0 ts=69cb90aa cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=vr9TklybbRi32TvS4M0W1g==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=lAgNKBcoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hAXPUp1672zZkZ7mbzMA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310086
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,arm.com,oss.qualcomm.com,kernel.doghat.io,gmail.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231367-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[doghat.io:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,linux.dev:email];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5BCB1367075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit 5d57164c0ab0ac5c99eca49c577994bfbca70a2a.

The original commit attempted to enable ACS in pci_dma_configure() prior
to IOMMU group assignment in iommu_init_device() to fix the ACS enablement
issue for OF platforms. But that assumption doesn't hold true for kernel
versions prior to v6.15, because on these older kernels,
pci_dma_configure() is called *after* iommu_init_device(). So the IOMMU
groups are already created before the ACS gets enabled. This causes the
devices that should have been split into separate groups by ACS, getting
merged into one group, thereby breaking the IOMMU isolation as reported on
the AMD machines.

So revert the offending commit to restore the IOMMU group assignment on
those affected machines. It should be noted that ACS has never really
worked on kernel versions prior to v6.15, so the revert doesn't make any
difference for OF platforms.

Reported-by: John Hancock <john@kernel.doghat.io>
Reported-by: bjorn.forsman@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221234
Fixes: b20b659c2c6a ("PCI: Enable ACS after configuring IOMMU for OF platforms")
Cc: Linux kernel regressions list <regressions@lists.linux.dev>
Link: https://lore.kernel.org/regressions/2c30f181-ffc6-4d63-a64e-763cf4528f48@leemhuis.info
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

This revert is targeted for v6.1 stable kernel.

 drivers/pci/pci-driver.c |  8 --------
 drivers/pci/pci.c        | 10 +++++++++-
 drivers/pci/pci.h        |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8b5796a6ed5f..fe6e5f716543 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1667,14 +1667,6 @@ static int pci_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(to_pci_dev(dev));
-
 	pci_put_host_bridge_device(bridge);
 
 	if (!ret && !driver->driver_managed_dma) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2d6b7da8c66..0778bb09d878 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1040,7 +1040,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3777,6 +3777,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0debf921a9fe..85488bc8e779 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -526,7 +526,6 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.51.0


