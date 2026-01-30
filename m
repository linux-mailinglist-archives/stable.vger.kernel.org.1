Return-Path: <stable+bounces-212894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJXYILXkfGkwPQIAu9opvQ
	(envelope-from <stable+bounces-212894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:04:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC6BCCCF
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD3D2304E329
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB03563F9;
	Fri, 30 Jan 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="m27aXN2m"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E83570A6
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792422; cv=none; b=Jj7bL19W2wBgjtvFkVt+/H7QwNRSF+B8c/t2M5VDX4pGrFwmCkFZcDNqjeek5jOFtG6UZUsI4Eq2oeGinFeu6s43jbLjxSTlVEF+4X3ZS88FzQHxAopADtduIthdH8dOUYfo/FyKkIh6MrKH3XJUuxG+ily+tPBt22FNmfrdgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792422; c=relaxed/simple;
	bh=JyBRMQSQuxvl3z8pwOXAeqgUK9hw9MiYTK2ahHd4AHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CApPXydGf3ZBLZjlmjdUHYcSalTiUSiB3Is2Wne8q4zQHGezoIpFneL1hQc9RaE1dfKCf9P05ys8ueggsg9Cc8uCml6JJ+fmNjPFYuqSPc568B/HfxjGx43EACUhcdVyhi/0rMkZnK4DmKnDCfD1UgxaQo5ko4CSoAnOmDVY9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=m27aXN2m; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60UD9DlY3839412
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 09:00:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Mm+xOkZ24YFd5RjWStEPyEiVdlh2cY8+P++RYXeeNlA=; b=m27aXN2mAG+e
	ez4zm7jZzRaxhytqzIvPVQpZw8dSPXOVVwYRJUoVs0x/Ts7AiNo7i+Kh+nS/e61l
	8GKDxve7wHyt8jNCp82wGUbAAQtYCclS4a5cnBbFOmbfcX5foxShfeqytUpw2p48
	RnoiB+kw+m835G+uXtPlYWcX8NaCeJfmEKFPr4aYKB6M86bFeWfAZJELtzSbts1D
	ompmX06B9I4d6pnh/wEAWPPY3U2nOhhGeIi7IwnZrxQOUBpr8ucpa6kvpFOhGtD6
	mNtu0GXHLmPM8V18a/spDpXkmZM8kRFquJeFxnTEVodqPWryyVcFczJKT0K7LmXN
	kwuO+nfnyQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c0w9ctd2d-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 09:00:19 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 30 Jan 2026 17:00:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 84E026EAF1B1; Fri, 30 Jan 2026 09:00:04 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        <stable@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/4] PCI: Fix incorrect unlocking in pci_slot_trylock()
Date: Fri, 30 Jan 2026 08:59:50 -0800
Message-ID: <20260130165953.751063-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130165953.751063-1-kbusch@meta.com>
References: <20260130165953.751063-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3AafLVpN0_WiOFTuc2CacYlgS_uHNMAw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOSBTYWx0ZWRfX3s57mQA43bkx
 zy0M6vmSpzv0zRJhqNMGdHgtSfmI8MdzJU3sXo+q2I+cTELX6Lw4djcfwqXG+8abt4AYtwzdn9G
 OpV6XxKOiNw4AxF/VRZpD1nMRL9nKldt1fhrqvS1C6mLIqQeWojiF0c/0Y+LLHQWqxfZcVW6tHd
 KniY+GnKTcw1EA6euTn2k5y02/t/Dx4FOrq/REHBivMbT5aFF1CKIqANg6i8S2W08uxolcIQ/eH
 bz+rjMWKlMQxETWHUeBsbXpKGuxY9KeC9uKx4pNh3e/Y5EfHznQLmK6mhIPNDmwpDL3/mXAfObD
 HnFKxX9PgkOhLjN6m4Rm4pOR8oNCHVt9nbkFg5f/YD/usMArVViwSaMxRBljL8kBJoDcjdmWetu
 rzzMRWg1v0T9k6jgj1/uO1FKjLamD9TpFD1yFUw2BWixeulT+2im3qldv0At+yky4Z5AmNLaDoX
 p1dgayBVGcwKKIZtMwA==
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=697ce3a3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=968KyxNXAAAA:8 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=KowqXwEJNvZSKAjHX7EA:9
X-Proofpoint-GUID: 3AafLVpN0_WiOFTuc2CacYlgS_uHNMAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212894-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kbusch@meta.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 01FC6BCCCF
X-Rspamd-Action: no action

From: Jinhui Guo <guojinhui.liam@bytedance.com>

Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
delegates the bridge device's pci_dev_trylock() to pci_bus_trylock() in
pci_slot_trylock(), but it forgets to remove the corresponding
pci_dev_unlock() when pci_bus_trylock() fails.

Before the commit, the code did:

  if (!pci_dev_trylock(dev)) /* <- lock bridge device */
    goto unlock;
  if (dev->subordinate) {
    if (!pci_bus_trylock(dev->subordinate)) {
      pci_dev_unlock(dev);   /* <- unlock bridge device */
      goto unlock;
    }
  }

After the commit the bridge-device lock is no longer taken, but the
pci_dev_unlock(dev) on the failure path was left in place, leading to
the bug.

This yields one of two errors:
1. A warning that the lock is being unlocked when no one holds it.
2. An incorrect unlock of a lock that belongs to another thread.

Fix it by removing the now-redundant pci_dev_unlock(dev) on the failure
path.

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Cc: stable@vger.kernel.org
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31f..59319e08fca61 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5346,10 +5346,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		if (!dev->slot || dev->slot !=3D slot)
 			continue;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
 		} else if (!pci_dev_trylock(dev))
 			goto unlock;
 	}
--=20
2.47.3


