Return-Path: <stable+bounces-204152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2463DCE856E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 00:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5C38300AC79
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6A419D065;
	Mon, 29 Dec 2025 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t30SW5TW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECB3A1E98
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767051222; cv=none; b=IQTHQcRwPY0Cea3A81g93h7nKWZ8/78CZFOIOFiBd4oxZL/ivVVcW7FcaY80+K1NnwWwO3R/m/adSXIo3+8pFrrAio3e9L45rh5j7xgWvKerlXgn0FMen9XInNCM2C7Xm5p7C0jFmXzLkt5jaVEYH6ApZSN8cIvxlXMCzsGP3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767051222; c=relaxed/simple;
	bh=bi9aRTW8HhcOsTh5EJfzqmo3JJwb6/SBCicYF00etiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCdGKCSSGEFvgOa1BvpG06jauxIb6oFnACwIRjmzqUICTJReg73y5m6Li5izTZJjy3A/NjJph/vBybASkwFPl3sXqQBt+wPKhLlZe5wCpplx01qDcaM0aerUcrWBaP9f+u8y0xEMaKBMrctfsn7QQKK3737VF/AX2LUcFLcjVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t30SW5TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DA5C4CEF7;
	Mon, 29 Dec 2025 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767051222;
	bh=bi9aRTW8HhcOsTh5EJfzqmo3JJwb6/SBCicYF00etiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t30SW5TWAwJxdcY0Iz2lcgjk03LHdwMGjz4ST3PFJ06n7waaAYO1ebxp2KDHubcCe
	 a49V9uJ6O23w2+2fm/I3FOYO4SswvxvIkD1TzDl3MxqaWs1waE7jREf7v/cRi27BSC
	 Y4LCYRHgt1IhEb+hxgzdzUwRFkq5n/FknFLQsfa6tija1+rss3qav6QOZQDq0cCTQh
	 bZVY/GxilEXtuuUqnCpU4kqwgiRXRfjgcObqLXVIZaNyEhRVPVvwnaUM14sdASbJyh
	 p62GsDUsxrd54i/cXSPRhJXDAm38mSpxj5g2/zOQgejYtOVybMG16M6DsNG8SJboEF
	 02qSjxejBwQZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Lai Yi <yi1.lai@linux.intel.com>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tpm: Cap the number of PCR banks
Date: Mon, 29 Dec 2025 18:33:39 -0500
Message-ID: <20251229233339.1824369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122959-residence-cover-1b11@gregkh>
References: <2025122959-residence-cover-1b11@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 1 -
 drivers/char/tpm/tpm1-cmd.c | 5 -----
 drivers/char/tpm/tpm2-cmd.c | 8 +++-----
 include/linux/tpm.h         | 8 +++++---
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 70e3fe20fdcf..458a3e9ea73a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -279,7 +279,6 @@ static void tpm_dev_release(struct device *dev)
 
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
-	kfree(chip->allocated_banks);
 	kfree(chip);
 }
 
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
index 93545be190a5..57bb3e34b770 100644
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
index bf8a4ec8a01c..f5e7cca2f257 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -25,7 +25,9 @@
 #include <crypto/hash_info.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
+
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+#define TPM2_MAX_PCR_BANKS	8
 
 struct tpm_chip;
 struct trusted_key_payload;
@@ -51,7 +53,7 @@ enum tpm_algorithms {
 
 struct tpm_digest {
 	u16 alg_id;
-	u8 digest[TPM_MAX_DIGEST_SIZE];
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
 } __packed;
 
 struct tpm_bank_info {
@@ -157,7 +159,7 @@ struct tpm_chip {
 	unsigned int groups_cnt;
 
 	u32 nr_allocated_banks;
-	struct tpm_bank_info *allocated_banks;
+	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
-- 
2.51.0


