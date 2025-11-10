Return-Path: <stable+bounces-192876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E0C44AE3
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E473B002B
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F51DDC37;
	Mon, 10 Nov 2025 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnHj4Iqr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7D2AD1F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735677; cv=none; b=isq6XyFs+cbPoKjtZr8DX4pnfeUQ8Z6aV58wDJ+CY7un1PxOEHG4f0IjSLh5noM6vHtpjgn3aVk1bvjEKacL5ciruuWbvK7z2mKo+nPSAGNpFwdTNEtVsGeMSyG8n13o0dUHeGw/mrQerZDE87QU5C7IxkZQhD3k0VUUfD0/snU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735677; c=relaxed/simple;
	bh=HVZiwibAdBzA8V3KJM5KJYgIsVZSCXxUSn8DMKk5XdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKiUfg4NyNqs6cfLikteDXd29z48awynrb9n5DTl+zc0eU+ibFQzwoq+mHMKMiAdCSP0wH61aj8u3teLdNyaAMDymDO5tsTMeWF72xZE0eb64/udQO2gxB+GKLJW5sUAuVkzb87ZXYF2xc5z0KkZCUoWN2sA1C6hAaIXFQymDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnHj4Iqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68381C113D0;
	Mon, 10 Nov 2025 00:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762735677;
	bh=HVZiwibAdBzA8V3KJM5KJYgIsVZSCXxUSn8DMKk5XdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnHj4IqrjTa6MpiuD+6TD0mTGdZO05PYN7sIb0XO6GPdm68iYNumRekdoD91IY0XI
	 VTJDqXOZ+2XqF8/jJHUeRu9XAbL42nH2A0WVYzkWSCE6Vj5q6jbM0sOtfm0Jw+5RVw
	 sUlp1SNYIrbvEM9ZlgHvERCk7V15LO0hwRUzJ0C8dEQKcs4JjvBOJ8Z+c9LibC5fok
	 GwvbNx1fLBNoBQ1lRriYtV/Bvbpm26K5IJ9a/tg5LWnA9WT0UXQ9gvbQ92C5+VHBUD
	 BKfKH2cAQ0zU2wLKtN+pKbNHfLRBmO355MgHt8AZw4w8t6JHYIQvbtU1kolVKg+nox
	 SuaV3gSjWHZow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/8] scsi: ufs: core: Add UFSHCD_QUIRK_KEYS_IN_PRDT
Date: Sun,  9 Nov 2025 19:47:47 -0500
Message-ID: <20251110004750.555028-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110004750.555028-1-sashal@kernel.org>
References: <2025110940-control-hence-f9a8@gregkh>
 <20251110004750.555028-1-sashal@kernel.org>
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
Stable-dep-of: d968e99488c4 ("scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL")
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


