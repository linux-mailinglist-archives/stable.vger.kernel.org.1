Return-Path: <stable+bounces-100701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28749ED503
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A6F161B0E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7564B237FE4;
	Wed, 11 Dec 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaPlzhyH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F652236951;
	Wed, 11 Dec 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943050; cv=none; b=tIlrlUcLW8rQOpkzwAZl4RSMDyiEwF6+bbdKtF6plGYd97QagXCfxdyG1rpCp+BXlalFtkZQ/GbTMOLVgmcDi97DVrJJWntgo3lbpJLtZ4CrB4SDjNCnr4WSBhIkIhpBF3CusYQZxjbch1U9b5RPJ6xgAsSVc1Il81/f1HJPP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943050; c=relaxed/simple;
	bh=jhBy7DsckUwY0VYkZgy54RJnBQYJQoxeCdI9nZKIlhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLfn2C8/J/bkRu+shMo+uuciNpUcf61wG+xFkvd17QfQtRKP4OuBqSGn1VWAr3xn85ClCI2iKYoCjETnAaV+xze1t6XWpZ0g0ihlvbI4QPlN/uKHs3OLI3vAUdcfKZ3ueMRQKMMrTntl+gEVULccWZti5Jr7BX/LfTAHa9CVVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaPlzhyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A58C4CED2;
	Wed, 11 Dec 2024 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943050;
	bh=jhBy7DsckUwY0VYkZgy54RJnBQYJQoxeCdI9nZKIlhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaPlzhyHOFkwNASuHOjPpqECsb+IHl4nFhg0W1oRNXOcE5o7rO2BGbjuX0FQKRUa1
	 +HIIsTdSXg/g9zSpSCt7LpVxpDKB2KDxoGDiZWyaxRtdLPPYkIPhBO0oS2GaQer3M7
	 Fr04t6UnU5VSiEoDT2/uxOJ7suj72Ns0rNXpyTM88i+XBmwBhqnNzAXoCmL2W58Mom
	 5diObWxvDwhnNxTp7ZL5bu/VvbR2nVBN2j6zxFOZUHumtu2wSiNWW2/qHeAGPv++rJ
	 WAfUZi+ihw1bLZuDj7GxjWGAHjrYw5u5f46oW2uTWRNjR5doa1imcDJV4LecojAZIi
	 7sDOqzo66yHGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	luoyifan@cmss.chinamobile.com,
	andriy.shevchenko@linux.intel.com,
	zhangjiao2@cmss.chinamobile.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/36] ALSA: ump: Indicate the inactive group in legacy substream names
Date: Wed, 11 Dec 2024 13:49:27 -0500
Message-ID: <20241211185028.3841047-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit e29e504e7890b9ee438ca6370d0180d607c473f9 ]

Since the legacy rawmidi has no proper way to know the inactive group,
indicate it in the rawmidi substream names with "[Inactive]" suffix
when the corresponding UMP group is inactive.

Link: https://patch.msgid.link/20241129094546.32119-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/ump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index 0ade67d6b0896..55d5d8af5e441 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -1256,8 +1256,9 @@ static void fill_substream_names(struct snd_ump_endpoint *ump,
 		name = ump->groups[idx].name;
 		if (!*name)
 			name = ump->info.name;
-		snprintf(s->name, sizeof(s->name), "Group %d (%.16s)",
-			 idx + 1, name);
+		snprintf(s->name, sizeof(s->name), "Group %d (%.16s)%s",
+			 idx + 1, name,
+			 ump->groups[idx].active ? "" : " [Inactive]");
 	}
 }
 
-- 
2.43.0


