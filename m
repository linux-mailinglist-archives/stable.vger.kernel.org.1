Return-Path: <stable+bounces-87879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACCF9ACCD4
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B191F24EA0
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707B200C9E;
	Wed, 23 Oct 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFjgZPw4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFE1C304B;
	Wed, 23 Oct 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693899; cv=none; b=W3x+rm6jkcq4FNDoPMnxxGj8rxOOMF+KuVQDlZrilq/Cpa3dst9B0g1Hq+CsaxWbCPWNxEddm9+79Z+6pPAUiwV5EVNQvxSH6b4/qi8TX/hxy1KFnKnXlI+i+YilWvZn/idynT/RNGH2TyAhhcYVBr0s7/S+Kx2cGO8at7prFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693899; c=relaxed/simple;
	bh=G59Njn/ri5bLKpEUV6Ax+VakkUWMTqQ2UEYtaLWGdrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkzDlWTdSXbZ1FC2C3rCTKBCnGjekwsg+G/JFLIM9Z0F8hFnDw495jeie58tV4ZaVu42g286DpzGYrSu1oNE6pn9ub9r5OAh0p7grHE+mBlu4AicHkEqgHTk9JjvD2pmAqoPKvokE507noixQD6mbDrPBHtPzx7Y1+HrffG/HAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFjgZPw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE05C4CEEA;
	Wed, 23 Oct 2024 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693899;
	bh=G59Njn/ri5bLKpEUV6Ax+VakkUWMTqQ2UEYtaLWGdrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFjgZPw4Ljl/0qGl3Mu97xWsSv8ITmJOzhJqehGlneHHcYuFgsBI/Z+lFqS4UCD6V
	 aryY7vn5dRfga7SYUP+BwdU2nfFSdBcpJLTWyCow0JGNIMvEufW0YwT4JfDUGIIbXK
	 /gzyVA+p2HfefU5VxRgb1/Lc3J1hdJOfaOwx9pJPwxcmzZ4drbpkZhX3+XWXuvNzrA
	 GCWGt/jk5FWDhQ+OvaP+5KjYxBtRKYx5hBWxtT3Ta0A0dhoo+4cWI+1xeg7f9+jH0c
	 FukgKs/3H/HJn551hnTzSkxlkysuh0Z+l7fSeLeUH0W3c+AV/6QUjph6vUnPR1FtRh
	 bL604nWn3lS2A==
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
Subject: [PATCH AUTOSEL 6.6 14/23] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
Date: Wed, 23 Oct 2024 10:30:58 -0400
Message-ID: <20241023143116.2981369-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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
index 4c036a9a420ab..8b40205394fe0 100644
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


