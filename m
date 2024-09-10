Return-Path: <stable+bounces-75678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC611973F59
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD571F27B5D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26CD1ABEBF;
	Tue, 10 Sep 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huSbjmIN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78B1ABEB9;
	Tue, 10 Sep 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988950; cv=none; b=kkVT0UN2XJd7vDElheCXMHEmHH84KOzLHBx0rVCsm6jRrZ3QUDF0q+Ba7YRebC+ONUGCXcrf6BCZpDA/iu2lfKbzEKq3+/NAb25s0MJcueSGnoczBWX6O4vNq4hH+lI3xeYjfzBYeP0UZcGcWHDsbb04VEkUzILqoQGHF7WQmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988950; c=relaxed/simple;
	bh=uYBdcRw4CO1Pi4+MfOOTNASrYWjrAVCeFTYpqsLoRj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwNhWAtilmraS74fe5Sc6FuXEtII+RSA8m+alZ0/jdJqVbCp0XwyQYJrRV0IQG4B6BBMx+AI6Fe+rRvGFqKSsxaLN8jFZ8uLNYP6/r5pdcL7ThUY7KPzTkO4YvrtP2LGL0RqqfUwnC52Lrfe6mW/AKodysue2ZlvdFOdqvGIwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huSbjmIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45E6C4CECE;
	Tue, 10 Sep 2024 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988950;
	bh=uYBdcRw4CO1Pi4+MfOOTNASrYWjrAVCeFTYpqsLoRj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huSbjmINf8kqqQnPMt6XQXHDbMEf1afFJnr3PVC0bQTHMf5YcNQPxcJlV9TvQsSUj
	 gjcgYEVK8DQevU9DqRcIExcCI7CajNfP0y4xCVXzkmDZ7o9T7daS9RkIDwOayZqbUe
	 4jULoufjj67JlLsCB/fkqSzJmO8tr4xX9CvtrnkYJnK/4iw7XMPJTRhQQDjrXMxaOC
	 TfBW+zPSApH6nQRBa1EwWM7wuBfUyggxlnI3YINKRH+5kJAOSnxc4ppvPtjAtVOOT0
	 jF2A6y0549uKcTNoBQaSzT2wYUL+KOkCQc/9Ri4AMgQAzoB4nz7Y4/boH71gkuW6Rj
	 GmrmfkBx78MqA==
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
Subject: [PATCH AUTOSEL 6.10 06/18] ASoC: tda7419: fix module autoloading
Date: Tue, 10 Sep 2024 13:21:51 -0400
Message-ID: <20240910172214.2415568-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172214.2415568-1-sashal@kernel.org>
References: <20240910172214.2415568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
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
index 386b99c8023b..7d6fcba9986e 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -623,6 +623,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
-- 
2.43.0


