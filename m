Return-Path: <stable+bounces-235690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIibJTEB2mkexwgAu9opvQ
	(envelope-from <stable+bounces-235690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:07:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 085293DEE41
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A98300B073
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988D12E62C6;
	Sat, 11 Apr 2026 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JimXOykA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FB1E1E04
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894825; cv=none; b=bK4W0f4BVUNSGRJkITR+/z5GDc0yK0Q/Jmn5ceCsQ2Wo6vU+0xUGsbrzOp3HLid1D7L5shpmgh2kN7rTEp7boYXDxkw5iTOk+DycCWhs9D4AGvvqX5FC3bePvdTjeunn7dEYyJElrDe1fdTSUM9LYpWA1YRgMvouQHnb/hvMnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894825; c=relaxed/simple;
	bh=Ln9AS63EngCFfiuHW4w5QGFza/cqFFBHSsii/NBMjNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1ujOeID0XrYmBBv31ohxYURlIjzx5DFF5QVoqt/CHuuacwb/Zs6j1DO0tYm7P4+etQAvZySJIxEjjFh2QwEm2cqe1su5kvtbK6+RIoIDbam69IcWSQOTBAL5CGxWWg9B+sLV0IoDA0ofLVyxw45ffxb7Bp0I646rP7kD0A6ufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JimXOykA; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so1802209fac.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775894823; x=1776499623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEU7yR5sJCU69J+H+ksKtM1IopDe6eUt21SCj44UVHI=;
        b=iSimLmZftgWIYaCgHEaW5O7d2Kb/wDGslwqLxpyxLoHprQG36Djhtd8ukw6aeAM8T2
         iNeoOvxu9lnRdQAPrfXAvzvauzXp+T/0eD7jdLp03jVkbI/1vSRA4yRHLT/zWfo8t8Tj
         GJdspp530B0JiLZbiehxmAbV4i6GF7Bqfc2dQGQq5WS3JRQ5AJak5hdiSYc96EVP6Rko
         1A6kO8p87/PBlvuhe18PjMDZ2GhrB03bRAJN/Qr3PcoaC73hUKys/ZiwkMPQCBv4JmDU
         MBa+noFY2esroxgQRw9RN1tGEmmBMt6CMKxER7Jza5hCPfMeOKn0veO5M2VNWQfaUgws
         6DcA==
X-Forwarded-Encrypted: i=1; AJvYcCV5AIxTYnXqXP4SDJHMZyoPx7jWKJhgdufN5BwTeHrFvNHJs2bU6jPYvM9pOXeZ38v8TP+HblU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCikrEHL3diL2P46mhanK1rq9MQR8XTyb9qOTcrJ0uvawQ7hz
	2uiBl0rloAbXdya0ijgZ9H6G5r+a84HradGiBOldnK42p5YjDqIH9qyu0WrlZKFUMxlidNITUoC
	uEvlG/Rx1975gfQEIaRq6vit5OZnee46IqGP2o1QOaxQMPEzMWjqzVCodCpuEpH00C9F4wGhJxf
	tf4ch/EZ6vO7kR4kDvlmZeK0KcNC3Y8F3AsyK0KwBsL0O7RCNkxjtvlrIXi0CvOO+CEt6LswKwy
	pw3HqIDhR8=
X-Gm-Gg: AeBDietZ/81AkF/8LOyQRdkL3ye/QAdnywkcaqaCN7IIirpo8pC3XRHb8c76l3cncLp
	CHmbRpav2VZy01zAwcWi1lUifZ8irIlTuoPOiyY/s1e0gv9ptJ3gLSu4j4qp07RWQKWMlaeszS0
	UhxEB6fkp0tmBdYUsumON4VmqkKnTchMRO5obWrNod5JYE+lptxy4PoYRJGVDNZTaKaRNAmD4Me
	3BZJZoNxsF0L3D/6VF8o0Buu1D9PqZXjolR1wtBZrCd0XLbva182Pr5exjiQE2inziYOnfIX5Cy
	fycAj7+pD9iKsRUR0BKrqFZtZrv6fNpC7u2Wjv5ilpW80WNFq1Eu6EDSWxoxKo0pkzXM2YuCDkJ
	8kwD5gz0AgIo3cT5Vz8MwqK2e2GtcFLs4H9Z/R9hyz4CtjsbER93rYwzDeVeP9rTBix1qZmW4wg
	zcdHFv2Vw3Z73H24RG3VTRRndpbmZ/edAZH3AqNT/BcYFhttxRDPOfXSgk
X-Received: by 2002:a05:6871:430b:b0:417:2b13:f2cd with SMTP id 586e51a60fabf-423e0e16ed8mr3566836fac.10.1775894822847;
        Sat, 11 Apr 2026 01:07:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-423ddb547bfsm617977fac.13.2026.04.11.01.07.01
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2026 01:07:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76b6db8bb2so1933895a12.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775894820; x=1776499620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEU7yR5sJCU69J+H+ksKtM1IopDe6eUt21SCj44UVHI=;
        b=JimXOykAQVTvbm0o90g5o8l29xU1cfORVa2XQ7BHSVjvleBuI7GNZ1UIPToanULC1q
         fw4RTXEwXwU2iZ866l995LKrfv3BHsEIfJS2oIbQm5kVMV4qVfJlcK3uhNu84RQ3vbJB
         50NRaUgqcrzFrk49HzpSw98qIvt9SAvY24GVQ=
X-Forwarded-Encrypted: i=1; AJvYcCX36pn5TgDfLFfbV6DZ1oNJsgStPHkwGM86e9gIaBoE99oPAJWz1hGCix4l+mejcbGXAi6HWLU=@vger.kernel.org
X-Received: by 2002:aa7:9e9a:0:b0:82f:1f49:dfde with SMTP id d2e1a72fcca58-82f1f49e255mr1373907b3a.37.1775894820552;
        Sat, 11 Apr 2026 01:07:00 -0700 (PDT)
X-Received: by 2002:aa7:9e9a:0:b0:82f:1f49:dfde with SMTP id d2e1a72fcca58-82f1f49e255mr1373885b3a.37.1775894820062;
        Sat, 11 Apr 2026 01:07:00 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b2455sm5083972b3a.35.2026.04.11.01.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:06:59 -0700 (PDT)
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
Subject: [PATCH v2] mpt3sas: Limit NVMe request size to 2 MiB
Date: Sat, 11 Apr 2026 13:30:06 +0530
Message-ID: <20260411080006.50010-2-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411080006.50010-1-ranjan.kumar@broadcom.com>
References: <20260411080006.50010-1-ranjan.kumar@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235690-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 085293DEE41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some firmware reports NVMe maximum transfer sizes that follow the drive
capability. When those values are very large, the block layer may build
I/O that this driver cannot handle, which can cause a kernel oops.

When an NVMe device is set up, cap how large a single transfer may be
to the smaller of the firmware-reported limit and roughly two mebibytes
with a small margin. If no valid limit is reported, apply the same
upper bound.

Cc: stable@vger.kernel.org
Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
Reported-by: Mira Limbeck <m.limbeck@proxmox.com>
Closes: https://lore.kernel.org/r/291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b8b84879d4a
Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6ff788557294..fca9d6722fc8 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -54,6 +54,7 @@
 #include <linux/interrupt.h>
 #include <linux/raid_class.h>
 #include <linux/unaligned.h>
+#include <linux/sizes.h>
 
 #include "mpt3sas_base.h"
 
@@ -2737,9 +2738,17 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
 				"connector name( %s)\n", ds,
 				pcie_device->enclosure_level,
 				pcie_device->connector_name);
-
+		/*
+		 * Firmware may report large NVMe MDTS values on some ASICs.
+		 * Limit max_hw_sectors to the smaller of the reported MDTS
+		 * and 2 MiB to avoid issuing I/O the driver cannot handle.
+		 */
 		if (pcie_device->nvme_mdts)
-			lim->max_hw_sectors = pcie_device->nvme_mdts / 512;
+			lim->max_hw_sectors = min_t(u32,
+					pcie_device->nvme_mdts / 512,
+					(SZ_2M / 512));
+		else
+			lim->max_hw_sectors = (SZ_2M / 512);
 
 		pcie_device_put(pcie_device);
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
-- 
2.47.3


