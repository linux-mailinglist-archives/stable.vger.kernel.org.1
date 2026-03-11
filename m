Return-Path: <stable+bounces-224731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBcTN/aksWn4EAAAu9opvQ
	(envelope-from <stable+bounces-224731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:23:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4786C267F69
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF0B311C7F3
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0BC30BB9B;
	Wed, 11 Mar 2026 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mb4G1kUp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D583009DA
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249471; cv=none; b=oqFjVymfy+1Pl521r6U3k7L5WCHk3QLXuP/WFJZ3XyX6SXp0+jUEhyoWuSJrgK/yQKvQFqRuXb9wz3acNkyiqoeNyCPZMx6qJyZO9Ov3NviTievfTvLYPCWt0KAiZ6nUyYgRJN5lu2VlYtMml9CDTe+DyrKnbktCMuLHXnniwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249471; c=relaxed/simple;
	bh=9JT882A4qmgPgn36of6y81H/ZfvLd8ev3IqBQ6pxXhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u6xF2lECCbBkkerI0u2gKeU/JttOsI3xYQwvML7/29QVFEwtWyFmRxE8+79KN2CAKWJE7d8l1od5caRAmQn+eMgQTYTLFLrGS9PX9ilzZz+UdsGbc0NwZFlMg0sMNHmpeVSiaddcYcr676g/KBsFXnOwXE7MebBOtf7VCA3+V1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mb4G1kUp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BHHQU23507925;
	Wed, 11 Mar 2026 17:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=xiLvSsmycUJmvubv
	pGei0JnUEGAgFu3QY8tCh90lqGk=; b=Mb4G1kUpql3GqCJzYIIC92LhzFFufvZs
	f9BhIYSmy75SV7SmwipZW4lRrCWVZAu3CHdKfO28R+EIPzZTftBS/Cw7NGrhK1VL
	H8z4F+Sp4jXCoaqTz/Vn3YP617b8ph6mtuPVjRkpPzNHoA5hRNooofNFNQm31Pv/
	eOe4VTqeZYnqJ1GgEAFc8m/UqHDUpo/1RG5Cfa5LXL7WqAVAe77jTYiKljVHcw5S
	p1hNUrTvr5DPGxWr+uJqGZECeN8Iv+WlasHZU6xgCnyBABjZM/G5vhqc1zTkCVW1
	q+r8W1wdNLcxBWEwW7+YHZxlk44t9LE4Hu0esGF8RC5NCyBMCodiGA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu58x0utp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 17:17:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BG9C79020396;
	Wed, 11 Mar 2026 17:17:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4craffv4ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 17:17:43 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62BHDJFd034049;
	Wed, 11 Mar 2026 17:17:42 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4craffv4kd-1;
	Wed, 11 Mar 2026 17:17:42 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH 5.15.y] PCI/ACPI: Restrict program_hpx_type2() to AER bits
Date: Wed, 11 Mar 2026 18:17:36 +0100
Message-ID: <20260311171736.343422-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE0NiBTYWx0ZWRfX8zI0MDevJ7Cy
 lnzd0QGeK03M1LkXkBgBWQnSBM2cPkRCAtmNlkzwklHB586hP03IkD90wyD84S08WkKgNLnPVo6
 u/ag7Q4fC2BthpvCoanG7m43a4GsRO7/iPZK0Os/1aj+3qxnzNL6dhGa7LTsbkrVVn8fSslhcl2
 KwR4WclVbDp37i1TYsQejgeckTa95ryGGkqTVZhXpStpz2+tJL/noJYS+kS74mmP1tJCUiP6CfT
 teCzN8cfS82eZ+gXZxxGs5/FmUbiPoAaPX5MLtZ6C5/W0fc3IB0sfY4GQhsB6iro+wiRgt5haUF
 3RVFchdFPHUEhzH1u0dj6KmBG4Na0YK+rPTaCRopu+LYTVmbcjwyVppRH1Na2JdkZf2zQqkih/d
 t9lMVtpHnt8CYzr3ZR5lrwzfX+rhTIMM5/kQEgdR3R/ei+AlzoQAJj6lukheDosDzcYCfzLwa8/
 HiqHisthGHN16P6nnA8iXpLUKxJl+J6RDywybj+A=
X-Authority-Analysis: v=2.4 cv=f+RFxeyM c=1 sm=1 tr=0 ts=69b1a3b7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=bC-a23v3AAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=SsKr03gcbRYbsVN0MpsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf
 awl=host:12270
X-Proofpoint-GUID: BLbeiIf-chvvmb6uaiFiIEVKm7EFbdG7
X-Proofpoint-ORIG-GUID: BLbeiIf-chvvmb6uaiFiIEVKm7EFbdG7
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224731-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,msgid.link:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4786C267F69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 9abf79c8d7b40db0e5a34aa8c744ea60ff9a3fcf upstream.

Previously program_hpx_type2() applied PCIe settings unconditionally,
which could incorrectly change bits like Extended Tag Field Enable and
Enable Relaxed Ordering.

