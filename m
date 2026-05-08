Return-Path: <stable+bounces-244757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEjBAO3k/WnckQAAu9opvQ
	(envelope-from <stable+bounces-244757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 15:28:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC44F70E6
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8FB3032060
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAFC3806C9;
	Fri,  8 May 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUkFCLtG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3137DE8D
	for <stable@vger.kernel.org>; Fri,  8 May 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246557; cv=none; b=mTNNXQ4NwgqR1UfJQ2W8hkxZ8C6l2YqVlNvHYUmb/XfMsG12KJ2JZOFXSOMqn4XFnO7PsOTEu3qriOeEbjgos40EV8AXJz40U+no3nL5HSBIbX9OqPrayjYdAL+1bxH0huj12VSQOJZcLPopEnGk+++UlP0dI4qmhiszGxRbKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246557; c=relaxed/simple;
	bh=SyFivII9xil39RSjyiqO+64275Ks6YNDXwHi3+oWN1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZjNEKc4/QaTnP1AYmRUx/u1vtZ7MakcIwT/3KIw53DKtAWibV7BX8hZKHmZZ2ptr1r0erqgufBoQap5MDPHpGEzy4aM40k442Bv+sjfygks2AyFbv4rR4tpsO7DMy2OGy6mzL5rOQu0wQjxfaKrBPXy/bLs+snZGgdcG8i3nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUkFCLtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98095C2BCB0;
	Fri,  8 May 2026 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246557;
	bh=SyFivII9xil39RSjyiqO+64275Ks6YNDXwHi3+oWN1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUkFCLtGD8hrvI6HgyJGuP6Yy7Nc/EW4AT+C3UEFFZxPtSswNwRNJgZ5vcnWWLLjI
	 VIA0zibEZ/2OZOcpf697xqp9J1jMmqaN48YlbHqzsOa1PAggv7bheLSBpJwhciFYPz
	 NiLgXw8ZNbKFtb6Xd+jxgzNCRV1TOoRP9i6Sdm5o4o97h+9qCKJQRF1N5DlAjm169p
	 IaPYziEPYTKWp6kuYVZCcBtgXXF9hN3y7AYkFaQ85xQmXfqDE/PUeGeoQ14XRovGOO
	 xUHBpQxj3jInxu+Uxcug4UYHSE8n8WXRZ6l0dxAy5nZWmaQb25DgT9MMYMkDP7ELgE
	 Ku28EwY09uTfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luke Wang <ziniu.wang_1@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs
Date: Fri,  8 May 2026 09:22:34 -0400
Message-ID: <20260508132234.1478437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050304-gauntlet-dentist-b0a0@gregkh>
References: <2026050304-gauntlet-dentist-b0a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54CC44F70E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244757-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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
[ adapted to use mmc_can_secure_erase_trim()/mmc_can_trim() and placed helper after mmc_card_no_uhs_ddr50_tuning() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/card.h   | 5 +++++
 drivers/mmc/core/queue.c  | 9 +++++++--
 drivers/mmc/core/quirks.h | 9 +++++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 9cbdd240c3a7d..94cc218a8750f 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -300,4 +300,9 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
 }
 
+static inline int mmc_card_fixed_secure_erase_trim_time(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME;
+}
+
 #endif
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4d68442619120..9baa6cc8e626a 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -184,8 +184,13 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
 		return;
 
 	lim->max_hw_discard_sectors = max_discard;
-	if (mmc_can_secure_erase_trim(card))
-		lim->max_secure_erase_sectors = max_discard;
+	if (mmc_can_secure_erase_trim(card)) {
+		if (mmc_card_fixed_secure_erase_trim_time(card))
+			lim->max_secure_erase_sectors = UINT_MAX >> card->erase_shift;
+		else
+			lim->max_secure_erase_sectors = max_discard;
+	}
+
 	if (mmc_can_trim(card) && card->erased_byte == 0)
 		lim->max_write_zeroes_sectors = max_discard;
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c0576..1f7406c0ab03d 100644
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
index 2e455b20c37c2..97e42b918412c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -296,6 +296,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
+#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME	(1<<20) /* Secure erase/trim time is fixed regardless of size */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.53.0


