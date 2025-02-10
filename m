Return-Path: <stable+bounces-114556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF36A2EEBD
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1782A3A3903
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BBA231A3B;
	Mon, 10 Feb 2025 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MydZtCbz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14E22F16D
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195320; cv=none; b=H/aUB0UCwNHYSFu/sI7HPrCrGGMsOfXNOCHJNbfnZGf6aRZ9EhPypa6gaJreS7NvQ8E1FkUuwpkyvLZoRLjABG44DA/43FZOAzNWF73MBnlTLvNNWbXtGSpc4s/j5F0/Cr1SBvCZk5Rqe4QjHle1xPSPyxKwPTD0QsxdjK/9eTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195320; c=relaxed/simple;
	bh=ANkRbD52LR5nk1Xp9DUmS8/8+jon14/gUPM31l3vGnc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jTNPsmEl96/4YbR1Ofgoc7pM4NNuJcUWlNrtyT1aqDoTMhuLWcXx5mPnYOm+Q6dOpUfHPFCk/cxbtU4T0xOGc9rkHjgnE0dDqY0Lk/o4zlGn9taSa+bdPRSAluo1MNDYBzuTtiHQjRpGVJjlA8t+nWwuhrld6p14G/LtjJSnd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MydZtCbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F51C4CED1;
	Mon, 10 Feb 2025 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195320;
	bh=ANkRbD52LR5nk1Xp9DUmS8/8+jon14/gUPM31l3vGnc=;
	h=Subject:To:Cc:From:Date:From;
	b=MydZtCbzmqmnyIPU7dW+i+qbWk0/5YmIPvoRtkqKy/jhGxjVxUsdDSky6kzLVXLa5
	 Ns0iMZkn/uBGHZexff9v4I5iMvhKWbV+eT29qLsPFPv7tixx8L1Q8/KDXmhw9u6hyZ
	 1cnDI4F7ZCTfL0WGnyEiU9+uKez5HiZBjQkjxA1I=
Subject: FAILED: patch "[PATCH] ASoC: renesas: rz-ssi: Terminate all the DMA transactions" failed to apply to 6.12-stable tree
To: claudiu.beznea.uj@bp.renesas.com,biju.das.jz@bp.renesas.com,broonie@kernel.org,geert+renesas@glider.be
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:48:36 +0100
Message-ID: <2025021036-humorist-voltage-3645@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 541011dc2d7c4c82523706f726f422a5e23cc86f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021036-humorist-voltage-3645@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 541011dc2d7c4c82523706f726f422a5e23cc86f Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Tue, 10 Dec 2024 19:09:33 +0200
Subject: [PATCH] ASoC: renesas: rz-ssi: Terminate all the DMA transactions

The stop trigger invokes rz_ssi_stop() and rz_ssi_stream_quit().
- The purpose of rz_ssi_stop() is to disable TX/RX, terminate DMA
  transactions, and set the controller to idle.
- The purpose of rz_ssi_stream_quit() is to reset the substream-specific
  software data by setting strm->running and strm->substream appropriately.

The function rz_ssi_is_stream_running() checks if both strm->substream and
strm->running are valid and returns true if so. Its implementation is as
follows:

static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
{
    return strm->substream && strm->running;
}

When the controller is configured in full-duplex mode (with both playback
and capture active), the rz_ssi_stop() function does not modify the
controller settings when called for the first substream in the full-duplex
setup. Instead, it simply sets strm->running = 0 and returns if the
companion substream is still running. The following code illustrates this:

static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
{
    strm->running = 0;

    if (rz_ssi_is_stream_running(&ssi->playback) ||
        rz_ssi_is_stream_running(&ssi->capture))
        return 0;

    // ...
}

The controller settings, along with the DMA termination (for the last
stopped substream), are only applied when the last substream in the
full-duplex setup is stopped.

While applying the controller settings only when the last substream stops
is not problematic, terminating the DMA operations for only one substream
causes failures when starting and stopping full-duplex operations multiple
times in a loop.

To address this issue, call dmaengine_terminate_async() for both substreams
involved in the full-duplex setup when the last substream in the setup is
stopped.

Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Cc: stable@vger.kernel.org
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20241210170953.2936724-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 6efd017aaa7f..2d8721156099 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -415,8 +415,12 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 
 	/* Cancel all remaining DMA transactions */
-	if (rz_ssi_is_dma_enabled(ssi))
-		dmaengine_terminate_async(strm->dma_ch);
+	if (rz_ssi_is_dma_enabled(ssi)) {
+		if (ssi->playback.dma_ch)
+			dmaengine_terminate_async(ssi->playback.dma_ch);
+		if (ssi->capture.dma_ch)
+			dmaengine_terminate_async(ssi->capture.dma_ch);
+	}
 
 	rz_ssi_set_idle(ssi);
 


