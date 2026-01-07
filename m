Return-Path: <stable+bounces-206196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC23DCFF75F
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 19:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E05CE300DBA7
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CAD33AD9E;
	Wed,  7 Jan 2026 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fho8rUMp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2933CE91
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810667; cv=none; b=ZalNSkrjA4lYn8uWqh3llRyhXZYUe66ebYfFh7ibPA5WfCg46xjFJpF1stXmxf+Hi6v4b3gamywtXxCgnBXD0k8bQC90U1AHhlon/w+4dN2hDvHNfY+WgSL1AM4S/8l0p5blNqIaTnPHsZMCNfBT3KoxKo51za25OGomGsnKBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810667; c=relaxed/simple;
	bh=eMeNFqR5Pctg3QbjgJQqiWaDgf3J7qEyQtRFeVHzVD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4wFFDuPUBoQkSNXSyZYmATegUHWS0LgMvjkgtmDe6KYlpvq0Xk/bpytxcLHGmn/Pib1uj1vbYqrpX++ClS3qyHJqHUEypT7ldJD0DbEavAh0oyoLOcki8X1OowybxMnEI2yidu/PsIKOFOyWP9uTZVgZ2kjcARDmGe+vGB5tnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fho8rUMp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6079FHXg021887
	for <stable@vger.kernel.org>; Wed, 7 Jan 2026 18:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VWfyabzJPuGaEH0aY
	uPp8WCVg/+g9O0m7WdK+9+/FrQ=; b=fho8rUMpfOYZOUSBDGvnbZM/QFQVcV4Y4
	GvscwtnaU545AaxBZofEsPTJDDw9+4Y3JUkGVAUly/jKQYQB8evNvnaBcsGAVHjr
	GcCriVmyWsdq7X/M/O2lCItIDskPdFsBnPCmlrAdtrIBGSn9Pa8TGuDZzbwrA/jR
	E42xZLKxZfu+JgoMkGFlJ6r9oEg33YAars/zp0o/JoFr63S+14uutfqpJkS0PGLl
	xDIJ/ruVnN7cqtZ05AiwUn9Z3Z1vF2lbk486mk1tB2OOj7stlcqsAKSB6PrKCJhE
	Wz8UxR5/7coy35iZGeXj9t0rwcKP3fUtwT1SgdXKbuml15k8Hp/Bg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6amq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 07 Jan 2026 18:30:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607H1Avw015202
	for <stable@vger.kernel.org>; Wed, 7 Jan 2026 18:30:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdesjvyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 07 Jan 2026 18:30:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607IUrgL51970408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 18:30:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158F05805D;
	Wed,  7 Jan 2026 18:30:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5C6258052;
	Wed,  7 Jan 2026 18:30:52 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.168])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 18:30:52 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: alifm@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH v7 1/9] PCI: Allow per function PCI slots
Date: Wed,  7 Jan 2026 10:30:43 -0800
Message-ID: <20260107183052.1333-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107183052.1333-1-alifm@linux.ibm.com>
References: <20260107183052.1333-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695ea65f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Oaqo05sdQjFGKWlA34QA:9
X-Proofpoint-ORIG-GUID: k6GeW5UOUv5JDYoyObwgZAKSqCQU-zTo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfXzhT5XwSAHR+1
 fb22mBDW//b+sFdN7sHQBFlnhasiQ0aO5L7mZE3CAS5TLZOs/1CqJqd2e/2bRnzmHEKsAeorVaI
 8+T2Awp7uhQot//nUOXY53AF9uFqvh/gF4q3S3x5i1ho5QDqGCqw0Bm3ST0uECSuVWRL3cWz/Lz
 KtsqmR0/DzQCPlR4O4yFvu7HV5j5y9q1TsCckHWnsGrZfLB+XtIW/wEKWl3cij0aJqFhjS3KcEB
 d/MrHBpPWP2l4ncaFl1GZyxlGBBVZX3LqHpv6yDrIagWPFfpEzprzdv3h0GibXL41hLxbR+pZSi
 SG/P2GhdX4kUNO2w6hGZLsZbi1EL6K1P5rtDeCoLvmtp+TxL3i4b7AHfyLaReB3dPBrviTGY/wS
 3q06qOcJ/vITOaRs01SO3J6O4ytIZZsEc/iOUTpClIQJzMv+NHUIGqi1yLCm6xSrrTEJm9/0G2X
 ddy0WJYKEJjmY2xJ40g==
X-Proofpoint-GUID: k6GeW5UOUv5JDYoyObwgZAKSqCQU-zTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070145

On s390 systems, which use a machine level hypervisor, PCI devices are
always accessed through a form of PCI pass-through which fundamentally
operates on a per PCI function granularity. This is also reflected in the
s390 PCI hotplug driver which creates hotplug slots for individual PCI
functions. Its reset_slot() function, which is a wrapper for
zpci_hot_reset_device(), thus also resets individual functions.

Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
to multifunction devices. This approach worked fine on s390 systems that
only exposed virtual functions as individual PCI domains to the operating
system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
s390 supports exposing the topology of multifunction PCI devices by
grouping them in a shared PCI domain. When attempting to reset a function
through the hotplug driver, the shared slot assignment causes the wrong
function to be reset instead of the intended one. It also leaks memory as
we do create a pci_slot object for the function, but don't correctly free
it in pci_slot_release().

Add a flag for struct pci_slot to allow per function PCI slots for
functions managed through a hypervisor, which exposes individual PCI
functions while retaining the topology.

Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
Cc: stable@vger.kernel.org
Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c   |  5 +++--
 drivers/pci/slot.c  | 25 ++++++++++++++++++++++---
 include/linux/pci.h |  1 +
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..c105e285cff8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4832,8 +4832,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 
 static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 {
-	if (dev->multifunction || dev->subordinate || !dev->slot ||
-	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
+	if (dev->subordinate || !dev->slot ||
+	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
+	    (dev->multifunction && !dev->slot->per_func_slot))
 		return -ENOTTY;
 
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 50fb3eb595fe..ed10fa3ae727 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -63,6 +63,22 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
 	return bus_speed_read(slot->bus->cur_bus_speed, buf);
 }
 
+static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *slot)
+{
+	if (slot->per_func_slot)
+		return dev->devfn == slot->number;
+
+	return PCI_SLOT(dev->devfn) == slot->number;
+}
+
+static bool pci_slot_enabled_per_func(void)
+{
+	if (IS_ENABLED(CONFIG_S390))
+		return true;
+
+	return false;
+}
+
 static void pci_slot_release(struct kobject *kobj)
 {
 	struct pci_dev *dev;
@@ -73,7 +89,7 @@ static void pci_slot_release(struct kobject *kobj)
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -166,7 +182,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -265,6 +281,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot->bus = pci_bus_get(parent);
 	slot->number = slot_nr;
 
+	if (pci_slot_enabled_per_func())
+		slot->per_func_slot = 1;
+
 	slot->kobj.kset = pci_slots_kset;
 
 	slot_name = make_slot_name(name);
@@ -285,7 +304,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot_nr)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..08fa57beb7b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -78,6 +78,7 @@ struct pci_slot {
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
 	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
+	unsigned int		per_func_slot:1; /* Allow per function slot */
 	struct kobject		kobj;
 };
 
-- 
2.43.0


