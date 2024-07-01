Return-Path: <stable+bounces-56169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9091D529
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA471F23CDE
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9E12EBD3;
	Mon,  1 Jul 2024 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeCiHT00"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F023776;
	Mon,  1 Jul 2024 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792839; cv=none; b=BCms/5kwTNL/Zb4iYF8RITg3e8fTQy+nbZTiE/ofFaKGg0XP0GGSrXaO1/MraJLJer+ewRa9kF20wrQH5f0V8iUvDbfRWpKJ+Bbs1g4tmXdvK6ltKro63w21ynrJ8Y+RXaJdDHceiT+jf30ebbc9EZFBQMar5j0Yg84u3A270g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792839; c=relaxed/simple;
	bh=mmHQr5aJoUncG6r9taP5gXzJX/VPjXNXlw/6mRr0XUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjXN0osL2FJxUWl0IX22PyZYInFFJlV6jb+YgJgS0aiTOWPdjZaBXMkqU4YcnOnwoMh0Ix1XDmuCcQTIbzIycCA/xbKGUdQSkO9vIVUbphikjJrYAvYsJBVdjsHj/RZzli017yOqp0SLB7RstUsXzhR3VdRongMnz+tGdcITwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeCiHT00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCB1C2BD10;
	Mon,  1 Jul 2024 00:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792839;
	bh=mmHQr5aJoUncG6r9taP5gXzJX/VPjXNXlw/6mRr0XUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeCiHT00U0SZ7XzGVi6/6kzYOPrnqaQcxbk+FavN6mLGxjOs8TnAvgSa0G+naknFE
	 2UmsgSpwPh8r2Hi6ZykEpOdyWlSr1VXB9IT4a4E4K6qOfa+JYjAPIyZUlVoE1JeJpt
	 W5uqzM0sLXpx+DFvqmKg39Rsg+sua3Oo777UyW6OWEDz3DVqq1/SjJ8RsEmExz54IX
	 xb+EpNhtuxdhPdQJg8e0OwdYSG1LYy5sSMuC0/1CbntlJDggikLgOJXXzcXsysmLcY
	 mst0CQA5O074Gmyh9IAZQYN3rB7U70XMulFKs7RKHZhIO6OboZ+TabhjksfBskYJBW
	 sl8b4bRli940Q==
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
Subject: [PATCH AUTOSEL 6.6 06/12] ALSA: hda/realtek: Add more codec ID to no shutup pins list
Date: Sun, 30 Jun 2024 20:13:25 -0400
Message-ID: <20240701001342.2920907-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001342.2920907-1-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
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
index 97df0b01b211c..882ac9dba97c0 100644
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


