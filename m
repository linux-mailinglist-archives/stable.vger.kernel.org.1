Return-Path: <stable+bounces-87920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70C9ACD4A
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758751F23C5F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C14216A02;
	Wed, 23 Oct 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtdT9yDA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C886216455;
	Wed, 23 Oct 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693986; cv=none; b=DjfZXotGq16Q+pdROPKlnJ9zpuiYyBhUwsncMUHadPSZpNoWxWms2dI+2ewNhY1eu7c5ih7u9PM8uHHQOg0F9RO/+AqvRugiRxprYxIctSd2Ze7GcGloym+V2sfNDuWY7McuWF1q9iy7ajyQ20KXuYs/H7QZ0h1SFEBOLPhcWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693986; c=relaxed/simple;
	bh=NAPVcUUPYvToBWjxwxWJNBTwqvqNI3h1+1+Ik+rH11A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN0MBOQFgp3YQSN82ziopYlS+yDErnvuIMmWo8Rg2XbdpjaankH3P9IwI2FBL0PJfpzke9E50BVb2OmoVvOsKGqJeKIYUm89RC0uu//DoJPrLbheXCuAQPIkjyNBK0hpXYtKzUX7kw/IAg3rcFlctzx14BSTFQ1LEGBlBO/hW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtdT9yDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636C6C4CEE7;
	Wed, 23 Oct 2024 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693986;
	bh=NAPVcUUPYvToBWjxwxWJNBTwqvqNI3h1+1+Ik+rH11A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XtdT9yDAynhiqImRrxFlF9S0yemkDK1J7rJIMNIAYweFj6DCykheeGv94WyJNDRdA
	 tW0wsTUP3wEtDUfspr3f0jnv+XA/lLi++HoovBma+MdW2D0ZeZNij9/Sa2Ee133iCQ
	 VHDGUr+9y4MbN6ZvgJtBA9eV3lacU9SITLW3E+eQ+dPArzCOOXlUHqGMaYQIbhB02I
	 5r3V9z6lHqsxQXux39+1enzq+7tQG+JjzJxIL2a9KpMt4UbG3cT5efpcYZNffrHtvT
	 uOUUI86R4B8G85cnPWFW2Dzagk+u0dZXIleSA2Hp2PaGI9FA1bvPXIiuvj4lDIW3FV
	 xiqhi0nrJQe8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julian Vetter <jvetter@kalrayinc.com>,
	Yann Sionneau <ysionneau@kalrayinc.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/6] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
Date: Wed, 23 Oct 2024 10:32:52 -0400
Message-ID: <20241023143257.2982585-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143257.2982585-1-sashal@kernel.org>
References: <20241023143257.2982585-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.228
Content-Transfer-Encoding: 8bit

From: Julian Vetter <jvetter@kalrayinc.com>

[ Upstream commit ad6639f143a0b42d7fb110ad14f5949f7c218890 ]

When building for the UM arch and neither INDIRECT_IOMEM=y, nor
HAS_IOMEM=y is selected, it will fall back to the implementations from
asm-generic/io.h for IO memcpy. But these fall-back functions just do a
memcpy. So, instead of depending on UML, add dependency on 'HAS_IOMEM ||
INDIRECT_IOMEM'.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Link: https://patch.msgid.link/20241010124601.700528-1-jvetter@kalrayinc.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/Kconfig b/sound/Kconfig
index aaf2022ffc57d..cb4cb0d5b9591 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM || UML
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
-- 
2.43.0


