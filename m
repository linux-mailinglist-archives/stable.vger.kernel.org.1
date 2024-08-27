Return-Path: <stable+bounces-70523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5191960E91
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2551F21B3A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E861C4EF6;
	Tue, 27 Aug 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQcx1HKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC044C8C;
	Tue, 27 Aug 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770191; cv=none; b=PwR8I7sKNqyQMCe/6ckC90PjM7nI3HCETIlza8phOZD1jrnsExeCYdT4xkuCWRWZVrIUOaTcNpgMaBIHvd0op4fdCWT7kt3YSjM9G2/Er05YtSqmZ2r/oerVkeABszilzGcmVgYhuG72WhVXVwpsgF4TqVT0l+Ff0BNzz0tas6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770191; c=relaxed/simple;
	bh=0SI9gsARQZeNiojTgZ1pjU8myvcKruNnTC8ckRsIF8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n32YGoj9DlcsLHgjZrqOwE0qCHgdqZY+d7QbNo5ysJ5b84hklz5utVgcOeDfOD3rQy017iwOO+9gCCUyyLiuBKPxtp1X0OrNpNste4oIc/prvysXwasvUbIGWp/Dkor2IWEWHSpbWAj8vkrdkrNGdzMCnGnPZhoeCYGot/e+tf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQcx1HKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A6CC4AF53;
	Tue, 27 Aug 2024 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770191;
	bh=0SI9gsARQZeNiojTgZ1pjU8myvcKruNnTC8ckRsIF8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQcx1HKeCrXJJccN/jTQLJBtmAyik/G5kJqBe2VvAEkMoNLetS5uRMZmQ91iBDmUx
	 KddXH34Z+VGAl/BXYgL3tPwKfqAQCNHu1H8v5lcIQgJ2kyMDczWJHRGh5yedcjUATV
	 thnLi3V6ClIzW1InHocMRX3Tcc4d2EvnFT5dYa7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 123/341] ASoC: SOF: Intel: hda-dsp: Make sure that no irq handler is pending before suspend
Date: Tue, 27 Aug 2024 16:35:54 +0200
Message-ID: <20240827143848.097145292@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 576a0b71b5b479008dacb3047a346625040f5ac6 ]

In the existing IPC support, the reply to each IPC message is handled in
an IRQ thread. The assumption is that the IRQ thread is scheduled without
significant delays.

On an experimental (iow, buggy) kernel, the IRQ thread dealing with the
reply to the last IPC message before powering-down the DSP can be delayed
by several seconds. The IRQ thread will proceed with register accesses
after the DSP is powered-down which results in a kernel crash.

While the bug which causes the delay is not in the audio stack, we must
handle such cases with defensive programming to avoid such crashes.

Call synchronize_irq() before proceeding to power down the DSP to make
sure that no irq thread is pending execution.

Closes: https://github.com/thesofproject/linux/issues/4608
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20231012191850.147140-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-dsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index e80a2a5ec56a1..1506982a56c30 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -709,6 +709,9 @@ static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
 	if (ret < 0)
 		return ret;
 
+	/* make sure that no irq handler is pending before shutdown */
+	synchronize_irq(sdev->ipc_irq);
+
 	hda_codec_jack_wake_enable(sdev, runtime_suspend);
 
 	/* power down all hda links */
-- 
2.43.0




