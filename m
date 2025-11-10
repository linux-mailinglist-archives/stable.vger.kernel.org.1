Return-Path: <stable+bounces-192873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F82EC44AD4
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA74E2953
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19919CCF7;
	Mon, 10 Nov 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpnUVwZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B02AD1F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735674; cv=none; b=IcpanPl7UIHMTL0yyh1lmPyY4Fp93J8Pp5ejmR6w5mfZ6wM4/ZGPH/bZEaI5XY9AkJ8/iIk/2GyYWAwKtSgimFcNc+DcdQlsREimLWRiN0SiGVZd2xdQuQq09+jegd/TijXX4+7Snc83l3FFV/Cf6/vmUYqM7qIjsMmh0tlAs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735674; c=relaxed/simple;
	bh=ZvNzgdYxOC1FMI5falcJlC18Breue0m1JI+cJTPRVzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yc2VUMEuBkiPAYojOHs9mpRaDNcQ2x7SX7xCp+ZEzAXJyW1z1o7Y7yNRyJLGjIHH8gUq0jFxG5m9BzC10l6JKgmHFWupNGLUW+kCAD9K8XLyM/Nkr1bahgqFb14PcGUxEy9mzBwYkj+gvAMW/xgY8qfl23RVguMqxN0RD2R+CFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpnUVwZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3452FC19423;
	Mon, 10 Nov 2025 00:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762735674;
	bh=ZvNzgdYxOC1FMI5falcJlC18Breue0m1JI+cJTPRVzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OpnUVwZ7V9VMufcY4J8TvqKBd/Xb2Bqvy4y9tQCqInCWZ0w8B1EFvf9e3oMOkit0D
	 o190hV2p4WlEFDueWzrQk21OsuRQ3Jqufllsbxy43fVMrD7OD95gLYF7VrJ4N9MnAV
	 ZpX5BJv5lz21zA+OMCguP4l5L4QFCakSGimfcDYWBSUh7SFvmD/xdI9QzQwNNJpjxa
	 31rvwqoGyhJZ2khHgIEBJA0ePV59sAyIx8CWQdyO7h69cWG96F330D4ucy5RIXqK1x
	 OLGqGMQU4L6Tl8MOf2yUhTvIz8o0tQl9INiac7Xbya0DXLxLRqNgO9yxJq7HGysgCW
	 +pOoFGvKYsPhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/8] scsi: ufs: core: fold ufshcd_clear_keyslot() into its caller
Date: Sun,  9 Nov 2025 19:47:44 -0500
Message-ID: <20251110004750.555028-2-sashal@kernel.org>
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

[ Upstream commit ec99818afb03b1ebeb0b6ed0d5fd42143be79586 ]

Fold ufshcd_clear_keyslot() into its only remaining caller.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20240708235330.103590-3-ebiggers@kernel.org
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d968e99488c4 ("scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index debc925ae439b..b4980fd91cee7 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -95,8 +95,12 @@ static int ufshcd_crypto_keyslot_program(struct blk_crypto_profile *profile,
 	return err;
 }
 
-static int ufshcd_clear_keyslot(struct ufs_hba *hba, int slot)
+static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
+				       const struct blk_crypto_key *key,
+				       unsigned int slot)
 {
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
 	/*
 	 * Clear the crypto cfg on the device. Clearing CFGE
 	 * might not be sufficient, so just clear the entire cfg.
@@ -106,16 +110,6 @@ static int ufshcd_clear_keyslot(struct ufs_hba *hba, int slot)
 	return ufshcd_program_key(hba, &cfg, slot);
 }
 
-static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
-				       const struct blk_crypto_key *key,
-				       unsigned int slot)
-{
-	struct ufs_hba *hba =
-		container_of(profile, struct ufs_hba, crypto_profile);
-
-	return ufshcd_clear_keyslot(hba, slot);
-}
-
 bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
 	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
-- 
2.51.0


