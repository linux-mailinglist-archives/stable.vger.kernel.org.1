Return-Path: <stable+bounces-92566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C69C551C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E327428B913
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9BA1FB752;
	Tue, 12 Nov 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFKvp9cE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7A1FB748;
	Tue, 12 Nov 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407893; cv=none; b=c8WiJyDJXLNilRgQK+/HLuD3Y1PLy+V4kMA7Pij/mLd+Of5B/0jtGDzLlh6WO9+oqrRLg/6oJVJsRo1W8hMh9/2a+ZKr9nctxrW5DVXhqAUgAKCTfKRo2v2YjbyvdNI0pREPyLHiSOH6u6E5HyKhrzwgexHN02n6THfzssjgQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407893; c=relaxed/simple;
	bh=gQlW2cwXESWjdYBxHe3WgqAb0ars9D3QYrkWX2iMrJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFUmHpvlIGbAeco7BcWhaXygbauhq9fFcwFBzVg3dbTHbQ9OYFfMKBxXbxj9IxDSTHDB3cHknEUxHMRpFM0B9LTHlaDIi8NfYpa5XXP64D1SZfstfrKQUW9w4UZsoa8Jbjd6uTAFUwvpYyKayuFDVOxW7XCAGr5EHIb4y+UgdXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFKvp9cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C85C4CECD;
	Tue, 12 Nov 2024 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407893;
	bh=gQlW2cwXESWjdYBxHe3WgqAb0ars9D3QYrkWX2iMrJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFKvp9cEMeavg+1yXZ6Yx4xRdS48tciq7FIX1ikoTWlNkwf1h5WoLNDxko2RFzWle
	 ULFfnyQVpmO7wz1qsUjZF2cWbOH9z5Q6RE5yugwRqe4Ba7gqgXMOhIxmQq9XinPj/N
	 YQ6NK94bsG3gGTX9BEnMbGbYQ8nyD3M3zPbg/XEVrHnaMZ+MUajbnBx6iuiQo7VLd7
	 a9H7zBPDjnKchDCevm6dex1uA9vJTrXaVjebXxswE4unjxwwickU3e7ClF5NbJcKtg
	 5OIpWhfnl1s8km5Lvgi3kRs2B4D9AHUN36qXSSZdbkd8F7dVkNfHqcaJE0AwFUSMlC
	 fimODpkiics4g==
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
Subject: [PATCH AUTOSEL 5.10 5/6] ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()
Date: Tue, 12 Nov 2024 05:38:00 -0500
Message-ID: <20241112103803.1654174-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103803.1654174-1-sashal@kernel.org>
References: <20241112103803.1654174-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.229
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
index 3a7f0102b4c5c..90e4757f76b0f 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -319,7 +319,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
 	int div;
 
 	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
-	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
+	if (div > SAI_XCR1_MCKDIV_MAX(version) || div <= 0) {
 		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
 		return -EINVAL;
 	}
-- 
2.43.0


