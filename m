Return-Path: <stable+bounces-4021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E38045AB
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516281F213B0
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A7F6AC2;
	Tue,  5 Dec 2023 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fj1Q5+Xq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B86AA0;
	Tue,  5 Dec 2023 03:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6A8C433C7;
	Tue,  5 Dec 2023 03:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746408;
	bh=S/iUYw8QHlxdu9rxsM4lDn/fFLd2TBtZCCxNRmrcRWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fj1Q5+Xq4pm6sKFz+GSdKTnFSVUmK0SVaXGrBr6k+F6pNVc7mPmnjiC/yf84BsUkW
	 LwRVA/WIw55kSpxGzNFNDqY4Kq3liQJ1M+B0WwWtOSXbyzRc9FA4IsTIcn8btvCPxv
	 vMEzp2qLaC/cA0xVYIk0Qhox/YEorilZzmzKIajo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 014/134] mmc: block: Retry commands in CQE error recovery
Date: Tue,  5 Dec 2023 12:14:46 +0900
Message-ID: <20231205031536.201678292@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 8155d1fa3a747baad5caff5f8303321d68ddd48c upstream.

It is important that MMC_CMDQ_TASK_MGMT command to discard the queue is
successful because otherwise a subsequent reset might fail to flush the
cache first.  Retry it and the previous STOP command.

Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20231103084720.6886-5-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -551,7 +551,7 @@ int mmc_cqe_recovery(struct mmc_host *ho
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
@@ -559,10 +559,13 @@ int mmc_cqe_recovery(struct mmc_host *ho
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	host->cqe_ops->cqe_recovery_finish(host);
 
+	if (err)
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
 	mmc_retune_release(host);
 
 	return err;



