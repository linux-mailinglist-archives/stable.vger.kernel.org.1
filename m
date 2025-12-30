Return-Path: <stable+bounces-204157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE6ECE863D
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 01:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B5383001E1C
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 00:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07A946C;
	Tue, 30 Dec 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/REwDae"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57046B5
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767053580; cv=none; b=JJsDPcvHV1sbkzMhPzrZnwaWKHzuQZIzmFAc3kfZYUL4DPGY9RkX1CE9jgWz3w5OCS5aIbgi2oseVzrpZ/USZYG22ZeMOKM+yXyVo339MbgxqYUQ4lVpZBZxZKpThXzThhGxJCuHeYKqEVmOM7JLhERMh/+9+r0/kzwdHxYkvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767053580; c=relaxed/simple;
	bh=JXlbUJYCDB9zdNKVVjUNsGSROqMyUxdF1pGVj2QnoSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJLbpIEb7y1kNgiq7T3wcrY8KEc0ky/KeO386QTmLUSgMYN2kNJz3DFntlntuH3P0kDWbjavfuBrdaScdUs0H/ryOdQgzPa8Fo4xxkM26h9JT4M/9MCDwqZpWNtpRdb91TMNdDUJ1ZXaM5XPylB0FW87LgmuVsR0vFStGpiJPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/REwDae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BCEC4CEF7;
	Tue, 30 Dec 2025 00:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767053579;
	bh=JXlbUJYCDB9zdNKVVjUNsGSROqMyUxdF1pGVj2QnoSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/REwDaeq+M25GsEDPIgrR9e/XxMgPxylqYfp1WJTI1hra2QTN5wS6JOUTZY4FFax
	 VE776VtQKJPbZ4S0Ym0VHVKvGsTDPbkUTnKSHCkJklm8s55pPl9/aKJtOVlGjUbKlD
	 n0qNRmfp21uKT4ZAS/rl0YwR/R7Tjoz0xjjAoCfz9No+lZ6TXXVRwdrNjz0SqfivOx
	 F2Z4suPSmBQFe1R7F7lIU4x74Nd/bLsDrEWg/YEbYSy+w1CxjzoU3WTomz+lJafU47
	 JawVUcoQQ8Ksy2j/Zg/rfxDgDuU0vd9qsRgwWI1quyNScIFGOEWR3ynB34ghQPE+Dt
	 WqqJxcInAPl+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Lai Yi <yi1.lai@linux.intel.com>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tpm: Cap the number of PCR banks
Date: Mon, 29 Dec 2025 19:12:57 -0500
Message-ID: <20251230001257.1873924-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122900-hassle-blush-5272@gregkh>
References: <2025122900-hassle-blush-5272@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

[ Upstream commit faf07e611dfa464b201223a7253e9dc5ee0f3c9e ]

tpm2_get_pcr_allocation() does not cap any upper limit for the number of
banks. Cap the limit to eight banks so that out of bounds values coming
from external I/O cause on only limited harm.

Cc: stable@vger.kernel.org # v5.10+
Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
Tested-by: Lai Yi <yi1.lai@linux.intel.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
[ added backward-compatible define for TPM_MAX_DIGEST_SIZE to support older ima_init.c code still using that macro name ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 1 -
 drivers/char/tpm/tpm1-cmd.c | 5 -----
 drivers/char/tpm/tpm2-cmd.c | 8 +++-----
 include/linux/tpm.h         | 9 ++++++---
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index a3459238ecb3..be9f9a003ce2 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -269,7 +269,6 @@ static void tpm_dev_release(struct device *dev)
 
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
-	kfree(chip->allocated_banks);
 	kfree(chip);
 }
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index f7dc986fa4a0..0f1754a328cf 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -794,11 +794,6 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
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
index de92065394be..440b703e29e5 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -574,11 +574,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 
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
index 2652de93e97b..c2f6d29f4560 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -25,7 +25,10 @@
 #include <crypto/hash_info.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
+
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+#define TPM2_MAX_PCR_BANKS	8
+#define TPM_MAX_DIGEST_SIZE	TPM2_MAX_DIGEST_SIZE
 
 struct tpm_chip;
 struct trusted_key_payload;
@@ -51,7 +54,7 @@ enum tpm_algorithms {
 
 struct tpm_digest {
 	u16 alg_id;
-	u8 digest[TPM_MAX_DIGEST_SIZE];
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
 } __packed;
 
 struct tpm_bank_info {
@@ -157,7 +160,7 @@ struct tpm_chip {
 	unsigned int groups_cnt;
 
 	u32 nr_allocated_banks;
-	struct tpm_bank_info *allocated_banks;
+	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
-- 
2.51.0


