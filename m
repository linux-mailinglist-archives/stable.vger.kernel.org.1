Return-Path: <stable+bounces-67006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B494F37D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8D0B22561
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB23187328;
	Mon, 12 Aug 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rBwdaKh+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA81186E34;
	Mon, 12 Aug 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479491; cv=none; b=e+cEmGs5wgnUCDGsE5vwbxxFwtSFsn1qCe1RMGM3tWefRafhHfabpqOAJLKsFesOOUGG9VULLe78LiFECEAdbLfOlmEbadHxjFyuUOV4rjVeTTIGoaONCI5h4kuxeHSFzqmRuFC6bpxxq6GQwu8vP5GdHA8I00C6VNwh816gKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479491; c=relaxed/simple;
	bh=DKW0HUdNifbaNccycnemhPUjj0cTOHPVPPgozvtwFCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEUibpkFWOPjbLMPhVR9ouuaQqQ/5DCxAUfkDSLXR3GBerO+A6/e6AkeOYb4Cl2zM4ue8QzVtI8ie+osUOBC+YpAB+RoqogTWN32g/8PKwy3wP/DhMZ1xW+wdV8pl8nHtYmZtk/TdwRb3gk2vMOgFQ/ppjlXwaqqMKwHPD2BDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rBwdaKh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005C6C32782;
	Mon, 12 Aug 2024 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479490;
	bh=DKW0HUdNifbaNccycnemhPUjj0cTOHPVPPgozvtwFCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBwdaKh+R08a3FRAt1kb0yAAw66jwdlHzSPoNCFdAaamqlAgOVjQLlwGfCtCIgqev
	 xdTUP2dJFyBoAjE2z9QY6V7yeqtUIDyplgOovghleMtfFtqsRhJP2gShlcT89S0dJx
	 ZOjB+8ech6o30cG83QbadxobVYmPxba5AYEu15ks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 104/189] ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT
Date: Mon, 12 Aug 2024 18:02:40 +0200
Message-ID: <20240812160136.145144580@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 5003d0ce5c7da3a02c0aff771f516f99731e7390 ]

With PREEMPT_RT enabled a spinlock_t becomes a sleeping lock.

This is usually not a problem with spinlocks used in IRQ context since
IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the primary
handler won't be force-threaded and runs always in hardirq context. This is
a problem because spinlock_t requires a preemptible context on PREEMPT_RT.

In this particular instance, regmap mmio uses spinlock_t to protect the
register access and IRQF_ONESHOT is set on the IRQ. In this case, it is
actually better to do everything in threaded handler and it solves the
problem with PREEMPT_RT.

Reported-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Closes: https://lore.kernel.org/linux-amlogic/20240729131652.3012327-1-avkrasnov@salutedevices.com
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: b11d26660dff ("ASoC: meson: axg-fifo: use threaded irq to check periods")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20240807162705.4024136-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-fifo.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 94b169a5493b5..5218e40aeb1bb 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -207,25 +207,18 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 	status = FIELD_GET(STATUS1_INT_STS, status);
 	axg_fifo_ack_irq(fifo, status);
 
-	/* Use the thread to call period elapsed on nonatomic links */
-	if (status & FIFO_INT_COUNT_REPEAT)
-		return IRQ_WAKE_THREAD;
+	if (status & ~FIFO_INT_COUNT_REPEAT)
+		dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
+			status);
 
-	dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
-		status);
+	if (status & FIFO_INT_COUNT_REPEAT) {
+		snd_pcm_period_elapsed(ss);
+		return IRQ_HANDLED;
+	}
 
 	return IRQ_NONE;
 }
 
-static irqreturn_t axg_fifo_pcm_irq_block_thread(int irq, void *dev_id)
-{
-	struct snd_pcm_substream *ss = dev_id;
-
-	snd_pcm_period_elapsed(ss);
-
-	return IRQ_HANDLED;
-}
-
 int axg_fifo_pcm_open(struct snd_soc_component *component,
 		      struct snd_pcm_substream *ss)
 {
@@ -251,8 +244,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	ret = request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
-				   axg_fifo_pcm_irq_block_thread,
+	/* Use the threaded irq handler only with non-atomic links */
+	ret = request_threaded_irq(fifo->irq, NULL,
+				   axg_fifo_pcm_irq_block,
 				   IRQF_ONESHOT, dev_name(dev), ss);
 	if (ret)
 		return ret;
-- 
2.43.0




