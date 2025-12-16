Return-Path: <stable+bounces-201180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA7CC20DB
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F983050587
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F932E149;
	Tue, 16 Dec 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s30uAZ84"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF81322B6B
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882790; cv=none; b=q6L21PixvVtODo7bkF+sdgTs/8oZ36Tr7joh226mmcSuf+2ogiooUClgNuFBAYu24R57g/YpggPnLqnkeh9/xP0KvayY2MemVeIgc578wAD7OrHB5NM4wlllZJShaW9ZyUpkYatItjQyrT0Kx73cnJVy2pNc191ChiXKvWWA+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882790; c=relaxed/simple;
	bh=b///cjVyHyXdk15J3N8VAQno3/RhLCHAxDB1VFuJPy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxVWDSh9RJt/ifQrhllykmhQKNkwX2c0udcc3faIgTt7zKgx0LRhz+MA4VKuXhFb1EoVEOGMEuWh19LHjpMYlcwhHVnL6drF3M2A/x2AwJ7qUuk8hiRpGmF86GGtcxBBZ0Dj48SSlhDJBepGDjSXVrSWwJ02cYZ0T7c7cO6aF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s30uAZ84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF904C4CEF1;
	Tue, 16 Dec 2025 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765882790;
	bh=b///cjVyHyXdk15J3N8VAQno3/RhLCHAxDB1VFuJPy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s30uAZ84PlY5yhZq17H59X6vrxNmadWS/GyrFJtfp7ARQuuCBLbJY1yHZdYNMz8AI
	 hZjQ1qJ/2HoGvnzYgkxqXnfzeux/DULej6lIhlfWH3YlSQuXeAALHNPXxTfeC0x1Ap
	 Myu/Tpc5MfsRNmaqREZfsGd7f3YJaRq1lUKBobAsQVCijOD+G+aqcM92w3v1BLQ4nb
	 lCGZKEGx4oXbMZOiVRzp0OUsWv+SF8lLCA09ZTCGZppRrpycm96jBdSkEoEWskTcrE
	 o9tFLx5WdXbGK2FHooBmUA9KbHRX0kRx0ZqXr0NDsRVhxB570jTRWBKATi3C1nuU53
	 aWOP9Q/UZZUYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ALSA: wavefront: Fix integer overflow in sample size validation
Date: Tue, 16 Dec 2025 05:59:24 -0500
Message-ID: <20251216105924.2751369-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216105924.2751369-1-sashal@kernel.org>
References: <2025121618-trimmer-clever-0be6@gregkh>
 <20251216105924.2751369-1-sashal@kernel.org>
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


