Return-Path: <stable+bounces-120133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20CA4C815
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A20F3A3937
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E37C25DCFC;
	Mon,  3 Mar 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7C1DiXA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3725DCE7;
	Mon,  3 Mar 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019474; cv=none; b=XAbFhObQV2Of5fAb6Nhaz0hFUZIVRVUgPC6k35eJJhcw8v0RwCsPXDmGLrVLgXuzrw1WyeclUIe62VGJELY/sJ6jisUIZtDsUHR6Gkn6xa7BvQgKEY1GbgPeAAispPCOsXuwGD+d3ZSSPvi3bdXVxNkjcOZtiyRf89K+f9BZdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019474; c=relaxed/simple;
	bh=k9IRkt+TgcxkQj3UctvZ4or7Cn5kuxCcivmqM+G6+qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXFqz/E9brsZAG0vDObXpoP7ZUhhldwvYvkXJyugnrIc8Bnhjr5MTSGLpGj0+lX9tOkCgOUIKL36R18/AD8q5Y+73Pba9duph4sz5JSXGSdAzSOfjpTtzyge95/lRS98RvMFwUdPL2FCCdHShAMa+xlVibT9xU7aJa6HfBwrHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7C1DiXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B789EC4CEE6;
	Mon,  3 Mar 2025 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019474;
	bh=k9IRkt+TgcxkQj3UctvZ4or7Cn5kuxCcivmqM+G6+qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7C1DiXA7AtylRWwyewfeYZ2DoXC4SeWUpSFD1VjCRcMxQQiNeAq2dT0CrMM5wR0N
	 rdzHPNC0dbijh+bcaVBmeyCV8wMbXSmDBn7+LlHv5FQXV89LGSseSmTfopkQ72xGbE
	 zkabnVGc2xGKvvfuisayvMfiV/DkasGxIvteQyx4gEyDZdTVd13TX7uUVlh0lu667x
	 3NkejYiL3IL+CknMqkRqeHv5X/GbL5jqyL7jjSrqNNnc7Mnvx0zSAJWnvJzCBqQgPw
	 ReKpaimww7+fUvTHVJdwOCQLbnjTiJGPKkxyx3aDf9izPOicEIJ1gZQsmbMdQSGQAb
	 wm1tui96jsvUQ==
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
Subject: [PATCH AUTOSEL 6.6 02/11] ASoC: tas2764: Fix power control mask
Date: Mon,  3 Mar 2025 11:31:00 -0500
Message-Id: <20250303163109.3763880-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163109.3763880-1-sashal@kernel.org>
References: <20250303163109.3763880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.80
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


