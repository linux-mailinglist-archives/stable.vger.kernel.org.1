Return-Path: <stable+bounces-148312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A7AC93D1
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E8B1C20F9E
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9C0231A24;
	Fri, 30 May 2025 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="V6BBeaf/"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE71BCA0E;
	Fri, 30 May 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623491; cv=none; b=F/29BQzSVLePTXOk9RTdkQUM0lMRyARteqbHfge6k2O2Zyh3C6b707cdvnjBWX+pJcj48dqRi6EO+KXJLFh2NPo3JoIvpKtJra7jpcThRF1NAUJS/IRY+JTHYVJpFpLp+YuPeppzqVzrT3OpYMIfVcwT6E51htRWJBgYpg4DvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623491; c=relaxed/simple;
	bh=pnlJNPcUuqtCQJ0GorYkGddvDrovEEiy2acoompiKnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhHRAFEkicu1FFmds9JUDPhFecjN4FeiDipb2VUdU1bb/bXXJU+7GdOcMY0syQrjH9pAXgse474WIpRF0oe7CgaTLVrQm+3wf/GlsRhse9AAn00GP5UQ+lcxJZkEQahqPws6rmCZx/4jrqnqVqiWrrMxK2dXatSEFrqNaG1SZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=V6BBeaf/; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2F3244076163;
	Fri, 30 May 2025 16:44:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2F3244076163
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748623481;
	bh=UNuEQvm7/1gsXQttRw7MHCKWoS1+gRNZE9/oQ9glN2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6BBeaf/jNuppOTjilT7ucd1b7EyOJtf5vYqhX9JgFc3KRXk4zWzhdpKczMWvCh4I
	 YysttXLFMFagj+hZxo8VWqMuzqpPifhaW9yjD43DBjPmueiP0VAOCneMB83R0Sh7rY
	 hz2GdrbmnyMCtAGUNq45gMDls65pKqTEBxnWxLqw=
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
Subject: [PATCH 2/3] ASoC: amd: acp3x-pcm-dma: free runtime private data on closing
Date: Fri, 30 May 2025 19:44:15 +0300
Message-ID: <20250530164425.119102-3-pchelkin@ispras.ru>
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
acp3x_dma_open() and needs to be freed in the corresponding ->close()
callback.

Found by Linux Verification Center (linuxtesting.org).

Fixes: c9fe7db6e884 ("ASoC: amd: Refactoring of DAI from DMA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index bb9ed52d744d..90559c8304bc 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -353,7 +353,7 @@ static int acp3x_dma_close(struct snd_soc_component *component,
 			adata->i2ssp_capture_stream = NULL;
 		}
 	}
-
+	kfree(ins);
 	return 0;
 }
 
-- 
2.49.0


