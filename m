Return-Path: <stable+bounces-231366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL0hKaSQy2kuIwYAu9opvQ
	(envelope-from <stable+bounces-231366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:15:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6D5366D1E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9E60303FED9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C37A3ED5DE;
	Tue, 31 Mar 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QeHlKM3J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOsMqFYK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3973ED5DA
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948399; cv=none; b=Erbv0NLTgkJiVNUoKz3NjsGJhBHnEEVIfJJVW7HSABROnH1Vi5/tdxQ1JCILG26MDJIWkqSDffImMdDfeTYaB8wezP19Fi3cT1pnspbyYtDHpQchmpCHM+HjA5RgH2vQMii70hRAqYcvXeCm9gm+uqabLbYWDoNyElVxwrDTJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948399; c=relaxed/simple;
	bh=HMS/kiTT0EphGAkmZl0wKbCjbDHW6VeoLhCBKAXNnXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbEhgqr2WN0GEv+t04Fo47dozgu9d3E9D/DKCSusB+lDQ6XU/McRd1+hUHKA7U11+HWYTpUFibyjFog1hvwOBfNaciafWaIjEFkQG4SSdo1gyuFAs+0sVqYQ8rYokS8xQpjwqjX3zciez9XyLjQeuy/SuQN4KptUTFuqva7yQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QeHlKM3J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOsMqFYK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V8jrjU2049358
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=D38zhW0VILV4j4J3w9UTb84asghozlWF+eh
	bzg3K3+g=; b=QeHlKM3J36TQqCS8rIOPt3xKrBb0cOucxUhc+kaoylprjuHMgAn
	IKCWNu0HrglLJmNSabmh26iq2i5K78TduFUZGcIL0RITeBczledezotg/2Rle59v
	3oR+aCai4+uSZg89OVWgl4fMz6xOEKe6w+iAKqvfRz0ldeuMw9VSDjAPtx2sHwhJ
	BQXY8EoTIb/KwK5XSTiWZ3K5R5HNPkgWPAWxYRctTebfg1XWZXA/7/bFgOZGv2xV
	93hMGNd+b3CEUGw5rDG5BMJmtUScPxzxAzPCk6rLIfhWeJKneoKqIyVKQ1EVdUi0
	YrYf5bZShp/DPjHN0zvZNPFMJaltBCObUxw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b1yr3jm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:13:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so15920184a91.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774948395; x=1775553195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D38zhW0VILV4j4J3w9UTb84asghozlWF+ehbzg3K3+g=;
        b=kOsMqFYK4Y4GP1hCZnIG/Eyj/QZMG1p1o1MqpyROPUDUBsPb6eLJ0tGKlh6Bf1KThh
         q9F6xJcPQUR14kHy4FaSXfXdcY7xSjup7+Pbqav+z2zZU9DudSixgWCAVLUJpumaLwnB
         BrcrIJY1RRcImgwM5pdtYBZ36BBngTc8P2XYAGMlkMPsVqBlaYci6KhFt0LYLLPTdivC
         dkR98ETgYWOmm5neQ0w7bnBHYlhvIdERhWLqZf+gg2Ar9NihuHE5PcJMdxC6BUw7nKIw
         zUIlZbl77akjxrDrszPoWsuo4E2gQlesSrfda51UzrvOIIlSsBQm0PSz2SeGBK3aeiZj
         xF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948395; x=1775553195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D38zhW0VILV4j4J3w9UTb84asghozlWF+ehbzg3K3+g=;
        b=k0H7/0D9gA51YIC4JBaucHGJH++Fyfk/MipKK/xT/A35OySchPwACZ3UG7EYvVp4ow
         Tb9w/UyEhqaOUpG0OAeA98IZvAMrdDhkTlbsYFvsOlQTHB/kugt2I017ZMxzASjO8sWE
         hhA9hbEUjiRsJz50LCZH0kKphtPh2lYNoQnJCFInlg/5kNdKUcBNq68ETye+dt0UL9n+
         J1wZbF4IZ2mGkSs8wfhUv+G0CDYlZdanXJUK6rkt7psfUaG1dQOmVpdh8QhqaSTHj9zW
         d7tlTAn9g70oPhRXJy7UA64Mz9XqCK5G/21G5UKJ/qZQxFOoRpwDXo/sNMUn/xkEZavE
         morQ==
X-Gm-Message-State: AOJu0YxCFhYk9stF5lSvGmmjUudEd+hr3vXp+j8SAO8QfzDR2KdhzqP5
	O/xCWBORKQokj0fk8xgZbGOnMbQiNIpbmxLVH22+opGkmZ5J/MrC3Pk7F7+WFWsYBsGHjsSsR13
	Rxmnb2mi5RV01Pt6ycj6QMuw9UBCIvTtSwIb2wYewfdRGktcZYDCVvyuPWdW80+lrFHQ=
X-Gm-Gg: ATEYQzwHqXt8wubQ2H+qh4xAyE5WYYEBoau/SerVvRapTgpJnrioDHnfKTMQmCUE2jo
	AWxWbTiueWDNdA626bz+8suAUgLlOdgRRSZYk0u93j79HXAFC4U5lgOj/ly7DDjs3YXibekEqbL
	YyET7lBxD5ZeyCSViCjOLR4ANL9c3shZk8d/qQCdMiUgmwewSk8EnOalGbt7/4p2FESMnY0ZN5K
	hYKjJ0n591DwwrikipZnC4RiMq2DSnPaa1G47ngGAhhwYk2RXieozp+5LjZ5xe1ypl/kd5kJHGW
	jcb+UfxRdjGId7IhRKqNITPAzaJGF8VNNNFqQyS1//+JyxB+SnluGYsere0d2u+TIMtenIOvklV
	iBMEu8CjVR/Mbw22wUPDtj6ZIvC1g/YZrynbL9TU=
X-Received: by 2002:a17:90b:48d2:b0:358:f0d0:1a19 with SMTP id 98e67ed59e1d1-35c2ffffaa2mr14258422a91.12.1774948395082;
        Tue, 31 Mar 2026 02:13:15 -0700 (PDT)
X-Received: by 2002:a17:90b:48d2:b0:358:f0d0:1a19 with SMTP id 98e67ed59e1d1-35c2ffffaa2mr14258399a91.12.1774948394510;
        Tue, 31 Mar 2026 02:13:14 -0700 (PDT)
Received: from work ([117.193.210.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9379f3sm986527a91.9.2026.03.31.02.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:13:14 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        John Hancock <john@kernel.doghat.io>, bjorn.forsman@gmail.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [PATCH] Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"
Date: Tue, 31 Mar 2026 14:43:06 +0530
Message-ID: <20260331091306.25210-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FAmLeqJxFg_YM6wXEE_chNHfUhPpdYEy
X-Proofpoint-ORIG-GUID: FAmLeqJxFg_YM6wXEE_chNHfUhPpdYEy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4NiBTYWx0ZWRfXzbslQitHr009
 V6jVmnX5UgzMotOYWJGbjlcWZUJ4kV+iQQvhgfkiXjkw0JRRULqxegdMuiGDfoGef37G1Qtil7d
 AmRgF8nfPO4n5VrhKEeyBEXGsqmucMtX0/4Oh3PBnPqsFmrJjwx9BuJEiYBu1Sov8vz3rm45nM3
 9wVUOj6zoecQrMzY033uy/6Fs3RimbiY1dzcK+C+yiD2w+Mi0oCk9gJd+PnajJ/xYsIB9hdoCx1
 eoaSJxOVinGHP3e99tIkRh3MAfTFwZtoVEgWDxAwwekYhv58XG06pJMx12dftI92Y5heWvayXZT
 HfYzpPssZqoktuINvRtPxiaCToOp6BjgVZVmIGpXQATaKCoCveydcNY2mUPuoojb6YNeqmorRu/
 Pcp2BR7EuAL35xL0OvPmR2CB0Bgnfo/pysCtc/+YD/G+peZwruRyjb6iVBUkl1xOt7SmfLnMO7c
 RUTmk6l0gGBIF+GLJzA==
X-Authority-Analysis: v=2.4 cv=aJT9aL9m c=1 sm=1 tr=0 ts=69cb902c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=vr9TklybbRi32TvS4M0W1g==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=lAgNKBcoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hAXPUp1672zZkZ7mbzMA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=drE6d5tx1tjNRBs8zHOc:22
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,arm.com,oss.qualcomm.com,kernel.doghat.io,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231366-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3D6D5366D1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit 573497f350b3cdb526c8c38955ddd287c5d4cc53.

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

This revert is targeted for v5.10 stable kernel.

 drivers/pci/pci-driver.c |  8 --------
 drivers/pci/pci.c        | 10 +++++++++-
 drivers/pci/pci.h        |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index de500afdcf97..fe15e59e7c56 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1601,14 +1601,6 @@ static int pci_dma_configure(struct device *dev)
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
index 82bde2a92cf6..c25bb6bbc6d9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -894,7 +894,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3548,6 +3548,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
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
index 5079800f56ce..c2fd92a9ee1a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -547,7 +547,6 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.51.0