When _HPX was added to ACPI r3.0, the intent of the PCIe Setting
Record (Type 2) in sec 6.2.7.3 was to configure AER registers when the
OS does not own the AER Capability:

  The PCI Express setting record contains ... [the AER] Uncorrectable
  Error Mask, Uncorrectable Error Severity, Correctable Error Mask
  ... to be used when configuring registers in the Advanced Error
  Reporting Extended Capability Structure ...

  OSPM [1] will only evaluate _HPX with Setting Record – Type 2 if
  OSPM is not controlling the PCI Express Advanced Error Reporting
  capability.

ACPI r3.0b, sec 6.2.7.3, added more AER registers, including registers
in the PCIe Capability with AER-related bits, and the restriction that
the OS use this only when it owns PCIe native hotplug:

  ... when configuring PCI Express registers in the Advanced Error
  Reporting Extended Capability Structure *or PCI Express Capability
  Structure* ...

  An OS that has assumed ownership of native hot plug but does not
  ... have ownership of the AER register set must use ... the Type 2
  record to program the AER registers ...

  However, since the Type 2 record also includes register bits that
  have functions other than AER, the OS must ignore values ... that
  are not applicable.

Restrict program_hpx_type2() to only the intended purpose:

  - Apply settings only when OS owns PCIe native hotplug but not AER,

  - Only touch the AER-related bits (Error Reporting Enables) in Device
    Control

  - Don't touch Link Control at all, since nothing there seems AER-related,
    but log _HPX settings for debugging purposes

Note that Read Completion Boundary is now configured elsewhere, since it is
unrelated to _HPX.

[1] Operating System-directed configuration and Power Management

Fixes: 40abb96c51bb ("[PATCH] pciehp: Fix programming hotplug parameters")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260129175237.727059-3-haakon.bugge@oracle.com
[ Conflict in drivers/pci.h because the context has changed. ]
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/pci/pci-acpi.c | 59 +++++++++++++++++-------------------------
 drivers/pci/pci.h      |  3 +++
 drivers/pci/pcie/aer.c |  3 ---
 3 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 268ca998443af..5e86038f2ea5f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -245,21 +245,6 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
-static bool pcie_root_rcb_set(struct pci_dev *dev)
-{
-	struct pci_dev *rp = pcie_find_root_port(dev);
-	u16 lnkctl;
-
-	if (!rp)
-		return false;
-
-	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
-	if (lnkctl & PCI_EXP_LNKCTL_RCB)
-		return true;
-
-	return false;
-}
-
 /* _HPX PCI Express Setting Record (Type 2) */
 struct hpx_type2 {
 	u32 revision;
@@ -285,6 +270,7 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 {
 	int pos;
 	u32 reg32;
+	const struct pci_host_bridge *host;
 
 	if (!hpx)
 		return;
@@ -292,6 +278,15 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 	if (!pci_is_pcie(dev))
 		return;
 
+	host = pci_find_host_bridge(dev->bus);
+
+	/*
+	 * Only do the _HPX Type 2 programming if OS owns PCIe native
+	 * hotplug but not AER.
+	 */
+	if (!host->native_pcie_hotplug || host->native_aer)
+		return;
+
 	if (hpx->revision > 1) {
 		pci_warn(dev, "PCIe settings rev %d not supported\n",
 			 hpx->revision);
@@ -299,33 +294,27 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 	}
 
 	/*
-	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
-	 * those to make sure they're consistent with the rest of the
-	 * platform.
+	 * We only allow _HPX to program DEVCTL bits related to AER, namely
+	 * PCI_EXP_DEVCTL_CERE, PCI_EXP_DEVCTL_NFERE, PCI_EXP_DEVCTL_FERE,
+	 * and PCI_EXP_DEVCTL_URRE.
+	 *
+	 * The rest of DEVCTL is managed by the OS to make sure it's
+	 * consistent with the rest of the platform.
 	 */
-	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ;
-	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ);
+	hpx->pci_exp_devctl_and |= ~PCI_EXP_AER_FLAGS;
+	hpx->pci_exp_devctl_or &= PCI_EXP_AER_FLAGS;
 
 	/* Initialize Device Control Register */
 	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 			~hpx->pci_exp_devctl_and, hpx->pci_exp_devctl_or);
 
-	/* Initialize Link Control Register */
+	/* Log if _HPX attempts to modify Link Control Register */
 	if (pcie_cap_has_lnkctl(dev)) {
-
-		/*
-		 * If the Root Port supports Read Completion Boundary of
-		 * 128, set RCB to 128.  Otherwise, clear it.
-		 */
-		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
-		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
-		if (pcie_root_rcb_set(dev))
-			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
-
-		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
+		if (hpx->pci_exp_lnkctl_and != 0xffff ||
+		    hpx->pci_exp_lnkctl_or != 0)
+			pci_info(dev, "_HPX attempts Link Control setting (AND %#06x OR %#06x)\n",
+				 hpx->pci_exp_lnkctl_and,
+				 hpx->pci_exp_lnkctl_or);
 	}
 
 	/* Find Advanced Error Reporting Enhanced Capability */
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d9d7a79e3563e..e1614c8dc04bb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -11,6 +11,9 @@
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
+#define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
+				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a8bec1c3c769a..9b86df5b82359 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -214,9 +214,6 @@ void pcie_ecrc_get_policy(char *str)
 }
 #endif	/* CONFIG_PCIE_ECRC */
 
-#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
-				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
-
 int pcie_aer_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-- 
2.43.5


