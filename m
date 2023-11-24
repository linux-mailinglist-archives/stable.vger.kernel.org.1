Return-Path: <stable+bounces-1331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8067F7F22
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2755F28247F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE409364A4;
	Fri, 24 Nov 2023 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eeiqx+QK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB052D787;
	Fri, 24 Nov 2023 18:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C14C433C9;
	Fri, 24 Nov 2023 18:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851133;
	bh=/zko6Er4XGNistFC4yXiG6akO5DZMVboEtE0pf64+F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeiqx+QKZdZMu8DAYjhkGUTGsM8KR+tXyHB/YiWZYjrNvxut0FeGEnXL7dxWZ1oSt
	 oQCtWkdhmNoYepmI93p0VmFctxyfq4ibVq0lXPASHE6whR1dQsYU/2hdJcRT6ocs0Y
	 YRP+0J5nrX4fU0o8vk4LkCx04IlRhvIaDBkoTOIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bean Huo <beanhuo@micron.com>,
	Rafael Beims <rafael.beims@toradex.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.5 302/491] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A
Date: Fri, 24 Nov 2023 17:48:58 +0000
Message-ID: <20231124172033.650552588@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bean Huo <beanhuo@micron.com>

commit ed9009ad300c0f15a3ecfe9613547b1962bde02c upstream.

Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
operation be allowed only after a write has occurred. Otherwise, the
cache flush command or subsequent commands will time out.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231030224809.59245-1-beanhuo@iokpp.de
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c  |    4 +++-
 drivers/mmc/core/card.h   |    4 ++++
 drivers/mmc/core/mmc.c    |    8 ++++++--
 drivers/mmc/core/quirks.h |    7 ++++---
 include/linux/mmc/card.h  |    2 ++
 5 files changed, 19 insertions(+), 6 deletions(-)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2389,8 +2389,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(stru
 			}
 			ret = mmc_blk_cqe_issue_flush(mq, req);
 			break;
-		case REQ_OP_READ:
 		case REQ_OP_WRITE:
+			card->written_flag = true;
+			fallthrough;
+		case REQ_OP_READ:
 			if (host->cqe_enabled)
 				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
 			else
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -280,4 +280,8 @@ static inline int mmc_card_broken_sd_cac
 	return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
 }
 
+static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
+}
 #endif
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2081,13 +2081,17 @@ static int _mmc_flush_cache(struct mmc_h
 {
 	int err = 0;
 
+	if (mmc_card_broken_cache_flush(host->card) && !host->card->written_flag)
+		return 0;
+
 	if (_mmc_cache_enabled(host)) {
 		err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_FLUSH_CACHE, 1,
 				 CACHE_FLUSH_TIMEOUT_MS);
 		if (err)
-			pr_err("%s: cache flush error %d\n",
-			       mmc_hostname(host), err);
+			pr_err("%s: cache flush error %d\n", mmc_hostname(host), err);
+		else
+			host->card->written_flag = false;
 	}
 
 	return err;
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -110,11 +110,12 @@ static const struct mmc_fixup __maybe_un
 		  MMC_QUIRK_TRIM_BROKEN),
 
 	/*
-	 * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
-	 * support being used to offload WRITE_ZEROES.
+	 * Micron MTFC4GACAJCN-1M supports TRIM but does not appear to support
+	 * WRITE_ZEROES offloading. It also supports caching, but the cache can
+	 * only be flushed after a write has occurred.
 	 */
 	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
-		  MMC_QUIRK_TRIM_BROKEN),
+		  MMC_QUIRK_TRIM_BROKEN | MMC_QUIRK_BROKEN_CACHE_FLUSH),
 
 	/*
 	 * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -295,7 +295,9 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
 #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
+#define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 
+	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
 	unsigned int		erase_size;	/* erase size in sectors */



