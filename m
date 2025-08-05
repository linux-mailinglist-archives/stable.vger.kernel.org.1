Return-Path: <stable+bounces-166661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8476B1BD74
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED61A17D57B
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8AB1D61AA;
	Tue,  5 Aug 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m5uxXU3f"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7064315E
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437336; cv=none; b=C17d+scXAZoVxvI19YQcxP3En8FOF1q3VcMK2C8PjH/Urfbp8L/pMhrhOjq3LZoGyL6AGwOV77wz9ZRt76Esi7VRqlzclO7CXxY99opI9dX7wL9DFLPPeA7YZk2A1yuCSEuKLNxgJQlOA0oVrjJvVMr4SESvKe0fhvbTalNvSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437336; c=relaxed/simple;
	bh=/jtN9awwVbOPVWc3dr62v/y502n3rqHyUG1C8pKVe0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejq+Gf016290QfK1qtIbBGo+6WP4A+kKXBxIZB7bPpqHhZLcjDi/UZkgQASCfMtvnRTGAkZRsC+CnemFR3fcmm2r1J6JwHZVd1oLlbNsQ7hi67EChtzjP01cQZALM4VwSPSKjnfAlrCA12Kj9D4hPPjZkjH42A7hZuH0VcwhKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m5uxXU3f; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754437330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nkx09rJ+LEyAgM4BQY44PNDPxqhQRPaCfDjd4zu2Xf0=;
	b=m5uxXU3fLsHGhx8s2GlaFlkQRKJE2HkCeNroSmNnBZSpr47LznJZTRumGsLl6c2/9/Cexc
	/vI69E4MozuYi+fWBbXtHUjJd27c4Rk3KfIxQXKiGpye67RIXmBmyQ7OUmBxCjPOjjsTr0
	AR5GK8T226I36K6H3ZTcr1Pkvuv0TEY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Joe Perches <joe@perches.com>,
	Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()
Date: Wed,  6 Aug 2025 01:41:53 +0200
Message-ID: <20250805234156.60294-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In __hdmi_lpe_audio_probe(), strscpy() is incorrectly called with the
length of the source string (excluding the NUL terminator) rather than
the size of the destination buffer. This results in one character less
being copied from 'card->shortname' to 'pcm->name'.

Use the destination buffer size instead to ensure the card name is
copied correctly.

Cc: stable@vger.kernel.org
Fixes: 75b1a8f9d62e ("ALSA: Convert strlcpy to strscpy when return value is unused")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use three parameter variant of strscpy() for backporting as suggested
  by Sakari Ailus <sakari.ailus@linux.intel.com>
- Link to v1: https://lore.kernel.org/lkml/20250805190809.31150-1-thorsten.blum@linux.dev/
---
 sound/x86/intel_hdmi_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index cc54539c6030..01f49555c5f6 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1765,7 +1765,7 @@ static int __hdmi_lpe_audio_probe(struct platform_device *pdev)
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strscpy(pcm->name, card->shortname, strlen(card->shortname));
+		strscpy(pcm->name, card->shortname, sizeof(pcm->name));
 		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 
-- 
2.50.1


