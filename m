Return-Path: <stable+bounces-192935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C2AC466E1
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41B64E3CE3
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BDF30DD35;
	Mon, 10 Nov 2025 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVBvEv22"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440F30DD2C
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775933; cv=none; b=QPV0U98Dg3dJBWXvvJ8+HVBhuIxFODJOuhmXIYShbS7rfHLoRnbM9BRNHGC4kX8fwvuLdAEFo7FauUo2zx1VK03RqBqbAM4JBstGnN9a7NkXEsRX9KMdWTG9Xu6fyUZBfBUi7znbiTi6IZxezVfk1lltDNGdr2pe6FSGBs3zsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775933; c=relaxed/simple;
	bh=DJXz+OUi39Twivnx/49OVFKlhmccc/nk5RdmpiDXQdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8LzVpPLdZttjQDHzbR+vEMNmSn153qYmfPNbGOGPGQQ4xA+1LQP6gm2VDdsozX0Fp9BCGRE8sDip0tS1W5apm2ptJELolN8BAbkRpYysdh+ZQGkzZFC2YTe4wP24gOMozw5i9tSG9MenW9PL3HQtd+PhS7JMxGdZ4PtbGLYaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVBvEv22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AEDC19422;
	Mon, 10 Nov 2025 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775932;
	bh=DJXz+OUi39Twivnx/49OVFKlhmccc/nk5RdmpiDXQdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVBvEv22hP99fxZGLSWgmBk+ePFxz70KPdWxOGG4X/XzxFdWZMR0AxW6O4ZCj5YfN
	 aLxISaLnf3z6z5S9+WAijOT2dLyeAy21KO5hL5SUhBcJ5yyZqJEDu4B4/OzE5+lhPL
	 l9JsR+XEnloR/bRmF8ObzayFUuPAmfWUNTH0MC7WRtOnzPJC921hAnhzNkRVIKwzAL
	 lyJxaA3BW+nePDjLxf6wJUFI0cmCvETG0eeWWffr0AqPgqqDGcgeek5IXRvjHrpJtP
	 s96MCIO4NbdqEsIxexLECbapgOxpQKiNmcYTUD28C9UCAgfuUmIWGeOOfIq/u9wxUM
	 lpeueizC3nOTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] scsi: ufs: core: fold ufshcd_clear_keyslot() into its caller
Date: Mon, 10 Nov 2025 06:58:43 -0500
Message-ID: <20251110115848.651076-2-sashal@kernel.org>
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

[ Upstream commit ec99818afb03b1ebeb0b6ed0d5fd42143be79586 ]

Fold ufshcd_clear_keyslot() into its only remaining caller.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20240708235330.103590-3-ebiggers@kernel.org
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d34caa89a132 ("scsi: ufs: core: Add a quirk to suppress link_startup_again")
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


