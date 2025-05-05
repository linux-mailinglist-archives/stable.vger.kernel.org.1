Return-Path: <stable+bounces-141195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279C1AAB181
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A623A2104
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F088B3D14C5;
	Tue,  6 May 2025 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qki16aMl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F102D113A;
	Mon,  5 May 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485471; cv=none; b=obyOKJZK5wlUh8jYzY1qOZZ1811slD3cZZwM6FpmKOPmzD7WkZtE8eUjfUE0NKoelksthmJahUced7SjGSKoBNL6uLJQopqZT/eCZ28CWM5xvcToj3IuNiezjaxFRoP8Lm1TK9B6Y8yhTYlA7Lu6nmgi/auu71OdK5QVz0JS/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485471; c=relaxed/simple;
	bh=mL8EK6vs3ZcgIypuRMahinbFQPPZZjHaEGVJlBDoZrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqXhC3wMg3O4dltz3FeUtSg0hd5JO/5ruDZJlIb8v17sdrJ7Zmz8oxA7HjJT+aHbQo0N2r/dNXi+1lwt4i2QyITohMB2AWp9MWXUwDAPG8qc9Ob1xLfbkhHxvjgtkm3K/c0ar3Ki7pBDpN4sxL9no4svoJsnQZlQDldDZKAPb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qki16aMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D812C4CEEE;
	Mon,  5 May 2025 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485471;
	bh=mL8EK6vs3ZcgIypuRMahinbFQPPZZjHaEGVJlBDoZrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qki16aMlZdEkvigy/VloRU3dcAg6+ci3nVpKEOCBMbex1Z8kz2LwD7+sYNF16yzUG
	 wQdV4JD85Dfq0P6xnBAd7s6pMCFtaCqXY5vj8zHcvDlsJwiBHEF4CHsC2zZz7gxnDX
	 E2l26XbQlH5x7k23oh3zy8QR0CWuBpd7CW2ReMytN2MqPbfIL05Rl2T0QN3vQ5FphK
	 FxKUmo/k+Y0WkgYH+WAAQSPAlOZ9JSuVX/vkI8IXE/poHLRYepC+7cmS8rWH9x1WpJ
	 cQf6PfbWErIk08qV/ZmNMeddia+UmhQXSwOzr8Acp1qwWaML4nTpHXqVKsGCI7KpoC
	 fXwwxPrfUkWIA==
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
Subject: [PATCH AUTOSEL 6.12 330/486] ASoC: soc-dai: check return value at snd_soc_dai_set_tdm_slot()
Date: Mon,  5 May 2025 18:36:46 -0400
Message-Id: <20250505223922.2682012-330-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 4e08892d24c62..de09d21add453 100644
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


