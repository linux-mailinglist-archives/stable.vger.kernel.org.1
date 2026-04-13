Return-Path: <stable+bounces-237620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CvPG8sx3Wn1aQkAu9opvQ
	(envelope-from <stable+bounces-237620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:11:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB97B3F1D83
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73155302205D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007CF3BF688;
	Mon, 13 Apr 2026 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G5a6PSnZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC2137C105
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103619; cv=none; b=torSnNNxe9Rw7MOkmRaBKff/amzx91wjEwUDAHvdXPhcq+Yu8NbAxZRiua0cJDyox8TAx9GY0nSy4WjLJ9deszqtg0rgi6sxorlYBQi9M9Xvs4zSkcH2HloeC5pjC4T6SpSN8rWZKyBcb6uBKid0bZ5IpTGEL3ISb7Ww7qfFVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103619; c=relaxed/simple;
	bh=VvPCJrCu9g1gV35wvay8Nk4+QLcK6/BTdVZ5dBMrklo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPIwSAxH+mZojV0/+PYQFmBDlvNhOMj2tv0yWfkughlDbx17KOwInkeYygLxQd4z+n3wuvv1LCN1atc9c6EE4NjXRJiinUA8aRwQ4sm51rW2cpVuDC5XMKcJO+9sst63r1tdNyMhavVsTq+pc3EGVD193DUhx0ii5KE9aC1PR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G5a6PSnZ; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-56eee0ba462so3117035e0c.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776103617; x=1776708417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwgfxPI0WEDEHbvM++fZKw+bBfmjMpf8y09VlIGHZCs=;
        b=hqu+LpTIF2d0nRlTbFQ0WHabtN24uD5+ivLQzPgGUiNFxZK6BxFJkCam00UGqaT85P
         0E+gIWWgUpRDf9mVj9pjS/pdnESkMvJ1OPynun6L/5qx+hmozb+WGa3bDargd/Gj4OxY
         lYxMrarXPn2dBi+SZo4aVpPIuDQLcAxaIYgNiz23msJqLbd1EUx6YB7SNkrHldgqU01j
         zR7pfJmazKez2vsIoIAik/3JvLHOuzKDsJaT09EwNnt+iNFFYfcqzt8XcjIUZLLWLXw5
         GZd5mdRODVVgi/XvpPl6HCI8EBzp/pST3rrVDgfx/gIUwMxhcNPSZihFEegSjhtFWPgk
         mp4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+al+V5bPtEtik/XtHvhCTU57pWazblK9Oh0Vfd7/09NtZd/MJl5wX+AtALelB4/iCbylXU+y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0YDjSPAPLnYzMMfppBPK5AtZOnTBV1pDz89XNrrmaglBGqyf
	ScjUwDaEqEIUu/raYPoIoygp8aJ7Krz0WxdQVE+ZvyT1xF3cW5MS9WZURIHFCR0pmgNbyNUHURZ
	adcyX2yMUdB3zLiKVg9QCeVvxNMee1jycN1HIcKut+b5FTnAkuvQOekc10OqGV12Ee071SwGabr
	/NGrMmG4L4THIaHOsa5p97OFgIAIeQOYIhDLtZnAB6GH8KAXOSZ5tzDWXn/wZPCxE40ZaRwYfdm
	bJXWCMrzpM=
X-Gm-Gg: AeBDievU8SOtGtDOGiyfvMSTRU9TxMq2BrKxOjMDHNY5SBX+rzaGw+yegWIiU0bJ0ai
	szEycPp1sYJhKizzh/Hw+QyGQAIbJGc+mB2hlyRUelyTrX82XmUxiWrZ5IpCTdBoVZPTr0LJcTE
	GTAHGeH7etFXrBmvmckW8ob5v5PGgn2mN0tPRle6/a77TNe6pe6pvuYhpywN/F4AF56ZkrwV4/8
	0hHbVn65BIDKt7rf07EFO8KKCPLaf3C1ieMd+M7YV0kpPZpPAtBn0xyqUGwYFY2fnAv5k5GFTfU
	O0rdH8Zu3f0+sw04SafhQkhcDBBfzQEP0S1igbn9z97AgKW0EhrTO4JuyeaKxAcAOW14eAV/rMW
	o19CXwX1OmYKDVFLQhcJ/DRr5SBDEzCuTLGGE1h7VlzulBkBdMflli2OnNBB08G5SJsMDpi26Ty
	aE2EzoDf8UMq+6qEj1MTlPHihLruo8o7THvhWMv+mUrLavFvLBhesr0WXM
X-Received: by 2002:a05:6122:22a:b0:56b:72f6:1b9e with SMTP id 71dfb90a1353d-56f3cb33a00mr4806065e0c.8.1776103617258;
        Mon, 13 Apr 2026 11:06:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56f3b7ffabdsm1045736e0c.1.2026.04.13.11.06.56
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 11:06:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24e9b4d82so38061615ad.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776103616; x=1776708416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwgfxPI0WEDEHbvM++fZKw+bBfmjMpf8y09VlIGHZCs=;
        b=G5a6PSnZ6kiaEcFSr82gajItucgSOANAxJ8jIQNqHe+nwPBEu8gly+ZjEvZAt5ZRVp
         LDIFt1SdMZinzT08AwJ3Bi2xoeUX4lq+WiaqKIJp667Ernt67CkJS9KwdI/E8VqbZoHr
         pu/jvpxu/T+Rlc5lkcR4QfTM182n/rn1D7J1Q=
X-Forwarded-Encrypted: i=1; AFNElJ8LsaJ1FFU4Rs7AeUD3llCj+autrM3rW/yrjEQXriEYpQiDiTiJryCqT41o87ZfuEliYQbOulo=@vger.kernel.org
X-Received: by 2002:a17:903:2acb:b0:2b2:5070:8b with SMTP id d9443c01a7336-2b2d5c54ec4mr110543885ad.1.1776103615987;
        Mon, 13 Apr 2026 11:06:55 -0700 (PDT)
X-Received: by 2002:a17:903:2acb:b0:2b2:5070:8b with SMTP id d9443c01a7336-2b2d5c54ec4mr110543695ad.1.1776103615470;
        Mon, 13 Apr 2026 11:06:55 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45e949464sm52648855ad.24.2026.04.13.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:06:55 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: sathya.prakash@broadcom.com,
	chandrakanth.patil@broadcom.com,
	dlemoal@kernel.org,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	stable@vger.kernel.org,
	Mira Limbeck <m.limbeck@proxmox.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3] mpt3sas: Limit NVMe request size to 2 MiB
