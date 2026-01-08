Return-Path: <stable+bounces-206313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93AD03DE4
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CAFC3055FFC
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D29C41B369;
	Thu,  8 Jan 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="igv9Oceb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7893C199E
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869308; cv=none; b=ExyRIFQSHat6xBfOS4yYCvsfRyXZlg67cptF7e09lt1lt52DFc5F2F3mIr/vXFkPhSkYKER+KxVB23twMRTsumgNHFvarcfkNmJCi/Wxty2no/HA50yw3cXFZEZsE2laLJ8apGDhwRljNWi9zg2g0YrS5/fR8067qoT+FUgfI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869308; c=relaxed/simple;
	bh=QCaPiD8GcxkO3ejFLqiCvTaxrJ6eMdDeYa0LPatXgQo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LaGQy3If/w93NOOut7mtyo7slGyT+lpXuoJktIzAgmR0cCQqcUJKv6t5UetJOwOnsH0YVcfbZfJLcV7ULaCdbtHJmfggS7jM18ek/qPWa3oQiX86K5mjmcalvVgV+A+kSJfIbrMvV1/hnndyDXh/Anr0KwA5TrFb7nv95cXwBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=igv9Oceb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2527CC19421;
	Thu,  8 Jan 2026 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767869307;
	bh=QCaPiD8GcxkO3ejFLqiCvTaxrJ6eMdDeYa0LPatXgQo=;
	h=Subject:To:Cc:From:Date:From;
	b=igv9Oceb1LRZSyoVmVT9Y5stL5gp8eaYDDPO/y2Q0fchXMjnrX+Wt2DkRTie3R/da
	 mOLnLFzD4vj8GeCfhzxe5C1AbE/10aHpwBQcJagnwQuGAQizvIP3LGVX2R8Lv74691
	 +snzmDjIyfG9Q0bxzXgCtEy+38U/O9qxSwdZqISQ=
Subject: FAILED: patch "[PATCH] tpm: Cap the number of PCR banks" failed to apply to 5.15-stable tree
To: jarkko.sakkinen@opinsys.com,noodles@meta.com,roberto.sassu@huawei.com,yi1.lai@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 08 Jan 2026 11:48:16 +0100
Message-ID: <2026010816-security-maimed-0bb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x faf07e611dfa464b201223a7253e9dc5ee0f3c9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010816-security-maimed-0bb1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From faf07e611dfa464b201223a7253e9dc5ee0f3c9e Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Date: Tue, 30 Sep 2025 15:58:02 +0300
Subject: [PATCH] tpm: Cap the number of PCR banks

tpm2_get_pcr_allocation() does not cap any upper limit for the number of
banks. Cap the limit to eight banks so that out of bounds values coming
from external I/O cause on only limited harm.

Cc: stable@vger.kernel.org # v5.10+
Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
Tested-by: Lai Yi <yi1.lai@linux.intel.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 30d00219f9f3..082b910ddf0d 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -246,7 +246,6 @@ static void tpm_dev_release(struct device *dev)
 
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
-	kfree(chip->allocated_banks);
 #ifdef CONFIG_TCG_TPM2_HMAC
 	kfree(chip->auth);
 #endif
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index cf64c7385105..b49a790f1bd5 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -799,11 +799,6 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
  */
 int tpm1_get_pcr_allocation(struct tpm_chip *chip)
 {
-	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
-					GFP_KERNEL);
-	if (!chip->allocated_banks)
-		return -ENOMEM;
-
 	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
 	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
 	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 5532e53a2dd3..dd502322f499 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -550,11 +550,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 
 	nr_possible_banks = be32_to_cpup(
 		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
-
-	chip->allocated_banks = kcalloc(nr_possible_banks,
-					sizeof(*chip->allocated_banks),
-					GFP_KERNEL);
-	if (!chip->allocated_banks) {
+	if (nr_possible_banks > TPM2_MAX_PCR_BANKS) {
+		pr_err("tpm: out of bank capacity: %u > %u\n",
+		       nr_possible_banks, TPM2_MAX_PCR_BANKS);
 		rc = -ENOMEM;
 		goto out;
 	}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b15360ff78d7..53de9488c509 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -26,7 +26,9 @@
 #include <crypto/aes.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
+
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+#define TPM2_MAX_PCR_BANKS	8
 
 struct tpm_chip;
 struct trusted_key_payload;
@@ -68,7 +70,7 @@ enum tpm2_curves {
 
 struct tpm_digest {
 	u16 alg_id;
-	u8 digest[TPM_MAX_DIGEST_SIZE];
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
 } __packed;
 
 struct tpm_bank_info {
@@ -189,7 +191,7 @@ struct tpm_chip {
 	unsigned int groups_cnt;
 
 	u32 nr_allocated_banks;
-	struct tpm_bank_info *allocated_banks;
+	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];


