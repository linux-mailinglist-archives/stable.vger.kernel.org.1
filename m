Return-Path: <stable+bounces-161725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A84B02B23
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 15:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D26A563BE0
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CFF222574;
	Sat, 12 Jul 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLCj26A/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A02278772
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328760; cv=none; b=r0qzl2ulhLkgBBuH5JTVaw+GpuobhGSM26Vzy9r/t5WqF/O8pxM7MFL1NRTzHJDxWTBK5drXYnd0IV55SMdZQmRGmzzVRKmRxxtPY3Kqi6VgMgWEBPRQzHgoI8QMyz/aPqAFJXV7btZuBP3fLsv1OYp5GjZzFcfAfxV4v2g0qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328760; c=relaxed/simple;
	bh=81DSkTBtZfhKxAwgC/QW35hL84MtsiPV9NTiX3nJPdk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CC83OUHs7dyaKPvI6do1XBVjbOx39gBQfusLXK3YuXwdnememS9Naw/ojmaqGJBs9HAQORYRXbtWq5Qf5X0pgOzfltw0TKZEo5pWuDa2iqk24FNYQgCAmqhqywi3z2r7DWMV0WC37/1RpaopjRGHlLVppj93xLTT31hR5MBu+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLCj26A/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD595C4CEEF;
	Sat, 12 Jul 2025 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752328760;
	bh=81DSkTBtZfhKxAwgC/QW35hL84MtsiPV9NTiX3nJPdk=;
	h=Subject:To:Cc:From:Date:From;
	b=DLCj26A/TS4/pOB4rQ2pHJLADL3cZbCuMct6DlckjdJTMZdTzg5nD8WV3+jxvzmPx
	 FSw59EMqaI8BNpQG+Xl5biD9bdnU7h2BpNSLopRMotXvjnaHmOOOAlSRN2Wo9a9i6A
	 nvfZXL2SHRoKsHPrb0bsZxm5ZKR0qVaAJDX0Pk7s=
Subject: FAILED: patch "[PATCH] ASoC: fsl_sai: Force a software reset when starting in" failed to apply to 5.4-stable tree
To: arun@asymptotic.io,broonie@kernel.org,festevam@gmail.com,p.camerlynck@televic.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Jul 2025 15:58:59 +0200
Message-ID: <2025071259-appendage-epidemic-aae1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x dc78f7e59169d3f0e6c3c95d23dc8e55e95741e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071259-appendage-epidemic-aae1@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc78f7e59169d3f0e6c3c95d23dc8e55e95741e2 Mon Sep 17 00:00:00 2001
From: Arun Raghavan <arun@asymptotic.io>
Date: Thu, 26 Jun 2025 09:08:25 -0400
Subject: [PATCH] ASoC: fsl_sai: Force a software reset when starting in
 consumer mode

On an imx8mm platform with an external clock provider, when running the
receiver (arecord) and triggering an xrun with xrun_injection, we see a
channel swap/offset. This happens sometimes when running only the
receiver, but occurs reliably if a transmitter (aplay) is also
concurrently running.

It seems that the SAI loses track of frame sync during the trigger stop
-> trigger start cycle that occurs during an xrun. Doing just a FIFO
reset in this case does not suffice, and only a software reset seems to
get it back on track.

This looks like the same h/w bug that is already handled for the
producer case, so we now do the reset unconditionally on config disable.

Signed-off-by: Arun Raghavan <arun@asymptotic.io>
Reported-by: Pieterjan Camerlynck <p.camerlynck@televic.com>
Fixes: 3e3f8bd56955 ("ASoC: fsl_sai: fix no frame clk in master mode")
Cc: stable@vger.kernel.org
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://patch.msgid.link/20250626130858.163825-1-arun@arunraghavan.net
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index af1a168d35e3..50af6b725670 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -803,13 +803,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	 * anymore. Add software reset to fix this issue.
 	 * This is a hardware bug, and will be fix in the
 	 * next sai version.
+	 *
+	 * In consumer mode, this can happen even after a
+	 * single open/close, especially if both tx and rx
+	 * are running concurrently.
 	 */
-	if (!sai->is_consumer_mode[tx]) {
-		/* Software Reset */
-		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
-		/* Clear SR bit to finish the reset */
-		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
-	}
+	/* Software Reset */
+	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
+	/* Clear SR bit to finish the reset */
+	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
 }
 
 static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,


