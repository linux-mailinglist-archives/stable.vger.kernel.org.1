Return-Path: <stable+bounces-123884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A032BA5C7C1
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF0516DA4B
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A225EF93;
	Tue, 11 Mar 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eyn1lwb+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7531CAA8F;
	Tue, 11 Mar 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707239; cv=none; b=D9dqfrhqrAlANYV4cCp6aoeACMmRE0i9yBosmJsdYlgqkcAfxKBmFMj8+ekC+cdu4LvFdn5hFtI4d4/xmloJInW+Ykm24KINb1AiqcaDIh3nwGCG/6wB/lFA9McigLtnFqyDgAiUX7JPtoAszlXie/DN8dafCNKxkBJKUx5QlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707239; c=relaxed/simple;
	bh=3Xx/6nNVL39wU6IxSuWPPBQfJ4uL+mwnZW5YmLpe5B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLaXEdwjnwafaIfcalxO2BXQDj5hGPxcbRLyosgqU1TpBNmvKcpntbcRUh19R/64AwNyY3dk6LLGJPyCD8m7UDzChpg3q4suoh+YkbNHznfBGfU2suEmAU/LRqFyYWVCytlWNdY/7jxHgxbYrab92zaJT9r7RxGMLQ0NXdN3uc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eyn1lwb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33ABC4CEE9;
	Tue, 11 Mar 2025 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707239;
	bh=3Xx/6nNVL39wU6IxSuWPPBQfJ4uL+mwnZW5YmLpe5B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyn1lwb+1pUry0uYvEJPgP+z64YWUedd8TEcUSWmOOu0Tv1Not+pHuFj8EQkOQVwe
	 U5rw1nCznJWG9g4awq0ZvoZV/fX2IPgmcfGMGy2bqNKKKe7ckt60b9YqdFu6jxGhpc
	 V0HvWU/L807yTGM6euliBxWAb3ix8vmGlajUZnF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eddie James <eajames@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 322/462] tpm: Use managed allocation for bios event log
Date: Tue, 11 Mar 2025 15:59:48 +0100
Message-ID: <20250311145811.083329817@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit 441b7152729f4a2bdb100135a58625fa0aeb69e4 ]

Since the bios event log is freed in the device release function,
let devres handle the deallocation. This will allow other memory
allocation/mapping functions to be used for the bios event log.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: a3a860bc0fd6 ("tpm: Change to kvalloc() in eventlog/acpi.c")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/eventlog/acpi.c |  5 +++--
 drivers/char/tpm/eventlog/efi.c  | 13 +++++++------
 drivers/char/tpm/eventlog/of.c   |  3 ++-
 drivers/char/tpm/tpm-chip.c      |  1 -
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index cd266021d0103..bd757d836c5cf 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -14,6 +14,7 @@
  * Access to the event log extended by the TCG BIOS of PC platform
  */
 
+#include <linux/device.h>
 #include <linux/seq_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
@@ -135,7 +136,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmalloc(len, GFP_KERNEL);
+	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
@@ -164,7 +165,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	return format;
 
 err:
-	kfree(log->bios_event_log);
+	devm_kfree(&chip->dev, log->bios_event_log);
 	log->bios_event_log = NULL;
 	return ret;
 }
diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index e6cb9d525e30c..4e9d7c2bf32ee 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -6,6 +6,7 @@
  *      Thiebaud Weksteen <tweek@google.com>
  */
 
+#include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/tpm_eventlog.h>
 
@@ -55,7 +56,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
+	log->bios_event_log = devm_kmemdup(&chip->dev, log_tbl->log, log_size, GFP_KERNEL);
 	if (!log->bios_event_log) {
 		ret = -ENOMEM;
 		goto out;
@@ -76,7 +77,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 			     MEMREMAP_WB);
 	if (!final_tbl) {
 		pr_err("Could not map UEFI TPM final log\n");
-		kfree(log->bios_event_log);
+		devm_kfree(&chip->dev, log->bios_event_log);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -91,11 +92,11 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	 * Allocate memory for the 'combined log' where we will append the
 	 * 'final events log' to.
 	 */
-	tmp = krealloc(log->bios_event_log,
-		       log_size + final_events_log_size,
-		       GFP_KERNEL);
+	tmp = devm_krealloc(&chip->dev, log->bios_event_log,
+			    log_size + final_events_log_size,
+			    GFP_KERNEL);
 	if (!tmp) {
-		kfree(log->bios_event_log);
+		devm_kfree(&chip->dev, log->bios_event_log);
 		ret = -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index a9ce66d09a754..741ab2204b11a 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -10,6 +10,7 @@
  * Read the event log created by the firmware on PPC64
  */
 
+#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/tpm_eventlog.h>
@@ -65,7 +66,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
+	log->bios_event_log = devm_kmemdup(&chip->dev, __va(base), size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ed600473ad7e3..1e4f1a5049a55 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -267,7 +267,6 @@ static void tpm_dev_release(struct device *dev)
 	idr_remove(&dev_nums_idr, chip->dev_num);
 	mutex_unlock(&idr_lock);
 
-	kfree(chip->log.bios_event_log);
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
 	kfree(chip->allocated_banks);
-- 
2.39.5




