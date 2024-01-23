Return-Path: <stable+bounces-15401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79576838513
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0221C2A545
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA87CF3A;
	Tue, 23 Jan 2024 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DxmN5kE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10777A735;
	Tue, 23 Jan 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975735; cv=none; b=S2rJD81hBE8L6DMyccTBzNnJKX/p+DNEGf+K7xs3onuO6m+OHzWll4YzN3etFOTZqUXnwjxeOYPaNneTwycBStk+0ZWKw//zdv6E/V3tboLwuwKjcEPI9vri2U47Vam9ldhef6Hk5U8kWxLoh6VuEkX6x2Xf3TTWH8x5dWFvDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975735; c=relaxed/simple;
	bh=9BNPvB8VHISk8b6tRGvPaoUhYhKCkLIXhJW6UsyVIA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6qoKFKvrSj6bFF3eCOY1o6l2vULD2pRRq0XFSQAW5jNEaYOPX+a2KoPH+LRnSP8uBOb3oQ59rt9Sa+Vxoo9r34U9RsdRmuc98b15un2QRN9AmuUw2jDZdXsKKuIYptKDUP0YlPRxSYFe2kYBsomdKFzeYCzbNfAUiM+JF7y0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DxmN5kE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD36C43390;
	Tue, 23 Jan 2024 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975735;
	bh=9BNPvB8VHISk8b6tRGvPaoUhYhKCkLIXhJW6UsyVIA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxmN5kE++GhTvfJhkZeCzE14AHYiq3FUJpf+i3dB4FWQ2qq7ifdiPiU9niP+i4msn
	 FYzFNdSjsz/xUzMTSjHY8JekY18vDTdkztuMhQ9P8uNiNuZKCqJ2LKm1qbLTVWHlYv
	 GBXQb3miIa4LydWbvvUSYrOXv/bh+kq7R19wN2OU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 497/583] spmi: mtk-pmif: Serialize PMIF status check and command submission
Date: Mon, 22 Jan 2024 15:59:08 -0800
Message-ID: <20240122235827.230540024@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit f200fff8d019f2754f91f5d715652e3e3fdf3604 ]

Before writing the read or write command to the SPMI arbiter through the
PMIF interface, the current status of the channel is checked to ensure
it is idle. However, since the status only changes from idle when the
command is written, it is possible for two concurrent calls to determine
that the channel is idle and simultaneously send their commands. At this
point the PMIF interface hangs, with the status register no longer being
updated, and thus causing all subsequent operations to time out.

This was observed on the mt8195-cherry-tomato-r2 machine, particularly
after commit 46600ab142f8 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for
drivers between 5.10 and 5.15") was applied, since then the two MT6315
devices present on the SPMI bus would probe assynchronously and
sometimes (during probe or at a later point) read the bus
simultaneously, breaking the PMIF interface and consequently slowing
down the whole system.

To fix the issue at its root cause, introduce locking around the channel
status check and the command write, so that both become an atomic
operation, preventing race conditions between two (or more) SPMI bus
read/write operations. A spinlock is used since this is a fast bus, as
indicated by the usage of the atomic variant of readl_poll, and
'.fast_io = true' being used in the mt6315 driver, so spinlocks are
already used for the regmap access.

Fixes: b45b3ccef8c0 ("spmi: mediatek: Add support for MT6873/8192")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20230724154739.493724-1-nfraprado@collabora.com
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20231206231733.4031901-2-sboyd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spmi/spmi-mtk-pmif.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index b3c991e1ea40..54c35f5535cb 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -50,6 +50,7 @@ struct pmif {
 	struct clk_bulk_data clks[PMIF_MAX_CLKS];
 	size_t nclks;
 	const struct pmif_data *data;
+	raw_spinlock_t lock;
 };
 
 static const char * const pmif_clock_names[] = {
@@ -314,6 +315,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	struct ch_reg *inf_reg;
 	int ret;
 	u32 data, cmd;
+	unsigned long flags;
 
 	/* Check for argument validation. */
 	if (sid & ~0xf) {
@@ -334,6 +336,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	else
 		return -EINVAL;
 
+	raw_spin_lock_irqsave(&arb->lock, flags);
 	/* Wait for Software Interface FSM state to be IDLE. */
 	inf_reg = &arb->chan;
 	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
@@ -343,6 +346,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 		/* set channel ready if the data has transferred */
 		if (pmif_is_fsm_vldclr(arb))
 			pmif_writel(arb, 1, inf_reg->ch_rdy);
+		raw_spin_unlock_irqrestore(&arb->lock, flags);
 		dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
 		return ret;
 	}
@@ -350,6 +354,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	/* Send the command. */
 	cmd = (opc << 30) | (sid << 24) | ((len - 1) << 16) | addr;
 	pmif_writel(arb, cmd, inf_reg->ch_send);
+	raw_spin_unlock_irqrestore(&arb->lock, flags);
 
 	/*
 	 * Wait for Software Interface FSM state to be WFVLDCLR,
@@ -376,7 +381,8 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 	struct ch_reg *inf_reg;
 	int ret;
-	u32 data, cmd;
+	u32 data, wdata, cmd;
+	unsigned long flags;
 
 	if (len > 4) {
 		dev_err(&ctrl->dev, "pmif supports 1..4 bytes per trans, but:%zu requested", len);
@@ -394,6 +400,10 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	else
 		return -EINVAL;
 
+	/* Set the write data. */
+	memcpy(&wdata, buf, len);
+
+	raw_spin_lock_irqsave(&arb->lock, flags);
 	/* Wait for Software Interface FSM state to be IDLE. */
 	inf_reg = &arb->chan;
 	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
@@ -403,17 +413,17 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 		/* set channel ready if the data has transferred */
 		if (pmif_is_fsm_vldclr(arb))
 			pmif_writel(arb, 1, inf_reg->ch_rdy);
+		raw_spin_unlock_irqrestore(&arb->lock, flags);
 		dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
 		return ret;
 	}
 
-	/* Set the write data. */
-	memcpy(&data, buf, len);
-	pmif_writel(arb, data, inf_reg->wdata);
+	pmif_writel(arb, wdata, inf_reg->wdata);
 
 	/* Send the command. */
 	cmd = (opc << 30) | BIT(29) | (sid << 24) | ((len - 1) << 16) | addr;
 	pmif_writel(arb, cmd, inf_reg->ch_send);
+	raw_spin_unlock_irqrestore(&arb->lock, flags);
 
 	return 0;
 }
@@ -488,6 +498,8 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	arb->chan.ch_send = PMIF_SWINF_0_ACC + chan_offset;
 	arb->chan.ch_rdy = PMIF_SWINF_0_VLD_CLR + chan_offset;
 
+	raw_spin_lock_init(&arb->lock);
+
 	platform_set_drvdata(pdev, ctrl);
 
 	err = spmi_controller_add(ctrl);
-- 
2.43.0




