Return-Path: <stable+bounces-231364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNtMKtGQy2kuIwYAu9opvQ
	(envelope-from <stable+bounces-231364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:16:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE37C366D4C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8404230FF4E8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8653DCDA4;
	Tue, 31 Mar 2026 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+BvmIya";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jjzj3mS1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768F3DDDA3
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948232; cv=none; b=D3uMkJ/CevFwrEzKFyX2cbPPBmkyX5xDxxmeZtLwGViqt93PhbNjHRQk+LrJg41cBlUWwKMam+jxbIgZKrUwL1m9z/ShFr2JUFCQC5yVVAMSBepgOTPj7elJRduTkTLBsxIJiO8o/3iTXeJF4273Bmh+1pMEDNxBAHrHxQM88gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948232; c=relaxed/simple;
	bh=+fcgrokixlEbcf+aOsmiZdoomim6YGRO5kT5k3+jI7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgEKU+IkF2RKK2883erj3boaCCPh9FUx+yOXeDcmlc7lGQvaTKxkszuXuPq7dRv0yBnpgsAyMRKIdtOZTBDFdW3/fvd5C6hBNpDz2Fw2BPQDXgF832HWHUpCzL9RLRKV81Hu/DYKj5iUm9vCLslq/+u43sA26oO09iReLEDUqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+BvmIya; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jjzj3mS1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6qF2b2391345
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fcs5ftBhXtYRcqqz+HI3Ln1If1xisAux+zA
	c7yob4so=; b=i+BvmIyaeE18u15CE/47Qr73cjIGc8PTRv4o79eFGzPG2yvFM6m
	rKR4wsLmVtIinwoDhT9cl5qlLrpXDVMnNsUttiZfIoC1jaHNrdEBKOYFLO/aiZul
	OQn1X2FeP6ZAkrzjuJdtRZz1RENybJsJU4cxd6/Sjm/CKrZnNijdnJm+e8Uo5rLF
	VBOcUv3bPL3z3QD6rrZeeMtpjChRm0cqA1PL2MLqZqrt8IzIiX+r9putRxu0Suhr
	UYvhaY2CVZ3rLolNTYTa7PF1qJrBqAkijjEjpnlCPluyhw3cNRnql8qRqtMNW8sh
	ewDj2ZkYvotiJ8iRpjQKlblSBamiSXwTFlA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7ue7krm5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:10:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c73c065dd15so3476170a12.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774948229; x=1775553029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcs5ftBhXtYRcqqz+HI3Ln1If1xisAux+zAc7yob4so=;
        b=jjzj3mS1NGrRYeTnU7zTB5PZ+3lYBhnE+iAO6cjX0UQHudV6sBm/kiq9eoiDapYEEY
         U9u1ol9Tc9V6PjAhWWXbnM8Ibgf4wmUQ/W6j1jFu6taDSjroxWX0esrKDDSIX+DMUnFd
         FuNKd6fhms1js0Nw2GWdTqARPWXAKpdYulpkJz5Bkn+/hI74UmZWeEpm52sPWKnetOmd
         kYYlg+IWaoLD8Rtvcuu6SWMH2fMp/oTytpdCxu/mAZUy08FNntpdOQ37ccOBKTPDWWms
         +btYW9rIPM0JVRABPpOudWZpZ7hcjiDmnHefxqA+JwZgKtVaWQkfekeQ4yll0qVqfxvK
         JEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948229; x=1775553029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcs5ftBhXtYRcqqz+HI3Ln1If1xisAux+zAc7yob4so=;
        b=FKGAN/Qup/J3k5r83D1voKsU+woC8xdPrmkdB1T/B0WmTYGqZqX4aymUcgvFFflL10
         c2/I6Mo2xvdVSgqF9eL9VVwR0s9vH9fZ/ZOLYULQHRQo/uARGGM/2dT/q0AJcyWKQxUA
         ree8/eyVN8v2C9JZObir8Cx7uTv5sAe5yt3P29cYeiAZSLjaXj8eRndU4p7O2rpoGTax
         sbe6bpofBlXTIyMu8jiqCvYKYpFUdSGewUl2yIafKqJAU6vkIl3o83Gq7OuHmRlpaFeH
         NZPNkhAanLGCW1AW3d+vwQkE/0P4u0cbWnGpEPuDZAhKM4dnjhrUB/KxGecIf+emLtLq
         xxJQ==
X-Gm-Message-State: AOJu0Yw3gS9PwQCLioMGdkvCopzy7/P1q2dznK4jl6LsM/h5Qt0nWcFO
	4idV33z4QZsatDScVH4OdDgC5vP2RxLfIxvoUK5MDUU8dRxtL7n45z5/m7mYBhta9c2GV1e6FEH
	ou2rK6hf6TqMeJce0JKfsn6YUwOQCrB6J1RxPKKGfFqlYT5jkifWRmsygF22QB6zqaAY=
X-Gm-Gg: ATEYQzxME9l9zw12ykyHYNuOe0pPot5aj2s9mRXxrwFKu0+HdWZ4u1Q2oe4OKHXgJiy
	m27+7C/mi1V1H8WZCDYgJSvSrLz5LZ++GZrSxq94WdFeY614IzjeQzW3eL6NnbMqsMkGcs5F4NR
	hg+vnVwTSW55urGBj48ILStUAgWVI/XJsLMXcgm6W599BX4AclstIxzM8wMolNkGLJdnN0n16Fv
	A4xmTJTIrl8SjxBCVRLbhA1xQTiKjE0XnV86oKh5rDT+mPPhzjwb0yVdYM1HljVTqne+yeyrSBK
	fywARSGMh44D2E59eiHi8lLCspvaSe/J+kaCzEG5vwsTPS4wPUxZxdAjjo4z3WAlQOYPDcPTqjd
	TBPHfXthd6Fvl+LkH5bfm3o4CUHYfVtAdkivqecA=
X-Received: by 2002:a05:6a20:7d9c:b0:38b:de3d:d542 with SMTP id adf61e73a8af0-39c87aea147mr17138850637.51.1774948229251;
        Tue, 31 Mar 2026 02:10:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9c:b0:38b:de3d:d542 with SMTP id adf61e73a8af0-39c87aea147mr17138802637.51.1774948228605;
        Tue, 31 Mar 2026 02:10:28 -0700 (PDT)
Received: from work ([117.193.210.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cdaa4c3basm1567941b3a.37.2026.03.31.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:10:28 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        John Hancock <john@kernel.doghat.io>, bjorn.forsman@gmail.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [PATCH] Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"
Date: Tue, 31 Mar 2026 14:40:09 +0530
Message-ID: <20260331091009.19536-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4NiBTYWx0ZWRfX/iuPdpo2eqFZ
 TcmtT7gDi6n+ZHdPAcRZJjQBL8N6ZyBswVczrEh5oTGMWmgDW3TxjFaH8lPRmN5pKt/9ggJx2yT
 HH+JuZf/Y04I7tiZPa0AFg+ILGf02dEvTjYFrUFzUxl7uJ5w9NoGk9pZCEri1VrX2LQNB8I7/kc
 EFqun+3duxSI1BjrtYec99tsbR8JSh5uOxpXmVGatriZ38iXWPzfar1H1egX0BEdiVE/ygHxVHs
 6reNlmWQA8gw6n4jSZbdjdgboe0MCZDbxNuJ0W3jcMWuwJT4+Un15X+8C80r5so4llgxE6nKYrU
 ANtL9lxcwby1M2H2ntPJ3hmnQzmro88hGB02A7Nel/DIwdPZPb1ZxFyrsQ9YB43pwGR5JuMLxI7
 1NTUQtNG2+QZlcP3F/CfLh14Y+SH6zIa3C2HqexqG0l1AxQWW3yO0P6HSJgZJE3gek+1LlX3IuO
 nNGJdhCIG64OkZ9QOrA==
X-Proofpoint-GUID: eo7qbe7tgaoUfh1arLVI4oajDfdV5XkH
X-Authority-Analysis: v=2.4 cv=G7sR0tk5 c=1 sm=1 tr=0 ts=69cb8f86 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=vr9TklybbRi32TvS4M0W1g==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=lAgNKBcoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hAXPUp1672zZkZ7mbzMA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-ORIG-GUID: eo7qbe7tgaoUfh1arLVI4oajDfdV5XkH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310086
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,arm.com,oss.qualcomm.com,kernel.doghat.io,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231364-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE37C366D4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit b20b659c2c6a072560b360feda81ae52176034df.

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

This revert is targeted for v5.15 stable kernel.

 drivers/pci/pci-driver.c |  8 --------
 drivers/pci/pci.c        | 10 +++++++++-
 drivers/pci/pci.h        |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ecbe382b56be..08c985478b8f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1616,14 +1616,6 @@ static int pci_dma_configure(struct device *dev)
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
 	return ret;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d1474b2129ab..2d4f3080e4dd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -936,7 +936,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3609,6 +3609,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
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
index d9d7a79e3563..4a8f499d278b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -562,7 +562,6 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.51.0


