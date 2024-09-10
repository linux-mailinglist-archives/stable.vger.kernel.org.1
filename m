Return-Path: <stable+bounces-75720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B875B974010
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3322BB21178
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE321C2325;
	Tue, 10 Sep 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+zXnr9b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A11A4E6B;
	Tue, 10 Sep 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989060; cv=none; b=avDJQfoeyZgc5t9vZvh4Ae0QorMX4KIDJPwvoB+8sZH/8SlG3LFKJUI72m7yohiW/RvmysuOc9p8Iitq5Ia2bVmejYMCdM1dag+Z5YAT/HD7D3CdweaRolLQvwXvMFlGHkBLbs+CS3FY9AoVEczJ8QqOTwvG1g61RnCkqICVknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989060; c=relaxed/simple;
	bh=PqFBaznGbhrHLs/Xfet0aM+FPZAcx3a83FzTUg1qIZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neiVRXywp7EqkiAPrfnwXfy79q1FKBmTiw4HTCLtXNfCsZVrgqi1H8oXrGYEFMfdxcNzWSh8UKg9AJ8IHgxNgZlq+Xk01hmIVvdkRXvM7sBUeACcKrIHI0V0WZJf4WFuu/4XAlilTpxBqzp1wTEF/dajzMD0DTZ45cuMWx5wJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+zXnr9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79647C4CEC3;
	Tue, 10 Sep 2024 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989060;
	bh=PqFBaznGbhrHLs/Xfet0aM+FPZAcx3a83FzTUg1qIZE=;
	h=From:To:Cc:Subject:Date:From;
	b=N+zXnr9bqF1iRRODAjEuVVJqfArJ7sixn30s2Wlvd0H1Az8sNgRNxVfeqwq9KSgwW
	 Lwesal22xMF9zlw45d7/O7jiT0iR7qWra3v22t0A8Dzgmur/40ARzBDpQmKlI5erMb
	 DwblYnjmeNzJQ7qAUTcRCQtdR3Y3xwGwVFnxPhjyHyNcwnRtgJjlNBCu9dnPuQQ6Pb
	 D9cBQu1w3BK3HwwKfm7pQylbjSfg002bHD885Q5HnLgctfm1vntzaw+VnIfAt9rB85
	 7OmaFMaT19OdLpEBJ2ZxrbMNBqnUtIIAM0rMT+WAz7uoDgpncZxuzUPNAlk+o0MuvN
	 g8SoMBrFPFDVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/3] ASoC: tda7419: fix module autoloading
Date: Tue, 10 Sep 2024 13:24:13 -0400
Message-ID: <20240910172418.2416688-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.283
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 934b44589da9aa300201a00fe139c5c54f421563 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-4-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tda7419.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tda7419.c b/sound/soc/codecs/tda7419.c
index 2bf4f5e8af27..9d8753b28e36 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -629,6 +629,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
-- 
2.43.0


