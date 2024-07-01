Return-Path: <stable+bounces-56188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EFB91D562
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAEF1C20A9A
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6151E15A863;
	Mon,  1 Jul 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKzvkNFQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654415AAD6;
	Mon,  1 Jul 2024 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792906; cv=none; b=jshG3l1rKyuCpTzST4VNJUG+6G5lMkdNvBH6atDvzb53hHwVmx7YfudO+qjRGrU7Bj0vjuCqIuJryOVQY5AEMf0lIu2aXR2+e4XTyP5WPKGOVHMZ/z2uwc+nwnhbEXRZMJZSkAbp3w9PQ6j11Fo7B7vTuHRKV5CvBV6vIjhF5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792906; c=relaxed/simple;
	bh=tub/KFrI5WMPRKPPQQcJOvZ8W01m9UyyKhvkoQY+7jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zmh8+28QGwGWbmqffC00okaMUQrTjs7CqyM6J4PKvI4jbz7zr7qhJEe/rb1hKluUocTVaLgb1nkUUMXO5a0t/jPU8+85YF8RF5JNp015+nZGsj0xzUTC9urSixtVce3rFr8DqhhySchIHcn9MMDLZ+6b8Exn9mTWxl1dOheI4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKzvkNFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A225C32786;
	Mon,  1 Jul 2024 00:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792905;
	bh=tub/KFrI5WMPRKPPQQcJOvZ8W01m9UyyKhvkoQY+7jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKzvkNFQ/KkoSc1BZnfXx97riSmMMgnnRmGcseOaR3ysmZkiNd0ijTPXX5v1dhaPk
	 VUpVbpbrPBsLg1bWyTqJy6Znf+bniPBHUBxhIGhoR/wl27h0YQFYKb6dm/pURtwczr
	 aoYhujUoR2AserNkCVaMqz31/kbspcxh/QbQIgZ3paqFlclVTeeWEdqNb5oa8pKkno
	 KpptWSUoLfix0vPgZ8dc+kOoG8VMo5aD0eucszoJ5VitU4Wh1Y0+MXIYaadARrAaXx
	 jvWZgXrUBhyOcY/eK5IDbbDL4uAPO3qU2E+lq5+L+ZacJjGyr6FHtpNw2FzuxV2nAs
	 2CySyCif3xFNA==
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
Subject: [PATCH AUTOSEL 5.10 3/4] ALSA: hda/realtek: Add more codec ID to no shutup pins list
Date: Sun, 30 Jun 2024 20:14:51 -0400
Message-ID: <20240701001457.2921445-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001457.2921445-1-sashal@kernel.org>
References: <20240701001457.2921445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.220
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
index 4af8094938059..7b02eb574dcb4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -578,10 +578,14 @@ static void alc_shutup_pins(struct hda_codec *codec)
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


