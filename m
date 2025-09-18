Return-Path: <stable+bounces-176011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8BB36C21
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0294F9823CF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A835334E;
	Tue, 26 Aug 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WswoC13s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA0345726;
	Tue, 26 Aug 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218552; cv=none; b=b0pcAkXauhIZTjL9m8MEvibbXmCZafHEVx5d+TcOyTI/LlIglqNhbBxMVrLFjYZ4WI7fteqhUymcg2ZxQKL4LilEJP4U6/8vMuinZ/MO8nAlzyNisPKQv607e7P6mXc9ehUTn0Yr4xe6iRu+/z7G3UIx6jy1dwmJOKMS/gSgCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218552; c=relaxed/simple;
	bh=l7/6wYpd/iTNnTHEOluzlSANxlqxNPVvMbHarcr/v+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTIuzINOrF8HZ5REvEKniy3yptXerB7j3dpVPyThdDGe/gR15kmcBXueFAFT7KyJpxZTuDZDri00GDB5/4TGK88kgnZeLSoKBsMaq6Ebl22foHFMG1recx1hB2IBWTUEHTbaLVc/1vJU0+gC6RJJ2P9jNyFtk7v593llxQy2eVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WswoC13s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7533EC4CEF1;
	Tue, 26 Aug 2025 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218551;
	bh=l7/6wYpd/iTNnTHEOluzlSANxlqxNPVvMbHarcr/v+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WswoC13s7Si2ENTZKtRz4LSPMmvsPp080u3aB8OsZP7iMbFF3p9pB1qysI9mFEwyH
	 ImrvHVOiaiEk/Wu6SObcs/Mz0aYcIBBrO7gouZ7X24Wkksy6VQaYV3tzFncOCV1EhC
	 asDs3vcjrx2SVLtmGn4dAFXoo06i/1QsFOe5qO04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arun Raghavan <arun@asymptotic.io>,
	Pieterjan Camerlynck <p.camerlynck@televic.com>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 042/403] ASoC: fsl_sai: Force a software reset when starting in consumer mode
Date: Tue, 26 Aug 2025 13:06:08 +0200
Message-ID: <20250826110906.985663454@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arun Raghavan <arun@asymptotic.io>

commit dc78f7e59169d3f0e6c3c95d23dc8e55e95741e2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_sai.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -565,13 +565,15 @@ static void fsl_sai_config_disable(struc
 	 * anymore. Add software reset to fix this issue.
 	 * This is a hardware bug, and will be fix in the
 	 * next sai version.
+	 *
+	 * In consumer mode, this can happen even after a
+	 * single open/close, especially if both tx and rx
+	 * are running concurrently.
 	 */
-	if (!sai->is_slave_mode) {
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



