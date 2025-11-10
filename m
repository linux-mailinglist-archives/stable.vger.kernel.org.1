Return-Path: <stable+bounces-192934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF8C466FF
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8401F1881736
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312053128D5;
	Mon, 10 Nov 2025 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aliAYlZw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205530DD19
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775932; cv=none; b=nkcCENQK2btrlzb6KSJisECRKF68z8Dp6IaKILI2cnY6Npse+7DLK9nple1ZElHxArIG8TBGRJ+TUmsEqR+1/C0DacwbCjA4004dRgb4y5X+5dp+ObWGJeoc3WkXtIt6mNCZA1n+OqWGUDwCA6pL7JYGbrYB205JGl/Z8Z3mkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775932; c=relaxed/simple;
	bh=JqmIGzJGzfxUyKu90gqTMiH9zXs/ZC4/ChQUJO8kE8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRsKV8dDfl0HIQtY+B1djin53zLj5qoZZMuZkTmlPgXy8RtHC7yPMen03pl3zCLmRdJlqLweKlPVkoHhyREE7riUBQcTPt02l49kCyN1F99zZjS1jCdj8Xs7RGf6OpIZrOvXM8mkpaSxDsO/lslI/JvozF07n3a5nTA7MeSOSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aliAYlZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5C7C116D0;
	Mon, 10 Nov 2025 11:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775931;
	bh=JqmIGzJGzfxUyKu90gqTMiH9zXs/ZC4/ChQUJO8kE8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aliAYlZw1rRz8cPfa2eXFsP7/Z9nY5v4jmFR6qu7Me0Sdw52Adkkuyz3VUZZjeany
	 HKQt3ve0W72qLQ7TR4acW436uvtR4oB6RHEHxvk5JsMpdLIZqT5q1f/kkedKw8GHZl
	 DN0TLKz8xilcqfUelR8x/VtBnRTa+FZaQRTncqRhkvvjx2rWNTMN1SxGB+dBtio3Xi
	 ho8YTAmgdFaIIE7YtAr6XkPVumxMY2hDtnx5wq7miYqYZXmYsN4hWXCt5K8/FswfvX
	 VzAkUQegdbIt/9qWUuGPc75ICm/xnb2syhjWb6oFRRTI+m9g5MIibXePiboTQNxCdW
	 VbAC/umg67chQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] scsi: ufs: core: Add UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE
Date: Mon, 10 Nov 2025 06:58:42 -0500
Message-ID: <20251110115848.651076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110906-retrieval-daunting-5fa7@gregkh>
References: <2025110906-retrieval-daunting-5fa7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit c2a90eee29f41630225c9a64d26c425e1d50b401 ]

Add UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE which lets UFS host drivers
initialize the blk_crypto_profile themselves rather than have it be
initialized by ufshcd-core according to the UFSHCI standard.  This is
needed to support inline encryption on the "Exynos" UFS controller which
has a nonstandard interface.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20240708235330.103590-2-ebiggers@kernel.org
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d34caa89a132 ("scsi: ufs: core: Add a quirk to suppress link_startup_again")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 10 +++++++---
 include/ufs/ufshcd.h             |  9 +++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index f2c4422cab864..debc925ae439b 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -159,6 +159,9 @@ int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba)
 	int err = 0;
 	enum blk_crypto_mode_num blk_mode_num;
 
+	if (hba->quirks & UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE)
+		return 0;
+
 	/*
 	 * Don't use crypto if either the hardware doesn't advertise the
 	 * standard crypto capability bit *or* if the vendor specific driver
@@ -228,9 +231,10 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
 	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
 		return;
 
-	/* Clear all keyslots - the number of keyslots is (CFGC + 1) */
-	for (slot = 0; slot < hba->crypto_capabilities.config_count + 1; slot++)
-		ufshcd_clear_keyslot(hba, slot);
+	/* Clear all keyslots. */
+	for (slot = 0; slot < hba->crypto_profile.num_slots; slot++)
+		hba->crypto_profile.ll_ops.keyslot_evict(&hba->crypto_profile,
+							 NULL, slot);
 }
 
 void ufshcd_crypto_register(struct ufs_hba *hba, struct request_queue *q)
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index e9db9682316a2..21d03510efb66 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -642,6 +642,15 @@ enum ufshcd_quirks {
 	 * thus need this quirk to skip related flow.
 	 */
 	UFSHCD_QUIRK_MCQ_BROKEN_RTC			= 1 << 21,
+
+	/*
+	 * This quirk needs to be enabled if the host controller supports inline
+	 * encryption but it needs to initialize the crypto capabilities in a
+	 * nonstandard way and/or needs to override blk_crypto_ll_ops.  If
+	 * enabled, the standard code won't initialize the blk_crypto_profile;
+	 * ufs_hba_variant_ops::init() must do it instead.
+	 */
+	UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE		= 1 << 22,
 };
 
 enum ufshcd_caps {
-- 
2.51.0


