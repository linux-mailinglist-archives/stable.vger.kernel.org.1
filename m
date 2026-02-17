Return-Path: <stable+bounces-216872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFEONnuxlGlbGgIAu9opvQ
	(envelope-from <stable+bounces-216872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:20:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE214F012
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A53A63036D46
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC483563F8;
	Tue, 17 Feb 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C4nF6Yaq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49D28CF4A
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352405; cv=none; b=TIg77PB62RBhoKVD9Kyq2kPAaHSuYHznz1sQ1OKeG/ROkRe0Bz1AHsO90o7ebPkUr1mzs0HJwqAc/tZOKgltO4c2tt9YpfgzuFa8tZxRHNmAVeQtqsppsZyTadhM499TNws7x0OoLOvfchsU2OxhZdzHfpAVxCOxsvb1Pa8JL4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352405; c=relaxed/simple;
	bh=OMenyl2shprXZ1KZp0pp5nevMGrtDA6idAvbhwf4lD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkebwzxIpyYnhDv6WZvUskI7DpIREiZE1D44j+HBcY1UxqM/x803AVU/cSEnGmcyoY2FS/hL8Ru3fhBjonJr8zi+WoDUTLjW3sxizbnBm5Tpx0N/3huXJ/aWgRsvvvPIQol9pV9rVP6hwQ5oIg68ljPHkD0eMjIH4woWexZqFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C4nF6Yaq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HDhjSP2003965
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y9dIYD3p1KrhhEB7Z
	Jvf13N19iuQOY65AOMMOz8Qerg=; b=C4nF6YaqpP70C8EwWCB6J8Dr/LuyoNUiR
	S7l6zYruidTgtHeNdn0jUpSB9xsJBnR3ukmhfhwtGan/lppGziM7T0BfEM5hyJFj
	WIk6z0qT0/bCQHySQY9+Ssd15I/WApBUkZgAm6PuOe8RyQ7iVYzRalddyheJRP/+
	5l0Q3+fQexNKjJPlQWrhShpgZFNrwRTf2epINUcI7l/lnbIGOsJoRk6OWgAbAEuJ
	mpvDqw6i9hPvmOXS4bR505vM1Z+ECJDSNy1G5/F7WXEX4Fs34enG1oRffktWvtxq
	+bgWnaFAZDIhlw0HcymPNsQ97ZCMqYQxXw3B/zoZZ9RuA8foKQwSQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj644q1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFwnOv015846
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45435h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:01 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIK0Vi27198146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:20:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9093658064;
	Tue, 17 Feb 2026 18:20:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F905805E;
	Tue, 17 Feb 2026 18:20:00 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.249])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 18:20:00 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: alifm@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH v9 1/9] PCI: Allow per function PCI slots
Date: Tue, 17 Feb 2026 10:19:51 -0800
Message-ID: <20260217181959.1536-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217181959.1536-1-alifm@linux.ibm.com>
References: <20260217181959.1536-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mPwnqIJD1LxjNsx3_cYYISYqxgKUP8-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX32yxxX0RZCy3
 Ms8y+2ghk7nBXYFgOQDAJ88/hz6DxORyi030x4F+kD1b+iAAkRYA0b4JSOKmjGHNZKpaH4BDROc
 CRXNiVqDeaqnLJGXoMuKxJc3lyFCjFXghwO5x9XONIBU5ti3WiVqs9WSR8tDrgNcTuINqvxbf4I
 pIp7/agFYCaQ78pwVpQqYWL6DDp4lyk8smMy6f/2KYESneUxsIEGVk2XpamEtdvCVena2LDPwpn
 7Kxs0+fuJCO9LU/tO2w24CSbKc2885KdNQJ2FwWG8B9AA/s/U04gsuTmWypN88xlmq0srvSQSrK
 TePesOeOdaVD0GaHkP24kJBU0z+AKzykft08MMy30qypP+Co0tIyMkdenuuEWdyafZa+071a3j3
 47evedRtcGAXUnP63fG0aPalZ/51XdJkWvyhzMdA0MDYnvqCfetI9nlEOOo0bib8gGUq1ik4ZJX
 U7kNbRIr4FuX2zoAzTA==
X-Proofpoint-GUID: mPwnqIJD1LxjNsx3_cYYISYqxgKUP8-U
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6994b152 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Oaqo05sdQjFGKWlA34QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216872-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 39CE214F012
X-Rspamd-Action: no action

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
index f3244630bfd0..3090c727b76f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4869,8 +4869,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 
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
index 1c270f1d5123..a9975d0e104f 100644
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


