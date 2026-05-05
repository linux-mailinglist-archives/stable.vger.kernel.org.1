Return-Path: <stable+bounces-244078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOLAIb7I+WlhEAMAu9opvQ
	(envelope-from <stable+bounces-244078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:38:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B24CB96C
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E366030916EE
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271144104A;
	Tue,  5 May 2026 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXQ2jadI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3469441044
	for <stable@vger.kernel.org>; Tue,  5 May 2026 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976262; cv=none; b=uzkSJ/QT1QvnopihwCHkzPAuFGp2D2dUDAr/ZIVXj3QivSFXSPOACSyAqleE4307lYzH2178duuBbTGprTjCzA9q+wrx/bMlWEYA+Fm+SZnfsB96th/PPbKiNsDu4OA/0ItRE7e0o/HiykqWvVu5IaWoIWbQnYgn5e6WKHg55W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976262; c=relaxed/simple;
	bh=6aMwysXihMMNoTGJf9nBVEs9gIKM70CiwbdHX9o2NDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyVPKNTz8cxKMUf692hFiZtdUkq5tgVmlOFp7JhFZh1OPzOW7GtJIyEOSQcyOlGM+nA3obOtQ5qLwwL1PG8ZmgPl9wl3nJZtwtIAJZFfA2Mei/GNKcHlTrcXHYYjw0y9MVMgUTIJQYOhTBG8G3S7KXL26P8Jo5/eaqmJ8ZEzBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXQ2jadI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D05FC2BCB4;
	Tue,  5 May 2026 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777976262;
	bh=6aMwysXihMMNoTGJf9nBVEs9gIKM70CiwbdHX9o2NDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXQ2jadIWZrOk0dGlLFmEGGypPn5fnZe/aJdRZ8jVJXddkL2oyRZ1XGa+T+HcoihW
	 UTtCV0Ot2ntowaYaGbDO0GGmgPnqZWoLbtfHwUOagxyeRecwRoI4+q+klT84Vaicjb
	 lTd+tmlcDPeySQsfMwcBXiSOzzCjuSM5u9fo/2CohfNUsGqpY5Fmxs45pvIFnL0MyR
	 ZPSa1o1+JGfrEWVJtgjTulf8WIX+yJGxtmeUr6xcefKXVqrYMffCKHT2LUy7ORSySs
	 CIByBKws2rOm6tysngeskJiq0jr0QT1muArWhfMnjAZ+o85xLEeeeQCihInC6inmsi
	 iP4r7UYo2y5Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] mmc: core: Add quirk for incorrect manufacturing date
Date: Tue,  5 May 2026 06:17:30 -0400
Message-ID: <20260505101731.582352-2-sashal@kernel.org>
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
X-Rspamd-Queue-Id: 028B24CB96C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244078-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,sandisk.com:email]

From: Avri Altman <avri.altman@sandisk.com>

[ Upstream commit 263ff314cc5602599d481b0912a381555fcbad28 ]

Some eMMC vendors need to report manufacturing dates beyond 2025 but are
reluctant to update the EXT_CSD revision from 8 to 9. Changing the
Updating the EXT_CSD revision may involve additional testing or
qualification steps with customers. To ease this transition and avoid a
full re-qualification process, a workaround is needed. This
patch introduces a temporary quirk that re-purposes the year codes
corresponding to 2010, 2011, and 2012 to represent the years 2026, 2027,
and 2028, respectively. This solution is only valid for this three-year
period.

After 2028, vendors must update their firmware to set EXT_CSD_REV=9 to
continue reporting the correct manufacturing date in compliance with the
JEDEC standard.

The `MMC_QUIRK_BROKEN_MDT` is introduced and enabled for all Sandisk
devices to handle this behavior.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: d6bf2e64dec8 ("mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/card.h   | 6 ++++++
 drivers/mmc/core/mmc.c    | 5 +++++
 drivers/mmc/core/quirks.h | 3 +++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 15 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 1200951bab08c..a9619dd452708 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -89,6 +89,7 @@ struct mmc_fixup {
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
+#define CID_MANFID_SANDISK_MMC  0x45
 #define CID_MANFID_SWISSBIT     0x5D
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
@@ -305,4 +306,9 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
 }
 
+static inline int mmc_card_broken_mdt(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_MDT;
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 243da805ada67..49f568f9a7d3e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -676,6 +676,11 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			/* Adjust production date as per JEDEC JESD84-B51B September 2025 */
 			if (card->cid.year < 2023)
 				card->cid.year += 16;
+		} else {
+			/* Handle vendors with broken MDT reporting */
+			if (mmc_card_broken_mdt(card) && card->cid.year >= 2010 &&
+			    card->cid.year <= 2012)
+				card->cid.year += 16;
 		}
 	}
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c0576..f5e8a0f6d11b9 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -170,6 +170,9 @@ static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
 	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
 			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
 
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_MMC, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_MDT),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index ddcdf23d731c4..fd0cb188c46e2 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -330,6 +330,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
+#define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.53.0


