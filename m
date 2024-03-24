Return-Path: <stable+bounces-31571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B24889686
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4AF1C3043A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D25C36C195;
	Mon, 25 Mar 2024 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMQBbWs7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835D14532A;
	Sun, 24 Mar 2024 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321975; cv=none; b=QSbzYWs+sk5va0aqDzaFOO2WVyDhp30uQPxtpNVw5A66aVqIsnExNXwe7hofKMix6IcaGaFMfgAUdSXRcB3vhsUkjaADO1z5qs+2bjQFjc6Z6UU76ahLoa6LiEDCbz8yWxeQpl16y4QLC/5MT0Uh5F4kkAdFScuSADBW/PkVU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321975; c=relaxed/simple;
	bh=RGrOirHE3j084FyDubnAZGEumOuMaqgWe3b9VZ19Iww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgIkJmjouQs1RJ5PL3eYB/SXjLSAqzfzQv0AC7/C/3UKvO5Sk6uP4JVipVlqkHLYrFGV937QqbHDuSWgLpb6lRlp3ornfGcyf6pqqF91ZOMKe9Q8bUUXMT4fs1G8n4gnK0GwZntpMLKyQLLLUSNhIkGoVGNfLMLndP885y+ZUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMQBbWs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA8CC43390;
	Sun, 24 Mar 2024 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321974;
	bh=RGrOirHE3j084FyDubnAZGEumOuMaqgWe3b9VZ19Iww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMQBbWs7d+/Ix+Tnf7TpRNcKAP43FE7J+yCpWQHhuO9NI3ZzPnYE40VnYRBp6/0+3
	 Y5HS5MSyMpAfE5Dz9hHPwRDxwnDmYBvEAjY+o0kb/j4OS1q0OZNc45GBWK2eoyf7NE
	 Fu83u/v4udAq+YfRJQjRdH7KqXMT9b6vUbSq1GVEPkMEnzwrFZcZA3f/VHGQPv9ocD
	 uV1DCEDs+vAt8YwWBq96pQH/5P4IzU8a5TbkM3Y9yZdMGA1ImbbauiKyQwDe8wkCOT
	 rcWAW01681DyaaPLI9U/AZOj8DONwSwGWHbuyju+wDocVJxA7qnD//tQjwtAZCR3of
	 LqFA3su1dgJHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/451] ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port
Date: Sun, 24 Mar 2024 19:05:22 -0400
Message-ID: <20240324231207.1351418-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 75bd7b2fa4ee6..ede3f8b273d79 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3681,6 +3681,7 @@ static void alc285_hp_init(struct hda_codec *codec)
 	int i, val;
 	int coef38, coef0d, coef36;
 
+	alc_write_coefex_idx(codec, 0x58, 0x00, 0x1888); /* write default value */
 	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15); /* Reset HP JD */
 	coef38 = alc_read_coef_idx(codec, 0x38); /* Amp control */
 	coef0d = alc_read_coef_idx(codec, 0x0d); /* Digital Misc control */
-- 
2.43.0


