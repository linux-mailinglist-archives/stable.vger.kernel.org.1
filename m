Return-Path: <stable+bounces-67578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B8F95120A
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CA21C2088E
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17913D510;
	Wed, 14 Aug 2024 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMDLjCDu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2637113D2A4;
	Wed, 14 Aug 2024 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601711; cv=none; b=V3FoA96vm6jC+67wY4HEaWrx+oEefmQruhfDjqeP9qO1ByDsJ340PXxgP5DAyrSFBA0BJ8c4NKQ0cSW7yNlVSpMiE47haeAHsmY9v71URfxIYqXJlbnKCEgTk1oHbvjCLF7O4TavG5slE8h0sW/cq4upJ3RJFwNO7uXQjEEWPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601711; c=relaxed/simple;
	bh=dV4nVI6VK8mbnpS/RZlX5b1RbtVI7nxm+YELZUDB0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KS4ka245h4EolVEGwZ2aPfTfsL1/Oyc5GktpcIrN/n8xXVeZIZJlhLL7biYImSTApkHdPRr48NnmLHalTwSsBkbHjzFRAfUna1p7udMNbkWQjHWMf4A6wdkEdx5eLIP7z5z1QFEI9trXZ+yiHkrp5+JV7+PhaeG4JW2uTOKwu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMDLjCDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349E5C4AF09;
	Wed, 14 Aug 2024 02:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601710;
	bh=dV4nVI6VK8mbnpS/RZlX5b1RbtVI7nxm+YELZUDB0aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMDLjCDu4z44FfuRQ5uEWnAmOS+rfC4OD/oadNQzozdOi3o8Pl/bNj3cG/2MY9w7U
	 SL/7LkKSVbNVW5nP1v6Q0w9KMVUT+EBRO5TNLPxGZ+9m7d4cqZsjSbKvcnUKWS5La7
	 E8X/cGh2nqP0/ONsfcl7EOeiGs1X5Otf7zGOgSRjcsLnM8h5qPzsEqyOc87mftzvw6
	 kWr1oED02iiohzEUnlRvZNSveIvR7Ac1IinIzQE/g4t0yA+ZH+89lrZo57v2Svc457
	 jgw6133rgDRYlmkoEfxW4tDA0S85SazES+rqkUNb9UhzTUutU7U0FrNd2uVzLVYWAb
	 BmRVvzxKCH6+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Krzysztof=20St=C4=99pniak?= <kfs.szk@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 12/13] ASoC: amd: yc: Support mic on Lenovo Thinkpad E14 Gen 6
Date: Tue, 13 Aug 2024 22:14:43 -0400
Message-ID: <20240814021451.4129952-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Krzysztof Stępniak <kfs.szk@gmail.com>

[ Upstream commit 23a58b782f864951485d7a0018549729e007cb43 ]

Lenovo Thinkpad E14 Gen 6 (model type 21M3)
needs a quirk entry for internal mic to work.

Signed-off-by: Krzysztof Stępniak <kfs.szk@gmail.com>
Link: https://patch.msgid.link/20240807001219.1147-1-kfs.szk@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index fa0096f2de224..103eb93143d11 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -220,6 +220,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


