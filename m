Return-Path: <stable+bounces-118824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F9A41CB5
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BF53AEC2C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962102661AF;
	Mon, 24 Feb 2025 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEgr/Yzu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6882661A5;
	Mon, 24 Feb 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395903; cv=none; b=g56GJPOyzRbk6BzLS8q/eAzR+CloojOorK/6nAhjIJonvmRl+ucz+WoaOmWVVP405aD1mfbznXtKzxQ1f5xUmzoeieYTfJ/h1cvyug20efXKOQ3zW5j1gJjbNOcLaGKMnT+7N55kzP4xXXJ/rKKY+i3NFQzdu+vFQZ2+/xLUzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395903; c=relaxed/simple;
	bh=5DTC/Ss3+H1mJNDLG0BLcyGDdFXUllPNf4h4Eve0s1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ePZle+3rXyX+F2XX0CrDDYOtBoeTVIA2AHMVi49PbuHLrnLteKxji2ZWpKXzktRxP+cl2ozYaInK59FH6DCqYs5PMEQEJWxC1sya7dHrRee2c5wAMFqP9hao0ta0eRkjGm2p6oT799IhUFSkA6pQCWrYbnL7Y0d1U222xt7J2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEgr/Yzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E88C4CED6;
	Mon, 24 Feb 2025 11:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395902;
	bh=5DTC/Ss3+H1mJNDLG0BLcyGDdFXUllPNf4h4Eve0s1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEgr/YzuhVGCEaZCSBCgNf5SD8brNyd9MZlyGl5M8PIDwfM68eHbev8TLWbOZgqhd
	 Q+eQki0iXg3xT+QpJxD07aa0sWEHTgDUSRxGoSS+UNjFAYbb9Esbb17NmrkebInEFg
	 n1mMpC+K4/hjJ6OH3bX1taE52DMqfTs566NMVUknE2YZJpi8n0Ytdu8mjV/6+FWWC9
	 Bzma33sZ39oEyuExAg74Ny6+PRWLEi7IadhEN3QeSvPzjZpQGgqy35rP2luT3ERTCR
	 iyK7Fmx2pSCdSANLv01PlTD22QcMcjfqIGfOldAYWMOeY8CcX3AEnzPKMC4VE4q16J
	 losdiuqgc4Xew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 08/28] ASoC: rsnd: indicate unsupported clock rate
Date: Mon, 24 Feb 2025 06:17:39 -0500
Message-Id: <20250224111759.2213772-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 796106e29e5df6cd4b4e2b51262a8a19e9fa0625 ]

It will indicate "unsupported clock rate" when setup clock failed.
But it is unclear what kind of rate was failed. Indicate it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://patch.msgid.link/874j192qej.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index b3d4e8ae07eff..0c6424a1fcac0 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -336,7 +336,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	return 0;
 
 rate_err:
-	dev_err(dev, "unsupported clock rate\n");
+	dev_err(dev, "unsupported clock rate (%d)\n", rate);
+
 	return ret;
 }
 
-- 
2.39.5


