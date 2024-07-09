Return-Path: <stable+bounces-58778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B992BFBF
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216571C23719
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5C1A2FB9;
	Tue,  9 Jul 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvcXRYI3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EE1A2FB4;
	Tue,  9 Jul 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542046; cv=none; b=nc1XAjdelIgnSIkkUS+oJzHO8/WQaNgmsX+pQglbYUQ1L3Q8stbU7ulcsUUCu4SasrM0cbIb4jqOiwCoJjXBvLD9KqJJGUmpifOVUcnb5m585EC5S3QHP2nvTan/zOaNuaPj7uvP6VvsxoCScbNWH59h46iTUE9PlF3xqDFpV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542046; c=relaxed/simple;
	bh=R6h4wze2Njs6kYY9naqqPMxXKdag1eGAWeRnfjamIYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnHbmlVmBM9KirKesFDR3uuQG6DRmkebwPX+HXnu0lp2hGIYBU3WYwx12FYYE+CzaiM1on2xGVD494YraoTXv5qVs1J+G7R4ehYWSVuEKkrFg16UtrzdMtirHVHW4fVKj/Z8kzd/xC9vxJmqjYsAraGY4g0oSltsS1A2qu4fwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvcXRYI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECA8C4AF0A;
	Tue,  9 Jul 2024 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542045;
	bh=R6h4wze2Njs6kYY9naqqPMxXKdag1eGAWeRnfjamIYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvcXRYI3fjnDR4DhZpf0efyJOGjhdmNQW37qLP6z51k4W73rIlY25P0orljqYlTvw
	 xmKw0bZZalx2r+v4LDwVzIxEfVeKICqFEzl5E3LP+rzmaa4ITSo+M8Eyf6t7TbGHft
	 e33ai0e9y5D9SyWIrlv99vGFqsvQ778Q470V5Bgt4GKX5tr/smXrjqtbbsQvkgZejR
	 IVx0ue9jVkkyvpqIVGpceiKGwAzLmG+LPua9Bk/QnzxHN2k5OIuO511YA72wKwNGrs
	 XoQTAMz+5cbuim6x3tRaExTOn1bjC8HILvrUnTZvpILr6XWJIIhe2S2vrjnk9GoeuT
	 C4Knlfe1lvpTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 16/40] ASoC: rt722-sdca-sdw: add debounce time for type detection
Date: Tue,  9 Jul 2024 12:18:56 -0400
Message-ID: <20240709162007.30160-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit f3b198e4788fcc8d03ed0c8bd5e3856c6a5760c5 ]

Add debounce time in headset type detection for better performance.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://lore.kernel.org/r/7e502e9a9dd94122a1b60deb5ceb60fb@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 0a14198f8a424..543a3fa1f5d3c 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -352,7 +352,7 @@ static int rt722_sdca_interrupt_callback(struct sdw_slave *slave,
 
 	if (status->sdca_cascade && !rt722->disable_irq)
 		mod_delayed_work(system_power_efficient_wq,
-			&rt722->jack_detect_work, msecs_to_jiffies(30));
+			&rt722->jack_detect_work, msecs_to_jiffies(280));
 
 	mutex_unlock(&rt722->disable_irq_lock);
 
-- 
2.43.0


