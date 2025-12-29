Return-Path: <stable+bounces-204154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455ECCE85A7
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 00:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4290C300BEC7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5729C347;
	Mon, 29 Dec 2025 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVVPYTnT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFA23FC5A
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767051657; cv=none; b=S6+JahfTehd3YLIG7pw/4vOqoRyaqeco5L3cFZlCHj+2862M+CEoxw0J9K9Jmq0uP4NIVmruThg2sW7CYwng5fCE+n6fK8gFs86aVxsUm4aNCE+tEvQwEgNFmsj74yqOOiGcNhaMRjunR1YeDjKnnSbDjiMUks0SksVJNVpe+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767051657; c=relaxed/simple;
	bh=fxIp2D4WGeYTzEjn9+fnEqyZauK9vAhszYVkhLz4qRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFMOPBDMPtpmdwcd0PZAVTaMF1VZmhSi+qcLSdUyShS4QUiA3xHqQn8yTNkp2ZOK8lpPxKPeEWiMVPQPTCt7VAvhRUZGC7UX1YUYIBfaoikVYjj9vUNRa+h7WMzi7cl8UWgSFFO0oHzqGMnVIbrAMoqE5bQyJ4jgoDjUmTpnhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVVPYTnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FF6C4CEF7;
	Mon, 29 Dec 2025 23:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767051656;
	bh=fxIp2D4WGeYTzEjn9+fnEqyZauK9vAhszYVkhLz4qRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVVPYTnTcpCN/xEj3SXUTYBFC5tSJgvWrC3+/mSbT4rc/teHRguLACo88w4PuMB1q
	 evKi6dvKSAW2pmUoL1rpb50F7IiXgAT8zTfih2VswLMnbjCPJQWjBHKyPoMRh6phg2
	 wYfYDV8cs11fpwWt8Ey8+FYVKinT6MGoCZNW9jqNSg+VjV42hvjWQ/pUutVN5V8M/c
	 aFLNW7XQn4dHjBhQCADLeUg1dnKsXqcT26YQeMUyTRlqYW/0gaN763uvdXd1TKGq1p
	 CS3xaSHTJTeMOB0MLnd9rQDYTvB9/Lu8g63Kchm9vNm353Xc9m+kT3LLWry3dRDVVB
	 GOSsJdOkRQzjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Lai Yi <yi1.lai@linux.intel.com>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tpm: Cap the number of PCR banks
Date: Mon, 29 Dec 2025 18:40:53 -0500
Message-ID: <20251229234053.1851978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122959-dreamt-stank-d6e5@gregkh>
References: <2025122959-dreamt-stank-d6e5@gregkh>
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
index 916ee815b140..412f19fa3207 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -269,7 +269,6 @@ static void tpm_dev_release(struct device *dev)
 
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
index 65d03867e114..ac8246153c24 100644
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
index 4a4112bb1d1b..1ca1585f032a 100644
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


