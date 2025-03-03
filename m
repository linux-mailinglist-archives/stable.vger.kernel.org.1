Return-Path: <stable+bounces-120100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCBEA4C73A
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAF4188A6C8
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC4216385;
	Mon,  3 Mar 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCjigM6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA5215782;
	Mon,  3 Mar 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019398; cv=none; b=AA75P5IgpBlAqRNBvzD46Txsrz5vK1E/S2mKiAr/f0JhYVqb9SA4lsbD38q8s3ZtdCNAjg4bL6pVhJshzia5u44avumEvEIzIC9ACjGQGHC9VAWUSQpM0D90ahXmwZMIOKqgH+lUvKxGWtHIsCTxX7GXzoxZdpPww9QCC6z6pb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019398; c=relaxed/simple;
	bh=k9IRkt+TgcxkQj3UctvZ4or7Cn5kuxCcivmqM+G6+qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfqSVKS8+A6sWlo1whDmqV0uct8LkP3mfua7KlQHjA8OZCvwEExXC2CWy9QMzHpbr6C1ctrCYjqiZFSUw3iEsErlzTB9KQRTZ6QtCXvuivo2da+BiwhLs/fbTgLDNGIcoj/5IQLWoVA4xI4bW8eBAiZ4wnnp6Q13Yqc7OtPJfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCjigM6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA39C4CED6;
	Mon,  3 Mar 2025 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019398;
	bh=k9IRkt+TgcxkQj3UctvZ4or7Cn5kuxCcivmqM+G6+qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCjigM6Yskgy8x5r3li5huUR5OmJQE2126QA3Xu8a4Gzfp7a3FrKMUC1K3yNKUg+Q
	 cfn6KNNOoJVZV6C+S/HOhiC32EDfgbA/UkhM1Otgai1GJPLeP179wvW6J9rNhrfGtP
	 n97r8AucxxVuoogc8RLkMjX+VQyazsXGYTtCQBREamWhai2+8BSLX/P8rj0/5ojiYI
	 uOaxBl274fYkScDdjbjFsWAnSEDO4FGorv5voOT7CoylRAvlp40U2MIqug3iEyvTWz
	 oHiwc4k/AfeaPTaTEe/VLZsgF4BZ6oNEJu35sV6V/hSEaDZEng0ctLCJK4yQYfuL8k
	 8p4eX2AwU6vgg==
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
Subject: [PATCH AUTOSEL 6.13 03/17] ASoC: tas2764: Fix power control mask
Date: Mon,  3 Mar 2025 11:29:35 -0500
Message-Id: <20250303162951.3763346-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
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
index 168af772a898f..d13ecae9c9c2f 100644
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


