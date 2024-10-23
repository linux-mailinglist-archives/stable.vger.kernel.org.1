Return-Path: <stable+bounces-87853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B97D9ACC8D
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4786C1C20D5F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37DE1CFED6;
	Wed, 23 Oct 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taVFpk5h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6D1CFEC7;
	Wed, 23 Oct 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693842; cv=none; b=SLbqhg/gD1OQOvykOh8BqeB2eZIT+l60jG9OCBdh/qXRvrvx+g6vzST/nv1ZmK6EN2LKRuNzPnGntS8W8kxuu67Exx07zoGf/r+hu0W+XIf9dF5AFDGeg2IY7EvpKQ4LZLfkj3WsQcxAddwCziizcbqYsOiyexWlhN8LdTW8ZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693842; c=relaxed/simple;
	bh=G59Njn/ri5bLKpEUV6Ax+VakkUWMTqQ2UEYtaLWGdrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MID7dHBUA3rvS7De61pbsCa0fqvGuo35T5idJKBv299Wrh+0nMQ6TYO5AsEzXKFSVNp/76sHm6p0/l2nUhyXcAKboTcl4uvxTD45qwFFQ6bIw2fzarWHovBeBCKOJBk5PWT+PDM+SzUE1KVLrl1LeiRlUmsvb75IHU3txOFhyN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taVFpk5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8FBC4CEE4;
	Wed, 23 Oct 2024 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693842;
	bh=G59Njn/ri5bLKpEUV6Ax+VakkUWMTqQ2UEYtaLWGdrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=taVFpk5h828tzcM6msbhZn52GWvIHEo+lVw1AHbbj8+tDSSOQPvtEFIVE82ribjoq
	 RfAsBapm1SbImbM4hNiBwQBwBgerKcVvnkZAGbk5bgDxXz0p4jFZHfa6j2TeRFf71m
	 IJaUcV2H1Vf5Arsyom1bKPU/JYBxJaulOnzux3GSzJ7ZrYmcMQLHkQUY6Dv6O+SsIC
	 gRxOd2L0vQWsWTERLDHILXXkchCU36B1mC4aE1UIslbcddCPNuta4NLdK0nmFwnouB
	 vEGbscmG2Qag37ttn7j8VY3AlpL8sRHtJwHC+oZxINgQLEXNlG705c80PFYxQtTgX2
	 cMReHtbg4WswQ==
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
Subject: [PATCH AUTOSEL 6.11 18/30] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
Date: Wed, 23 Oct 2024 10:29:43 -0400
Message-ID: <20241023143012.2980728-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
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


