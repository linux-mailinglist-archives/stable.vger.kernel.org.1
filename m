Return-Path: <stable+bounces-56184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E93491D556
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F541F24EC6
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439E158DB1;
	Mon,  1 Jul 2024 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7KviFu0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4DF51C42;
	Mon,  1 Jul 2024 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792889; cv=none; b=bDvJjs9NEWNUZSQ0fh7Rldvm5dN2mmU5bsY9X3T+C+2aOXkeu8zZlVjFNyD0f5atf2bSqLqWnLW4LXxiU0dnqFSvuLouQctsd4EBumP9FsSQGxRhk7OYy1OeifjEG4Cm7LYjv3SBO6P0CCG+c73t0r+NOK/sE4PozX/o8WLfc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792889; c=relaxed/simple;
	bh=A/ISte9LWlbET1fwZUcc73sBVgts8em/ne3uxLTDWRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ud3lXjr417N5/XAnu1fgCfWDV6g2tcJfcGCMWARHBXs9K0QzoSMlvPpjcswbmRZHi4+G+ixQPLbzSrPn1zr2vdAtnIhzy/sVTwEfBIvWmRB9AUB0JS5AmRGS32SCR4vS1VL7Yfe1vSyIh4BcchnLT9d2U+Rktm4b6JMzbwzf8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7KviFu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CB2C4AF0A;
	Mon,  1 Jul 2024 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792889;
	bh=A/ISte9LWlbET1fwZUcc73sBVgts8em/ne3uxLTDWRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7KviFu0J7+NGhSWSnNEFnE3jxR3368zz82p9inM3gkkxmsRTM9zHz4w236KFZfnI
	 v50BR9o/t0UyU/b2Tt6zI5GFLX54y3WtwxPc5JVkZA4gxqG2bCjq+LhvLhVvaqj/L3
	 5OtEMogAkrQnARj7t5VpdBdiuBl/SV7tsKTaaEZw0S/G/Uu0XAW/byBBCo6IvI/wd9
	 KgKAJNrCqY7VZ69rzZ1Kn22cLBwmAD0PGvAcpsRA64G2BubGFtAVCmqPZBcdG8g7fI
	 eB5rKiLTvbBEIwYwt25o7MvJMGq8b/m4Tse3mREhF+FypyleFMiUyJ4zpCoLGvCxFD
	 33Oftdd/O1Ogg==
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
Subject: [PATCH AUTOSEL 5.15 4/5] ALSA: hda/realtek: Add more codec ID to no shutup pins list
Date: Sun, 30 Jun 2024 20:14:32 -0400
Message-ID: <20240701001438.2921324-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001438.2921324-1-sashal@kernel.org>
References: <20240701001438.2921324-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index c7529aa13f944..fe0d412c0438f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -577,10 +577,14 @@ static void alc_shutup_pins(struct hda_codec *codec)
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


