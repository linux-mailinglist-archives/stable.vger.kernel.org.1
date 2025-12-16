Return-Path: <stable+bounces-202003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFCECC4681
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE7E30CAC91
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4CD3563C1;
	Tue, 16 Dec 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RWaMjFjW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35A3563C4;
	Tue, 16 Dec 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886506; cv=none; b=iAncj9jaqf3XSZZcvz9UFe18uqc5s+qtSyLphtZe3zfFgEmpc2u5YSH0heg2llLXVSpKQwiGHA630h/pwjsIOy1PvjjBu992fbjR4ktberQul6at2WK7jlN5kk2MQ9e0D639qR1+yDcMpFt70qgm1PZBZ9PNMCEQMQ9IKd/GvoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886506; c=relaxed/simple;
	bh=f0p3m4Bgthzly0S2dUFHfWtlP3ZCcxP5Cd3l04HnWzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGA/n5ynVrcdCQc0H64/WnrER24wgSWoxDKCQD+6DnEJIoHzrf8o7nfOhFCZMvTiKdk9XKh96fRfbnWLq+2/pAlONFocswHklz2R7isE4Z8qsmT3C2mu95ozIRXveGUPILc1IDU/BAe38ugn6CSn9CKcOeuKB7tYkl0f96frGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RWaMjFjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08024C4CEF1;
	Tue, 16 Dec 2025 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886505;
	bh=f0p3m4Bgthzly0S2dUFHfWtlP3ZCcxP5Cd3l04HnWzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWaMjFjWynyiG2C4pAl1QaxbbpXThFvCF4eWbbzC/CngMoP4jO6z+K5orXgURMY+s
	 bp8u8Gc76iVYFEs2kWerxnbluHgJdO3tIm8mr5Hdbw8uIt5VRTIdcXST7NtymTKiyB
	 TZtbNAmo+xDX6P+jXdj7eI6VLjXMV5fH6RXh/rqE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 455/507] ASoC: bcm: bcm63xx-pcm-whistler: Check return value of of_dma_configure()
Date: Tue, 16 Dec 2025 12:14:56 +0100
Message-ID: <20251216111401.933667541@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 0ebbd45c33d0049ebf5a22c1434567f0c420b333 ]

bcm63xx_soc_pcm_new() does not check the return value of
of_dma_configure(), which may fail with -EPROBE_DEFER or
other errors, allowing PCM setup to continue with incomplete
DMA configuration.

Add error checking for of_dma_configure() and return on failure.

Fixes: 88eb404ccc3e ("ASoC: brcm: Add DSL/PON SoC audio driver")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20251202101642.492-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index e3a4fcc63a56d..efeb06ddabeb3 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -358,7 +358,9 @@ static int bcm63xx_soc_pcm_new(struct snd_soc_component *component,
 
 	i2s_priv = dev_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0)->dev);
 
-	of_dma_configure(pcm->card->dev, pcm->card->dev->of_node, 1);
+	ret = of_dma_configure(pcm->card->dev, pcm->card->dev->of_node, 1);
+	if (ret)
+		return ret;
 
 	ret = dma_coerce_mask_and_coherent(pcm->card->dev, DMA_BIT_MASK(32));
 	if (ret)
-- 
2.51.0




