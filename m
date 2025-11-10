Return-Path: <stable+bounces-192936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E8EC466F3
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60E33BE753
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98F30DD3C;
	Mon, 10 Nov 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqYY/Wne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07F30DD3B
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775934; cv=none; b=BLEI2w5URmk9h5DGdwR5LVrK1n78o7Dmuu8kp29BT1A+c5sU9dxQ8YXYFcm0nNB/xk/vEiOr8j0zo4UwIZDf6QBD1AUEXn3/eDnJztHRxRXQYfYGTzJOicJLSrNDTELbXFPQFA8pMLUyfFkEeSYheKzy+ySkKPCaQ3IuvMxaybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775934; c=relaxed/simple;
	bh=etsF+soXzzpVi+WHXI114htyEk5OM6hKDGszZYA7lHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtqTJs8VwkcqqywZH1OveOYumV/FGElf1h+NnR7cuXJgFCsRr96MYmrw9KcpsOCI7OD4hMk6vjy0kx6Ayl62i6Exzey/Px3+fD7/2yVrWZU7T+2aC+dFXKAmAoEpaQrnMbmHlvipXY/AqjWDxwDfaB8qp5tXxaz4agZzjhUfbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqYY/Wne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8EAC113D0;
	Mon, 10 Nov 2025 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775933;
	bh=etsF+soXzzpVi+WHXI114htyEk5OM6hKDGszZYA7lHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqYY/WneCK2f+Ed2T6AGIdX/Z5XMPUIwecJOTNa5zPcby5Va1UFEEYLnB3GiZf093
	 JJBkBmDIVgBoc0R5lOSoXGasVL+ZqYOQ+Hv6eRbRppCeCHNVqssv3ise9OHCNwG87E
	 6B2e2Lz6jGd/fC8MSkY2Kdv51P/evaesjmzmvbb59lZAWlqqEoDBRbNK3/INP6jIZP
	 sS+fHZJ0sz68Cg78aVt/6ty/rNfdcjRWdpCFIr6VluhmAmcEwsu9u0RYDuKcdyLywo
	 Wkc++6/ogkIXQo1EwiDXyaqw0WpADGPAICiIFrVY3OP4nQH3AAtBc/W4VueF7kscBm
	 p5CJnk5i0iPVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE
Date: Mon, 10 Nov 2025 06:58:44 -0500
Message-ID: <20251110115848.651076-3-sashal@kernel.org>
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
Stable-dep-of: d34caa89a132 ("scsi: ufs: core: Add a quirk to suppress link_startup_again")
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


