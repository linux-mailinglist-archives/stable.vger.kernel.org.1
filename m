Return-Path: <stable+bounces-192874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE1C44AD7
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 708324E33F2
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD11A9F88;
	Mon, 10 Nov 2025 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVgXizOS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A42AD1F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735675; cv=none; b=BScyxQPV1CjWfIiLt+GV3SmB38QTAAlBQb5fTXme4K5XKRO0EV1NXRYVKIvooX4zCebvRCD7o2jE4EivIzdaI2m8P5H6DZr8pEEh68OxzXaoJI8befPHLRSknY/cEbzVLM7VRG+URslGztxTRclI5ToDBAXLntfyVrmERgUNUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735675; c=relaxed/simple;
	bh=woZZLH4dwN95CvzmDcxW4xr0+PiUEMlhPHA2js45QB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrBbYa1NkbLnkETTtk72FzZcZ7i89nVGdPPyLRSLMdQ9i3WgG7MXmyLqh3lSJol8QQdzoPRQ1eYCOGmb6rwHfNZBf3WKl1KPvSZa4lAEaj+W1blp84PH09YGjZQYMIBZljDB1lK+fEkhMJL97x+apXZ3cUatO0cdyZl5Kd3sgH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVgXizOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C54C4CEF7;
	Mon, 10 Nov 2025 00:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762735675;
	bh=woZZLH4dwN95CvzmDcxW4xr0+PiUEMlhPHA2js45QB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVgXizOSdSNFfZp4qD2mVkVY2obGGd0ttHBOku/aV3Dq6c9/7I/BBF+7FAUIDFSYz
	 EkZJsUwvKcgC56jQzJingC1CAP7KNkJOQaz/oOUlK+x8YMmyIk+srVQvLpzQnDOPyB
	 aGT3xrUXcJRlSNX529pnjaRFwHYGhkqSm/OFqa5ylVVM8GXgFUsL39Y5RCYL3L51JT
	 ZeaFXl7XdFZ91HvoQSxwhufzcW3PQUKFDOCu2mMhV/pKPIyIVJyGl1SuFVYTnB8LLd
	 LAgPIbtIjeAH7xe5gr1xKqqIvuWuv5ChJJ/O/mGzeYspjEk/Twc8/iimAIHz0EPYAt
	 d/rzZCzmfEHmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/8] scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE
Date: Sun,  9 Nov 2025 19:47:45 -0500
Message-ID: <20251110004750.555028-3-sashal@kernel.org>
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

[ Upstream commit e95881e0081a30e132b5ca087f1e07fc08608a7e ]

Add UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE which tells the UFS core to not use
the crypto enable bit defined by the UFS specification.  This is needed to
support inline encryption on the "Exynos" UFS controller.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20240708235330.103590-4-ebiggers@kernel.org
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d968e99488c4 ("scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 8 ++++++++
 include/ufs/ufshcd.h             | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index b4980fd91cee7..a714dad82cd1f 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -110,6 +110,10 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
 	return ufshcd_program_key(hba, &cfg, slot);
 }
 
+/*
+ * Reprogram the keyslots if needed, and return true if CRYPTO_GENERAL_ENABLE
+ * should be used in the host controller initialization sequence.
+ */
 bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
 	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
@@ -117,6 +121,10 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
 
 	/* Reset might clear all keys, so reprogram all the keys. */
 	blk_crypto_reprogram_all_keys(&hba->crypto_profile);
+
+	if (hba->quirks & UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE)
+		return false;
+
 	return true;
 }
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 21d03510efb66..3a3183dc899c3 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -651,6 +651,13 @@ enum ufshcd_quirks {
 	 * ufs_hba_variant_ops::init() must do it instead.
 	 */
 	UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE		= 1 << 22,
+
+	/*
+	 * This quirk needs to be enabled if the host controller supports inline
+	 * encryption but does not support the CRYPTO_GENERAL_ENABLE bit, i.e.
+	 * host controller initialization fails if that bit is set.
+	 */
+	UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE		= 1 << 23,
 };
 
 enum ufshcd_caps {
-- 
2.51.0


