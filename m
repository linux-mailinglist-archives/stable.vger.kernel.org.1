Return-Path: <stable+bounces-18467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D833E8482D6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBAB1F23BCE
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687A4EB4A;
	Sat,  3 Feb 2024 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vGlxXk1D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761631C2BD;
	Sat,  3 Feb 2024 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933820; cv=none; b=sckd3BrrRT1Bq88VeBi/G6oXkASYqh3/QBonc89weoKh+idmj4lMu3vLmUofk83eyaPd2T03vDJcz2z5AAnqvU7qOruXZq0fqjLbGDAIAFzcStRH5NoeiqO1/r8vZ/DLts0S74HQsPNYkvRDSBK1HA7dzQ9J+o6MlcmaVd3Trw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933820; c=relaxed/simple;
	bh=40xvsDZuH/oebFv7m577Jqy8TGl/8eN0F8m2zgPgFQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtkq0l65d07hfzB0E6VKCwOB2Qrh6ozk3VEV3y/qxW3g24vLkSB+juxRcfNb0rfadaOZhb6v26ms/gZPaBC+XTI7b/ONgbKxYnyASGtDNCV6TGv9H8jts70XgFzuN0LBBkAR/DjnGam5XdpxhzI6AXLr8oB8Z2qcxe2DHrvfTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vGlxXk1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAAFC433C7;
	Sat,  3 Feb 2024 04:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933820;
	bh=40xvsDZuH/oebFv7m577Jqy8TGl/8eN0F8m2zgPgFQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGlxXk1Dk+EhXwXWk3NLI3q/aH8RyufeHgUBaCcyNa4SOQcF4lImCI/FXTTPHbWnn
	 jPLAEayMSQYT3NEx+8L13aoIG+Kwiq9LFYN+K7qopwEtMA7Yg5djvwYq9Ab+hynw4P
	 7gMFFIOhtYqiavEihyOBDDKxa/QObZcVoAjP8Ur0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 115/353] ionic: pass opcode to devcmd_wait
Date: Fri,  2 Feb 2024 20:03:53 -0800
Message-ID: <20240203035407.392260621@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 24f110240c03c6b5368f1203bac72883d511e606 ]

Don't rely on the PCI memory for the devcmd opcode because we
read a 0xff value if the PCI bus is broken, which can cause us
to report a bogus dev_cmd opcode later.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.c  | 1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h  | 1 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index c06576f43916..22ab0a44fa8c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -321,6 +321,7 @@ void ionic_dev_cmd_comp(struct ionic_dev *idev, union ionic_dev_cmd_comp *comp)
 
 void ionic_dev_cmd_go(struct ionic_dev *idev, union ionic_dev_cmd *cmd)
 {
+	idev->opcode = cmd->cmd.opcode;
 	memcpy_toio(&idev->dev_cmd_regs->cmd, cmd, sizeof(*cmd));
 	iowrite32(0, &idev->dev_cmd_regs->done);
 	iowrite32(1, &idev->dev_cmd_regs->doorbell);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 9b5463040075..fd112bee4dcf 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -153,6 +153,7 @@ struct ionic_dev {
 	bool fw_hb_ready;
 	bool fw_status_ready;
 	u8 fw_generation;
+	u8 opcode;
 
 	u64 __iomem *db_pages;
 	dma_addr_t phy_db_pages;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 835577392178..1b547acfd8e9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -465,7 +465,7 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	 */
 	max_wait = jiffies + (max_seconds * HZ);
 try_again:
-	opcode = readb(&idev->dev_cmd_regs->cmd.cmd.opcode);
+	opcode = idev->opcode;
 	start_time = jiffies;
 	for (fw_up = ionic_is_fw_running(idev);
 	     !done && fw_up && time_before(jiffies, max_wait);
-- 
2.43.0




