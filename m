Return-Path: <stable+bounces-80316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6598DD03
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02BDDB272BA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112941D0BAA;
	Wed,  2 Oct 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HCLYYDYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B6B1CF5FB;
	Wed,  2 Oct 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880017; cv=none; b=NgDvTvAp+GNdKne0MIa16C+Cr/Y8uQlICZe5uWx3+rupMF+tB90X3r8YSRqjXfG9/SPUQJdSC1qff8jZ3AT9QiZbdaS5W9yerqeAAd2Rrg2lbfbyooiCxMGZdDEzA2HWYwlTZgw4TfcJ7SLyuMVgC9DobDdtLMcdFNTA2AhzDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880017; c=relaxed/simple;
	bh=xF88x8Ue5+gN/rQM4THMa+ZfOy5Dr3sa5fWufRbsFmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWzzbErjwmGjARqJQxPL3FucoQUuEyROAZRuurszMAAa7hnE5tsHYm1pPU7tZpnkFdgMDEpd56hH47XDtUICdiJRkZps4ZgVTmc75/1PH3YTRK3ltaLj7i+hs3Tf4S+Fxi0OYEJoJJKCAsw4HB4w6kWF0IYZjzPRsIMGkyDGYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCLYYDYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445E8C4CEC2;
	Wed,  2 Oct 2024 14:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880017;
	bh=xF88x8Ue5+gN/rQM4THMa+ZfOy5Dr3sa5fWufRbsFmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCLYYDYyGzuXKWgixox+MC+I3Z8tN8uAV4aAJ+haj2HJiG89DB9ZJ649YZV/uQD72
	 KKtMhn4/B88WUMQWFPcjcmXiFb+euX526Git5+yC3S1moao0TyfwQNQNbXl3PTAoe3
	 eZquxfZvbLJmgFbE9gXXrA/eM/vQsqNjoaSIULSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Boyd <sboyd@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 298/538] clk: at91: sama7g5: Allocate only the needed amount of memory for PLLs
Date: Wed,  2 Oct 2024 14:58:57 +0200
Message-ID: <20241002125804.177560474@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

[ Upstream commit 2d6e9ee7cb3e79b1713783c633b13af9aeffc90c ]

The maximum number of PLL components on SAMA7G5 is 3 (one fractional
part and 2 dividers). Allocate the needed amount of memory for
sama7g5_plls 2d array. Previous code used to allocate 7 array entries for
each PLL. While at it, replace 3 with PLL_COMPID_MAX in the loop which
parses the sama7g5_plls 2d array.

Fixes: cb783bbbcf54 ("clk: at91: sama7g5: add clock support for sama7g5")
Acked-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20240714141315.19480-1-claudiu.beznea@tuxon.dev
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/at91/sama7g5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 91b5c6f148196..4e9594714b142 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -66,6 +66,7 @@ enum pll_component_id {
 	PLL_COMPID_FRAC,
 	PLL_COMPID_DIV0,
 	PLL_COMPID_DIV1,
+	PLL_COMPID_MAX,
 };
 
 /*
@@ -165,7 +166,7 @@ static struct sama7g5_pll {
 	u8 t;
 	u8 eid;
 	u8 safe_div;
-} sama7g5_plls[][PLL_ID_MAX] = {
+} sama7g5_plls[][PLL_COMPID_MAX] = {
 	[PLL_ID_CPU] = {
 		[PLL_COMPID_FRAC] = {
 			.n = "cpupll_fracck",
@@ -1038,7 +1039,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	sama7g5_pmc->chws[PMC_MAIN] = hw;
 
 	for (i = 0; i < PLL_ID_MAX; i++) {
-		for (j = 0; j < 3; j++) {
+		for (j = 0; j < PLL_COMPID_MAX; j++) {
 			struct clk_hw *parent_hw;
 
 			if (!sama7g5_plls[i][j].n)
-- 
2.43.0




