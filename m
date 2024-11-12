Return-Path: <stable+bounces-92540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D189C56C3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A3AB294F5
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D90227B8D;
	Tue, 12 Nov 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXCskZvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D7227B8F;
	Tue, 12 Nov 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407858; cv=none; b=aE04Ztdi1XpIQTFMnZ6H4ZC6w9KyZdYrZ2ZXli29UIhyWzpqR127qoug+Tw1cjCeGAzbFC4BGp77J/PSp7SdMePHtYShoDE8c/1PiQju6xhJSLBnw9cRmM/ETurvgx5nRoBuo9VFBDPUj+AF524YJEHOnn5EFZ2zjtQ/3EOwWMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407858; c=relaxed/simple;
	bh=P/cWhJSzT3puwSZtlig6ZrMwW8z69zWDYWcHupE6Rt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOwmSzGYYWU6RY07E5vAgGbhPKejq9vMV1wpN7pj/yWJCD0ENpsLGp+scmDELioPcmKNQiimgnm26BDfUEngb7aGRN7bj6OZnv4boyCZBm+gwSFb4BAvOOfSbjMNuCZk5bLPqGDGbbz0pHCV2nzGF4TCP6SnQ04dO754HNR5U08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXCskZvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA76C4CECD;
	Tue, 12 Nov 2024 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407858;
	bh=P/cWhJSzT3puwSZtlig6ZrMwW8z69zWDYWcHupE6Rt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXCskZvcklrVg6zOgYlnxaT9bxAabnQfXkFIXICfqH1LiqjQ58XURu8aZ4pUaDiD3
	 YMHP/2z9Ws9IfMp/xKD/WLrue7fyGquY9LrCFTTbL50v7c7f+vfUmUps5ZdfSx2EQR
	 DJ4jbp6rCfHqJQtyRHO/+MUJxfnifaVhYtQ7RP3DoZGFKAAMPDnd929zqAmQg72qKF
	 pwFT5p2Blnd4uRLjF0OzVh6AyTAv/9KGL4l7RiJBhnsP6mn/GZ9gGv4y92/S3ksFXF
	 1L3o1PxQObNMUr5H66gBaH0dSl98Efq5Eqnw66fKvn46vMhhiOL3Clqj8eB8su9Xbs
	 I3otYSaQ0AuEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luo Yifan <luoyifan@cmss.chinamobile.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
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
Subject: [PATCH AUTOSEL 6.1 10/12] ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()
Date: Tue, 12 Nov 2024 05:37:12 -0500
Message-ID: <20241112103718.1653723-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
Content-Transfer-Encoding: 8bit

From: Luo Yifan <luoyifan@cmss.chinamobile.com>

[ Upstream commit 23569c8b314925bdb70dd1a7b63cfe6100868315 ]

This patch checks if div is less than or equal to zero (div <= 0). If
div is zero or negative, the function returns -EINVAL, ensuring the
division operation is safe to perform.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Link: https://patch.msgid.link/20241107015936.211902-1-luoyifan@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3d237f75e81f5..0629aa5f2fe4b 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -317,7 +317,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
 	int div;
 
 	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
-	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
+	if (div > SAI_XCR1_MCKDIV_MAX(version) || div <= 0) {
 		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
 		return -EINVAL;
 	}
-- 
2.43.0


