Return-Path: <stable+bounces-43405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422058BF27E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8921F234D7
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132E20FAB5;
	Tue,  7 May 2024 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFW5RrXl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5FD20FAAB;
	Tue,  7 May 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123622; cv=none; b=qafgxTiyOBVBc84skghx7eI72HS5bgts5KhDJtrLLj/SPg1ivEfYQwYo2jA5qtT4EhgV6xVTX2P62GwkLD4mzvCph9cO4maVhLgggIkFmuSV+cfd8bnuZ/iCTKrO8vOd0moYi7bEOM33T6UoTpY6/ROdv2ufKawqhgLfqhAf6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123622; c=relaxed/simple;
	bh=vxPIpeBoZyEHEzotlPWiyTd9qS05CqhWAd3mkWYwmKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3IStaVgJzwJosEUm5jmu8F2NAthd3yP5Efsg5wSt2LXhNx7Soz8X+JsD2bkMt+/1PCfDZTEt6jvoh26DJqhozGovRpWJlrueV/aatQxr4u+Fumkbh17rHZanRI1El0rfmODaZTuxyf1FrAF5qsXARPsw3GN7iaQPBlJ4kmVAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFW5RrXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B239C3277B;
	Tue,  7 May 2024 23:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123621;
	bh=vxPIpeBoZyEHEzotlPWiyTd9qS05CqhWAd3mkWYwmKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFW5RrXlFUh3VbpRSrvKU1Y7pu5gP42bYLOL4iJxSXreE7tBlsMUBAX106aKSy6A9
	 2MpkPsUqSu5Xxzqrwm2AHksiNJCwEWYFwuwTjZTEasbgyBnoHthdhsQPkrtwWyH/We
	 17ErJH0+zSQyfOdIGGP8IjhI12+Fomr9IM1pR2TIAn+4Qb7lE7y2r7rCnIZAbESaMJ
	 LHyCI1tkToqQNviezgTKx+u1c8x/Zs1nQHpAGOVX9VwOyZaBGwYEdEgKlWRUE/LICL
	 PoWte5xYujQC1EbT5FwEe+UxQKr1I0000R9zIUfQyn0hKpR0lUH1VKNEaaT0qnZuFr
	 TrYlzePe+sLbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/15] ASoC: rt715: add vendor clear control register
Date: Tue,  7 May 2024 19:13:14 -0400
Message-ID: <20240507231333.394765-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
Content-Transfer-Encoding: 8bit

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit cebfbc89ae2552dbb58cd9b8206a5c8e0e6301e9 ]

Add vendor clear control register in readable register's
callback function. This prevents an access failure reported
in Intel CI tests.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Closes: https://github.com/thesofproject/linux/issues/4860
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/6a103ce9134d49d8b3941172c87a7bd4@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt715-sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index b047bf87a100c..e269026942e17 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -111,6 +111,7 @@ static bool rt715_readable_register(struct device *dev, unsigned int reg)
 	case 0x839d:
 	case 0x83a7:
 	case 0x83a9:
+	case 0x752001:
 	case 0x752039:
 		return true;
 	default:
-- 
2.43.0


