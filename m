Return-Path: <stable+bounces-43339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EB8BF1DD
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A061F23348
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E91494BB;
	Tue,  7 May 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2/0Z8JK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8041494B1;
	Tue,  7 May 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123449; cv=none; b=mucgepaAYEJMXdZhaVnlrmO/l1wiLLvL+eSB2GwzPJgKde5D+yxYuOzMLssF4jfM9g4VwBgeC9h5GhZXzxa44QFtlqexcVdixZ0Iq2g7y/OEfGadbvajs1slqdmSscnfxuCGNU28Emw+KW6GKFN13vkvyd5pGWSlPO8+XofhVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123449; c=relaxed/simple;
	bh=CIfsrnD0zsMUFHMqqLqP520fgGLcEzV+dxAOybbhrOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3cXM0kEA+DVDhJJmquzwop298HGdubE5yocJ6OIEr1Z3YKJmUfiIvlAOAPF3pPhgdmt/Ivd/ki1YfoH/nLjenkQWajn78OvIsWdGnqVCA+gt/r+cptjnKLhISo8Sbta2IXIt6MkSQ7kuzd046wJ/4A7YhpJIYKS4FlUTuCZna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2/0Z8JK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F1FC4AF17;
	Tue,  7 May 2024 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123449;
	bh=CIfsrnD0zsMUFHMqqLqP520fgGLcEzV+dxAOybbhrOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2/0Z8JKSa8xvZ4JJDWbjOXxiA0UoNINYdZvTre0g37tGoRWrhXETRulL+ZyXPA08
	 wxksNhRWtlL130TCKDEScsRaMComsNPfLjKm0pRp1Q/ElOQJ5Frhb9/jRhPzIDRjG6
	 R6us+C9kKlLZkTKae7xn1/yAeIo7jPP95X4Mj/uHAcq+6yQV+Pi46B7P9N97HEA4ES
	 lIWGU3k2d9yFYGaGxoAKTNpPfIboxHvA4ZyDrjXN2PAoJno/s53jU9z0VZoepCVFZI
	 rXHfi286A2BsDSruJlKoT6Ox4z9WgWOFsYM3RHmYyNtdT3DxaXT2aFN/6jTkhW0TnS
	 qySfVXvs1tWOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/43] ASoC: rt722-sdca: modify channel number to support 4 channels
Date: Tue,  7 May 2024 19:09:29 -0400
Message-ID: <20240507231033.393285-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit cb9946971d7cb717b726710e1a9fa4ded00b9135 ]

Channel numbers of dmic supports 4 channels, modify channels_max
regarding to this issue.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://msgid.link/r/6a9b1d1fb2ea4f04b2157799f04053b1@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index 0e1c65a20392a..4338cdb3a7917 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -1329,7 +1329,7 @@ static struct snd_soc_dai_driver rt722_sdca_dai[] = {
 		.capture = {
 			.stream_name = "DP6 DMic Capture",
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 4,
 			.rates = RT722_STEREO_RATES,
 			.formats = RT722_FORMATS,
 		},
-- 
2.43.0


