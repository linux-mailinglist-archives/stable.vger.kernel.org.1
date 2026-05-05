Return-Path: <stable+bounces-244080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHwWAkrK+WmFEAMAu9opvQ
	(envelope-from <stable+bounces-244080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:45:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 708114CBBA6
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F098C3095579
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED04418E3;
	Tue,  5 May 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCWFiFh9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9F44102B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976264; cv=none; b=sJR4AVAECtDyD/iZm9xrm9DmazquoWmx5BvKdwEIB87SjpBJWSyCbmXZoVRHbA6Ep9lXuaXZLx3HWrDpJFtYnDSMbfLI4eFAUFDHrsnYsDsjTYM0hiVjKEmz8dvfyQJN9LMMwHLC6k8/1kWB+KgFAfXvFWqzDSDQ+7hWVdFKg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976264; c=relaxed/simple;
	bh=PIMYnevEk5SDSzPdyWQ67YbvCvcCq2hiG/6AdeGhjfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmdL77xXbrVVqdr6mhlJVNeZvydd6PYnhdpvIf11YhwIbFuSSgcpeRMdjkAsN7+gFXTqDFO6wU/oonGYKI92ADfCUxeSokj2SrD4Z9HL88WcALrBx5S6BFYHpffQq5sdNst5hPhtR5sbGQsWEh6Y/nuqcgdJnqmKBd++sJ5kENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCWFiFh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0754C2BCC7;
	Tue,  5 May 2026 10:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777976263;
	bh=PIMYnevEk5SDSzPdyWQ67YbvCvcCq2hiG/6AdeGhjfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCWFiFh9dPJa+cE59ukZLr0pkMJr5TNcJ3X9hBnGkpZBsS2LyWQ6cdJkexT97Sl8o
	 vbRNe/aw++Chh18AI9gX+ZskxSnewoBcvVVuUYBhit4Q7/Ak5fQEs+dS4Lk8bw1wwL
	 WfOlEmd6XpIJ97ZaVl+qxF/MG4XDtgihsc/a9JhZOICDbKR1ZyMlLPcsgL9FZyhG1d
	 Voc/3MuRVN9BkQxic5E8Fm3GGWbxLFCXLqUBGp+O79L5XZN+UrmutF/8aCTgP3bLc/
	 ENw+FWLRkMyWV2sa05gxut2JlGglYSNWtAVlspKSqOCMbPv/9WHkpqS6iLxwbjFq45
	 1wn6aKtqbfECQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luke Wang <ziniu.wang_1@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs
Date: Tue,  5 May 2026 06:17:31 -0400
Message-ID: <20260505101731.582352-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505101731.582352-1-sashal@kernel.org>
References: <2026050303-enroll-hulk-16c2@gregkh>
 <20260505101731.582352-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 708114CBBA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244080-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Luke Wang <ziniu.wang_1@nxp.com>

[ Upstream commit d6bf2e64dec87322f2b11565ddb59c0e967f96e3 ]

Kingston eMMC IY2964 and IB2932 takes a fixed ~2 seconds for each secure
erase/trim operation regardless of size - that is, a single secure
erase/trim operation of 1MB takes the same time as 1GB. With default
calculated 3.5MB max discard size, secure erase 1GB requires ~300 separate
operations taking ~10 minutes total.

Add a card quirk, MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME, to set maximum
secure erase size for those devices. This allows 1GB secure erase to
complete in a single operation, reducing time from 10 minutes to just 2
seconds.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/card.h   | 5 +++++
 drivers/mmc/core/queue.c  | 9 +++++++--
 drivers/mmc/core/quirks.h | 9 +++++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index a9619dd452708..a7c364d0030ad 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -311,4 +311,9 @@ static inline int mmc_card_broken_mdt(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_MDT;
 }
 
+static inline int mmc_card_fixed_secure_erase_trim_time(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME;
+}
+
 #endif
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 284856c8f6559..eb1053d8cae72 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -184,8 +184,13 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
 		return;
 
 	lim->max_hw_discard_sectors = max_discard;
-	if (mmc_card_can_secure_erase_trim(card))
-		lim->max_secure_erase_sectors = max_discard;
+	if (mmc_card_can_secure_erase_trim(card)) {
+		if (mmc_card_fixed_secure_erase_trim_time(card))
+			lim->max_secure_erase_sectors = UINT_MAX >> card->erase_shift;
+		else
+			lim->max_secure_erase_sectors = max_discard;
+	}
+
 	if (mmc_card_can_trim(card) && card->erased_byte == 0)
 		lim->max_write_zeroes_sectors = max_discard;
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index f5e8a0f6d11b9..6f727b4a60a52 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -153,6 +153,15 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * On Some Kingston eMMCs, secure erase/trim time is independent
+	 * of erase size, fixed at approximately 2 seconds.
+	 */
+	MMC_FIXUP("IY2964", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
+	MMC_FIXUP("IB2932", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index fd0cb188c46e2..8151f2240db41 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -331,6 +331,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
 #define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
+#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME	(1<<20) /* Secure erase/trim time is fixed regardless of size */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.53.0


