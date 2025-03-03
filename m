Return-Path: <stable+bounces-120162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EECA4C857
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24A51887347
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5526D5A7;
	Mon,  3 Mar 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKkTSiDj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BF26B2CD;
	Mon,  3 Mar 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019536; cv=none; b=qe/xYzhXsjMrnJs1Gf9iaO/FotSpm+WnXJIhXrYGBmK8vby8AZ/++9ZFJrHzRlE1yP5z/4AJil5VIXbxdqVByX4jZyFWCtKrQSTcFwhl7GQDo2zhVRLtMB3C8oheGySz3eXaO79YGR7DNxzRAVOWoeDM11mCWYQ4dydhIQ7CIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019536; c=relaxed/simple;
	bh=Y5g5RhY09ft1Nl3Ko9ald1wz1+n3GylpLTz1GdQdDfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ipglAxns0ubJNdeWpPZQhiNhdWAJJPOxR3kphWepStj5pfQVLolcluehl+NjRAbiBN/DQFafl77VDzDBG6EheZdr/zoPeBaIAFh1UPbfWOIPhQCQZVClX8Z8NbUVb1OLvrV4TR+0jyHDicecYVdGdoNEiE1LZoPNl/a3mt5TQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKkTSiDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A615C4CED6;
	Mon,  3 Mar 2025 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019536;
	bh=Y5g5RhY09ft1Nl3Ko9ald1wz1+n3GylpLTz1GdQdDfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKkTSiDj6onUxW4aZSTPIr/pVhjkqFatpeetw7fAlXSkRK3i9jI2/lYcp2Jj/qS1L
	 Gw0DNzFg4dPDaLO1kOuPNoucOcUcQKgyhqk1K4yid1SGF0lMTPd6lvOEWjUKHRHijm
	 ZG5xHIX8a+Gv+dcjmIENGLebhLpz7mKmPYL37st9wCIEeGHsfcl22vUBg9EPLhVRY6
	 tua8liXWwgTLjQzdpTvCYepLQYZSfvlD1hyF7TkT8wnSlR7sDNnQit5PnLog8E0yeo
	 tGD9u7b6GcPRlOI6t6KbNpauY1Y7UswfttQDxlbFNDamHpr9d4+moQfqtNYP206HTq
	 mCRC/rFPJLmFA==
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
Subject: [PATCH AUTOSEL 5.10 2/8] ASoC: tas2764: Fix power control mask
Date: Mon,  3 Mar 2025 11:32:05 -0500
Message-Id: <20250303163211.3764282-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163211.3764282-1-sashal@kernel.org>
References: <20250303163211.3764282-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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


