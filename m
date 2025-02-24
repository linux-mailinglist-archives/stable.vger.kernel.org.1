Return-Path: <stable+bounces-118849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A81FA41CDC
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760C3189C63F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37822690D1;
	Mon, 24 Feb 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roVJQXbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845672690CB;
	Mon, 24 Feb 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395967; cv=none; b=VNQCKvYHqPAqhHeAL14hh4Dtsb6tBMZM6O0zC/PzQwe9lcl+RF7Vqb3pFa94ChAbK4O4L+2opeaYvI5ZMmD3a0lXEKDaOGRSxfsuu/OCSh/rixSco8nsR4wbEqf04A3DhLavPnICOvg1f7pP1idVMJlOAkXmHm34SURFx8YVEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395967; c=relaxed/simple;
	bh=KachhjvHlgdI7EuxbAmmXbMUXUXDWbyNsfZe0FVzCqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jfbh4tJXJbTSAfL6hWaq54yy0foz4fY8TtMiO04tgp9RGEBZezQ1f3tU/uxqxM2bMHj2Mrj9tXFjzxF0PHiuLafCRXFHlsF3/WaS0QL7UTeDwd98tkUoBRuyCime5iowzKgPm5/I1uPvUy6OnXA9JbD6mgUfJgwDV/AN8UdDYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roVJQXbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336B2C4CED6;
	Mon, 24 Feb 2025 11:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395967;
	bh=KachhjvHlgdI7EuxbAmmXbMUXUXDWbyNsfZe0FVzCqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=roVJQXbJJiEwEFVML1nxUFzQP8eh9o2LUxtgnWxUNBHxqvZm6wX7SYsLELtBjs94r
	 KPto30aEk6NyKhySOpC0mZx7SrQGPyWW28CT6F15Dx7p6xG3Hs5vU2XDPBrbtukGD9
	 3efghLiLfvnW/e2aWFS83ChPboZw0/oCAjkXC6wjdsL1Insj5YZm11x6wSYDeDaHKQ
	 YOjp/3b2onHdlGbd8BYsOvD4Av88zVjXgkl6ESAbsLidg491krcGz4hA63B8iGFmWd
	 1dadktaLD5QDnSb15h+51b8OzWLL96npvKce15tkJ3ZIelo2tftTIwlrDZFtsu3ieb
	 USk2Ya5PA/ZaQ==
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
Subject: [PATCH AUTOSEL 6.6 05/20] ASoC: rsnd: indicate unsupported clock rate
Date: Mon, 24 Feb 2025 06:18:58 -0500
Message-Id: <20250224111914.2214326-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
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
index 690ac0d6ef41a..2a9e8d20c23c3 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -334,7 +334,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	return 0;
 
 rate_err:
-	dev_err(dev, "unsupported clock rate\n");
+	dev_err(dev, "unsupported clock rate (%d)\n", rate);
+
 	return ret;
 }
 
-- 
2.39.5


