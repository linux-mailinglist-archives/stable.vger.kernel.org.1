Return-Path: <stable+bounces-231376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEp8NVSZy2mYJQYAu9opvQ
	(envelope-from <stable+bounces-231376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF4367609
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10089304C07E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11E3D47BB;
	Tue, 31 Mar 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA7R6kC0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EA394793
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950647; cv=none; b=rmHztdEllzsBb8TdoCvWgs+sUdmzk0yeZT38OnhugFdHFgS6Eg3FrLw0HPgLHeC9ej+zt6xLCedMvaVN24jAnrOb9OSvrNX30JJdg1IQnvDdKWeMvrL8xo1bg/T05hKzYlGOihzCHCe+C8KwEGDn1I7fi8VNNTxGqe4U4XkbqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950647; c=relaxed/simple;
	bh=cNSpa42mZKBpO6X9VxDXfS83F3gls16Ut2Hgfy/5fhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJ+EhUHOBl0cb9uzrxkj9xMcqq3hhUwjwcB7f6PEGuQf+ap0fS2/9zMzhmbhNx5SbmtZgEpWwJjA6Uy/qOb4ObxkN/U82I9FXL/wMFOoQcUU93C/WvZEJwgxG0wTb/0OoqGXTKerJ881gRABHPM5BOkiDvuHntSaY1/7MevQ0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA7R6kC0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso3847256b3a.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774950645; x=1775555445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GU/F2QI9q8EVNVojnX0CtcCJf9ZvbWREtW+2yWmBDUg=;
        b=FA7R6kC0DsA+hL/8E/9a7DUwlHK7CSsQtw/A0OJFuC/x46PXN10QO9js+M48GKvWNo
         sfNmEcpd7yA6l3462C7kUI1+k1C6qFn4dNRJtL8Pwzv/tvUe9aEcNsSBO3f1vgSipah5
         z17KNGZ0G9slkrsHaShgnF8nvS+wwSLy1HdMDH2K32t/9YFTbd4dv48/S8s/2f5osFLD
         3Zzjy1OVlipMfqPDpxUqMze+R4EbABJ1Wsp5WUV70kpvi4ttOvBsvXi80rphR9Cnw3qh
         D9WaewGIatoouzbliRUaRPnnc0+6a8D4SG+2ImonMBtqU7VgFEV2wpZuwBDOEP/x/mbG
         5Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950645; x=1775555445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU/F2QI9q8EVNVojnX0CtcCJf9ZvbWREtW+2yWmBDUg=;
        b=Fn12ygT71gV16KMhNAlAIa9Jz+6H9LTQmUBc7DWn75RkSh9OfOyHUvL3RQL3RI2bs+
         s+6ScL4l80r6f5O3bD4wMoTUAEZvdDcoGfDuRp8ltLLviTFHhVMecjDiv7AlS2nMz0ZY
         8ynvrGKpFl3rN2+4UZjvko8x3qEoXNygy+fE6VJhixmb7Ox4+dcsFK5JHftB17UvYr+2
         NFQPjErCkwGJJtedrue78ri9i8DRVtjHb60VbxVvoad/N0PPPp+lVVtaB2pJw71F09+3
         ZRv0cjtnj1UavuByADjh9yNVryAuyZ2JwQmy2hW8S4cSN1ZqScmGjYayzJgiDEU47L4n
         B+nw==
X-Forwarded-Encrypted: i=1; AJvYcCU901Ks59fncNggI4U8kmUYQxV+GcSxs54IGDdGele6JuLKEzdxur2r1IwxoC87zyFJXZi0Vno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU3c9c1+nHepvc1LJBMqBxwaV0W0w7cg8mNpUXyif+cDU7OdDg
	obx6VWN3T+LiEvO4wIIzsIqAud4TzEGf33jqRG4rezfi/fqDTPe38dRB
X-Gm-Gg: ATEYQzxLVijdPCkGK2c01RkFl3M+Drb5J8jPFst5CMyAD1GZ13TsNLfAHVxGK/PSCe0
	UcrQd1nLnuyNuvzML65BiKmJXNgwoEh8nES7RL/SfGR4wMRWAllQ76/MkCecjf4fGzv4nlcfU7c
	jVwR7UOajrsg0KAcCsztNWOIvhHtuhH+qQf4xT4K5EZ2FMXR4PbDslDhgzU641NqouALJfo+Ljg
	P9oz0a+ahFqD1Mj3cZyNA2jAQsbJybYeWqW4qYdjposaEG2YtFXv8ulFVvzGqlYhNzEiJQd7yV1
	va43SIITRB07L2lvWwHgPLjOMEdmJPsXJmywsne7JlbPo6jUs0Ogna5uQH3UxmQnqp0h9CAS3T4
	GU22H8qs7fKJxMEELp8n534yBnoYW2YNidQCBDeGTdIF5Q35/uXFTbuQ0yZJKsbDO3HZ3TG2stA
	il+jO/GVH3K9GZPwUElvw2A+32orjmls6fJhssv3UE8A==
X-Received: by 2002:a05:6a00:4c9c:b0:82a:7f6b:3fa1 with SMTP id d2e1a72fcca58-82c95ed4602mr15144187b3a.33.1774950645507;
        Tue, 31 Mar 2026 02:50:45 -0700 (PDT)
Received: from f7eceb44c2db ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc6e9sm11279771b3a.46.2026.03.31.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:50:44 -0700 (PDT)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org,
	pratyush@kernel.org
Cc: hd@os-cillation.de,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	sanjaikumar.vs@dicortech.com,
	sanjaikumarvs@gmail.com,
	stable@vger.kernel.org,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: [PATCH v5] mtd: spi-nor: Fix SST AAI write mode opcode handling
Date: Tue, 31 Mar 2026 09:50:26 +0000
Message-ID: <20260331095026.38-1-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231376-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[os-cillation.de,vger.kernel.org,lists.infradead.org,bootlin.com,nod.at,dicortech.com,gmail.com,linaro.org,ti.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dicortech.com:email]
X-Rspamd-Queue-Id: 4DAF4367609
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

When the SPI controller lacks direct mapping support, the fallback path
in spi_nor_spimem_write_data() uses nor->write_proto based operation
template. However, this template uses the standard page program opcode
set during probe, not the AAI opcode required for SST flash.

Additionally, controllers that do support direct mapping will also use
the wrong opcode since the dirmap template is created at probe time
with the standard page program opcode.

Fix this by:
1. Checking the nodirmap flag in spi_nor_spimem_write_data() to ensure
   the code falls through to spi_nor_spimem_exec_op() path which builds
   the operation at runtime with the correct program_opcode.
2. Setting nodirmap=true for SST AAI devices in sst_nor_late_init() to
   disable dirmap and force the runtime opcode path.

This only affects SST devices with SST_WRITE flag. Other SST devices
that use standard page program can still benefit from dirmap.

Fixes: df5c21002cf4 ("mtd: spi-nor: use spi-mem dirmap API")
Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
Changes since v4:
- Disable dirmap for SST AAI devices in sst_nor_late_init() to fix
  the case when controller supports direct mapping (Pratyush)
- Updated commit message and subject to reflect the broader fix

Note: Patch 1/2 from v4 series is already in spi-nor/next.

I don't have hardware to test the new sst.c change. Hendrik, could you
please verify this on your SST25VF032B setup?

 drivers/mtd/spi-nor/core.c |  2 +-
 drivers/mtd/spi-nor/sst.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e6c1fda61f57..2e4b167cab57 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -281,7 +281,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
-	if (nor->dirmap.wdesc) {
+	if (nor->dirmap.wdesc && !nor->dirmap.wdesc->nodirmap) {
 		nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
 					      op.data.nbytes, op.data.buf.out);
 	} else {
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index db02c14ba16f..cd2f04830a6b 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -267,8 +267,16 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 static int sst_nor_late_init(struct spi_nor *nor)
 {
-	if (nor->info->mfr_flags & SST_WRITE)
+	if (nor->info->mfr_flags & SST_WRITE) {
 		nor->mtd._write = sst_nor_write;
+		/*
+		 * AAI mode requires dynamic opcode changes (BP vs AAI_WP).
+		 * Disable dirmap to ensure spi_nor_spimem_exec_op() uses
+		 * the runtime opcode instead of the dirmap template.
+		 */
+		if (nor->dirmap.wdesc)
+			nor->dirmap.wdesc->nodirmap = true;
+	}
 
 	return 0;
 }
-- 
2.43.0


