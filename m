Return-Path: <stable+bounces-58815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6D92C053
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1678128B9DF
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB41A1C0DC1;
	Tue,  9 Jul 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj/mz/EP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86471C095A;
	Tue,  9 Jul 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542174; cv=none; b=n5fxpCrk81PFCuJPb2nMa8akVO6OXTuV9E5JTz5WimErmdxXMqJRhxRYd0t+pPDv8V+u3xxES7Oza/J2IVRtxJXdcmSAPXF6r+HWZF1O+f5PrFqrbLhnyD5CWOIlvfXiWw3QTI/AaQNNBK01usZRhjC0zAkKO30mYwlU/opgQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542174; c=relaxed/simple;
	bh=wNu3iwcQ3/so9l/yQd8hiLOPHAdjBs30DzuJ6GxfFHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbK6f5gDSBPuY5b1fQz4YmA+0ydbsrm6tKARapOzZmC0uIpbF1Y4+X1LANQaLnEyOGn11iP4+cRX7acknk0rO60cgNHjlsQ1RsTFt5CUsJilhPinOmcwY1m7zNqlxgC2KqPcWASrvy5fRQ/4dI2in8xiAXnayQKdFzxbjkYXdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj/mz/EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ADDC4AF0A;
	Tue,  9 Jul 2024 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542174;
	bh=wNu3iwcQ3/so9l/yQd8hiLOPHAdjBs30DzuJ6GxfFHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jj/mz/EPRYWjEYCDrjwEHGa5zNLmjF6JyCQKUfZlyl063EttTstrJu+fygy8n1K1V
	 PTRTBUNscr2CqDymQOVG/2TQ497kLZ5vWe2lhZxA7Yjocw/zFJno4w9h1rlYUAgUdf
	 dKhwAhXMGtJEsQT8+8ZRWAvqQj8RsV7TE9nqAAVfvrocr56IvNPC/XS/Q4hSa6A06w
	 wPg3OQ2cg399AJpjVRCo6CFwzUsrG3IRJLkg9QHPHANxzOzm6AAyg/Ejb6ZxLN8AG8
	 F/V61aSkRjlZwbXxi2TkkTPO+g588oDQbFGzOehu6+3CSpe0KcbJ1rWbltXekuMs0t
	 FpxYk2brAHZAg==
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
Subject: [PATCH AUTOSEL 6.6 13/33] ASoC: rt722-sdca-sdw: add debounce time for type detection
Date: Tue,  9 Jul 2024 12:21:39 -0400
Message-ID: <20240709162224.31148-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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
index cf2feb41c8354..32578a212642e 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -349,7 +349,7 @@ static int rt722_sdca_interrupt_callback(struct sdw_slave *slave,
 
 	if (status->sdca_cascade && !rt722->disable_irq)
 		mod_delayed_work(system_power_efficient_wq,
-			&rt722->jack_detect_work, msecs_to_jiffies(30));
+			&rt722->jack_detect_work, msecs_to_jiffies(280));
 
 	mutex_unlock(&rt722->disable_irq_lock);
 
-- 
2.43.0


