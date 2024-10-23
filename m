Return-Path: <stable+bounces-87930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FC9ACD67
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE931F25B43
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC602185BA;
	Wed, 23 Oct 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtJCDbk1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FB2185AF;
	Wed, 23 Oct 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694008; cv=none; b=SpGBVdRK3NmRtu4urZDYpyh3wAYzRYrnE29PdlZwL1eIc0AVp6tae2yhZWHxvPAUMPz0hoqiyNfLM2xmDpYlEYKOe3XK7iBVVdQJDCnFEzCKBItr8bilFM/QOvXVgySGTEf8koscTVPEAtb8W/Kxmfkm7yoaoidJL+S/QtU4W74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694008; c=relaxed/simple;
	bh=S3UtykaDtYZGznGjl8tHD3XtFFB9dALBjYjnnE+3L38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIYoAg46RQxVZsdHpGTAHRcnqcf6fL2ZBMwxqmsFwRKNRecP6zdB1H96TmLBlAhKxZmf/FoSo6OZpqNH8s8GOV2y/z4hsBYxMK0FK+aDB618vr+00ojO3J6ylxxQ2sf9fYA22danOJDzlG8FpWsvzMn7hlTC0mS0kvbK633tglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtJCDbk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79281C4CEE5;
	Wed, 23 Oct 2024 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694008;
	bh=S3UtykaDtYZGznGjl8tHD3XtFFB9dALBjYjnnE+3L38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtJCDbk1gSag5Ok9nF3P+MpTX4pPXMUXpqPIxOuulRqHNqtnlzopkAzSkzF21j6Ax
	 GrjkE+mjHS9AkyH0NIskh03/QbfiKF6UVuld/9YjV8fH/sz2rrRddBzY2TQYZz4Bmc
	 7ijVmOfTiHYQjh5B3me8tiAHktEylT3jEiYXhlZiB630bJJXkaCqH3cpP1T8gaQdFP
	 dFc4gBaTfH0dcpgne6DOXHYeeUF3B0NEgcoU6kFGQhiv29yWzymzhYcdufhw0DZHfW
	 Y+ZoXiW/jdqIZ5+c/REj1nAfrtYxlqJAJvUz4vzgvw2PK0+g174dodT6rbW3DCwNyi
	 jllWkE+nRBpnA==
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
Subject: [PATCH AUTOSEL 4.19 4/5] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
Date: Wed, 23 Oct 2024 10:33:19 -0400
Message-ID: <20241023143321.2982841-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143321.2982841-1-sashal@kernel.org>
References: <20241023143321.2982841-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index 76febc37862de..be30a24daaf1c 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,6 +1,6 @@
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM || UML
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
-- 
2.43.0


