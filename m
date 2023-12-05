Return-Path: <stable+bounces-4452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9A804788
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE9F281641
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB848BF8;
	Tue,  5 Dec 2023 03:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I2L57SrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DE6FB1;
	Tue,  5 Dec 2023 03:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E669C433C7;
	Tue,  5 Dec 2023 03:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747586;
	bh=FqN9kESAZHY5eg7PFVDpoSDkF4RyRln14l7p91TpHlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2L57SrKtjU4lwPaTkrp+S4HUrYxHOLTpMpqU6Dwm91sEx+gNxI0i20eZcCE8R18L
	 bHyVlywfTWrEdKNxuAkmYUQe8QTstKqroZ+Z3Hcob7HrP1ULjALfYibR4SB/WmzKet
	 M+hIZFY8w0QjQv9ST4atIC/NXIiIQ5i5bx2b7Zzo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Yongjun <zhengyongjun3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 129/135] mmc: core: convert comma to semicolon
Date: Tue,  5 Dec 2023 12:17:30 +0900
Message-ID: <20231205031539.023480742@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yongjun <zhengyongjun3@huawei.com>

[ Upstream commit 6b1dc6229aecbcb45e8901576684a8c09e25ad7b ]

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Link: https://lore.kernel.org/r/20201216131737.14883-1-zhengyongjun3@huawei.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 8155d1fa3a74 ("mmc: block: Retry commands in CQE error recovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f24653942536..9cc4e3a0bc9a8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -547,10 +547,10 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	host->cqe_ops->cqe_recovery_start(host);
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode       = MMC_STOP_TRANSMISSION,
-	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC,
+	cmd.opcode       = MMC_STOP_TRANSMISSION;
+	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, 0);
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -558,7 +558,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.arg          = 1; /* Discard entire queue */
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 
 	host->cqe_ops->cqe_recovery_finish(host);
-- 
2.42.0




