Return-Path: <stable+bounces-161721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FECEB02B24
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 15:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58345188BABC
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A77527877B;
	Sat, 12 Jul 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aHa7uOB9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C042277C9D
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328750; cv=none; b=D2yGfJ2MK5mPJL73+lulh6/VPU2YRt/ZTx2LasMAcCMn4rXMZz6zPFFbAho40uwj1lKNEmScDsG5TBRIGEaEpLdfLUN90e3u0OStepnx4oH/wNF/dFS9I1YCdFOs8YlwsOyqrbXYLho0FUYur6CojQxSW3S7WDtbqyombqpyyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328750; c=relaxed/simple;
	bh=d+UckrvHeCpfa9KPWnStDuL6grc4OI4FiknjZsPTklA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YelbaIHKyaDkRHDkwF3EVRN4bkuy1mI65SO/krlQsctFy6oYsmYNY84SusNQypxkrlgEeHSU31/WnZLCO8DLr6MAvkdDK0GmFlRw3v0Rt00rQ6JNnOtJPX9vXX7kU/pH4JRjQyai1mwZNpfqSLJM9AvF16SXNpmbV5/joMGK2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aHa7uOB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C844C4CEEF;
	Sat, 12 Jul 2025 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752328749;
	bh=d+UckrvHeCpfa9KPWnStDuL6grc4OI4FiknjZsPTklA=;
	h=Subject:To:Cc:From:Date:From;
	b=aHa7uOB9UYp3zIBp8g6LyfLB/kXxzeIInNyhpBxR10FiZU7ioqLHpKK25hTwv6VSA
	 6g51YvvBKJxN4kxcu6qHZQrUkGApKW0wnQ3GrYZumXb9KLwsQb+ojoIxqEYxhjYAqh
	 n39VPdml0qrkyYO296rFkr6Jbism0qra95IPR4Hs=
Subject: FAILED: patch "[PATCH] ASoC: fsl_sai: Force a software reset when starting in" failed to apply to 6.6-stable tree
To: arun@asymptotic.io,broonie@kernel.org,festevam@gmail.com,p.camerlynck@televic.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Jul 2025 15:58:56 +0200
Message-ID: <2025071256-clobber-annotate-b978@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dc78f7e59169d3f0e6c3c95d23dc8e55e95741e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071256-clobber-annotate-b978@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


