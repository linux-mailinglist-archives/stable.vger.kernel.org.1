Return-Path: <stable+bounces-119636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B6AA458E4
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218317A7223
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743FE224238;
	Wed, 26 Feb 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nzilg7ck"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7899B1E1DEA;
	Wed, 26 Feb 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559913; cv=none; b=Nrjac0KoFk14PzoQliOzQ7Rjd/PcdouYruaILI/3dLX+XPIDrzERtfbNbc/F3peAJZisRaQfZ4QA08QS8kgyK/4uisjqNt/34oYTyizpKVx6B/DHHsVHD6j0Ra5mB0YPuve+8AH+WhJOpD2y+zxkhvxJE1gQLVsjP9F8WCbtcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559913; c=relaxed/simple;
	bh=KrDx804goEIsj6Ttq1rYSXS0VwgGZXtZ8WpbM3w0qCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UrZJZ5xJCt67LkQ7EAfVhJc6DLxY22obS1pvCmPVwXMdRmripcyvNDVTANMGGJfHKQRGrmhCHLDieXSnHLVNvdrCxAv4d0aqKHluFzC2OAkfH1qXB3kcdJhh1qeceyWkf6KAD3rF1YWnqfLFx2hicUlMCcOGtVav0CpM74j+WNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nzilg7ck; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ObvQD
	iPPxOzG/hmREPfYkM4fAGsaYvUaZ5Q4hk45P4I=; b=Nzilg7ckxss9jeVntAsrU
	pMqa30cCJadBdyUfBWGr37lmKo7g25PJr3CjIoQFLoq8Qd1plxJGqguzxN9iVD/u
	83s7fHqaEo398EalLR1WuMT6lpPil0p/2GL/kU6AU17zLMZlGaNmxfRGz8UM3E0N
	cZ7fgkvi8U2bJ3YNtQ/IvA=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3n_zs1b5nqnH6Og--.60025S4;
	Wed, 26 Feb 2025 16:50:53 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	quic_mohs@quicinc.com,
	krzysztof.kozlowski@linaro.org,
	quic_pkumpatl@quicinc.com,
	alexey.klimov@linaro.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wcd937x: fix a potential memory leak in wcd937x_soc_codec_probe()
Date: Wed, 26 Feb 2025 16:50:50 +0800
Message-Id: <20250226085050.3584898-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n_zs1b5nqnH6Og--.60025S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7JrW8tr1kXFWkWF48urWDtwb_yoW8JF1DpF
	4ktrZ8Aa45Wa4rA345J3y8uas2k3ykuF1xGw42g345Jwn8Jryxuw1Yy34I9FsruFWrGrnx
	ZFZFva48A3W5Wr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkBsAbme+0SWJ0wAAsS

When snd_soc_dapm_new_controls() or snd_soc_dapm_add_routes() fails,
wcd937x_soc_codec_probe() returns without releasing 'wcd937x->clsh_info',
which is allocated by wcd_clsh_ctrl_alloc. Add wcd_clsh_ctrl_free()
to prevent potential memory leak.

Fixes: 313e978df7fc ("ASoC: codecs: wcd937x: add audio routing and Kconfig")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 sound/soc/codecs/wcd937x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index c9d5e67bf66e..951fd1caf847 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2563,6 +2563,7 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 						ARRAY_SIZE(wcd9375_dapm_widgets));
 		if (ret < 0) {
 			dev_err(component->dev, "Failed to add snd_ctls\n");
+			wcd_clsh_ctrl_free(wcd937x->clsh_info);
 			return ret;
 		}
 
@@ -2570,6 +2571,7 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 					      ARRAY_SIZE(wcd9375_audio_map));
 		if (ret < 0) {
 			dev_err(component->dev, "Failed to add routes\n");
+			wcd_clsh_ctrl_free(wcd937x->clsh_info);
 			return ret;
 		}
 	}
-- 
2.25.1


