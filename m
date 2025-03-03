Return-Path: <stable+bounces-120117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF7A4C764
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB975162713
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC1D23F28F;
	Mon,  3 Mar 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMv3b7Gg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73EC23ED72;
	Mon,  3 Mar 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019437; cv=none; b=JOCMaRJAPWd59nbYauS/K5uFoRKy3/4ayrizgnQ3MuYtqmPHFlDRmtvzQHfxVgzCgyUjKXf2rXX2Ao4nRtnCc1TRcBAOVgfD+WlvvgPS588wXS2oAMJyNkLIn/mxAdaYOQvuoyhXC7miv/ybGy3vedNkJcA7BzKOz7osAOk+LSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019437; c=relaxed/simple;
	bh=k9IRkt+TgcxkQj3UctvZ4or7Cn5kuxCcivmqM+G6+qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5e1d4UdsX/fgb3HIfaB20ApDzic1x6aHtu8c8Cj8dE4V+pCul8Y9O7T5NLHCdgvTC3+YuoKOXIgr/liBUImxFja/vzBluXEZImOIntQH0PQZNOFDlPKywq+PiO02exoS58iwk9KDH3T6i3aQhgR+qybSnzgJP9EFb2YcndD2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMv3b7Gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08182C4CED6;
	Mon,  3 Mar 2025 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019437;
	bh=k9IRkt+TgcxkQj3UctvZ4or7Cn5kuxCcivmqM+G6+qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMv3b7GgUJ93OoZPwCJuh8nItXW1gKB/rId+V0iSsDIuyOxk6Ad/jYf0aobr+cU49
	 yQmYbQ3MPJ9ZEWxSu4WFm4oDew5KNAx+4i5q2R0oOjH46F23TxM51XuuSYIdQGlGcM
	 G9ux55IXR5u3BZum1GoZYJucR+1OWnsxfJRKfDFnRomDpXuCeXnKIz5LtUbq+htXDb
	 FgCsohbc9J9GjyIgisnznipclmPmKev1BNCKQOpMYRzD7CFWtwDgf5upicz5ydcE9p
	 xd35CXEgZECsk2eRK1xyW5vMqxLv0E77V2mZkbeS09T4iJSZeCp71ApJ66XpBl28Yq
	 NRl+uQb7acPGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	James Calligeros <jcalligeros99@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 03/17] ASoC: tas2764: Fix power control mask
Date: Mon,  3 Mar 2025 11:30:15 -0500
Message-Id: <20250303163031.3763651-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit a3f172359e22b2c11b750d23560481a55bf86af1 ]

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
Link: https://patch.msgid.link/20250218-apple-codec-changes-v2-1-932760fd7e07@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 168af772a898f..d13ecae9c9c2f 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -25,7 +25,7 @@
 
 /* Power Control */
 #define TAS2764_PWR_CTRL		TAS2764_REG(0X0, 0x02)
-#define TAS2764_PWR_CTRL_MASK		GENMASK(1, 0)
+#define TAS2764_PWR_CTRL_MASK		GENMASK(2, 0)
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
-- 
2.39.5


