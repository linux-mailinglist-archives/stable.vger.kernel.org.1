Return-Path: <stable+bounces-203520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F31CE6934
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 300F33020C69
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49430BF4B;
	Mon, 29 Dec 2025 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G9m8JqRT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6A2D47E9
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008522; cv=none; b=AgvtY0xg8Qts4uXiYNQ4JgsyAp3lVvz2emllhIDehooYdihYe4pU0QOxsf1HdgvJxySD+tPMvpMdpQIb67JfASmo3RnjXcCTBtgPtRBkuxFnVH5rWI2oLs9Xtp2yVE5TCmnyrKQSHRW1VAbIEAWdujO0ZiQT9NiSm86Ehp1Tt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008522; c=relaxed/simple;
	bh=WdP8AjFnPA/Se6SHpX9eJSX3Fb6isWKn5IpHyUqTYs8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DbMN4XmVg7xJ+ayo3FQPXLGYswE1cntub6406vKNXBsBp1dhsuFXbVRoAjFmpNjXpna//ajGZ4a4+TZT0upUpOE0gLX2MnAlj7boTmkP3NPYgn29hQq5Gg4i/Ix1mUgROipX0OJEOKAnwhjFH8A/bJdTRy6RGjlgsTRYA/V7i8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G9m8JqRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB130C4CEF7;
	Mon, 29 Dec 2025 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008522;
	bh=WdP8AjFnPA/Se6SHpX9eJSX3Fb6isWKn5IpHyUqTYs8=;
	h=Subject:To:Cc:From:Date:From;
	b=G9m8JqRTdnlQBA7Du7ycv9S4bUH3ngDHNXcCkgic90fcSbmNvKIP+qDQWWeYpYjSk
	 2g/HWHQG4zSocqa4cgDT8LbpyKTyD/+rXd81krph/8BG+IPVuchIY1v7pnUqps+kTn
	 gnmgX9U3zUze+/AQ4b5XmAzbCfyVle177U9ICOMQ=
Subject: FAILED: patch "[PATCH] tpm: Cap the number of PCR banks" failed to apply to 6.6-stable tree
To: jarkko@kernel.org,jarkko.sakkinen@opinsys.com,noodles@meta.com,roberto.sassu@huawei.com,yi1.lai@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:41:59 +0100
Message-ID: <2025122959-residence-cover-1b11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x faf07e611dfa464b201223a7253e9dc5ee0f3c9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122959-residence-cover-1b11@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From faf07e611dfa464b201223a7253e9dc5ee0f3c9e Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
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


