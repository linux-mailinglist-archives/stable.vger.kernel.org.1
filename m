Return-Path: <stable+bounces-206393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED96FD05011
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CABFF3027E72
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEBC500962;
	Thu,  8 Jan 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9oCBfUp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129229BD95
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892624; cv=none; b=gnGLNlayBqKfLvmIT/Xll+w9vWEU73rhTmAo+XD9+EJulI4Re9+PYJydRZ/uAqvsoIQL1wJt+b2wkHOOxUPcxwb3LDI7shyLZ9cZc0HEfrkMF1ZafUOmEK3ohNA5FzP0wawZFMsfv4t+v7G4nG/EKqkPgejYkstIGO0kqB7FKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892624; c=relaxed/simple;
	bh=6vq0SXBRUS62FP3sy2JE5TxatsPmBg3OXFU7384/lfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbQ/awcmuRw3pOo+k3mmPXMI3y+bsEG4kRvFX9wowOdH0N3YZb7S42E0CFYmcn6cQ7OktvbsGNuUd9FKwShvBIjveM1zuP25EMTanaKbzvDXEJunxgZA9XqmU6CjSCmg8pB6C7sPLVGYjE02aaK7trzRDSG5ieAandRgflH3CB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9oCBfUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5821C116D0;
	Thu,  8 Jan 2026 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892624;
	bh=6vq0SXBRUS62FP3sy2JE5TxatsPmBg3OXFU7384/lfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9oCBfUpk/PAHhE8fPc4/dCQW89YevTkNax4FzcxYbgPbTZ1MuQnIy8LuEWLTE7Kh
	 9laL7Is2qfSkBnG9JFnE/vT0KnI/GLRdYihMNLUmVBlLQT3OT3KGHr5EB+tv37xlna
	 MTxJNnQfkh7EBAoFi3uaZ1FvyaXAxf26GLRcN4wwsJMZEFudD5zaSQSMTwo7OE7bCm
	 TlrvgpX4WaeWWuA7ZfXQ735Gz7SFsoPtTPttXXHAFs6MLo4y+ieVVLDBWFMys7JFn5
	 WKZ4ro0WZnaPREQoHiTRX0sp4vEevrFJtS36uEGk7nPT9kxFl6HTrGQtLmuZ5rmVZX
	 ZY3Rn9BZ9IWVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Lai Yi <yi1.lai@linux.intel.com>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tpm: Cap the number of PCR banks
Date: Thu,  8 Jan 2026 12:17:00 -0500
Message-ID: <20260108171700.1555668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010816-security-maimed-0bb1@gregkh>
References: <2026010816-security-maimed-0bb1@gregkh>
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
[ add TPM_MAX_DIGEST_SIZE for backward compatibility and remove CONFIG_TCG_TPM2_HMAC block ]
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
index 2652de93e97b..28f2a31d7c98 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -25,7 +25,10 @@
 #include <crypto/hash_info.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
+
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+#define TPM_MAX_DIGEST_SIZE	TPM2_MAX_DIGEST_SIZE
+#define TPM2_MAX_PCR_BANKS	8
 
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


