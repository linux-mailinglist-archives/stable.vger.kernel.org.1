Return-Path: <stable+bounces-43304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727388BF18D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140E41F220AE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218313E89B;
	Tue,  7 May 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6qguEtH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D11350E4;
	Tue,  7 May 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123329; cv=none; b=Ysjb7ymWu07ne5ieL0ohPS8f3Z8Ii35J667l6eAGp66GvczwSB3XZeVhQjaQxIdMZUyTV5yFt3xfTzSUebyJTWTReALv1R6xpBcT4oucC1aeOBqWzGnmZSjG3zkUY0OcXm64E3jeTNPOZecwkUn+VYivSeMWsZ2v1IkdoWoNKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123329; c=relaxed/simple;
	bh=xexA27Mt4oEuII0u/q/FpJT4grps7/6vevw9C19Zmiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LK8NkuIy1XZpUZ/jfKsVdmNEKAiRtJyKn5IqmIie6wEcduXy5tHd4336wANVrqX8FtCyCt7bNlSNhpXeH/90Gsxr9cYVpymxRogQERDGVJMLT3hPrcL7eBCLZhVLnOjx1jJDSF6fkL2hTN+1eQa2ra9QNjn083KmrLa7z5O0HyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6qguEtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C1FC4AF63;
	Tue,  7 May 2024 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123329;
	bh=xexA27Mt4oEuII0u/q/FpJT4grps7/6vevw9C19Zmiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6qguEtHtDUN04SmTGlJiPdm49qdoKE1DvMqVR4jyK8z5KxVlaiHamkqv1xzVRXhk
	 +g87L4g2bCefrhI3G6k3/ymDuQG54ciRochXyU6r7LWJYCRCciQ/1s96A88W97YRoL
	 B6HY+eYNFrsWDta2Z+OIWQ8IQmpNhZbuVlyWVVg0Te2BP4qHYbYxPMzb7HUP3+0If+
	 mZ8IPAXVawvn5jXWvirFnhU9mKG6n/jgijZ3ME9Tx6dBHIiu3J/x/RzQOssNJj4Vye
	 mmr3SO4v6XiG/C/wmKcGOpM7cuwUNY89TccCQ9S6et+OS7gWuecmsjzrhaZXnUj5og
	 9f3Kx7yRD2l0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 25/52] ALSA: emu10k1: make E-MU FPGA writes potentially more reliable
Date: Tue,  7 May 2024 19:06:51 -0400
Message-ID: <20240507230800.392128-25-sashal@kernel.org>
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

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

[ Upstream commit 15c7e87aa88f0ab2d51c2e2123b127a6d693ca21 ]

We did not delay after the second strobe signal, so another immediately
following access could potentially corrupt the written value.

This is a purely speculative fix with no supporting evidence, but after
taking out the spinlocks around the writes, it seems plausible that a
modern processor could be actually too fast. Also, it's just cleaner to
be consistent.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <20240428093716.3198666-7-oswald.buddenhagen@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/emu10k1/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/emu10k1/io.c b/sound/pci/emu10k1/io.c
index 74df2330015f6..5cb8acf5b158c 100644
--- a/sound/pci/emu10k1/io.c
+++ b/sound/pci/emu10k1/io.c
@@ -285,6 +285,7 @@ static void snd_emu1010_fpga_write_locked(struct snd_emu10k1 *emu, u32 reg, u32
 	outw(value, emu->port + A_GPIO);
 	udelay(10);
 	outw(value | 0x80 , emu->port + A_GPIO);  /* High bit clocks the value into the fpga. */
+	udelay(10);
 }
 
 void snd_emu1010_fpga_write(struct snd_emu10k1 *emu, u32 reg, u32 value)
-- 
2.43.0


