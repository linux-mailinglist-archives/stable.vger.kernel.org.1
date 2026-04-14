Return-Path: <stable+bounces-237800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DynNz0i3mkIoAkAu9opvQ
	(envelope-from <stable+bounces-237800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:17:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DF3F9393
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8004B30570F1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F83D9DB0;
	Tue, 14 Apr 2026 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hbcH5sjM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62342AA9
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165307; cv=none; b=L2LT6WD+8BnuuBR6uFnrhiVUe3bjCDUjWHKey69Lego9Pxa1xUmMkQa8ZVmcGKNbH3z+QhoUHb6d9g3gxeCOsKZDpa2RP0VdBCSo/vVlt2EejgjiXvn9E2KJLHVbx8cAT+3KGw7GGS0D38tIgZLSX7mtZ2Y8xS/ffUQqG0i5KgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165307; c=relaxed/simple;
	bh=iXwYiToNDzVFSYqHR9hmBiK6ONF7EQLGiFPMcdUmh20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aOaURW9v52i5TTchtHQi+dU1JkKBeCfZzgfdD7zzB1vWNqOATKODScsa7Jh+4KrN33sMLj2M7yATgO5UCHBY2zQxKUSx4pC27Rj/QIENJKan8/Wuo02md2yhEMfTs06Y1atarqB6UraS7ELigBFEwV5jkzCJez1AviCQTTAYg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hbcH5sjM; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7d9bba96f7dso2893684a34.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776165305; x=1776770105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBJhofTzUvusJZHQm/kAL1AM7X3RPqZ3DbYLT/nOXsE=;
        b=r8WfmGdFUuI34SJ5QDDxhOLtrLulbJf2cJt2WaCY28xIVwtU/fYZ7cTfMbz3UztaTp
         7tzgpNuODc2Wh5VFPlHHZ5LhBntATFHzdaW+PMdHi+EIlnRBpfqsLu0KwccHHPj+6cKB
         oqMJMCfdOjJYMn5cfFymbsAvORBW4RB2+5jx2o2Dp/BTEi9521ug2OkDzCmPrNqE4wXO
         k36rKYTa02mIt2dvCSgkS3pNxWJWyHOnlsGhAOZv40Yiw1fX4UqI2K/Um2+44o7z91je
         foJ/d+uA/KSbr11IO43lSbo9bscyu+emPUtj+GW5Erq4VxMBJPGS4lK+ffC4SqI8atht
         DJPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RbDXFxH+t98aHnQazKxxTEcAEpZrjiL6uNVDblxStF/CortzFov5sOwQsg5YmtYTAc6VwZAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgCh+YTKGKWg++90NYGEZO1jjzUVjoexMNFeXceRZC4lqZiAD
	fne10+6DiKMWM9QJjqLt62Vz0lR/6HX65xwVJaVdIrEX/WpsECIlpc6vFovgPqA9MdvituJw4zL
	FQp93//dtzhapGLV2ugomAvMsG5OCBI2gfEVpnYKOUOqajM/sYeLVDdVfJpDDIY1+aivfWYHXgn
	MkZy2kbULAp94DNjieQZr9Xehe1SO0P6lUpaPNpYy/iXc4rXkpgxUQcrkVelSDHgQHK2xwSRDbV
	ypzKuSUk1o=
X-Gm-Gg: AeBDietUk4b1/GF6cGAaHonZYe456G1tJuFP6UCyQ8TWMwknNVNC5Rc+rqvkDvtW70a
	AmI0Y1lZI9GWssP035FXAuLM8bS03pKmTsnKhL4ruylGTdr5VWlr+90N4DC68C25LaUxYDHzb69
	90t/0iWsvC1bzZv8mJ2sMgyt9S3wMTSx4wZDqHmyl4wKCxkCpFWrZk2uzypE3QAF6GdI0gOwZHs
	5KkmmFgPl+skXhhNcd5DVjQq0A7Eu3viQVwskG2rFMSnxpTvzhZT3txbFmP9Ebxg6TuPGW9Ag9f
	FJhLPPzXkIfnQy1+m/H79jw0qzyETeanP6jAhTqFUVw4mxqCAbwQxRvaFOvb/MwBHV0sypLKfJz
	PW+tBMPFHhqtmhurvPCYZBvo5MgzRuesaPpuyxbpkRCh3jhslathnveg2NnwXlw9v7QH2gS0E4G
	ZSut3uFn99SOMYw/jLd9KSaMb3AVfdu3udQCAezZFEM5aNjCaycrV3eMbO
X-Received: by 2002:a05:6820:4c14:b0:67f:ac04:6b55 with SMTP id 006d021491bc7-68be5b5ab8dmr8039672eaf.10.1776165305305;
        Tue, 14 Apr 2026 04:15:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-68bca5f8551sm894898eaf.17.2026.04.14.04.15.04
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 04:15:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24a00d12cso56385905ad.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776165303; x=1776770103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBJhofTzUvusJZHQm/kAL1AM7X3RPqZ3DbYLT/nOXsE=;
        b=hbcH5sjMI3mmIYvVY+VS5AkLpZVYzJyYbHdCrQ/VdaRh68eUpMQ95urFeglLG3k4gP
         h0WNr9ztb2oAirpT0wzQBjwzqDNxRedqRqRNyPTat2UmKwDA8I+p2mMpA/TKFNC1nEYI
         b4psyxFt68tuw4gtAepLLJSq78ciPAXk7Kp7E=
X-Forwarded-Encrypted: i=1; AFNElJ/wI028qw9b61o/Zxfg4YTm4MJBF4c8uW2z11PiI6sq/sH7OVUbMB3c+VctOx2oW9BqwAPHvoA=@vger.kernel.org
X-Received: by 2002:a17:903:2acb:b0:2b2:527d:103 with SMTP id d9443c01a7336-2b2d5a5dcc0mr160781295ad.43.1776165302977;
        Tue, 14 Apr 2026 04:15:02 -0700 (PDT)
X-Received: by 2002:a17:903:2acb:b0:2b2:527d:103 with SMTP id d9443c01a7336-2b2d5a5dcc0mr160780975ad.43.1776165302502;
        Tue, 14 Apr 2026 04:15:02 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f39ccbsm179722255ad.77.2026.04.14.04.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:15:01 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: sathya.prakash@broadcom.com,
	chandrakanth.patil@broadcom.com,
	dlemoal@kernel.org,
	david.laight.linux@gmail.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	stable@vger.kernel.org,
	Mira Limbeck <m.limbeck@proxmox.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4] mpt3sas: Limit NVMe request size to 2 MiB
