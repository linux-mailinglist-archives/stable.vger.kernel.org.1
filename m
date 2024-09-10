Return-Path: <stable+bounces-75712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2DA973FFE
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F2FB28B20
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5911C0DD1;
	Tue, 10 Sep 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Dp5VTB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B61A4ADC;
	Tue, 10 Sep 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989039; cv=none; b=dmIbXzLX23i93ITfTrjaJb9jIvockxKK1fMMUGFyOtiLe7oq5HRc8S/Uc/KLOS5UrHCAZoBr3evXxlcY5N2gnvnTOIAwlJmz6ZCSJyO3cvhV5Ohea4cFiFSNN7waRMOy0Safg27+aHVDw3RU71qtRpaweB0OdpsbKiCRB3cufFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989039; c=relaxed/simple;
	bh=Y2UwvIsxxOjnL4whgu8DXvh9aZlBKxW4VG6uLLbXMKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDiDQVnw4BA5itDkPrqncpx6irkbfEAqTaoZMAk1AfhWex7zwtd5mdPvwFQ1IlPI4pUGfbfYMr+S0zgef9GI7f40JfMc13yHVbQxNkR5XUGWBcQ+Icm16otlG9SDB+XWrbVckymvP5yyacZswX+7uFOLNeyAcsKtBZ6tgtdIaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Dp5VTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC7FC4CECD;
	Tue, 10 Sep 2024 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989038;
	bh=Y2UwvIsxxOjnL4whgu8DXvh9aZlBKxW4VG6uLLbXMKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+Dp5VTBV2vkIpLmFw3OcH+wmKP+HfWjiI2bd/huGrWVzlWVqRhSsJ7Ty9mXfvlTQ
	 U3+sNt+qkd3gr9zTq1k05jYP5IDcHsQXkQG9YzydjJcDvAfRbl0ISa7hMR/vJ0PTJn
	 vLbSyACTPN3QzMUjYSGytYwGDzMe8IJW7pPbNiBNol4SODG9v1IKaw8zQw8r2C00MO
	 PEpUySsMvECYLaWrT2RLX4i3UCaSBudl5EQoKUSn/TjrclOkJf+i3nOH4tIRq4w5Kf
	 98m3AEHCqnrwhGvZKaqqQPd1qtNqBB1pxMOWjrEvAAr2f/JGrpsZHtRfV2rBooMAwy
	 0yxe+aaEhFKrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	u.kleine-koenig@pengutronix.de,
	andy.shevchenko@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/5] ASoC: tda7419: fix module autoloading
Date: Tue, 10 Sep 2024 13:23:46 -0400
Message-ID: <20240910172352.2416462-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172352.2416462-1-sashal@kernel.org>
References: <20240910172352.2416462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.166
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


