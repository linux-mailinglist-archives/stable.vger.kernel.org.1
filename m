Return-Path: <stable+bounces-43295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D568BF173
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37789B2389C
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB4913343F;
	Tue,  7 May 2024 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2L/1C33"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95613133421;
	Tue,  7 May 2024 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123311; cv=none; b=oOJjpDvDvNSzEnRsMYLqKvCLHc3FNFNr5/3y+a+7g3W9CkMTH/n8oYpy2BIDu/ow7jluvvR/Dzx4LL5VzeviPT/OPj5w8crNB/Vqu7NazLTtWYptTZ4Uqdsr06+f1Hkkniu3QmTxV6kDBZ4pO7bqiTDPJSN8Rg3SUhPGDuYk6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123311; c=relaxed/simple;
	bh=o/ODnhmhN1qH7N+ff6lbhvRSq87JfgrZG6RDa7NzEv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSzj93VUyU2xEviNwC8Pf9ijbzfEISXhkiOucKT6L9Um2cz6u9Ckz2RAXS3lLENd+hF/KfjxOW9wW1E/B67z2DNhpYnkJuIgvEdtqJOI9EG0kVgO/mLUPvEpOPdrB+g0OnOu7yvxKtCtAOyeVfSiQG/N+4U7r81fwfbq0glHUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2L/1C33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2F9C4AF17;
	Tue,  7 May 2024 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123311;
	bh=o/ODnhmhN1qH7N+ff6lbhvRSq87JfgrZG6RDa7NzEv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2L/1C33QtNSSIx71ZccHmp8Fvp4U/1TeObmDkaTsR8xIsFpbcdL5oddZi+DqxQ8W
	 mBx2tgyllD4/k1uvY3y1ZR2T+4tPNhjqEyyCRmJ/Qwq7m2BNFXSxJvh5MFTBkW7SB4
	 jtKVxeB8OhNoAKQF6JlkSqqCZJeh+w3M9aveSvwJSjBTiTeLiZbGL9H+ugygf28IkQ
	 Uci8tw06P38sQcW63bXMQXKLVyJQk1IhBhA7d5HDg8L0l0LDF9RovXszLxe1YXtrCr
	 SC7L+eq9rF83AMD5xuuOZ3dOxXZx5CbumNaVRmLuXH/JP4EdurqoD7NaTRHGdtKRd1
	 YkfPMWuLLSJbw==
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
Subject: [PATCH AUTOSEL 6.8 16/52] ASoC: rt715: add vendor clear control register
Date: Tue,  7 May 2024 19:06:42 -0400
Message-ID: <20240507230800.392128-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index 21f37babd148a..376585f5a8dd8 100644
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


