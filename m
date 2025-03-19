Return-Path: <stable+bounces-125280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F2A6909B
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AF58A086A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0601E3780;
	Wed, 19 Mar 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NneyxBeJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B51C1F02;
	Wed, 19 Mar 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395078; cv=none; b=mikur593a5Hom9x2fpnUQ34jYGvv7BhI/rbitZTg6ght3oiAND96oFavBQeHEeun7S1pjLikg6GSPxPiO5VbAob+yedvqwSCR3GbS53Cad6T0V3QVyNR/FizwXlXoe7MOBJd1JNuxePRNIK8YXSRB2zPtjE4U2QcCh+8MMNeifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395078; c=relaxed/simple;
	bh=px755rGebE2EFa7CaLU96aTx38Jd+L5ubZLYEEpRRCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIXABS/yN1ch7b0IlhKACoHrtEzECFjwfou2SA6shPt7ELERsNOA7xeED7FtecU2mFlcps+QCuS/L5pEdeNCuTccSv45i7ZxpjalD+u7SOtuaQo6n6Oqg4CaVlSMndP4jt/X8AjO48C8aPcmv7eIH688aIxoAvCVX8TlPeopCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NneyxBeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300D1C4CEE4;
	Wed, 19 Mar 2025 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395078;
	bh=px755rGebE2EFa7CaLU96aTx38Jd+L5ubZLYEEpRRCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NneyxBeJlfwX8oTvE6vTgmaLTKYrOAf4HscGTFL1DiQdEnE6juZCA/pQrWkCKtVTb
	 PJic97N0iV+ulcHOZl5oRMZi5lzqQpDrf2qN/dgd0tbsYjQlMLizaKDrERF/1trBqf
	 4vYqY5bwZkFTaJE/lGUdbdLhN3bz5MS9VGmIf7r0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 118/231] ASoC: SOF: amd: Handle IPC replies before FW_BOOT_COMPLETE
Date: Wed, 19 Mar 2025 07:30:11 -0700
Message-ID: <20250319143029.759493449@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit ac84ca815adb4171a4276b1d44096b75f6a150b7 ]

In some cases, e.g. during resuming from suspend, there is a possibility
that some IPC reply messages get received by the host while the DSP
firmware has not yet reached the complete boot state.

Detect when this happens and do not attempt to process the unexpected
replies from DSP.  Instead, provide proper debugging support.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://patch.msgid.link/20250207-sof-vangogh-fixes-v1-3-67824c1e4c9a@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp-ipc.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index b44b1b1adb6ed..cf3994a705f94 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -167,6 +167,7 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 
 	if (sdev->first_boot && sdev->fw_state != SOF_FW_BOOT_COMPLETE) {
 		acp_mailbox_read(sdev, sdev->dsp_box.offset, &status, sizeof(status));
+
 		if ((status & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
 			snd_sof_dsp_panic(sdev, sdev->dsp_box.offset + sizeof(status),
 					  true);
@@ -188,13 +189,21 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 
 	dsp_ack = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_ack_write);
 	if (dsp_ack) {
-		spin_lock_irq(&sdev->ipc_lock);
-		/* handle immediate reply from DSP core */
-		acp_dsp_ipc_get_reply(sdev);
-		snd_sof_ipc_reply(sdev, 0);
-		/* set the done bit */
-		acp_dsp_ipc_dsp_done(sdev);
-		spin_unlock_irq(&sdev->ipc_lock);
+		if (likely(sdev->fw_state == SOF_FW_BOOT_COMPLETE)) {
+			spin_lock_irq(&sdev->ipc_lock);
+
+			/* handle immediate reply from DSP core */
+			acp_dsp_ipc_get_reply(sdev);
+			snd_sof_ipc_reply(sdev, 0);
+			/* set the done bit */
+			acp_dsp_ipc_dsp_done(sdev);
+
+			spin_unlock_irq(&sdev->ipc_lock);
+		} else {
+			dev_dbg_ratelimited(sdev->dev, "IPC reply before FW_BOOT_COMPLETE: %#x\n",
+					    dsp_ack);
+		}
+
 		ipc_irq = true;
 	}
 
-- 
2.39.5




