Return-Path: <stable+bounces-100787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602219ED604
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643572811DF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908512583B5;
	Wed, 11 Dec 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYiEtAzt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED172583AF;
	Wed, 11 Dec 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943288; cv=none; b=DGoa6kEjivEeGGoq/2kDz2/6mawcVszSwttaxMZU8Z/sLA3zPoMKdkOGap0b5NEL8joaC5ouCXecTedtTBTDN4fcJyzpEJdVyUPDaTgL0Yy09SVwVjkXVJqzpvpzSF9pE6QQI3oWPlmqR3LX+3abrlNsreMvY7xFsu/mkcznTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943288; c=relaxed/simple;
	bh=P2isL+1jBnElSRl0reBQcqxPGJ/PaYfIRGS5B/m6fyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uubkSU+MDZ7XdjMYifapF8BE3/zj/Ql3sOsFc8Nx96fY2I9fKbGZdMgEm2Qs/TAE3B5CChtUB8ZdD1W+5js0cCNsaUksCG7u/IodB8bFe3gP6eJlB15c7qKWievoXm+uwo3hX0eSBGKop3tjzin4AD8OITe/jLLDXt4+7swBRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYiEtAzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211EAC4CEDE;
	Wed, 11 Dec 2024 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943287;
	bh=P2isL+1jBnElSRl0reBQcqxPGJ/PaYfIRGS5B/m6fyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYiEtAzt0Q7tUPV3iRVb261EzhgtoOSaPnZfWeWfelFECoK1PZ84pdnWjC5b4zmNS
	 EzVxXGk7NW5Hr8CL9cp6hpv43ZueBqDrBpNa7H5mRkXyCHKAOcxf5tn2wOvk/OosEr
	 1ixizjy2DeShxHdY+nF99AoEK5RjBXAdDbta623f7j31mNi0TTtc6k33+N8wH3Redx
	 6j9trG/y9x2KFh4nQ639/t6cIPPibnfrXXDDZz/bqzWYtmBeCvC8icz8UwSzzO5UEv
	 /HjfnxFGHRfCn4ZjzGQJoCMJWA9mW6S+ZKtpopqrhgsA0fKfo2gA3JOoqvAgyEljRI
	 RgFdqD+v7gvlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 5.4 3/7] regmap: Use correct format specifier for logging range errors
Date: Wed, 11 Dec 2024 13:54:36 -0500
Message-ID: <20241211185442.3843374-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185442.3843374-1-sashal@kernel.org>
References: <20241211185442.3843374-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 3f1aa0c533d9dd8a835caf9a6824449c463ee7e2 ]

The register addresses are unsigned ints so we should use %u not %d to
log them.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20241127-regmap-test-high-addr-v1-1-74a48a9e0dc5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index aa9c6e0ff878d..e06bd7e64075f 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1064,13 +1064,13 @@ struct regmap *__regmap_init(struct device *dev,
 
 		/* Sanity check */
 		if (range_cfg->range_max < range_cfg->range_min) {
-			dev_err(map->dev, "Invalid range %d: %d < %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u < %u\n", i,
 				range_cfg->range_max, range_cfg->range_min);
 			goto err_range;
 		}
 
 		if (range_cfg->range_max > map->max_register) {
-			dev_err(map->dev, "Invalid range %d: %d > %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u > %u\n", i,
 				range_cfg->range_max, map->max_register);
 			goto err_range;
 		}
-- 
2.43.0


