Return-Path: <stable+bounces-113047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FABA28FA3
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A2516715C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C59155CBD;
	Wed,  5 Feb 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lquQepnY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDC155382;
	Wed,  5 Feb 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765642; cv=none; b=r702sfURN6PiEcKFT96Di8qBcOpsrAYhyhunlTrljurVFuCP0g2mr0kO+sXlL2a6glR7oWleqGWxVrg8xzq6Tt1x+jfdUwNOssyY6J3M/KM43R8ZrnOiTcou7hCErQOlY6ZEiVqugCwA+OOifIIbj4Z5RMsoRpAEOktPkiinkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765642; c=relaxed/simple;
	bh=bnP+QKgEudMpPrMGO2NI8spFXNCmisLUsAHHfF/DmgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEW4DPf6+35Nm7FK3oKJQRTugOfNT2PwVIv8z3EZxcHT1gDN3MK/XU1s+efyGLCgKy8mywA/ZK+u6NXayNa7ivUba+0atQ5TyIZiWH+MMpA2KQNqLrU3CZwc1EgUmbXCQVleUYaaH7UKxp8iAHZBtfONmsMVLEGjr3humlkOim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lquQepnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F40C4CED1;
	Wed,  5 Feb 2025 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765641;
	bh=bnP+QKgEudMpPrMGO2NI8spFXNCmisLUsAHHfF/DmgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lquQepnYxIKqR46085UZDcLL2l1nd36yHF/0lTZPHSQYK1HV/9q5BzW942L/xh7M6
	 gyt5dSTgplqrfvEWRc3lPDNH4BBX/ydkNzi0KHR9yR1qBmGY8EuiDYuMOJ4a0gh8rH
	 ihVgdFLvqCGSnY6P0ELr7Xb1le/Er6lME6HRdpAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 239/590] ASoC: mediatek: mt8365: Use *-y for Makefile
Date: Wed,  5 Feb 2025 14:39:54 +0100
Message-ID: <20250205134504.426737122@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit e9d2a2f49244d9737f0ec33f4b7f3580faecd805 ]

We should use *-y instead of *-objs in Makefile for the module
objects.  *-objs is used rather for host programs.

Fixes: 5bbfdad8cf8d ("ASoC: mediatek: Add MT8365 support")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20241203141823.22393-3-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8365/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8365/Makefile b/sound/soc/mediatek/mt8365/Makefile
index 52ba45a8498a2..b197025e34bb8 100644
--- a/sound/soc/mediatek/mt8365/Makefile
+++ b/sound/soc/mediatek/mt8365/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # MTK Platform driver
-snd-soc-mt8365-pcm-objs := \
+snd-soc-mt8365-pcm-y := \
 	mt8365-afe-clk.o \
 	mt8365-afe-pcm.o \
 	mt8365-dai-adda.o \
-- 
2.39.5




