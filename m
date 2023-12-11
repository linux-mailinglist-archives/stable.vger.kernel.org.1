Return-Path: <stable+bounces-5498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B780CE8C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134221F21568
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D836495C0;
	Mon, 11 Dec 2023 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SV4vvgUy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B891EB4
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702305705; x=1733841705;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cvLSMkDD0X/aStaJE8lg3mF0nPsLU+lRQEQCqVPGc0k=;
  b=SV4vvgUykqhghfnGZYdLZatM7qyohb8qGkxusDwb0bCW88ohFrsvCi1M
   R8GcC9laL+kHL1A11vgfju4ydGj9MGaTWL+EtMyAZY0qVXdbvnJPwBD9n
   kDwlfzZ4cMIriqpw9l6nLbbqLvUD+X88O8cdiCFL8YyLGtzcf/EjWojwr
   djPrA8fDSK6+jc+NAylQE5sTGrx6yJcmuT27YQ3pWLOXXwS72hAiVrl/Q
   QS3EdNxb4AWcTyrsBvWraiBHYGv7LjWjDXKZE70J15gZ3jP0/6PlDdqur
   q5eSUzfY2eHKSJjHfGdFXTZOnSPqIgeiANrWqwtpnvvHnuG5jvukiBO8J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1782082"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1782082"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="843535184"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="843535184"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.23])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:41:43 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10] mmc: block: Be sure to wait while busy in CQE error recovery
Date: Mon, 11 Dec 2023 16:41:32 +0200
Message-Id: <20231211144132.99257-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023120358-baking-anymore-b0c7@gregkh>
References: <2023120358-baking-anymore-b0c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

STOP command does not guarantee to wait while busy, but subsequent command
MMC_CMDQ_TASK_MGMT to discard the queue will fail if the card is busy, so
be sure to wait by employing mmc_poll_for_busy().

Backport to 5.10: Add mmc_busy_cmd MMC_BUSY_IO

Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://lore.kernel.org/r/20231103084720.6886-4-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit c616696a902987352426fdaeec1b0b3240949e6b)
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c    | 2 ++
 drivers/mmc/core/mmc_ops.c | 3 ++-
 drivers/mmc/core/mmc_ops.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index fdeaaae08060..d5ca59bd1c99 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -553,6 +553,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
+	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, MMC_BUSY_IO);
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ebad70e4481a..b6bb7f7faee2 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -452,7 +452,7 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 	u32 status = 0;
 	int err;
 
-	if (host->ops->card_busy) {
+	if (busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
 		*busy = host->ops->card_busy(host);
 		return 0;
 	}
@@ -473,6 +473,7 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 		err = R1_STATUS(status) ? -EIO : 0;
 		break;
 	case MMC_BUSY_HPI:
+	case MMC_BUSY_IO:
 		break;
 	default:
 		err = -EINVAL;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 632009260e51..e3cbb1ddc31c 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -14,6 +14,7 @@ enum mmc_busy_cmd {
 	MMC_BUSY_CMD6,
 	MMC_BUSY_ERASE,
 	MMC_BUSY_HPI,
+	MMC_BUSY_IO,
 };
 
 struct mmc_host;
-- 
2.34.1


