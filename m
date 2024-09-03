Return-Path: <stable+bounces-72879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED4796A8DF
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57641F25630
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760021DB549;
	Tue,  3 Sep 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfIX1OWL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8C1DB545;
	Tue,  3 Sep 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396229; cv=none; b=CP3LvuLy5rUCPpjPHdAnOjuxt3GIOKfrd56QCFgXJQNQfuOMPXIS0AXiTiJxL1Vn8iOpW3fD1s96twRvojCTctFcs12DzeTrY5mjiZzO8HYjqRqYk0rdTNzc97ezvaCUlsI01iiUtW7PLpUz9pvkiaZH3VfuxXQhfz0vILO+M0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396229; c=relaxed/simple;
	bh=rpVy/2S6tHa5HdrpNzi7blBYTbk7EjxeGZ4cHcB9QDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtbyabVAQN4Zl5cceNF4Kd6PLoSSnwUbDzACSu06Lpa2Uly03N/aDK/GZM91vYxqrjcdCkcgCber+9WQyyd6Olau92fePvUojrXMzjXr95oRP837uNBwqjBYNhkLuzOoKb4m7pXOj/T8YAnUQCvSWYZ/dh32n7DaOnupMEfX4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfIX1OWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF7CC4CEC4;
	Tue,  3 Sep 2024 20:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396229;
	bh=rpVy/2S6tHa5HdrpNzi7blBYTbk7EjxeGZ4cHcB9QDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfIX1OWLEZDqo84fRSnu97XlLFCsVcvLs+voTOBBx13UQLbj58630lEKb6AmcJpSf
	 L9zbsoYLcA+bubS568Roegk6v5ZzXbik1F+VcO9Y19C+dy6aVChYL2OFHfXvvN8Vg7
	 JKzTGcjJEM67gIEOOfoIdflbAj3wWpw+IYIqZw261vNkg6/Up2hvNJjcCP1LFRA/W7
	 lxNU3LCnWWoOJyZKEF7ZKwPvApiBzCCQEus2dwGaF7G7aJN1TLq1W/5lOJJMMVZ5aH
	 A4eg8CQsCyHUiW4ryrFnm11hwIS8gBkcJT+GxnP3ZgzkJpn7qSrIEnCCN47Ki5Eze8
	 aaQvwrtwSNcSg==
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
Subject: [PATCH AUTOSEL 6.6 03/20] ASoC: allow module autoloading for table db1200_pids
Date: Tue,  3 Sep 2024 15:23:35 -0400
Message-ID: <20240903192425.1107562-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
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


