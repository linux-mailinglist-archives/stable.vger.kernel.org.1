Return-Path: <stable+bounces-192938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A30C46708
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808C61882FE3
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA5930DEA0;
	Mon, 10 Nov 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsjr8IvP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4730DD2C
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775936; cv=none; b=MD09QDSnKvXoDwZH+1S/hfkLtAmb8X4nqjBSPkjBdHvQfd+p9Egr4REvw9h6Y2EEJOM64NJiYOTFSX/iay11+4Vjpo4hGWMkQ/Hj61miixlE1eWl9aiMdIL82gRWzmzkzpEooKuIjfMiyJAkovG3QMOQbq6OzST2qkxWD401Wfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775936; c=relaxed/simple;
	bh=P83TD7LricTzevw7P26sqUxbZdPTzkVyELuF1QE8yO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQLr/yIqt3TdsUhsQ2MmXXubzKv6SGjRS9nB1oiFVU5BmOTJpkooQsHtosba0A2WoDZQdkWBjnQzvJgo+RcWNflR76KobTbO4SDp7JWfaCb/y9pWchvbbNOwGm7TPQCCbyVP8BFzue1uYAl88OdppPXU2q7valONrYSQzJRbJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsjr8IvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175E9C16AAE;
	Mon, 10 Nov 2025 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775935;
	bh=P83TD7LricTzevw7P26sqUxbZdPTzkVyELuF1QE8yO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsjr8IvP8PEr1E0g330a8Gh/DxFf/JdebyFk8RKeYWVjnenqXjPheSuab5ZLSiS1S
	 9L4p/hfKB2QnkeJQT5rvxobJS/oeCIJLqsM5ZQMFPiJ7KWrZDWNLb8xtudasuKxSfK
	 VTFMpRZeSgjdCwlgoQvBseS1bw+xkqrNy+TMVyGOsGFpUv5h+63UYzgni6o5idNQOi
	 cgp9WIi22igV33fE9wAxy0UgDocc6mPWju+yQYOVm/MaS0ZbX8ula8iMjGaxF5bMqV
	 laOq/J2AzsH9QJTDirc4o29gwQB+DDLFqFJEntdBIGtWSN+Hu5eB8gMcGRf0fCzZZu
	 RGy1YJ8h6wXzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] scsi: ufs: core: Add UFSHCD_QUIRK_KEYS_IN_PRDT
Date: Mon, 10 Nov 2025 06:58:46 -0500
Message-ID: <20251110115848.651076-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110115848.651076-1-sashal@kernel.org>
References: <2025110906-retrieval-daunting-5fa7@gregkh>
 <20251110115848.651076-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 4c45dba50a3750a0834353c4187e7896b158bc0c ]

Since the nonstandard inline encryption support on Exynos SoCs requires
that raw cryptographic keys be copied into the PRDT, it is desirable to
zeroize those keys after each request to keep them from being left in
memory.  Therefore, add a quirk bit that enables the zeroization.

We could instead do the zeroization unconditionally.  However, using a
quirk bit avoids adding the zeroization overhead to standard devices.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20240708235330.103590-6-ebiggers@kernel.org
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d34caa89a132 ("scsi: ufs: core: Add a quirk to suppress link_startup_again")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd-crypto.h | 17 +++++++++++++++++
 drivers/ufs/core/ufshcd.c        |  1 +
 include/ufs/ufshcd.h             |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.h b/drivers/ufs/core/ufshcd-crypto.h
index 3eb8df42e1942..89bb97c14c15b 100644
--- a/drivers/ufs/core/ufshcd-crypto.h
+++ b/drivers/ufs/core/ufshcd-crypto.h
@@ -50,6 +50,20 @@ static inline int ufshcd_crypto_fill_prdt(struct ufs_hba *hba,
 	return 0;
 }
 
+static inline void ufshcd_crypto_clear_prdt(struct ufs_hba *hba,
+					    struct ufshcd_lrb *lrbp)
+{
+	if (!(hba->quirks & UFSHCD_QUIRK_KEYS_IN_PRDT))
+		return;
+
+	if (!(scsi_cmd_to_rq(lrbp->cmd)->crypt_ctx))
+		return;
+
+	/* Zeroize the PRDT because it can contain cryptographic keys. */
+	memzero_explicit(lrbp->ucd_prdt_ptr,
+			 ufshcd_sg_entry_size(hba) * scsi_sg_count(lrbp->cmd));
+}
+
 bool ufshcd_crypto_enable(struct ufs_hba *hba);
 
 int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba);
@@ -73,6 +87,9 @@ static inline int ufshcd_crypto_fill_prdt(struct ufs_hba *hba,
 	return 0;
 }
 
+static inline void ufshcd_crypto_clear_prdt(struct ufs_hba *hba,
+					    struct ufshcd_lrb *lrbp) { }
+
 static inline bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
 	return false;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8b7033cd6cdbb..6990886a54c5d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5509,6 +5509,7 @@ void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 	struct scsi_cmnd *cmd = lrbp->cmd;
 
 	scsi_dma_unmap(cmd);
+	ufshcd_crypto_clear_prdt(hba, lrbp);
 	ufshcd_release(hba);
 	ufshcd_clk_scaling_update_busy(hba);
 }
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9ba8162c00a5e..40b457b4c831e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -662,6 +662,14 @@ enum ufshcd_quirks {
 	 * host controller initialization fails if that bit is set.
 	 */
 	UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE		= 1 << 23,
+
+	/*
+	 * This quirk needs to be enabled if the host controller driver copies
+	 * cryptographic keys into the PRDT in order to send them to hardware,
+	 * and therefore the PRDT should be zeroized after each request (as per
+	 * the standard best practice for managing keys).
+	 */
+	UFSHCD_QUIRK_KEYS_IN_PRDT			= 1 << 24,
 };
 
 enum ufshcd_caps {
-- 
2.51.0


