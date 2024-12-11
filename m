Return-Path: <stable+bounces-100704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194F9ED50B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232CE28445B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F5D239BBB;
	Wed, 11 Dec 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll2xSNGs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98C239BB3;
	Wed, 11 Dec 2024 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943060; cv=none; b=r1ofNT6TONyMCzv3Aft3kc5ehUvwHA9GttAX5OJwcOHzaZsnMcMHU7i8EWLno7VJR4HkL67ZC06X9PjF8wVrIL7LljTbxND2OlKayx9eoN4gODmmElyGTxb6Y7EQcyC6VwNm1hYDmp6gUjgI5f3aVhD9zrvMbJO9os7T/ev1Dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943060; c=relaxed/simple;
	bh=zOSeGU4H+i7RSqaaHl8BsDlAjnT0qNXTMMi396+RqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuiDFsu47KK3rbQz9UsYf4ul9IUoc0uILz3ahN2BKIy1SpzLMgX9TJiXmJetn8vufCEl6pzm+L84Afv9PNOcfKNCchMeu0cXkZ0HJv62yZigk27x0nPZ825iC0wLU8sMwawJFAKpzoSGOFDsspdjfeQhIeEjt+FuOBqlkouln/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll2xSNGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6A2C4CED2;
	Wed, 11 Dec 2024 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943059;
	bh=zOSeGU4H+i7RSqaaHl8BsDlAjnT0qNXTMMi396+RqqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ll2xSNGssehhP0BQKqYqVTOnqsthmKFdMtVlrC+fM22EsSFM97SryZ25OA6bN2Lsn
	 q4EweU5XLuXFYUw4vBEbq+HyJQFFBN/1xg+bPgQVb7HbrT7+r0Phkg6zfzhYn1tHQF
	 /iYTpBMBjoGZq584i0lULFrDuTwM/XC4oXmITlLSrMSi1PHwC4d5SdMa301GfYKVcz
	 1wQ/VDK2FWy/YSWnYzA+D2g4kVTJuNpR/sKKGskwGgpalLm2IGwQWE0A3KfSJCSA1v
	 2E5LWWuI37dZTJhryI6owA6joD7k2snA7ZQgiYxL8tMF/lWbDcJOhWubKJRq4FZHap
	 WOPxk8rGvhz/g==
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
Subject: [PATCH AUTOSEL 6.12 14/36] ALSA: sh: Use standard helper for buffer accesses
Date: Wed, 11 Dec 2024 13:49:30 -0500
Message-ID: <20241211185028.3841047-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
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
index e7b6ce7bd086b..5a9f77908a3d2 100644
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


