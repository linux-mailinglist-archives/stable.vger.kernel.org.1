Return-Path: <stable+bounces-149673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A99ACB438
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D143A1946BE7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B67223DFC;
	Mon,  2 Jun 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NxkGneZP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88941C5D72;
	Mon,  2 Jun 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874677; cv=none; b=raXTA3mxSp6Qyy4dkWsXSiW2JcTYKQHNjSzwTxbLDi6nnQZ/7s75UBtZkITxCrZlyx+uFVErR1m3CYYAeAFL6LFE77BhDy2P2GwUVl1GqKcBOmf0gfI2BJvfHRHdIdmf4mwEuwWFUWsp07hNubfy63SECjSLqWja6iWiLsCKT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874677; c=relaxed/simple;
	bh=wzVDEEWGkoeyVMetQqPYKrUu5q08gDEr25xz5XZpHb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSXfD6CzsJyl2PY6B3EYv1LSBaWy2K59D88Mx8OYatm51GlJtwDylzu+y0KN9sN822kx/a7NQCDo40tP+nYcz30dN+tKZyu0KFxfpKE32xZoRj+NmaHc2Qw2cIDtzx0fKv6LMABaWvPuBu/2bKUtj7sMV8ZwDKCgLn87gE6dxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NxkGneZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26139C4CEEB;
	Mon,  2 Jun 2025 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874677;
	bh=wzVDEEWGkoeyVMetQqPYKrUu5q08gDEr25xz5XZpHb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxkGneZPOV/lUAQxZqnQcU5fKDB/HNZxo0WlE1aKYfakspdltpdoPsmElK2MSCKGR
	 fypB8IERAXx6MIcOLlUkla5L2X0jixIW+aJM6XHZkf+8dcPRNwu0bWKyPG6TDpCNUv
	 huWJkTIUqXMJOIHt74mGvdfVRDtvTA+64H4s5dZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/204] ALSA: sh: SND_AICA should depend on SH_DMA_API
Date: Mon,  2 Jun 2025 15:46:46 +0200
Message-ID: <20250602134258.549991807@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 66e48ef6ef506c89ec1b3851c6f9f5f80b5835ff ]

If CONFIG_SH_DMA_API=n:

    WARNING: unmet direct dependencies detected for G2_DMA
      Depends on [n]: SH_DREAMCAST [=y] && SH_DMA_API [=n]
      Selected by [y]:
      - SND_AICA [=y] && SOUND [=y] && SND [=y] && SND_SUPERH [=y] && SH_DREAMCAST [=y]

SND_AICA selects G2_DMA.  As the latter depends on SH_DMA_API, the
former should depend on SH_DMA_API, too.

Fixes: f477a538c14d07f8 ("sh: dma: fix kconfig dependency for G2_DMA")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505131320.PzgTtl9H-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/b90625f8a9078d0d304bafe862cbe3a3fab40082.1747121335.git.geert+renesas@glider.be
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sh/Kconfig b/sound/sh/Kconfig
index b75fbb3236a7b..f5fa09d740b4c 100644
--- a/sound/sh/Kconfig
+++ b/sound/sh/Kconfig
@@ -14,7 +14,7 @@ if SND_SUPERH
 
 config SND_AICA
 	tristate "Dreamcast Yamaha AICA sound"
-	depends on SH_DREAMCAST
+	depends on SH_DREAMCAST && SH_DMA_API
 	select SND_PCM
 	select G2_DMA
 	help
-- 
2.39.5




