Return-Path: <stable+bounces-7135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52049817116
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FDE281FAE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A61D136;
	Mon, 18 Dec 2023 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GxWfy0T3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06415AC0;
	Mon, 18 Dec 2023 13:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D74C433C7;
	Mon, 18 Dec 2023 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907657;
	bh=jg5zOsamOWfWCaMicVKi+XBC/txQQwORn2/8fbIWx4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxWfy0T3GhUjl5m281OimzLFftFIBhElWnRLzn26t9uajTluZ/ILTKJQRqiHdx7dg
	 5WH5FdQWxszy/tr69rAAM3WyLiroiPurkLmMvma8JEpVnQ3UtM436Fi1uvOHOffmNT
	 5NFnXIMGS78uCDAGQVtJkbrtZnMhfh9Ue5xrITuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 34/36] mmc: block: Be sure to wait while busy in CQE error recovery
Date: Mon, 18 Dec 2023 14:51:44 +0100
Message-ID: <20231218135043.040078332@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135041.876499958@linuxfoundation.org>
References: <20231218135041.876499958@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/core.c    |    2 ++
 drivers/mmc/core/mmc_ops.c |    5 +++--
 drivers/mmc/core/mmc_ops.h |    2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -573,6 +573,8 @@ int mmc_cqe_recovery(struct mmc_host *ho
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
+	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, true);
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -448,8 +448,8 @@ int mmc_switch_status(struct mmc_card *c
 	return __mmc_switch_status(card, true);
 }
 
-static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			bool send_status, bool retry_crc_err)
+int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+		      bool send_status, bool retry_crc_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -502,6 +502,7 @@ static int mmc_poll_for_busy(struct mmc_
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mmc_poll_for_busy);
 
 /**
  *	__mmc_switch - modify EXT_CSD register
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -35,6 +35,8 @@ int mmc_can_ext_csd(struct mmc_card *car
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card);
 int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
+int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+		      bool send_status, bool retry_crc_err);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool use_busy_signal, bool send_status,	bool retry_crc_err);



