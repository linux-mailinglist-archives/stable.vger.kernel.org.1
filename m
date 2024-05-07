Return-Path: <stable+bounces-43287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532BA8BF15F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73A41F20B66
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F3130E46;
	Tue,  7 May 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPJJXivu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011BE130E39;
	Tue,  7 May 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123298; cv=none; b=GLJf31iqqeZ9zB3P0ekLjhGM7uVPJqQM8nFN6VjNCRi+XsGrGTM9DcEJCDT4PfKmnwh+IISOs6PSQe3iPyYJqwqtO0ylvpY/msi0Gz01kLAmKFui7SvlN6KWwG9StZjtfzVBKIAR92FQH6XfxYS+4XAaP6GCUzlCwQinQY9T/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123298; c=relaxed/simple;
	bh=tzAO42lNI2hbn6/bD9ofHq+ScsvGfmTLGzi8KkdDbrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIfgC2BJ1F/LLsgU02nfcucNDIYc5a+YV0Uonlp1zGPeI5OKj+HYDZ0zUSJy6BehLd5OTlZN76HTPASMw5MRQ8C/U2+FzCyA3PztW3aqhwHwLLt98amPL6Vhc5TY3q7VAeG6Cvkx1uGdsqD5bUjXpQWYl7wnDiu21j7hoSj1vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPJJXivu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69649C2BBFC;
	Tue,  7 May 2024 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123297;
	bh=tzAO42lNI2hbn6/bD9ofHq+ScsvGfmTLGzi8KkdDbrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPJJXivuFIvrAs+sQMTJX2YDLH89P0Ahyx2lZcn0SXH3+7jICsBTVF7AeF5d873BQ
	 fQHVcL+sDT7Vp2fwcSucsk+GDw5jj8ABwJcqzGijCZg3UjWpusjbozlmG6bXC/+cFh
	 87pmwBlRv81vtB3cEVn+xTYOrLs0AiFcFCy9oXG8W6AklJkbouNuqJaikWUnm20CHY
	 y+uIxYKvcMsNP5dFoW9sm2o61c1ZlBPWT45EMXt9F0L7rgPzV5s5DcBU2Z0KlI31DX
	 GQB5vWCJX6e9pP/nnuyNWwY6p2VAtmMqFHysOHoZfvP85O2cnUW4U3KfQ5N2DF7ZjP
	 iopKBqYJ4QROQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "end.to.start" <end.to.start@mail.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	jeremy@system76.com,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 08/52] ASoC: acp: Support microphone from device Acer 315-24p
Date: Tue,  7 May 2024 19:06:34 -0400
Message-ID: <20240507230800.392128-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: "end.to.start" <end.to.start@mail.ru>

[ Upstream commit 4b9a474c7c820391c0913d64431ae9e1f52a5143 ]

This patch adds microphone detection for the Acer 315-24p, after which a microphone appears on the device and starts working

Signed-off-by: end.to.start <end.to.start@mail.ru>
Link: https://msgid.link/r/20240408152454.45532-1-end.to.start@mail.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 69c68d8e7a6b5..1760b5d42460a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -430,6 +430,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "MRID6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MDC"),
+			DMI_MATCH(DMI_BOARD_NAME, "Herbag_MDU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


