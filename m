Return-Path: <stable+bounces-5797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A819580D70D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635C8282C50
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA254F98;
	Mon, 11 Dec 2023 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWQdCeEi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C1EB8
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702319683; x=1733855683;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OgohU8Ls1B2XnJnrrIB2zy5JezZGmeg/h++0agzR2Qs=;
  b=nWQdCeEi+66EY499vPN8rRIwGxDMkjsQoJEUD8dNHjH9dley67VUMVkH
   /4TJ0e8Ujz0BMbE4CxtL4FgjojwPh8KO8rIuKCAG4AycB0F01o7+xgpsW
   UcvjPtjs6Plo3JiRqgLtWYB1Y8EPix8ReLpNCl2ml+gED+62NXYfitNcd
   ndNALvLktEZJNFFsQhw0jID+emHd5vrZA/820ihTqNVkl9WttkSrsbHm3
   QGfYKBD1FTc3nm1TPIRP0pnQp0+ej3EIaFsYeOaB+eFMGaeOWDC0uiZy7
   qtOy3EZi68Ejn3qs5u5pJyDdZc5PdNOATjIEDLAkXNgULkKpuxezrsPBL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1531263"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1531263"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:34:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104571690"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1104571690"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.23])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:34:41 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: stable@vger.kernel.org
Subject: [PATCH 4.19] mmc: block: Be sure to wait while busy in CQE error recovery
Date: Mon, 11 Dec 2023 20:34:31 +0200
Message-Id: <20231211183431.275363-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023120326-sadness-deem-1895@gregkh>
References: <2023120326-sadness-deem-1895@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

commit c616696a902987352426fdaeec1b0b3240949e6b upstream.

STOP command does not guarantee to wait while busy, but subsequent command
MMC_CMDQ_TASK_MGMT to discard the queue will fail if the card is busy, so
be sure to wait by employing mmc_poll_for_busy().

Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://lore.kernel.org/r/20231103084720.6886-4-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c    | 2 ++
 drivers/mmc/core/mmc_ops.c | 5 +++--
 drivers/mmc/core/mmc_ops.h | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3c299417c4ab..3399e8c477b9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -573,6 +573,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
+	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, true);
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index c2187fc6dcba..2ed47f800126 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -448,8 +448,8 @@ int mmc_switch_status(struct mmc_card *card)
 	return __mmc_switch_status(card, true);
 }
 
-static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			bool send_status, bool retry_crc_err)
+int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+		      bool send_status, bool retry_crc_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -502,6 +502,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mmc_poll_for_busy);
 
 /**
  *	__mmc_switch - modify EXT_CSD register
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 018a5e3f66d6..daf7ab867f0e 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -35,6 +35,8 @@ int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card);
 int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
+int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+		      bool send_status, bool retry_crc_err);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool use_busy_signal, bool send_status,	bool retry_crc_err);
-- 
2.34.1


