Return-Path: <stable+bounces-75723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB7D97401F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FCB1F264B7
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5BE1C2423;
	Tue, 10 Sep 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfQxpU0z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A111A7040;
	Tue, 10 Sep 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989069; cv=none; b=J7FoMi7zwLn0XkDwuBcyvhLCLOY+7RxVBe8dTDKIXyavsM0EUPO3bO5/IO5hHRGgoRyVXxQHCF7yc0cp10wN0miVAjAw/lLQxQFom4Q9o338YKbxmGLAwKk+sAyS25YCqDIErWEQ5G+Xkz1PrM3xXUX3oe6MHFWbiy4FpDH3wPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989069; c=relaxed/simple;
	bh=iX30pa45alC5+UYKYp9bjirk3ti7X+bAF6YqZywQnu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdF7LHoPsAlUsDEHHNrN4ac1pZIhnPLsWJMTAcUn+PrDFLIww9ybx1dzaE55pITSW0RzdcyIhqgj6CN9eD8W5MNopiaBDZBqZBfWhH5F249h2bb92dNITHwr7GZTzpzIO7R/qcbDSTVvGJZhZU5tIP/kghKc4PVj6o7rSfaOO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfQxpU0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F26C4CEC4;
	Tue, 10 Sep 2024 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989068;
	bh=iX30pa45alC5+UYKYp9bjirk3ti7X+bAF6YqZywQnu4=;
	h=From:To:Cc:Subject:Date:From;
	b=qfQxpU0znc3RutqahbkMkCnx5z2J5EhGk5eDTjUpyVJQ08sWBkqUokgkrJWcDLq5W
	 VmU0oHfCciW8ju/sGDL9O5dUtyavHb1rCeQzWEeOpM0jtmJ1eYjZ5YiCcst1wbSLP6
	 FrcYjRF4cg08dBtrdLwsIBPDBwoqOuItOnhWuO+qfaynGJKebiMqaVN3Lo6Y3DFwJc
	 asQEMq/gNed700PyoY5AND9NoJ4xi/a0DIeB+e4D8uVYLeHGfFI1NuM6tVymzeSaD6
	 +gKekSQam1o8L/ExdQSkYl85smkziXbsTBwVQKRbw6YwGbMo16ZR2zBy+D0+4uDBfx
	 nW8h5l4jMQJcA==
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
Subject: [PATCH AUTOSEL 4.19 1/2] ASoC: tda7419: fix module autoloading
Date: Tue, 10 Sep 2024 13:24:23 -0400
Message-ID: <20240910172426.2416764-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.321
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
index 7f3b79c5a563..a3fc9b7fefd8 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -637,6 +637,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
-- 
2.43.0


