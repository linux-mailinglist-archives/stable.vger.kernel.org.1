Return-Path: <stable+bounces-100755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228C9ED5A1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7812C281A3C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B1A251092;
	Wed, 11 Dec 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzQ70LSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD6251088;
	Wed, 11 Dec 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943209; cv=none; b=eTitZKzFsbrfZ3cTakYFBJR4kuKejlPRgSWi2xArpXaJXUdcfOGDme4xyrEtyFrgXz6IgtTQ5wYKXGdeSg0ZvV4krcDBJAYvK+0+PqI/0zTXwJMXucecFUybEYm8yT3TKonr0Ps7OWXBq9ZKBUHdyEk+emGAXQh/I/NSkIcBiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943209; c=relaxed/simple;
	bh=How9apzQzB9Vp3zCICXjecHalI0rmjP6guqiBFhkBT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkveRZ8rAz79DyQvid0BQ3Cc2PhabO4lWvfB6MRXKwBX95ylX+sXV0sdfryydiltqh6KXIIKVoZghrNskl9fofWwhVQ4gYzzwx675gWjn4lorZm329xq+QV1qzwKY7Kdn56Ydqk+X4P/H1Pa+cLs2KQcxnOFKl8rbHE34vh8J0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzQ70LSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB648C4CEDF;
	Wed, 11 Dec 2024 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943208;
	bh=How9apzQzB9Vp3zCICXjecHalI0rmjP6guqiBFhkBT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzQ70LSX6F41+EH3yv/o9YRC/wifb1/bAnrrCrsYPh3kuVnAVDXwwp3L743w9cirB
	 /PsTBgaLf+Ri8FElyYWEcIv9mWYMDT/MdQeeM99icgJMjEtv39tzuUKsFJB+Ax25QU
	 h/t6rFuP+Li6htOdO7UtKA7WKy1hwxLcynC2HvBbHtrfAi5Lrynu7iKzqo1sh82pqG
	 Vlz+uCXyBJ1Wh4rGkzqgbigAhAJihjFtJL2UgMEkbrw2GKrSXXI2WhoEYs8PBeZjnj
	 PO1zS1p8vjepNLMM1ky/BTkPT6id7VwsdNGZgdnw3JNLIfuD20nbPQmXrEjwLV1sfW
	 HlC2yTEhGuLLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.1 06/15] regmap: Use correct format specifier for logging range errors
Date: Wed, 11 Dec 2024 13:52:58 -0500
Message-ID: <20241211185316.3842543-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185316.3842543-1-sashal@kernel.org>
References: <20241211185316.3842543-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 140af27f591ae..15b37a4163d31 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1144,13 +1144,13 @@ struct regmap *__regmap_init(struct device *dev,
 
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


