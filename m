Return-Path: <stable+bounces-110171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0B5A192AF
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDCD7A1283
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B3284E1C;
	Wed, 22 Jan 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xa8vQRyP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9810E0
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552972; cv=none; b=FfAxrVkyQS8SjuDzsw/EtEkhTRhWJzYsviHT3OzjAeF63nV84JD7xTcFKbPpAoMBb1ZIIgUQ28ufee10k5KlNe4o6YXaQbUtc4SEAbBFmYRltrtmrxbmTg+tId9iiIV5hwQDVNnqK+1iKvKbpscRG9wvzCRazyl55AT8auMHU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552972; c=relaxed/simple;
	bh=2IYadDO2tSTLRjZIcBlqU3xaEaqELXbZPSp+hlgglA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Oy4Fofq4VzMkg/qHg2UUJcWv7heRKjZhTQ/PWN/uuMd3PQxfMkRSr75OEcVZMUCklMUtGZu4bvvdGPzuqSFwJHRaIJ6HeKem/ULOy8ZD0w9ItjuNMlJ2Pt4doDiiT0G0At73IWlIlx+CNesE/dMk3YiNdLtkHl/TSQLvnDeyEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xa8vQRyP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MD8k6k001261
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 13:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=URX8+qaLHaH6gbtuukAc0S+FHF/o
	P3xNIEBudSejUjA=; b=Xa8vQRyPOGzAxFHOL4RHvJhIKM/mGajnbx/erEc84f1L
	lgfS1Nv+tnNfsSghPWeKJ8MzRIwyUw60X3C8gtQsT1/3NbfkqzKVejM3tED7LSUY
	EXRWWcPz7iEUYzIJ0mgGzA8IcwSxWPErw0ouay2fw+XO6PtIj6B0czC7n2EsvFcg
	YRcQTaIDIKRhn305kH6F8S5uuNsWeFNUN6a8s8EWeEKthx6wBgjsvO6WI6A5GVM8
	lWfMqAHAUzF9UfXaeqiit75kUPq4hYfrDmzP4G6ld/FSK6IgzOUH5nTdTs2KVj/6
	SbjbFwRFiB4sD3NnhxMqTENercD4OeeauLYGRpWztA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aduywq8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 13:36:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MABBGC022370
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 13:36:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4k8g8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 13:36:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MDa44m32572158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 13:36:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6B1658053;
	Wed, 22 Jan 2025 13:36:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A33658059;
	Wed, 22 Jan 2025 13:36:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 13:36:02 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 22 Jan 2025 14:36:01 +0100
Subject: [PATCH v3] s390/pci: Fix SR-IOV for PFs initially in standby
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-fix_standby_pf-v3-1-63cd58a114e6@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAED0kGcC/2XM0QqDIBTG8VcJr2d4dCXtau8xRmgel7BVaJMie
 vdZMBjt8n84328hAb3DQC7ZQjxGF1zfpRCnjDSt6h5InUlNOOMFAyipdVMdRtUZPdeDpQimAFG
 dsdKCpNHgMX3s4O2eunVh7P28+xG265eSRyoCBWqlMSClZbwR16fr3lPu9Ctv+hfZuMh/CM7+C
 J6IsgDFjQSLSh+JdV0/2waHMfMAAAA=
X-Change-ID: 20250116-fix_standby_pf-e1d51394e9b3
To: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        Niklas Schnelle <schnelle@linux.ibm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ilCWMO4W1MIi_gBIkYSI1dUp_xAJgXbv
X-Proofpoint-GUID: ilCWMO4W1MIi_gBIkYSI1dUp_xAJgXbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220100

Since commit 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs") PFs
which are not initially configured but in standby are considered
isolated. That is they create only a single function PCI domain. Due to
the PCI domains being created on discovery, this means that even if they
are configured later on, sibling PFs and their child VFs will not be
added to their PCI domain breaking SR-IOV expectations.

The reason the referenced commit ignored standby PFs for the creation of
multi-function PCI subhierarchies, was to work around a PCI domain
renumbering scenario on reboot. The renumbering would occur after
removing a previously in standby PF, whose domain number is used for its
configured sibling PFs and their child VFs, but which itself remained in
standby. When this is followed by a reboot, the sibling PF is used
instead to determine the PCI domain number of it and its child VFs.

In principle it is not possible to know which standby PFs will be
configured later and which may be removed. The PCI domain and root bus
are pre-requisites for hotplug slots so the decision of which functions
belong to which domain can not be postponed. With the renumbering
occurring only in rare circumstances and being generally benign, accept
it as an oddity and fix SR-IOV for initially standby PFs simply by
allowing them to create PCI domains.

Cc: stable@vger.kernel.org
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Fixes: 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v3:
- Add R-b from Gerd
- Add Cc: stable…
- Add commas (Sandy)

Changes in v2:
- Reword commit message
---
 arch/s390/pci/pci_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index d5ace00d10f04285f899284481f1e426187d4ff4..857afbc4828f0c677f88cc80dd4a5fff104a615a 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -171,7 +171,6 @@ void zpci_bus_scan_busses(void)
 static bool zpci_bus_is_multifunction_root(struct zpci_dev *zdev)
 {
 	return !s390_pci_no_rid && zdev->rid_available &&
-		zpci_is_device_configured(zdev) &&
 		!zdev->vfn;
 }
 

---
base-commit: 6b7afe1a2b6905e42fe45bd7015f20baa856e28e
change-id: 20250116-fix_standby_pf-e1d51394e9b3

Best regards,
-- 
Niklas Schnelle


