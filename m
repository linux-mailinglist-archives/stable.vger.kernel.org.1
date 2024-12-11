Return-Path: <stable+bounces-100733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6699ED56A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D14F188C07C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257120B20A;
	Wed, 11 Dec 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2X2vbUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9B24881F;
	Wed, 11 Dec 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943150; cv=none; b=sHIZ7cnpZLQBN2qeo3HEgnwnGRZi354LMvER+CwSe6qqlPsDgvQjUrWadt1YGVlRuRDagN2DPo4em2WVeolT1EXvSq3EhhDsvF1mdOirBFLSSvNUgXXHXs95bTFkwaGRmEaXNGzteB+KO2H74N/9vYoJOdd1yWhlHL+FvPt59zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943150; c=relaxed/simple;
	bh=SllFxMOpwNKL0RcooiNm+lR1U7la+6Mrw1LL4Axrag4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlSebFJ+7Dx7kXSxZrfO5cqAgB3znMLA8kUZgsXpUjuNf8e0z0l6rOvvwX7xRZAf+KOAdDZz4Z4v4GHArVE0oa0C5oS5+uSJLqE8Eh6EZKpfeXpETkbgvL//fCjAm1BOf5SK5Lszav2JB5SpoGEYZjCCYshds2miJ9Td/tKBOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2X2vbUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2FDC4CED2;
	Wed, 11 Dec 2024 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943149;
	bh=SllFxMOpwNKL0RcooiNm+lR1U7la+6Mrw1LL4Axrag4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2X2vbUUR2LS8XOfXgiyGNdJ01gkK74YL3JLJVJgsd+k3s+sDiP14ch4fO/3xHNtl
	 ZCok2jNRscoe+ZVp2IiTJe6Zif62EVcY/WAa8IxcmD1gfyVoJYQZf359KLG7PYKO/T
	 p39HoOl1mfQDGuBCa2yh9oukeTKaY9yH/37dIrNqgUtd61Hi7w3K2/1DRwP4jyzvgG
	 9S2afHxp7MaaDNcm8ns9xT0WdMoqU8t5k0hBdk5M7dXIX87LgtJfZquBwpC6vGP69b
	 tlp1IcU6ug87elflUSBltOqZ4OJDoIemI0hYpDVnoK5CgjiI+xW16jAfJiV1y5g0bo
	 qGjltKdGGKI0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	u.kleine-koenig@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/23] ALSA: sh: Use standard helper for buffer accesses
Date: Wed, 11 Dec 2024 13:51:44 -0500
Message-ID: <20241211185214.3841978-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 9b5f8ee43e48c25fbe1a10163ec04343d750acd0 ]

The SH DAC audio driver uses the kmalloc'ed buffer as the main PCM
buffer, and the data is transferred via hrtimer callbacks manually
from there to the hardware.  Meanwhile, some of its code are written
as if the buffer is on iomem and use the special helpers for the iomem
(e.g. copy_from_iter_toio() or memset_io()).  Those are rather useless
and the standard helpers should be used.

Similarly, the PCM mmap callback is set to a special one with
snd_pcm_lib_mmap_iomem, but this is also nonsense, because SH
architecture doesn't support this function, hence it leads just to
NULL -- the fallback to the standard helper.

This patch replaces those special setups with the standard ones.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411281337.I4M07b7i-lkp@intel.com/
Link: https://patch.msgid.link/20241128104939.13755-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/sh/sh_dac_audio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 95ba3abd4e47e..36a973d1c46df 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -163,7 +163,7 @@ static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream,
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
 
-	if (copy_from_iter_toio(chip->data_buffer + pos, src, count))
+	if (copy_from_iter(chip->data_buffer + pos, src, count) != count)
 		return -EFAULT;
 	chip->buffer_end = chip->data_buffer + pos + count;
 
@@ -182,7 +182,7 @@ static int snd_sh_dac_pcm_silence(struct snd_pcm_substream *substream,
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
 
-	memset_io(chip->data_buffer + pos, 0, count);
+	memset(chip->data_buffer + pos, 0, count);
 	chip->buffer_end = chip->data_buffer + pos + count;
 
 	if (chip->empty) {
@@ -211,7 +211,6 @@ static const struct snd_pcm_ops snd_sh_dac_pcm_ops = {
 	.pointer	= snd_sh_dac_pcm_pointer,
 	.copy		= snd_sh_dac_pcm_copy,
 	.fill_silence	= snd_sh_dac_pcm_silence,
-	.mmap		= snd_pcm_lib_mmap_iomem,
 };
 
 static int snd_sh_dac_pcm(struct snd_sh_dac *chip, int device)
-- 
2.43.0


