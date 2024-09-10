Return-Path: <stable+bounces-75717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A70974009
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C21F274E2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143F1C1AB8;
	Tue, 10 Sep 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHbPKnax"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD631C1AAF;
	Tue, 10 Sep 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989052; cv=none; b=UTShjHO1cfSz/g1JWijqdcVf1AlHJ9yzbQGzfrMkSykbL8vNn1ouFzdryVR5aG3+q2xwvFrl6kzWrKvfdtxu2lx1DYtD3NVbOcIF6VRi+bVuvBndeFwu6sRyYq53Wch1UTHVeMiIvUKFt3s1fRUow6igXXqbY1zeiOGzWgld4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989052; c=relaxed/simple;
	bh=Y2UwvIsxxOjnL4whgu8DXvh9aZlBKxW4VG6uLLbXMKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ozhwb4BKtWRvzlx+iRPSjri4SHoLPD1DCSqV3+osib3/DGOCKPAChX5Qi9RForSY6BWnac8VOrfIGFmzdTevZAp2kGerKyGEH6AV3sgAtZ9tJdsstifG5lj1cSX9pH9ki+U+GV6KrJlwUlncJnjufAXXEaZdU3FBzlNB0AgQNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHbPKnax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F109C4CEC4;
	Tue, 10 Sep 2024 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989052;
	bh=Y2UwvIsxxOjnL4whgu8DXvh9aZlBKxW4VG6uLLbXMKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHbPKnaxgMdu/gitwLxdRknDC8gLYZGBTNiOVqEmm/wEuk+jFB9wiLwS0LgBkEYVq
	 +Fh8+3MzW9NhY8FvazBsigpQy4vPOk26ynw3lx8w9LnErwLsUsWhCg6l15w6DKbZ/a
	 ZH36jKh/RR9n3sQUrHsdEcN/g6+DWHUYycNVq3RWYC+jQL8HDqjTc7Jjk53D0+9YS1
	 7iqorc+PGutSKY0LyIoQQEupmJSnkRb5AjXK2ze5atPzzyJTl4sVGFDzYSMZgiPeip
	 YdGdtwGh63m0hXu063Hmlpn/2J1HrsT0lj11StydNsA/VoTykv00PBWKr2wH3TcY40
	 4kTsuAcPKlTwQ==
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
Subject: [PATCH AUTOSEL 5.10 2/4] ASoC: tda7419: fix module autoloading
Date: Tue, 10 Sep 2024 13:24:01 -0400
Message-ID: <20240910172406.2416588-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172406.2416588-1-sashal@kernel.org>
References: <20240910172406.2416588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.225
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
index 83d220054c96..9183db51547d 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -624,6 +624,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
-- 
2.43.0


