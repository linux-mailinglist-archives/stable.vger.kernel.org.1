Return-Path: <stable+bounces-27391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B91878824
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 19:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA612B23FF5
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 18:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774365BA1;
	Mon, 11 Mar 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NchFS/VF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554395A4E1;
	Mon, 11 Mar 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182412; cv=none; b=hZH4PSxY6b5eRxkWO/QKfXdFTYZQbdaV2KLH7vZYklKzi8dyF9T1TjFE+z9jKDsUpSF0B89TN6cA5jjgINtpFnIDjp8t9wK0qyCoMa3ozoAPOBahQiJtAgkd472EcAQJCEci9hj2uUV5JJxETgqeXkn177fh3F7Slhyd7IONUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182412; c=relaxed/simple;
	bh=mmN/SZR6PmFIvbIsDtMtfVjVtr8+wCKe8berH2El920=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShTNwgMVxjW3j1f4IYceXj3xNmImIsVzCdIz14TCCoNb4ykR1J77UFeHDe0vjHa+qaQccSbALydwYZPlrCTwdApSrMwYdyZ8KDYI+RmwfdacjA9VtFL2WmfTdeJKgV0gAKywpyeZyi8FwQGhBKqYADIlPqkMs7XPx+VFMvETMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NchFS/VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C48C43390;
	Mon, 11 Mar 2024 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182410;
	bh=mmN/SZR6PmFIvbIsDtMtfVjVtr8+wCKe8berH2El920=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NchFS/VFTIs0bFSuWFV75HS5qScCu5rmrXZfTIRJbnA8jsAk7azxwb4b3uQKUlHNw
	 PEOsaSCzivsuy50t7p0dxpeaNygB8emsmtR/xg+MIhWCOBK+If+9Oa5lUq8iZpuvjM
	 y3zXK+Y9MtOdO8TH3KcwyA+Arlqx65DC5vgwfpT24kIfZ+TWxew0zgfZn8PGXIkeKB
	 7KRfnDQXyEMv7M7/YFwbV3Fs9cU0S9RKZHsyrpRftrGGX/xv8uL+7sLIn0cM7Gt5Ga
	 UyojBjlQ0vl+8zRnT17mW6ugCCVquZX5ZWhyiAdzZU1zs4wMJ2vqXsOtO7AB0Ph0U7
	 OkwqMKBFk7VEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 5/5] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:39:49 -0400
Message-ID: <20240311183950.329120-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183950.329120-1-sashal@kernel.org>
References: <20240311183950.329120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.271
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 9ccec511352a0..15828ae62f9de 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2908,7 +2908,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


