Return-Path: <stable+bounces-201177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED994CC2092
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1953301E153
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6882322B6B;
	Tue, 16 Dec 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3lWw6Qa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D1314D10
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882488; cv=none; b=A4dxQwivJN5VDXvSfAvWXqwk8sbbbDX0VHYk+DQIHyWMxG+eQJ/DKpUef3nJh+OlB4NGtne75LvgnNBccxCvShVJL/GU69jgBQU0VPBvBZUqFqcp41sdQjcEi9jG40SoXIMNlZQP0Fvd1qc3MQWtHuexn2iPf6+/kg//sGUsKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882488; c=relaxed/simple;
	bh=b///cjVyHyXdk15J3N8VAQno3/RhLCHAxDB1VFuJPy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeqacRRxJeE9FZeKKIIDXx93Wyk+7rfE9ykhoJQx4qp6JM3tABxuslOQ8RgcK+uht8wxxul6x7eNQO0rMBGDQBWVJ4CvGTcukGMNJsFSET1Zvwp19lAn4//fTkEHGuBh9+gL1dsNF641Wfx467qzI+mFnWoFkHcpAjGvL9x6lYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3lWw6Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2721BC16AAE;
	Tue, 16 Dec 2025 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765882488;
	bh=b///cjVyHyXdk15J3N8VAQno3/RhLCHAxDB1VFuJPy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e3lWw6Qa88TeIq3W7uGV948ij3bfbSmBiF9HbKh5PgQlBP0LidCUbjCKOtzaWQ5nT
	 ZwW/4CygxlyQTMyEGPIF6uzLoNaQV4czj5VWf37Hu5OmyrtbpEQwczNIjBrmt+mDaP
	 4+XEl7Jv4j5z6XztSQ1SWbScn2tk1i5s+fMmHUnr604927CROzZ3lfnMTbCa8KHlH3
	 UHQhP8gYRkuIwEH1EsQlTK7lVO5aeFw6f8U2XhT03/Q0oxG3ko2+3eQ8OxHnSDJcBU
	 wwVk6MCloMYKTTJVY/pHgNU3/BOXLpDMOpT+MYBaZm7RfQSzGXpPYWyBfKn0kM4Qzf
	 /q/UZqupOxavg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ALSA: wavefront: Fix integer overflow in sample size validation
Date: Tue, 16 Dec 2025 05:54:28 -0500
Message-ID: <20251216105428.2749611-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216105428.2749611-1-sashal@kernel.org>
References: <2025121615-subplot-parachute-73bb@gregkh>
 <20251216105428.2749611-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 0c4a13ba88594fd4a27292853e736c6b4349823d ]

The wavefront_send_sample() function has an integer overflow issue
when validating sample size. The header->size field is u32 but gets
cast to int for comparison with dev->freemem

Fix by using unsigned comparison to avoid integer overflow.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB7881B47789D1B060CE8BF4C3AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/wavefront/wavefront_synth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index bd679e2da154e..9eaab9ca4f95e 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -950,9 +950,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
 	if (header->size) {
 		dev->freemem = wavefront_freemem (dev);
 
-		if (dev->freemem < (int)header->size) {
+		if (dev->freemem < 0 || dev->freemem < header->size) {
 			dev_err(dev->card->dev,
-				"insufficient memory to load %d byte sample.\n",
+				"insufficient memory to load %u byte sample.\n",
 				header->size);
 			return -ENOMEM;
 		}
-- 
2.51.0


