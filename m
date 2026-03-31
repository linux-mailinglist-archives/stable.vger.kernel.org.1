Return-Path: <stable+bounces-231368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDphHEaRy2kuIwYAu9opvQ
	(envelope-from <stable+bounces-231368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:17:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A7366E1C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C24E63026F6A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC93ED5B3;
	Tue, 31 Mar 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sf5b7NfN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H9OA+HSR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142E3ED120
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948659; cv=none; b=oIO9jDfSp1SwbZNlBejXtDGzNrOPM4ya+iUZ5irOR56ohcRbVTkN6rb6/PiFVLFr60oHpjTa4Aj89RZmdvMQGsedKZa6jmZTk2xd8eiVgNwI7i8NKGaSH1msxUIaoFUFdJX9lSiVfwBrJgaIziXybETDHLvyeNVp+pSexp1Lp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948659; c=relaxed/simple;
	bh=N/eES/Xh/38FhKMRuW7Q6v2kLjf92GpFC2BRpl1Ud4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mv2atuiJPPKBf5Ho4COWdOMT2ZqttB1lI1WhgRjuakzQ11pV+3gWH7gpxDgl8kUi5aFjc2FXr0ThyIa9tTFLlhw4nkpXT1HC2KscwAN1a1xGCwN147NgLempa5qmBHkTkgzfG/3UPWMXllU/b9gfaf7BCB1XZnl1Cnl5YSRCg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sf5b7NfN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H9OA+HSR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V7OUFn2465252
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=N5vIQzVWTdz2F4TNIPIiGoPdK8bGPWTisCz
	WzVjic3I=; b=Sf5b7NfNiJQTHSohskYwVmu7ZnhPhLyShbQHQplcY2QkqqIPGaj
	zBhr7cfuqZTDhHjOzuyLsrTVsgDe7EuRrL4qPmIE2+gYp4//xiUFeN/z5zBenaBA
	KBppuSduPZmTrf00Mg4U6hR+Ck3RU7FR/In+GEMofWbUxUx7NJWogJ+Ifu6VR8Au
	8WwJ0BWa/7MBv+AxISrlHt5PTWc2zKbbGHodCFrAN8V+xks2EDp3YlhYtQ8bIjAz
	0AjUvygqct8I9R548/dIX8TGUn0OdvzEvGLW9DctahTZkwrPpuYaDXRfgUXqclEp
	P/Sts/3RCH9Yw5Blp0qkdEmQOfFVNPmm6mQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d89ut8g6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:17:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2489af602so33869005ad.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774948656; x=1775553456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5vIQzVWTdz2F4TNIPIiGoPdK8bGPWTisCzWzVjic3I=;
        b=H9OA+HSRw4TRxI7CjGqTEIeiQoX7/7miajnByESfBokbRfeBuTZXaFXz2Cq3nhiJ6S
         zhm4n58Il3xwNo+2xCkPOPPuT+1NW0tZovRyCOE6T2KAbwyjCYuyuT7xniVxmJLHUSlW
         /ZYMm9DaXQFWPFw3Z2BO/Hi3s444C95O+PhUtqDjCzvWjy6z1PABANiMZl1t+0L+A0Zi
         BpMgcY+7V1efgbvbKGwXG80CS/BeFiuxNpeQcokO8kyXCXW9yGQkXcFc50/CMoFyNcub
         SaeZCmNuhWUyrHxHLC9zoyTYbNsLB/KBAx+QONYS3e+qkIFJk5qrmEr3LID9i6PAvnWz
         0Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948656; x=1775553456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5vIQzVWTdz2F4TNIPIiGoPdK8bGPWTisCzWzVjic3I=;
        b=iau51G0Qge+NXimaH8qe4i/tN7X9AGbiPviES6cfYmwjdeY47qsjdnAs221v399tlA
         vfaaR9YbmDyl0fzEenuFj7EBMfGDfdS3Gw+sn58u7llQxS5A0x+QItUkvwZgbDlpQihV
         6B2oqjB7Ex+dmPLk4cHixHY5/4InhC6+poOCYkuaqDT9VJykSU+8WDm37IlgBTjNQ50A
         8TvE9RoalBjaMN9pkDkCl1Gdzr9SyBQTgH+FjMgmUIOpIEMkrPGTrXTgdVdXyVGKsimV
         l/NnB2jkk6EijVQbqlvBNn+XvNjc/KLcKHm4MH60A8ynrzVplIyu9Q856w6iUGvZwJ+t
         dU2g==
X-Gm-Message-State: AOJu0Yy6ZwpOOrqiEoDArbPH7fMaC0djkVVSZCL7N0lR7wx4UjPVsMDs
	3lGWgLjoBXUvJhlYMGhvRcZxb2HxFGmgyYm0o52EQH3h/9tILZnZfaQlshRtfR1dkzAyuQ8lpLq
	s+xsKYVGLqviOxT+zcgGhljS4FztT0SemBt65rtLjJwSv9mC6sxTaTzoQzcHuB/hyAJo=
X-Gm-Gg: ATEYQzxZsd7T7kB8cD6yaUmpxQRxhdn/9rWLCuTfdpc7p1ma69fWF2RwIR5diYECuUc
	Tojl0rrgsguZRoOYqBj/VtNj+qdQ4PlQfwq5Ceoc7T5Xc+niwMPvVTopwdfKJo88GaYITciPO1+
	f7sPsmMhlUjW2w0XDhoQp1W4UngW2LW24aDahoTkfYyBOJvWNSvmSPKR/CN8D+wrZOiQgw8vjQc
	86yLjpnOXznp0lfLyW/oAGRc0szFwovqW6aTAlE0FLPjZvgeiMsqtb1+IyZdC7UQiaWrpMmS8gi
	MCANFiTtdjs8oJBNVwImg0836B5m3Ruw0T8Bih/8GVhC7t0lfphI/Y7pgnt+qAtvt4RYALyumyi
	4L1E8s/ubezYDOpA75mbL6nDbxFGlkxagMn3zCP0=
X-Received: by 2002:a17:902:d60d:b0:2b2:4f43:b49a with SMTP id d9443c01a7336-2b25ef77bccmr24215095ad.22.1774948655932;
        Tue, 31 Mar 2026 02:17:35 -0700 (PDT)
X-Received: by 2002:a17:902:d60d:b0:2b2:4f43:b49a with SMTP id d9443c01a7336-2b25ef77bccmr24214735ad.22.1774948655386;
        Tue, 31 Mar 2026 02:17:35 -0700 (PDT)
Received: from work ([117.193.210.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427663acsm104909665ad.46.2026.03.31.02.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:17:34 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        John Hancock <john@kernel.doghat.io>, bjorn.forsman@gmail.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [PATCH] Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"
Date: Tue, 31 Mar 2026 14:47:27 +0530
Message-ID: <20260331091727.33552-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r473WCcdmGUBiDVmEO8M98ytNpHPN6k7
X-Authority-Analysis: v=2.4 cv=C5LkCAP+ c=1 sm=1 tr=0 ts=69cb9131 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=vr9TklybbRi32TvS4M0W1g==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=lAgNKBcoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hAXPUp1672zZkZ7mbzMA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-GUID: r473WCcdmGUBiDVmEO8M98ytNpHPN6k7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4OCBTYWx0ZWRfXx6DWxzH0iG0n
 V4YjIMnb8fHxqE57qBKdmDIJYi6C03/nbHEDUTQ91D1PdUr+gqVe8RUz9nL1b3HtzCd+fTMRvZD
 k9E5jg911eCPp8A9MgRpxf+2GDo7OCUnlbeMwXIhG/i8qsts8qOtSsoFviQ3qah4+szjLiCxv2H
 7hMm209OG3XL90BnOQFe2ebsXiqVGZc8mmAEsLmpmw/NGA657Qw3QklSgETjtELW/YJYK2+WA/C
 jSapHiJujVflSxVS9amcUnu+aroyvqsBhZF2vZe8l2el71Iaz/hO0YkyyskJr8iuacEupL39+x5
 RKFIshpo7CQHWPC7iaGkTXHVH9r6QwgpgUUVDNXtpfI9aTLzjl5LD1eQsdRK6K7XbtlLGH8v8pJ
 pHtGSj0DQmIbbZYbMDTqM0rPbLrvzlMbzWjg12MdPJ1K41XuXV4n61xF/y4inPy0PY4Y7bwN6IQ
 VhF6sIZruVEPVznai/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310088
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
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,arm.com,oss.qualcomm.com,kernel.doghat.io,gmail.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231368-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,doghat.io:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 072A7366E1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit ec494c0260bf57a6fa3aa43a91daf7a774f8bd97.

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

This revert is targeted for v6.6 stable kernel.

 drivers/pci/pci-driver.c |  8 --------
 drivers/pci/pci.c        | 10 +++++++++-
 drivers/pci/pci.h        |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b7a6d8a28fe9..8c941d6267a5 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1668,14 +1668,6 @@ static int pci_dma_configure(struct device *dev)
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
index d015df77ddff..b82927905968 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1046,7 +1046,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3823,6 +3823,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
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
index dae7b98536f7..3c35aae7431f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -557,7 +557,6 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.51.0


