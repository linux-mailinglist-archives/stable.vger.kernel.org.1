Return-Path: <stable+bounces-148314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0436AC93D4
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1397AB17F
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB72356A9;
	Fri, 30 May 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="oJEh+szW"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049315DBB3;
	Fri, 30 May 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623492; cv=none; b=RtNRg1fhzY+n8HM//f72s6Us02nS88NqCUPi/QRY5KOvclDqcMgnX1I+dI6KFmxOQdwPz9bPzpFkmbJyigUHLDWhz2ujULm84aVraIzbucY+ZIzGV2X93h09i1NTm3i40MqHIjLcpWjnptiXmlAcweIEjBATjhjU4ta6za9WERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623492; c=relaxed/simple;
	bh=+ITI/lJciWXQ2zEFJZJYQzwqSQqACYyW4DyGzLZwJHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jppi3rftereiGzz8xdM2LxlqWkakuPOSR95cPO0gRFkqlJx/0SgWuP2LMsZMrI17GgahZ9Jnf1ewPxXi9bWhGGR2DkVYIVhs9LOhR3EWRm2z8+nt/6QADhsjrNko18PF0OW7Uv/MorhySWSZlEySHlEQqm9XdRIi12HmnYvOYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=oJEh+szW; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1597B40755EB;
	Fri, 30 May 2025 16:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1597B40755EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748623480;
	bh=hJKih8Dm6t83pwIHhRWysbIb0HcBG92LURaVZy9gSD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJEh+szW8UKbvRHMcqaPgwj9p0D+Nb6wS2z0fhr/30hz3GgJDi2i3e6MzMZlQqAkd
	 bs1+VzwF4Jzs7ReQnS9lULPhoA5mjAGCBFOXg12im02aw+jhbOmrLfmUWakn6eJDae
	 b//4ueSClqxU9PCkgkKTin1P5hCY16pSlqDk4NTg=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Jaroslav Kysela <perex@perex.cz>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: amd: acp6x-pdm-dma: free pdm device data on closing
Date: Fri, 30 May 2025 19:44:14 +0300
Message-ID: <20250530164425.119102-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530164425.119102-1-pchelkin@ispras.ru>
References: <20250530164425.119102-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic memory referenced by runtime->private_data pointer is allocated in
acp6x_pdm_dma_open() and needs to be freed in the corresponding ->close()
callback.

unreferenced object 0xffff88813525a940 (size 32):
  comm "pipewire", pid 1238, jiffies 4294728195
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 3c 03 00 c9 ff ff  ..........<.....
  backtrace (crc 14400236):
    __kmalloc_cache_noprof+0x3a3/0x490
    acp6x_pdm_dma_open+0x10d/0x680 [snd_acp6x_pdm_dma]
    snd_soc_component_open+0x71/0x150 [snd_soc_core]
    __soc_pcm_open+0x221/0xb40 [snd_soc_core]
    soc_pcm_open+0x99/0x110 [snd_soc_core]
    snd_pcm_open_substream+0x18b/0x4e0 [snd_pcm]
    snd_pcm_open+0x244/0x670 [snd_pcm]
    snd_pcm_capture_open+0x72/0xd0 [snd_pcm]
    chrdev_open+0x1eb/0x5e0
    do_dentry_open+0x494/0x1820
    vfs_open+0x7a/0x440
    do_open+0x3d0/0xd30
    path_openat+0x1d3/0x580
    do_filp_open+0x1c5/0x450
    do_sys_openat2+0xef/0x180
    __x64_sys_openat+0x10e/0x210

Found by Linux Verification Center (linuxtesting.org).

Fixes: ceb4fcc13ae5 ("ASoC: amd: add acp6x pdm driver dma ops")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 sound/soc/amd/yc/acp6x-pdm-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index ac758b90f441..167cd792d33d 100644
--- a/sound/soc/amd/yc/acp6x-pdm-dma.c
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -275,9 +275,11 @@ static int acp6x_pdm_dma_close(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream)
 {
 	struct pdm_dev_data *adata = dev_get_drvdata(component->dev);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	acp6x_disable_pdm_interrupts(adata->acp6x_base);
 	adata->capture_stream = NULL;
+	kfree(runtime->private_data);
 	return 0;
 }
 
-- 
2.49.0


