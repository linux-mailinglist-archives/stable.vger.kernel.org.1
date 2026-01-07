Return-Path: <stable+bounces-206229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DF0D00331
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 22:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4194C309A6F2
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1868C3358C2;
	Wed,  7 Jan 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="HhraP5iT"
X-Original-To: stable@vger.kernel.org
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C5332912;
	Wed,  7 Jan 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821827; cv=none; b=BRnQCQjvMShwsM1KMA6s48NOidjrSGySJIrLxiQXNQcd3RLm0MpbdIem1kncEsku8IltniM7iWgwu23VCPUyM3Xxc13RdgjOwWxSAdkBCMzOL85mihjy1FkGXE+JtHQLXC/bRZrYj81cBJRdaBV7Vp5/24bNSFju6ybIy78e2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821827; c=relaxed/simple;
	bh=TN6p14zk4i2fdHlP0UHWZyCKlDsPZybqAunkuk5hWCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVMhT+0cm1nUXofYsWZAQZSAEUP6yseo31bDWvm7dRyOTTV6ml1WJIMSo68aioUTfPFcvRNGomscWo1FM6FPyZF2hm7PAeGsVjAUCZG11Flfd1NSh/UKEeI6gNvZco5CpvtRL9zigYaPlw/m/cykrbQ4NrGXg0s8PknDtFI8Vm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=HhraP5iT; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 093AA3E13A;
	Wed,  7 Jan 2026 22:36:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 093AA3E13A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1767821812; bh=1g5pCNyE2qpUqyl7rpB6YGkIsPLmOcYoaRMFsevthv4=;
	h=From:To:Cc:Subject:Date:From;
	b=HhraP5iTQ3fUS7dXccTK+6p/jO3xyVA6gExtvOoKeDwo+icLHXCfSM91Zs0nlPZZc
	 0V7HP4DFDo5/B6TL8ko8Ix/+8Sn60YDfmmtp8qQH6Huika63b+fP0pTSRxXaicxrTm
	 kOgTetd37NuZl0TfMc2AHC+YFW7IMSPr0JlPb1Sg=
Received: from p1gen7.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Wed,  7 Jan 2026 22:36:47 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: pcm: Improve the fix for race of buffer access at PCM OSS layer
Date: Wed,  7 Jan 2026 22:36:42 +0100
Message-ID: <20260107213642.332954-1-perex@perex.cz>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the error code from snd_pcm_buffer_access_lock() in
snd_pcm_runtime_buffer_set_silence() function.

Found by Alexandros Panagiotou <apanagio@redhat.com>

Fixes: 93a81ca06577 ("ALSA: pcm: Fix race of buffer access at PCM OSS layer")
Cc: stable@vger.kernel.org # 6.15
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 include/sound/pcm.h      | 2 +-
 sound/core/oss/pcm_oss.c | 4 +++-
 sound/core/pcm_native.c  | 9 +++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 58fd6e84f961..a7860c047503 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1402,7 +1402,7 @@ int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream, struct vm_area_s
 #define snd_pcm_lib_mmap_iomem	NULL
 #endif
 
-void snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime);
+int snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime);
 
 /**
  * snd_pcm_limit_isa_dma_size - Get the max size fitting with ISA DMA transfer
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index a82dd155e1d3..b12df5b5ddfc 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1074,7 +1074,9 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 	runtime->oss.params = 0;
 	runtime->oss.prepare = 1;
 	runtime->oss.buffer_used = 0;
-	snd_pcm_runtime_buffer_set_silence(runtime);
+	err = snd_pcm_runtime_buffer_set_silence(runtime);
+	if (err < 0)
+		goto failure;
 
 	runtime->oss.period_frames = snd_pcm_alsa_frames(substream, oss_period_size);
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 68bee40c9ada..932a9bf98cbc 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -730,13 +730,18 @@ static void snd_pcm_buffer_access_unlock(struct snd_pcm_runtime *runtime)
 }
 
 /* fill the PCM buffer with the current silence format; called from pcm_oss.c */
-void snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
+int snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
 {
-	snd_pcm_buffer_access_lock(runtime);
+	int err;
+
+	err = snd_pcm_buffer_access_lock(runtime);
+	if (err < 0)
+		return err;
 	if (runtime->dma_area)
 		snd_pcm_format_set_silence(runtime->format, runtime->dma_area,
 					   bytes_to_samples(runtime, runtime->dma_bytes));
 	snd_pcm_buffer_access_unlock(runtime);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_pcm_runtime_buffer_set_silence);
 
-- 
2.52.0


