Return-Path: <stable+bounces-148313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2FFAC93D0
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD01173B53
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA962343C0;
	Fri, 30 May 2025 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Hy0nElZe"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD41C6FE8;
	Fri, 30 May 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623491; cv=none; b=h7/Pi4PSV0jxC7jGwB1NLCGG2nmOfzBeFQ5wM0Ha2J0BEwT5LZf/Usv7SGhOnP18pM/IfqolJItdAx/+UPyjUeWZYejKrRi/cBjPJiiCHCVCeUOsjX5zo0Ja1GKQ/BDieg6vtjCec79PColrNhmb4qf1GBkeGQd9GOzfty/kvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623491; c=relaxed/simple;
	bh=N63jKpGiCSXNWDphomYejhXm4R3ctp0/FkZ77iqGKfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e84gkhYYweglTqO939+skrDZCrvJgcucZPdCzYgqRhlVTymlzbIMc8IpAwX0AgW/A1a4fn4E6BZuhUNaIheP0xXh7wRn94yW8bC2/8QeQ6WH1w6ebPVACoJduNlxGtydd+Fi5MqdlZOcr8R68ukCdbKxlsWUdWdRSj/BI0by7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Hy0nElZe; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id 01B994076165;
	Fri, 30 May 2025 16:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 01B994076165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748623482;
	bh=fPS9KLJ/Uc9OoO0w2alburJ4UW3qX59EuFMYSOSI0iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hy0nElZeftqtkdS9jx271XZtlE7wOHh2eUSunioomRU4HmPCx6MqLHnkEBqAQKlCT
	 Dq+k2QEU27qC64z/zyJ8yJbcQbnER/ouHR2vgAm0QK1TfjJiqGIW5986FcTKoYLsHf
	 yvr6Wjcl1EKnbvyd7cUDQGTZQsnBSEi193MHAQWQ=
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
Subject: [PATCH 3/3] ASoC: amd: acp3x-pdm-dma: free pdm device data on closing
Date: Fri, 30 May 2025 19:44:16 +0300
Message-ID: <20250530164425.119102-4-pchelkin@ispras.ru>
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
acp_pdm_dma_open() and needs to be freed in the corresponding ->close()
callback.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4a767b1d039a ("ASoC: amd: add acp3x pdm driver dma ops")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 95ac8c680037..6b294040e164 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -301,9 +301,11 @@ static int acp_pdm_dma_close(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream)
 {
 	struct pdm_dev_data *adata = dev_get_drvdata(component->dev);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	disable_pdm_interrupts(adata->acp_base);
 	adata->capture_stream = NULL;
+	kfree(runtime->private_data);
 	return 0;
 }
 
-- 
2.49.0


