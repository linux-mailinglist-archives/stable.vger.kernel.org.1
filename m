Return-Path: <stable+bounces-118804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7203CA41C84
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A653BB7CE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED13261571;
	Mon, 24 Feb 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmdrX6Bn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BF26156C;
	Mon, 24 Feb 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395860; cv=none; b=dJieiy7I39DjdEOJAjsYkOpbu4JZyZzJcJ9pdyKbeyGWtRBEOxMoVUOKl1A7+2dQAnQRczgzFK8fiKAwM1jiKcvsxbTPp+EGRgfkSg5Ta2GPZRkjhlcGpha3aWL7OJeXs08PvwVp9klTnl44lmnsUPLbg4ajuNVpSjr6VGS+NpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395860; c=relaxed/simple;
	bh=HuzOtvANT2iS/b8mzEPUx/768H2RHmHBD/7ZWLQmsWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pR6MAU5F3mTHJa9T68pPDqXYiN1k/Ar75nKEGzBpox9NtKCV4f5x73CrX0KGfx9kYaeRc2sPS8OxhHGCyn807thdBb4GQZMCdrMt1EkZVRkoS6OinC4ZpXkiXmUFssO4XXnbAa/WsJ7q1+35PwJ6TZtVYzqcZUcxclz4Zy9VOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmdrX6Bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4DDC4CED6;
	Mon, 24 Feb 2025 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395860;
	bh=HuzOtvANT2iS/b8mzEPUx/768H2RHmHBD/7ZWLQmsWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmdrX6BnoKhD+78XURTEbbQu9izHD8Pd2jCl7+deSPgSHUhDrPeDRyN4zYi6uaENn
	 q+qvOr2oHPjy3z6atS852UHc8jrEqnpgg+YkKQmf9kUW7xnj4iRsXdkP52L6fvf9HB
	 b9mZOM+ha27Tnm4/440Gu/IuAyH6rSX6MT70uigA1C9p0N0XjN1TRypL4f3zQ1KxPJ
	 QM3HJzdq3HHwfB/AqeusxQGEOefgGovzHJree6g3fvcV1bAp8tXZIss9sBgD1Oy92m
	 um0FIOSpBUOYPY1WQkYkWdBc84dVQ7bwXGZ1UG44CXHbLGxjfRAS49cdt7tumkFzSs
	 35K8fS2ZPa9ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	venkataprasad.potturu@amd.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 20/32] ASoC: SOF: amd: Handle IPC replies before FW_BOOT_COMPLETE
Date: Mon, 24 Feb 2025 06:16:26 -0500
Message-Id: <20250224111638.2212832-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

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
index 5f371d9263f3b..12caefd087885 100644
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


