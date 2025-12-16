Return-Path: <stable+bounces-201186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C5CC216E
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4585F3006D8C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF311341AC1;
	Tue, 16 Dec 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab7Mh/Je"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F720341073
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883226; cv=none; b=Upa0m1Rdu80oW1Bk8gxAzcu6vcuMxs2bGGyhcGk4TpYogVpQluVrs+rt3uE8T9QCxZW03HKVSfv3uxHeAoTa3NVCWu0KaGhNfP/1a0+LeInXxMiQjBM3uyixcyUYvsDv6eujaTS1h9qUovmiZceAkmvdc3j4la+DKL/s9aR/umE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883226; c=relaxed/simple;
	bh=cMxMBPjeuqtT8qCEhEAqYz6XQ6hsFcetT7VuyJmKOaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs30mcFQPZclhx8M7rr6qoSdrpBsItMCnzs1h5/akw8Iuil22ppnNSbS6r2rzvBh6+8F38VWInyE6AGFtaCuSzWrMB9+qOWVAobEojdHbi7co6Pui68i+RXrLluCLbA8cfSDnBMI5kia8nxpsNiWZhybW/ie62JFhaZGrnnTvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab7Mh/Je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70097C4CEF1;
	Tue, 16 Dec 2025 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765883226;
	bh=cMxMBPjeuqtT8qCEhEAqYz6XQ6hsFcetT7VuyJmKOaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ab7Mh/JeBx3QHmPocK317PskkgE5GuReXwj5pPDISDcwElGpzk+8jvZfhQykXYzLV
	 W+7cYd5p1YHEWmyeNAk/Xb/hagJ0vuuOyUhDsgiXISgNIV+MQ5a8uLJmnWJqgvvyIS
	 FglfF75BJq9iEPXyjTfKwwLwLk4318IRkypnmzipmJyiBOGexR9IPGay0Y9UnyR5Kf
	 f8l08QZeQgmEjOBH/R2749vubxmWWP3lSjmuMIEefYfjE3Ix+vz70umbL1oLa5s3fL
	 ZS0xoL+7qA6DKaBDdKIMD7EkSTr4qVC7u/QtqSkeZ84r0kOmyhhzwJ+v3vvWjwamX4
	 T2fcQhXjI8B2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ALSA: wavefront: Fix integer overflow in sample size validation
Date: Tue, 16 Dec 2025 06:06:27 -0500
Message-ID: <20251216110628.2753962-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216110628.2753962-1-sashal@kernel.org>
References: <2025121618-refuse-macaw-9005@gregkh>
 <20251216110628.2753962-1-sashal@kernel.org>
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
index ab4017918ba8d..b4d2788ff4780 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -952,9 +952,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
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


