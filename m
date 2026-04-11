Return-Path: <stable+bounces-235689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMbgBSwB2mkGxwgAu9opvQ
	(envelope-from <stable+bounces-235689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:07:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B63DEE33
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951593023501
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CC2F4A05;
	Sat, 11 Apr 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C+R+jyv5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408E23C8C7
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894821; cv=none; b=IVJV8yDnQ9gNMM+23Vnbmg5U/B7UPe3chxsrygK/AAMRI5YVtEzrcRx+akYf6NzO7M9jlwPTI23/DE6KWFhMQj7t5fOHUavJ/9LJN4k5fKeVrrUZdGhVeM5LFkW3yVaVfvexqeSZXo0LFiPSE1d3xgVxxWyml9YZDszwcn+kTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894821; c=relaxed/simple;
	bh=Ln9AS63EngCFfiuHW4w5QGFza/cqFFBHSsii/NBMjNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=an7aQIB59e4ywqSNerVvpFhghZSDhWLgEZpJH0JFSh+tsfp6eo/skHVdAZQGh3Bulb3sqsz8GS0XhecbHcukzSLxeJg+C9XFGCS8R4ceFMlASyue7w55F3Ck0RJgx3NSkLGKbLrWzbgVSIpxSmVfJuFsx4drYLZosye8ZZpOO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C+R+jyv5; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7dbe437b072so1517315a34.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775894819; x=1776499619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEU7yR5sJCU69J+H+ksKtM1IopDe6eUt21SCj44UVHI=;
        b=rahP0DLd12kAgW9nMpqZ+cIR3Ufo0FxmcBw/2neoPXNByPcw+8yaMeIq+i1JMiL9s2
         8Wl4NMyW6AJwb4T+g29lla3wDNxN6ptxD3TdY5lT/T7Tgycz2mqqylYr804oFoH0XQ88
         F3b0wObOLqsz2dy+ZnPjiLPrLmNMMFNvLlIxYF4hzebinQ5XA/BokVLGnkqPx8ZKXRLM
         duo5uNIYZvHaLvMivdA59ReDMf6ZIMncAUloYDMJ99Yr1VViOE5ImWskvrAGcVV4KDR1
         /pPVIfpJrC9CLb6oTyMtSuua/uNcmmd3kHK8ERWMcGgFFD55hnRWI4+uTJKDjY+HKpnO
         pwOg==
X-Forwarded-Encrypted: i=1; AJvYcCW1iA6jOaSfX3FV5LMWEcVm3KtN3h4RmnR1KDwto+BmZSn0b4WJ6rIXvO3qgd7mBTH6OZUqlqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDc68KSbDj7NjuThE5PpPTbDv6N4P8Z5EEr+4HWPSTqzGV6SyH
	zK3UUTWQEFKT6Dmtq/gyrRbSvDd1sVZCrYfb9FtYOSHcJk31zGFNDL+hGO1O8pmyfLrMb+bKHcP
	mv8BRni+ai4gQBveRv6+aAHt7BWfhpLC/k4iMeQc87/rH5rU2OEZ2IUSTZpVur6E9hQKYH7DcOf
	pveWGT9Y4FAg3aWYawKLsjvMLVK8+zK7YdSpynbn457smWwaAhOuA3Vg6bhGHbxRDPWVNeMrMRY
	VNgLUESGCE=
X-Gm-Gg: AeBDietcHbM5s+GMpasXuD2LpLG9pWeQgYgzlZzPYceulqFlo/IJW0XlVgEjAHYb54F
	35SzzDq0s+zqawaS232PX6QxRSNUnIDBzP5M1FR0S58BgkkOn4bGv/2KgtasLwJrVRHUvZpL1V+
	zuGnNqiZkvvwCsl2gXltWCfBZx3X5NS8R2D7kXBv9inqcBHkRVTGsa/STzkdzHNyhjjkIM0F6hl
	q/SvVKo0Hss6moaXVtdZRfsT5efIvtIg/XvLp/m9reMp0mASENmEeWziaL/lXiYLZABes+BDbEx
	O6pYCEFX0Yl2loHQiM7EY3vQ/R6O93NRC8g32UdgMqgysqsXzQniqX/CX0vzzGXwwyBi6246H3e
	dbIU4+Cywju6IYQVcxg3/zwNVL/wyLuOuzHBW112BkuJpLw51uD8GNXTMMUoCHNgkeI4hgSJMs/
	wEg8xARh91UXbv+TmBEeyJcEPMW1CX/lk4VUc3agLjB74XbrLaqoHacHxf
X-Received: by 2002:a05:6820:2908:b0:689:d8b0:ccd7 with SMTP id 006d021491bc7-68be596a66amr3277458eaf.12.1775894819198;
        Sat, 11 Apr 2026 01:06:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-68bca5f87dbsm403574eaf.16.2026.04.11.01.06.58
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2026 01:06:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so5481144a91.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775894817; x=1776499617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEU7yR5sJCU69J+H+ksKtM1IopDe6eUt21SCj44UVHI=;
        b=C+R+jyv53bglT2KFHhqwTfP9DMbl7XOg9VaHYaa1kZsAKBT5V7okOJ2DEwwRQM31lY
         WKtdF85oAVltDkaIrbadzyTNhRVCdWCNc/Q4i+uCBsPzGjwJ5fi1OqJdA0otTDbQZLNF
         4ENwNYsh/5zQEY85OVGoV/RkEFjt6sQZ53g+I=
X-Forwarded-Encrypted: i=1; AJvYcCWzhG9SBMNZPEqHStB+eS4klmXb6PF6H744eEN8cc1m1Q013+tqPgTCHHg2DWhMn6RVEvkduN0=@vger.kernel.org
X-Received: by 2002:a05:6a00:12e6:b0:824:93df:6d86 with SMTP id d2e1a72fcca58-82f0c2f0ee0mr6626521b3a.50.1775894816774;
        Sat, 11 Apr 2026 01:06:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:12e6:b0:824:93df:6d86 with SMTP id d2e1a72fcca58-82f0c2f0ee0mr6626499b3a.50.1775894816332;
        Sat, 11 Apr 2026 01:06:56 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b2455sm5083972b3a.35.2026.04.11.01.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:06:55 -0700 (PDT)
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
Date: Sat, 11 Apr 2026 13:30:05 +0530
Message-ID: <20260411080006.50010-1-ranjan.kumar@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235689-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: B29B63DEE33
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