Date: Tue, 14 Apr 2026 16:38:11 +0530
Message-ID: <20260414110811.85156-1-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,vger.kernel.org,proxmox.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237800-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.991];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 445DF3F9393
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The HBA firmware reports NVMe MDTS values based on the underlying drive
capability. However, because the driver allocates a fixed 4K buffer for
the PRP list, accommodating at most 512 entries, the driver supports a
maximum I/O transfer size of 2 MiB.

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
index 6ff788557294..12caffeed3a0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2738,8 +2738,20 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
 				pcie_device->enclosure_level,
 				pcie_device->connector_name);
 
+		/*
+		 * The HBA firmware passes the NVMe drive's MDTS
+		 * (Maximum Data Transfer Size) up to the driver. However,
+		 * the driver hardcodes a 4K buffer size for the PRP list,
+		 * accommodating at most 512 entries. This strictly limits
+		 * the maximum supported NVMe I/O transfer to 2 MiB.
+		 *
+		 * Cap max_hw_sectors to the smaller of the drive's reported
+		 * MDTS or the 2 MiB driver limit to prevent kernel oopses.
+		 */
+		lim->max_hw_sectors = SZ_2M >> SECTOR_SHIFT;
 		if (pcie_device->nvme_mdts)
-			lim->max_hw_sectors = pcie_device->nvme_mdts / 512;
+			lim->max_hw_sectors = min(lim->max_hw_sectors,
+					pcie_device->nvme_mdts >> SECTOR_SHIFT);
 
 		pcie_device_put(pcie_device);
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
-- 
2.47.3


