Return-Path: <stable+bounces-29874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D2888811
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6080B284211
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72722EAC7;
	Sun, 24 Mar 2024 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEbXUUla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C61FD102;
	Sun, 24 Mar 2024 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321328; cv=none; b=bhiSiUvBhIbIt/Yq5YhIferbOz9omeU+CGTKLWTA/han7genQLMKaF5BoQgcY0l3OjZNjGnX4YRjVs+Kc2zG4a/1wiqiKE0XGT/QNcc9QaG5ZI4jV2dBUGo1q5wjBPqYqx9fuhoC99m34Gs56MqKDYhU73RFWrJVICBxSCAKM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321328; c=relaxed/simple;
	bh=/LhJIP8T8+p/zwAyQer+F/R9x5sOpEcp3+Z1eGMIylE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyvLow9TvXULDpxSRyBx9L1bsCXmziYdGngHBEWkOyHG4Y70Abge9lqyz5Ged1nZ0ofza9aNUCLxuqp3OpolfsvXNReu16QRcAk/oB37eJIKQil21N1tsOWQ2UOkFJ4Gott0hycLDX7xh3Ya80P0lxWXhQgbw2zivMJ1DDHyciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEbXUUla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4591FC433C7;
	Sun, 24 Mar 2024 23:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321326;
	bh=/LhJIP8T8+p/zwAyQer+F/R9x5sOpEcp3+Z1eGMIylE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEbXUUlayrwm6RkBvu5cNx8Whqma8AP4537pdqUdqXPtLRyJD6ee3cBAjnoKMicuK
	 fCq79IDWArB7polBstdD+4Nw7gZALuDsWyxYavplKHePyqBLRm7Dw2NXiuh6otnkHA
	 SGpVfFmnaA2jyImB/qMoDvvdLLFLdI/b7in9pxP0AaRNS6y7jngbr8xWyhswv50Smk
	 5SVtAcdBiUUsIpaNgPhtAxn3V8IA9Mcr+S9s/F/OtIDOjWxb0bJGk7eW9QHWH8YT/A
	 1J+FMojH0K9Phjg4M4lHHftchTBMiGEOkG3HwEywDfY5qPR1QduSdreLYu0apZjRQe
	 9RzDISfLouJgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 050/638] ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port
Date: Sun, 24 Mar 2024 18:51:27 -0400
Message-ID: <20240324230116.1348576-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit b34bf65838f7c6e785f62681605a538b73c2808c ]

It had pop noise from Headphone port when system reboot state.
If NID 58h Index 0x0 to fill default value, it will reduce pop noise.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/7493e207919a4fb3a0599324fd010e3e@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 88d006ac9568c..234c8b46d9254 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3683,6 +3683,7 @@ static void alc285_hp_init(struct hda_codec *codec)
 	int i, val;
 	int coef38, coef0d, coef36;
 
+	alc_write_coefex_idx(codec, 0x58, 0x00, 0x1888); /* write default value */
 	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15); /* Reset HP JD */
 	coef38 = alc_read_coef_idx(codec, 0x38); /* Amp control */
 	coef0d = alc_read_coef_idx(codec, 0x0d); /* Digital Misc control */
-- 
2.43.0


