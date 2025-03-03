Return-Path: <stable+bounces-120153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D5EA4C851
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF543A2642
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590522DFB3;
	Mon,  3 Mar 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo6meYns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB82266EE3;
	Mon,  3 Mar 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019517; cv=none; b=jAZjkgWfEqw+dfgEaO6fDYDcRrgSfhGVd8cYfzQblthkZCoG9Ivw0afOkbjcBjzxlxIfCZEq+NzG++2LnTYHasz5RA7+UDP/zAbK/Bp8GcEWRYr8hDAK1Jt/n0iaDngI+n81F8BtKHPqktkJF0wjlWUhcSjguFBudnGpnSBXT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019517; c=relaxed/simple;
	bh=Y5g5RhY09ft1Nl3Ko9ald1wz1+n3GylpLTz1GdQdDfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OE3Q6CVXZsk0p9jITrduMYWxiV50jiktPlSqQGECBZ1X9ssTwdYVUCjvpHS1ECx3bUkrHTM2hqfBA1pSrT2vJqM4tkO4yerdUs/vTG7wRyeEgwzmQ92Z/bdeIEE1X2PqBzYzAskqnJZX/Ys4grzEF4H1bKWjaI+DjVoGnXpkCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo6meYns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C07C4CED6;
	Mon,  3 Mar 2025 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019517;
	bh=Y5g5RhY09ft1Nl3Ko9ald1wz1+n3GylpLTz1GdQdDfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uo6meYnszJnHQTFnULYYZz24q1F0Zz4S8f3HorRVIh9QFuYSW2DpS7ILQLQ3wIde+
	 Zwz0vZf01mSIKcwYjJGVyh/7lptekvKiyum8XhdcHCYs9ec1SKg6TCbdI93IfaQ8vn
	 sLFxi9Mzdjm/SG07nj7B40s0gs+XsgLVPDBR/hniisdx2ssEOchAozh0PAdIv8uN/v
	 HBU5WEf0RMu5Xws4bfgz09L5n4yppwYBGycVgNhegeI7T0o37Ba5/MunFlfr5/hvXZ
	 i6VTLp9WGGLl4N8DOIY23Uq3i8bZGC8FP7MUJR0E5pYn+0ILZiIQnokwsOMGxpW56w
	 y3zyVmQbnxZFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	James Calligeros <jcalligeros99@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/9] ASoC: tas2764: Fix power control mask
Date: Mon,  3 Mar 2025 11:31:45 -0500
Message-Id: <20250303163152.3764156-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163152.3764156-1-sashal@kernel.org>
References: <20250303163152.3764156-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit a3f172359e22b2c11b750d23560481a55bf86af1 ]

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
Link: https://patch.msgid.link/20250218-apple-codec-changes-v2-1-932760fd7e07@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index f015f22a083b5..b18a637bd9fa3 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -25,7 +25,7 @@
 
 /* Power Control */
 #define TAS2764_PWR_CTRL		TAS2764_REG(0X0, 0x02)
-#define TAS2764_PWR_CTRL_MASK		GENMASK(1, 0)
+#define TAS2764_PWR_CTRL_MASK		GENMASK(2, 0)
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
-- 
2.39.5


