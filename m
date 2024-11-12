Return-Path: <stable+bounces-92573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B829C552F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714221F236EC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4280220C58;
	Tue, 12 Nov 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU+52KJQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AC220C4D;
	Tue, 12 Nov 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407903; cv=none; b=g5UZKgpWrWJA4hs4SWjGzuVvcUn3wykAGVSVMgnM86C2nf9L88oHTmMPZ1s1nncdAlsHCJZLCSZle69K+3/zYz/BVH22rw7M34kaNFfsCOJUMwb/Y97dscYplQISUXiWb5cjnLdN9ceesX3SWSX0kGTykZE1MtrMuWnE+dP0qHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407903; c=relaxed/simple;
	bh=UTB7rna8C2SmXb+CbI0L9/7fDGZHifqbzEw4rtLnFu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT29J1c4Ar2VzVTrsAuGLYi+7wQIpXBZWPJbVRw3Xj3UQLZAKUF+wdr6X6mPfDuoFKlXZiZMIe8cOnLXzf8k7zwWdqtWapu68lPPqrSoi9SVQgH6Bqhbr6vEr6zQpWDaOPWbPj0VYU8EfpH/eZo/PnL+WBp09jHeCtPeeNBU7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU+52KJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4428EC4CED7;
	Tue, 12 Nov 2024 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407903;
	bh=UTB7rna8C2SmXb+CbI0L9/7fDGZHifqbzEw4rtLnFu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZU+52KJQQgkrYNI5B61TS9q6rdaiMEtzK6rre/DUOajJoqzkdzViES6v+9ZAFoG9x
	 OJUWBnLO+0V3xsxLjmTeSJ3fsFarvyOVzUc7jBsdgNTAz0fuoDn0p4cfZ5YlysB4R3
	 Nxx/Xmu85BQuEO/pKp0zwDw6IHXisWdm26KAP53O37/7zm0eRmWdBQCnYoAQUEhdI4
	 KH5reP0zX7ftooBREJJzyQ9mEWbTB3AZLqEBU6JSiGfqlh1bhmQQDYKNnogEhOs8Ed
	 WLpaZ9M0t552MBi7sTMIfjxIWlOd5epNP6hRZyQ66Da0BSYZgQL0NkJxnZ0xdoewwd
	 RRJD1CuqqCH5Q==
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
Subject: [PATCH AUTOSEL 5.4 3/5] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
Date: Tue, 12 Nov 2024 05:38:13 -0500
Message-ID: <20241112103817.1654333-3-sashal@kernel.org>
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
index 7e965848796c3..b7dc9d3192597 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -379,8 +379,8 @@ static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 
 	div = stm32_sai_get_clk_div(sai, *prate, rate);
-	if (div < 0)
-		return div;
+	if (div <= 0)
+		return -EINVAL;
 
 	mclk->freq = *prate / div;
 
-- 
2.43.0


