Return-Path: <stable+bounces-92554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF779C574A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95E7B2F028
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1CE231CA4;
	Tue, 12 Nov 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbE5ARv8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E452309F9;
	Tue, 12 Nov 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407877; cv=none; b=qJexOw1BnoVl/KaFWZFElK98Drpr6kbj/ndeky9XRCcbWD//XnLJsvWHdYKHTKS8l0bIvIL9cYb+K9s4PfkgSvvCOUPxxPp5wrRld5PnfvwxoXb8PeU9FmLCu43DxFTsZk35oqBz0xtSeicujk2Dntv5SS8cZTPy/0/XmUjzJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407877; c=relaxed/simple;
	bh=od6gr/PGtSwhl7xGbZ35EBKxaOm7AXdWNVc0c5rm570=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr2TVU7nnqd/Spw8VUw7/wo6P8+oNosUNAsG2CXGzzFO15mT+ilSVvfuUkuhYIO8Wkkurd8fnazQhGWJqodod80a2aO4PD0iueLstusx8nzmAGno3Ei9XFdZgXc8t8iosqknFtexJ3KFxYofwENnqMAlj18ZaxIIl4AXXVzowq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbE5ARv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DB2C4CECD;
	Tue, 12 Nov 2024 10:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407877;
	bh=od6gr/PGtSwhl7xGbZ35EBKxaOm7AXdWNVc0c5rm570=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbE5ARv8VXVGQSnT5oDhTWAJnlxal2UCMV3RoYqOw1LwAAbqn+tMVsiBLIK9uHsW7
	 oQ+hANPjm4kVfF+ye/Vg33Yn1LjryPK4+lCJPiPyW/Jayyw92K+F33OyyW0v6Ga7Hv
	 Tb7WemweoHw1VS0dAipo3IVZMGFvF3IuFVeZtbD/4wlEgGsUijrHDvRHD/Im9IgAsM
	 FTvWCTunzRJmeIWQK3aOoJNHghJxnO/DvkLd8iwh3ZKVxlPuxidkvr8Yq1meIa3SSE
	 LYcOaxk/vrNIUAx7aDvD9P1OlM2cuigWkTL7tulcvvjEiAtt1mVcD5U+aXo6dB5alL
	 e6uWgjmSS4muw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luo Yifan <luoyifan@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 6/8] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
Date: Tue, 12 Nov 2024 05:37:40 -0500
Message-ID: <20241112103745.1653994-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103745.1653994-1-sashal@kernel.org>
References: <20241112103745.1653994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.171
Content-Transfer-Encoding: 8bit

From: Luo Yifan <luoyifan@cmss.chinamobile.com>

[ Upstream commit 63c1c87993e0e5bb11bced3d8224446a2bc62338 ]

This patch checks if div is less than or equal to zero (div <= 0). If
div is zero or negative, the function returns -EINVAL, ensuring the
division operation (*prate / div) is safe to perform.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
Link: https://patch.msgid.link/20241106014654.206860-1-luoyifan@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 9c3b8e2096565..aa9cdd93b5778 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -380,8 +380,8 @@ static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 
 	div = stm32_sai_get_clk_div(sai, *prate, rate);
-	if (div < 0)
-		return div;
+	if (div <= 0)
+		return -EINVAL;
 
 	mclk->freq = *prate / div;
 
-- 
2.43.0


