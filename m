Return-Path: <stable+bounces-140165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D57AAA5D2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713D83B047A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53993174C5;
	Mon,  5 May 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhq7AfzZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9028D854;
	Mon,  5 May 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484260; cv=none; b=GUEnTD/rZHNPVo71jqcc3xQJRbwK3Jkpfcqlx35k3PSXeJu4Ud3hww+Rv7KkDho0T9k4GSmvyMbzvrknxQPo8yz5JT3CfAiZQsrq+ZRKsqwm+dextPFzRy/Jr+DSnsuaZAmw0atgfnZ4fARp39GMRwHdwrmt5x5JaxAV8fSXkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484260; c=relaxed/simple;
	bh=nWkLOygKAu0A+2IVOPoN6DxR9J74CWcuU3LtYBWwiBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V8GAWtImONgA87vtIYHH/rXmjVZx3fXOUhys4Z4bfRhh4bOWIf/JmbBn7ynbRwXgbMrmL+RoOMddoCQCusMj8dk5laze+o7IEk1PFb9AmrVEs8XIdihQhgDaK0l2/NurpcDgYLwBFcsXEhJNnj72CmC1OESDu6fEsaOnFLV9nlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhq7AfzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4CAC4CEF1;
	Mon,  5 May 2025 22:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484260;
	bh=nWkLOygKAu0A+2IVOPoN6DxR9J74CWcuU3LtYBWwiBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yhq7AfzZRG/i2prJGNahZyDd+ESNMZFCNpU+D2ZKi3dd4qhKJ+8TYMKGvm9Tje7D9
	 D0EFGegWtvwTW8mobQPgZPZY1zUxWpTIiwjdY44PBnCHFUu+CeT/OUrYJ7bCmVTMKA
	 S8Wskn11RQmox9PuXoQg9TwUWGzWdLqDejCgQzCUnqwdm6U+WmJ4iC147aKLQ7D6xT
	 HWw6DyRZscdQcv3/JRVXwsta2huSXnk/uMQS54q5jBcZdqG9P1vP4PSZCDaYzkep7f
	 +/gjaZ9kCHAm9/c/bhAHwJ/UdKW031h2OtLNl9Lc+F/mxGtu+U78stvT9367AycPMV
	 CvWg9oNlLcBWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 418/642] ASoC: soc-dai: check return value at snd_soc_dai_set_tdm_slot()
Date: Mon,  5 May 2025 18:10:34 -0400
Message-Id: <20250505221419.2672473-418-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 7f1186a8d738661b941b298fd6d1d5725ed71428 ]

snd_soc_dai_set_tdm_slot() calls .xlate_tdm_slot_mask() or
snd_soc_xlate_tdm_slot_mask(), but didn't check its return value.
Let's check it.

This patch might break existing driver. In such case, let's makes
each func to void instead of int.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/87o6z7yk61.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dai.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index ca0308f6d41c1..dc7283ee4dfb0 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -275,10 +275,11 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 
 	if (dai->driver->ops &&
 	    dai->driver->ops->xlate_tdm_slot_mask)
-		dai->driver->ops->xlate_tdm_slot_mask(slots,
-						      &tx_mask, &rx_mask);
+		ret = dai->driver->ops->xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 	else
-		snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+		ret = snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+	if (ret)
+		goto err;
 
 	for_each_pcm_streams(stream)
 		snd_soc_dai_tdm_mask_set(dai, stream, *tdm_mask[stream]);
@@ -287,6 +288,7 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	    dai->driver->ops->set_tdm_slot)
 		ret = dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 						      slots, slot_width);
+err:
 	return soc_dai_ret(dai, ret);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
-- 
2.39.5


