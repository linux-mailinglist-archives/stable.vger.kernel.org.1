Return-Path: <stable+bounces-192872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECFAC44AD1
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB94188B923
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8317B506;
	Mon, 10 Nov 2025 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDDBp+q+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE32AD1F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735673; cv=none; b=YGCbgOX+6UzBfy1gcT4ZbCho6dEauhfSGQWhMQMdo8T6+62tiSoSwkXcMAD2sv89yC9w/vrcmvoFIRvBxEuzYrGPy+ful9AO//XXPVvI9ArImLu9xAe2gVjyuGvk4HCPgrx3A/PItGZWIQLN9DDsW0YXfXKiZz0vTpM7p45CBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735673; c=relaxed/simple;
	bh=2mGP7YHgs6hdvGDLpCkHIzOwWjTIBT/spZGOZ1FMaaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLKJbF4yCSKMkMqf+cq9wVWgpT2pOBdUnXzM7hbN1gSUL2KVsl3MlmW45zelo/tlVqzV6hU26FCYj7oonnzczk9dThEtITk6aYATd9eEpoEb/QxQF5lPEHGD0uOTnOcpVPq1UNtMQf7elW3yiUEMS1ncjSIq0qZVhtAaoRS+6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDDBp+q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AB8C4CEFB;
	Mon, 10 Nov 2025 00:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762735672;
	bh=2mGP7YHgs6hdvGDLpCkHIzOwWjTIBT/spZGOZ1FMaaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDDBp+q+FhLKe0pHxxC/CauQWCYjmzL6ht7ROM5Yl0NDKROJQdLO9JosZ97kBe/sc
	 DssBjlbpBj7Jq0j7vHmQb+UgBvz3e4iYSTCOTVdD/tNjaDLp5M/Ngfe8ZIL68iHb8Q
	 3Do5qFDwFSoxTO808U9AbIBdWFwjg3ZbMq0tVXOe2YQM0LcLD8JlpVSIJ09ntMSN51
	 WmqJmj/ekGDUHByQEztZyJy/aK4i7MbUYKk0MeO/p4XEMuhi2gCAAUMGiBWgAo8zDC
	 eU+SMlYLmUqAe9xYaAWGbeK0ci1A/VEsL16lsh+Jl1mBE89SW3Xi/oAS1RD5P3eu4b
	 4C0PfSHw7LWbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/8] scsi: ufs: core: Add UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE
Date: Sun,  9 Nov 2025 19:47:43 -0500
Message-ID: <20251110004750.555028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110940-control-hence-f9a8@gregkh>
References: <2025110940-control-hence-f9a8@gregkh>
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
Stable-dep-of: d968e99488c4 ("scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL")
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