Date: Mon, 13 Apr 2026 23:30:03 +0530
Message-ID: <20260413180003.76489-1-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237620-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AB97B3F1D83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The HBA firmware reports NVMe MDTS values based on the underlying drive
capability. However, due to the 4K PRP page size and a limit of
512 entries, the driver supports a maximum I/O transfer size of 2 MiB.

Limit max_hw_sectors to the smaller of the reported MDTS and the
2 MiB driver limit to prevent issuing oversized I/O that may lead
to a kernel oops.

Cc: stable@vger.kernel.org
Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
Reported-by: Mira Limbeck <m.limbeck@proxmox.com>
Closes: https://lore.kernel.org/r/291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b8b84879d4a
Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6ff788557294..44dd439e6f17 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2738,8 +2738,20 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
 				pcie_device->enclosure_level,
 				pcie_device->connector_name);
 
+		/*
+		 * The HBA firmware passes the NVMe drive's MDTS
+		 * (Maximum Data Transfer Size) up to the driver. However,
+		 * the driver hardcodes a 4K page size for the PRP list,
+		 * accommodating at most 512 entries. This strictly limits
+		 * the maximum supported NVMe I/O transfer to 2 MiB.
+		 *
+		 * Cap max_hw_sectors to the smaller of the drive's reported
+		 * MDTS or the 2 MiB driver limit to prevent kernel oopses.
+		 */
+		lim->max_hw_sectors = SZ_2M >> SECTOR_SHIFT;
 		if (pcie_device->nvme_mdts)
-			lim->max_hw_sectors = pcie_device->nvme_mdts / 512;
+			lim->max_hw_sectors = min_t(u32, lim->max_hw_sectors,
+					pcie_device->nvme_mdts >> SECTOR_SHIFT);
 
 		pcie_device_put(pcie_device);
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
-- 
2.47.3


