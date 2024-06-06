Return-Path: <stable+bounces-49190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E5C8FEC3F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B211F21A84
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BC61AED46;
	Thu,  6 Jun 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kwynE2zB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9319AD7A;
	Thu,  6 Jun 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683346; cv=none; b=QtcV2hZ3txaqRLtFOWc/XIhCRR7Spt/Mf5XWf3DgzmyfYJk+WfuJ+Gx7jsyK6w/YjFnNg1E9ExaXV4W5j8fTuhmcgF5DFTeh0c8fJIeo5qBRQ2QEhobXs0XbiLJ7U9kR7MoUN02jEQSnuRoSwXWvD+LKFt9m2eifzy6I+v4XJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683346; c=relaxed/simple;
	bh=N9mj3jiXy5iT60e5ylCgY5kn8E13fMEmrMwzrPsc0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txnR37XmXKqTledtTWR5Jnk8ZuaiFqjWETYFth3iqQKZAcJUKmhMvtPo8IMFPRuI3cyPHXevZmQe1svLRoCcgB3AZHe2xqy8MIBzlCi2vCam4HGB14XTVf0IS+3O2stM8enqol+LxggkRh3w2e2iOWDa6KAnV8JfztBOw3soqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kwynE2zB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93DBC32781;
	Thu,  6 Jun 2024 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683345;
	bh=N9mj3jiXy5iT60e5ylCgY5kn8E13fMEmrMwzrPsc0Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwynE2zBiLW3pzi/aaUNL/wb0nD5cgH8O6z6kV8+NPjYRVoqffqQL78rPfRf+mEQd
	 BTI2nrHOGAsazNhvYDTfvF9TN6NR9UiJbkv1PZI8xkWu8Uzlz+Gbq+HRz7BgLHwIza
	 dc1kpq0OEdK0loHBylyBwvwoEG8wgKjAp8ydD1bA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 286/744] ASoC: kirkwood: Fix potential NULL dereference
Date: Thu,  6 Jun 2024 15:59:18 +0200
Message-ID: <20240606131741.578933167@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit ea60ab95723f5738e7737b56dda95e6feefa5b50 ]

In kirkwood_dma_hw_params() mv_mbus_dram_info() returns NULL if
CONFIG_PLAT_ORION macro is not defined.
Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bb6a40fc5a83 ("ASoC: kirkwood: Fix reference to PCM buffer address")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Link: https://msgid.link/r/20240328173337.21406-1-amishin@t-argos.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/kirkwood/kirkwood-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 640cebd2983e2..16d2c9acc33a6 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -182,6 +182,9 @@ static int kirkwood_dma_hw_params(struct snd_soc_component *component,
 	const struct mbus_dram_target_info *dram = mv_mbus_dram_info();
 	unsigned long addr = substream->runtime->dma_addr;
 
+	if (!dram)
+		return 0;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		kirkwood_dma_conf_mbus_windows(priv->io,
 			KIRKWOOD_PLAYBACK_WIN, addr, dram);
-- 
2.43.0




