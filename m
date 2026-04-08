Return-Path: <stable+bounces-234508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JkvGfmi1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:48:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98CB3C197C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFA7301779E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4753AF643;
	Wed,  8 Apr 2026 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDC8yevk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958C36166F;
	Wed,  8 Apr 2026 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673042; cv=none; b=YyX1wdmkhaLlOX/Mzw6T9fhgXflJwM1wz2wIL6tlUFYYq1MmHcC43Xc7V5SKkPZfaZJliZtwExofJZb+GH4ex1vthOliNChi1M1jH5Bu9dsdCvtSwCdfYDDjNXge7JEg64QFw0eYtQYKWTvUwbc/LSnCPti8miM+NEfXeQVIzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673042; c=relaxed/simple;
	bh=PowZaHGGXlGqn7OItFaAX59S5OZl76LLFqt+oM1ci+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVbD6HYUa5G4RjWWqYJ9Ze7TpY+xILzJpuBW+3+rcqlkARQD+wx0xwnYg4VSqCE25wSIwm70R/LWDvv9jOELFH7P9egcj6aSRl744m5sWbpb8Iw56McaJzBDXj2EWBcPogIsV8vb2Pl2QHxuxpkDgjmwhYoQnNGgPSuCIRNmOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDC8yevk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEFCC19421;
	Wed,  8 Apr 2026 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673042;
	bh=PowZaHGGXlGqn7OItFaAX59S5OZl76LLFqt+oM1ci+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDC8yevkWeCU/g+/TzfbPgrh6b0/YfGydSI3LebUai6esuGh1Xes0+Ou1+AdQ95w8
	 jyKh53/OTpYqD+lL/nhRwtBWZ2jiU9pofP1g+tT1N2+1EGUSGnxf5mYH19Mq/lyfVR
	 RfKHt65I2pQ8pVDbm604lk0wrIElifY/XpsKjq3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jihed Chaibi <jihed.chaibi.dev@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 046/277] ASoC: ep93xx: Fix unchecked clk_prepare_enable() and add rollback on failure
Date: Wed,  8 Apr 2026 20:00:31 +0200
Message-ID: <20260408175935.577897724@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234508-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E98CB3C197C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

[ Upstream commit 622363757b2286dd2c2984b0d80255cbb35a0495 ]

ep93xx_i2s_enable() calls clk_prepare_enable() on three clocks in
sequence (mclk, sclk, lrclk) without checking the return value of any
of them. If an intermediate enable fails, the clocks that were already
enabled are never rolled back, leaking them until the next disable cycle
— which may never come if the stream never started cleanly.

Change ep93xx_i2s_enable() from void to int. Add error checking after
each clk_prepare_enable() call and unwind already-enabled clocks on
failure. Propagate the error through ep93xx_i2s_startup() and
ep93xx_i2s_resume(), both of which already return int.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Fixes: f4ff6b56bc8a ("ASoC: cirrus: i2s: Prepare clock before using it")
Link: https://patch.msgid.link/20260324210909.45494-1-jihed.chaibi.dev@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/cirrus/ep93xx-i2s.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index cca01c03f0486..5dba741594fab 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -91,16 +91,28 @@ static inline unsigned ep93xx_i2s_read_reg(struct ep93xx_i2s_info *info,
 	return __raw_readl(info->regs + reg);
 }
 
-static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
+static int ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 {
 	unsigned base_reg;
+	int err;
 
 	if ((ep93xx_i2s_read_reg(info, EP93XX_I2S_TX0EN) & 0x1) == 0 &&
 	    (ep93xx_i2s_read_reg(info, EP93XX_I2S_RX0EN) & 0x1) == 0) {
 		/* Enable clocks */
-		clk_prepare_enable(info->mclk);
-		clk_prepare_enable(info->sclk);
-		clk_prepare_enable(info->lrclk);
+		err = clk_prepare_enable(info->mclk);
+		if (err)
+			return err;
+		err = clk_prepare_enable(info->sclk);
+		if (err) {
+			clk_disable_unprepare(info->mclk);
+			return err;
+		}
+		err = clk_prepare_enable(info->lrclk);
+		if (err) {
+			clk_disable_unprepare(info->sclk);
+			clk_disable_unprepare(info->mclk);
+			return err;
+		}
 
 		/* Enable i2s */
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 1);
@@ -119,6 +131,8 @@ static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_TXCTRL,
 				     EP93XX_I2S_TXCTRL_TXEMPTY_LVL |
 				     EP93XX_I2S_TXCTRL_TXUFIE);
+
+	return 0;
 }
 
 static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
@@ -195,9 +209,7 @@ static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
 {
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
-	ep93xx_i2s_enable(info, substream->stream);
-
-	return 0;
+	return ep93xx_i2s_enable(info, substream->stream);
 }
 
 static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
@@ -373,14 +385,16 @@ static int ep93xx_i2s_suspend(struct snd_soc_component *component)
 static int ep93xx_i2s_resume(struct snd_soc_component *component)
 {
 	struct ep93xx_i2s_info *info = snd_soc_component_get_drvdata(component);
+	int err;
 
 	if (!snd_soc_component_active(component))
 		return 0;
 
-	ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_PLAYBACK);
-	ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_CAPTURE);
+	err = ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_PLAYBACK);
+	if (err)
+		return err;
 
-	return 0;
+	return ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_CAPTURE);
 }
 #else
 #define ep93xx_i2s_suspend	NULL
-- 
2.53.0




