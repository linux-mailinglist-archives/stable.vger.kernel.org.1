Return-Path: <stable+bounces-72898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D096A915
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77961F25800
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04011DB55F;
	Tue,  3 Sep 2024 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3Eff+co"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DBD1DB929;
	Tue,  3 Sep 2024 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396320; cv=none; b=o4+d+vIDdbmi+6v0VIV9EWnF5c14S09RoqsVvlJBvFEkEcZMmtaOXG3G/By9MIP5KFiQzS12eJFbsS8O7CYEqZltJWXm0MIM13pKLlyTmmcx8JFKwqntifSppJ53ybCR35j4TAxFwSmWBxJofIWQhv/Vp+8anHW9/Apa1fnj5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396320; c=relaxed/simple;
	bh=rpVy/2S6tHa5HdrpNzi7blBYTbk7EjxeGZ4cHcB9QDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnvTfTCkBYSDswVnyhjkE/pia0MJeKXIiJCWUma0vdR/ntX/qdXHN2eq2Es1CTU/bXgUlCol7MdBcFUtH3IVDXu39bngjWdeUsnRCVXD13fG7eNNbqCpzbeR1g6emHfB+q9vRgnktUjz3HHm6JCrnuQG4bF/+5teSA9ofO8G8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3Eff+co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F0EC4CEC5;
	Tue,  3 Sep 2024 20:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396320;
	bh=rpVy/2S6tHa5HdrpNzi7blBYTbk7EjxeGZ4cHcB9QDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3Eff+co32ItUkvV1VUmF8saQlP3AekKPyGh8uDGrXJFvmNi6Pd6M1ibJzLokfl/C
	 WL6BXY/T3CNJN31Lr9eM5nfG6VjUf7au8V1Jlo/4umk56+XZsaSrGbMtpxscb11V3O
	 5AyxjznePyDltDyS9ZYqZ0gPZed/YY1OZ8mIKRcou/anHS2qs+LmlOmmzBACZM/NyV
	 1B6HWQJ9dhJQHCphOyt/vlux0sovDIci/EBiP6ufZzwOKjikm/0HJ7e4koIDz46oqU
	 zkDnc107Ny98A/xPAnTvfxxCVg2yQ9LFuIrlQWhxg5EOPSM+g7sKm3Cimai18dbRGX
	 ctm4a7J0iIaxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/17] ASoC: allow module autoloading for table db1200_pids
Date: Tue,  3 Sep 2024 15:25:16 -0400
Message-ID: <20240903192600.1108046-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 0e9fdab1e8df490354562187cdbb8dec643eae2c ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-2-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/au1x/db1200.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 400eaf9f8b140..f185711180cb4 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -44,6 +44,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
-- 
2.43.0


