Return-Path: <stable+bounces-235490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MM/Ex/112mrVAgAu9opvQ
	(envelope-from <stable+bounces-235490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:51:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20F23CEDAE
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884123032CE5
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46115311956;
	Thu,  9 Apr 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fUKWwylB"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B43195FC
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760554; cv=none; b=DHZ1HSyvbeSNhIdG+cO4PKkWJ6Cf4pAwI/DOSlo42sUHpnPlBTj7IfyDF3zeWaOJs3+gs8h7R0GM8xzTA03TF0gJ613PAln1aaIhNCPVazzyuAuqU54gtBQU5bj3OFZEN74PrxMHk/PueQLpVmGH7loDXqeP55d1GnE63+hnt70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760554; c=relaxed/simple;
	bh=1snxM50mQ3FERkI06h93zUTKXN4DfAB0lfunbOt8dN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJfhUc3/yO8HPp3vLca/72zQJf+n74hZWnaWvypXb34rzTGJEyacSD+iCX9J5Mwqgkoow/LqB/NK6/m+NIbhmC/ZLh3afxRfCNNwy0JGdUOECPw4J1w4DoXDgXB5QkzdyjQGb1L79HZ/f0BE3mkgTNZX+Ox1XwhggQb2S4UKRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fUKWwylB; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2ce102afb0aso1532835eec.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760551; x=1776365351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOiqsKH5apPL4V8NFI4S5DMIPLrVTX5q0gWEgcgQjLU=;
        b=UDKv4PdRq7Xwb0SR9GyemF4FEvYDy8WwOBFWlEvItXliqCAq3Ut0UEYbyOxhCFYC1F
         /2njJEA8PK2W5IVuzyLU5+TYVdjQmWSUi6KhkDz4QZ9T8FFN9Au06zS68RV00pqlxn9h
         YUNVA8iITbTCghJRuaBongD4ouCO5A0zRa2iMSrZZHqLHjWWI9WDc6W9laSoTd7zhbJy
         6E8sGuZR3tV6crl7Gdkc2rxjU33SrVYZj6xDOq1IS+I/nZtR5pjD5oWJ0yYobc7+5w5D
         xaw7NNU4IHBid/ek7UCElHdbVlX+LmfyuF2z7KzNwGvqD8dCaj13FJ1mK+btFDmLLx9z
         8qcA==
X-Forwarded-Encrypted: i=1; AJvYcCVjHbrnpiUUZxKqa/pjr61Y6Z52TywUdp5BpYXUT10Wgpoq/Ls2Y9rURR/sjsYEstUIDqHmYv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOwfmHfd6M68IO98raVV4oOr77qjMH0dvwVvOhAbjeiMBbtKt
	bEDw+HPSw3zkF4i7lymGWQ20yuRbOAtO2CAevhmksJaMgqtKF1UWl8sGTlxX8RyQSuEhi1jAmrN
	dRDI/Wfu13U38qSfJyesCe2+HC7iENIOi/xlDR2BnccreyZ3JnfIiqEPg2gf/jYIUgAErlEEr8P
	y8TYdEJ+KvESbcf9Hmhb9ePCz7Sy3zXPg1g3JrhxC2ILiAo9r4OSsnS2uV1EVMa9rdke/SVN8my
	cA9LaiJ9eU=
X-Gm-Gg: AeBDiesVSXxWCsCq3xTofUTWYu+hIdpG2C8/+CGWR9Kek+/FiGEcVVYKY2HFQVmvXOv
	HsFFdiH7y8gJNVyb6GSIy9Twkm5VYqtW6Q33OxUjfQ6eaMsNC1E4V1ca3YV91fXp8V0ST8RKrqA
	9cr4TzZhr2HhE0E8VsOIUgkFs4YLRotKAEHKBYeW3eIf2bbbJCj9jMCnKEMRlMYtQC5+Ebff4Xi
	CT3SXgOm8LOhSXRh0Ewe5C1yJalziW8U7YyK2YZZj/Yf+FaYoF+xO9F9WC9WV7xGJsjffSOsepR
	N1pGq0NnABoEIZarH3xyogJF52iE1DJimSQ8DuwHGlekC3/Qyn8EFWAMrxqFnXmEwW6Ja9vWOC4
	tqXkGntL7vF7y6vYuuIBuxtPuEjdEE+1g1+nzDoZhrOJ2/7PzKgnPSJEEZ+VFJRVNWSQQX+JzHC
	TwnjJe/+D/vEXrYGqYhXjbp20Inw8M8SuGTeqiynSRo7v1OnYyjri44PDG
X-Received: by 2002:a05:7300:bc10:b0:2c8:1d56:340c with SMTP id 5a478bee46e88-2d58946284amr112769eec.23.1775760551042;
        Thu, 09 Apr 2026 11:49:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2d55e902570sm48907eec.1.2026.04.09.11.49.10
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:49:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so705018a12.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775760548; x=1776365348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOiqsKH5apPL4V8NFI4S5DMIPLrVTX5q0gWEgcgQjLU=;
        b=fUKWwylBUfAG2NDJ9K3uKdmcfgBGA/kZiV1of3oK3CrdGqfq2xCMCsL1iWVGd3hP30
         Na4HnUYazj90VRppNTTeog9lgC1PijFqGWE28DJEjYjxuGVks4wZ7SYdQFuQuk3wRR83
         IKjkHyN/WvROFlhNeRA0sL14ZmyrewwC9hd8E=
X-Forwarded-Encrypted: i=1; AJvYcCX574flSYJUVY/c2eUEu6uJvmPQvUfBDmdqynBBLEfKf5gojNd5Ika4wykbdde6VRwl6AFCvBc=@vger.kernel.org
X-Received: by 2002:a05:6a00:1bcd:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-82f0c1691aamr383542b3a.16.1775760548408;
        Thu, 09 Apr 2026 11:49:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:1bcd:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-82f0c1691aamr383515b3a.16.1775760547884;
        Thu, 09 Apr 2026 11:49:07 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c34f789sm166471b3a.19.2026.04.09.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:49:07 -0700 (PDT)
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
Subject: [PATCH v1] mpt3sas: Limit NVMe request size to 2 MiB
Date: Fri, 10 Apr 2026 00:12:17 +0530
Message-ID: <20260409184217.32992-1-ranjan.kumar@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-235490-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A20F23CEDAE
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
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6ff788557294..b6abc83d8121 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -54,6 +54,7 @@
 #include <linux/interrupt.h>
 #include <linux/raid_class.h>
 #include <linux/unaligned.h>
+#include <linux/sizes.h>
 
 #include "mpt3sas_base.h"
 
@@ -2738,8 +2739,17 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
 				pcie_device->enclosure_level,
 				pcie_device->connector_name);
 
+		/*
+		 * Firmware may report NVMe MDTS from the drive; values above
+		 * what the driver can handle can cause a kernel oops. Cap queue
+		 * I/O in sectors to min(MDTS, 2 MiB - 4096 B).
+		 */
 		if (pcie_device->nvme_mdts)
-			lim->max_hw_sectors = pcie_device->nvme_mdts / 512;
+			lim->max_hw_sectors = min_t(u32,
+					pcie_device->nvme_mdts / 512,
+					(SZ_2M / 512) - 8);
+		else
+			lim->max_hw_sectors = (SZ_2M / 512) - 8;
 
 		pcie_device_put(pcie_device);
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
-- 
2.47.3


