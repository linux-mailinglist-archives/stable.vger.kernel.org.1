Return-Path: <stable+bounces-92575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1892A9C5534
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3341284EAE
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9734322ABDD;
	Tue, 12 Nov 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjruMj4G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A80220C7C;
	Tue, 12 Nov 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407905; cv=none; b=e5mMSNw5N4quRvaafq10MV4JL8l1XMfkUbPPHlnz2gL4ssVw/Kg5buRr2DN1yLx/ys57QnXMJoi0byE6Rz3+G9ygijtDW4tlCL5XNAeuSX+B1HBuZhFTBoUW2opcCjsqxJHJWTYKx5NCo6pdH/erq2vHTtDP5L16mDbfzsBBndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407905; c=relaxed/simple;
	bh=rTKtriyNWvffiRqVIHWkpQOhccNRe75UQLh/YYwhxKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iD+9vKpZk6lk/Ev1yCMkataBnfQRjzgni+QHl9h+wMxAoijrupQPRwMNtTbN5Xw1nPVrJowraDcmvaAKrGgUlZO/LPbzVWlrnMNbsCMPi6mme3K98237+Vxahh4hyrFLDyf7xrPFFyMAQHNA5b6ryEi3PDEsZkoEgjh/JA2E+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjruMj4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6583FC4CED9;
	Tue, 12 Nov 2024 10:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407905;
	bh=rTKtriyNWvffiRqVIHWkpQOhccNRe75UQLh/YYwhxKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjruMj4GDJ7KqW8F0tfF7WBYBaCf4LrlFb8JyYB5g1ZgyzyfwmflkMLRn40BPd8Gn
	 YO1zNlpSnyS4ApCjc9C3g0JczexZesTr6sQb/16fgMk961uDad+3enEVp52DhA/HHq
	 MZpBRAwXURD73dJUQzmHz2qJWMDhG0w5qTFRgpRrfIF1dn7gepUVYt7TDG6Bp+vPEB
	 unHFFZNsikrkGoC1xKog9lm/Avxpzex/SUsx85+n7aMLC8CZ/eZ/Qj7tUIR1t+tuOC
	 hFEOuAOli3fItmDbZlDetNrrC9GJJnhUM8dJTKrH7QLN4ruiEAsDIX65LdF434A0uz
	 dE+jwMq8CeQXQ==
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
Subject: [PATCH AUTOSEL 5.4 4/5] ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()
Date: Tue, 12 Nov 2024 05:38:14 -0500
Message-ID: <20241112103817.1654333-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103817.1654333-1-sashal@kernel.org>
References: <20241112103817.1654333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.285
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
index b7dc9d3192597..e8cd58c0838ee 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -318,7 +318,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
 	int div;
 
 	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
-	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
+	if (div > SAI_XCR1_MCKDIV_MAX(version) || div <= 0) {
 		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
 		return -EINVAL;
 	}
-- 
2.43.0


