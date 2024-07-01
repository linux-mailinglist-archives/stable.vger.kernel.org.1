Return-Path: <stable+bounces-56153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FBC91D4FB
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF9A280ABA
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C994A07;
	Mon,  1 Jul 2024 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af5/++a3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB442AB1;
	Mon,  1 Jul 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792756; cv=none; b=CqSFf9xt6dLYt6m6DUfKymY9aAwbVwvJmnxjyPW0GktQlKTXNLpitgdyCJJg+5TQ/GC+fyw4NsRRKJ7dmAkitBskHfmb2H9BXjS0zYugTgE6VP2+DTFRJzMVBOy1cJwqSRh1mJ4iDj/EXML6lvGrTStRl3CN1Iu+QVyUKn9bZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792756; c=relaxed/simple;
	bh=pmNLpYGTrh+IbL2zJ6QYoPCyOKNW6TCyewUsmUqYrZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOkKCehhOCnKA5bYKizjMnGpHSe2wGi6oj0k+J7ZJEywWOzs03Qd0lDuNtn1vDOOmkU+0wrC5AmxRhLwj0azK4BXH7fhB/3QmcRIT5y+B40jaDr0p0AfK1xzEyUlRLj3t9TgQCW0qi8RPL0/bjzglJq8VsKMj5Xz9DuE8hxnKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af5/++a3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06517C2BD10;
	Mon,  1 Jul 2024 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792756;
	bh=pmNLpYGTrh+IbL2zJ6QYoPCyOKNW6TCyewUsmUqYrZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Af5/++a3el3BCAJiEgBt+ES8kss/y5Ht+l6hE5bb+8DBZU3Ri59rf8YHAzjTdZxb8
	 DQJHkG03eZ6n0J55v8leVRI4qGjibDo5xSCHe2AheJMO1JbgSDu1vJVjiXBcUAi7tq
	 Cb8BdVbODFmmSdHLPUoT86Y4Wx9zRYWglgbrd/K3L1IsYiqsjZ3uf07RlVhdvwirQH
	 4oDl85KGE9TzqGgdv39P7YL/KnWUQZRlIMB4PTzvzEbWTNcMNU2i0fCMArPgiTeojE
	 Euu0705dyl0SXXnFUQyGRNnw5OtxLY1U1ZPpzYCjXr8gC/4ZuPk3cCmHay++oz96v1
	 SgknNCrKVy0aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 10/20] ALSA: hda/realtek: Add more codec ID to no shutup pins list
Date: Sun, 30 Jun 2024 20:11:15 -0400
Message-ID: <20240701001209.2920293-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 70794b9563fe011988bcf6a081af9777e63e8d37 ]

If it enter to runtime D3 state, it didn't shutup Headset MIC pin.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/8d86f61e7d6f4a03b311e4eb4e5caaef@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c3412dbdc775d..949fcdc0de98c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -585,10 +585,14 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
+	case 0x10ec0285:
 	case 0x10ec0286:
+	case 0x10ec0287:
 	case 0x10ec0288:
+	case 0x10ec0295:
 	case 0x10ec0298:
 		alc_headset_mic_no_shutup(codec);
 		break;
-- 
2.43.0


