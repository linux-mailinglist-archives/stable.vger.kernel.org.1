Return-Path: <stable+bounces-37146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF089C385
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41752283B58
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF457D09F;
	Mon,  8 Apr 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xh5uuaC3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FF768EA;
	Mon,  8 Apr 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583381; cv=none; b=YmldTmGxETipCzD3JHH+2p+ox93ZtwQ9Jq+PNKODNgBcNnEfM7+D6aoRC9gOx0VEnyMu54hPUFigqyXjPZTfBxLfscofjeKZg2oY/VpMjMp3/d7DDnNL6FMNtglMxqdm5nbZUoewmHO510HbkJZEc/2+ymJnG9IrbQ5QMz0YESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583381; c=relaxed/simple;
	bh=RsXOOfPj6Eh8TE2rU3Cq5uX8axLZoVJNlXQEvfxvn1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTGsb3yS61E2yBwdYg5PrXHaOrO6Rei7bC/vXT4sHURMznHyL8T7+LTrF5Mvuuj9L8DsEiGulI8agnbmSnPejlPRTtSsVRPQm+ASS7cSpjIk9p2a7l3zm2sQdBffl4G1MTfJr0KAyQ9TLFTMApTBZh3b46lMeC8ptPgWFLoWyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xh5uuaC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C46C433C7;
	Mon,  8 Apr 2024 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583381;
	bh=RsXOOfPj6Eh8TE2rU3Cq5uX8axLZoVJNlXQEvfxvn1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xh5uuaC3BbzhOxD5aPPUyayd2IEALmm+84+Nu70uSt3y2ddUoVnBkUmomi3MzU1e+
	 IBEeak4oDqvG8oYbLSPjqFi910KyGYsNBYqS9VkgNhrDIOFO7nSTcJhlAtHe9pMi/x
	 3n7AkmQTt0DppwEekHR1uZAlmYH/RMKJd3A6TLFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 173/273] regmap: maple: Fix uninitialized symbol ret warnings
Date: Mon,  8 Apr 2024 14:57:28 +0200
Message-ID: <20240408125314.634003332@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit eaa03486d932572dfd1c5f64f9dfebe572ad88c0 ]

Fix warnings reported by smatch by initializing local 'ret' variable
to 0.

drivers/base/regmap/regcache-maple.c:186 regcache_maple_drop()
error: uninitialized symbol 'ret'.
drivers/base/regmap/regcache-maple.c:290 regcache_maple_sync()
error: uninitialized symbol 'ret'.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f033c26de5a5 ("regmap: Add maple tree based register cache")
Link: https://lore.kernel.org/r/20240329144630.1965159-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index c1776127a5724..55999a50ccc0b 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -112,7 +112,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 	unsigned long *entry, *lower, *upper;
 	unsigned long lower_index, lower_last;
 	unsigned long upper_index, upper_last;
-	int ret;
+	int ret = 0;
 
 	lower = NULL;
 	upper = NULL;
@@ -244,7 +244,7 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 	unsigned long lmin = min;
 	unsigned long lmax = max;
 	unsigned int r, v, sync_start;
-	int ret;
+	int ret = 0;
 	bool sync_needed = false;
 
 	map->cache_bypass = true;
-- 
2.43.0




