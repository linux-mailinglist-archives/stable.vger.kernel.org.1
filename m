Return-Path: <stable+bounces-43419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2038BF29F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5261C20D10
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256819E93F;
	Tue,  7 May 2024 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAbVnryW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720BB19E934;
	Tue,  7 May 2024 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123654; cv=none; b=gWRymFTjHRgmfWRjqLVOA7iXwM+C2TGjiWiq2uhl3PLzSaHgnqYmILObYbmoJlZ74YZOcq0oqE3CKJ1v6SXSfVogGMirq2aiPaymAkF2kX4Vzu1ffwvy4CCAJwRB6PvKW9mMDIwoWz3rVeKBr+SmI6rNZMuxxW73vlJG3CJOswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123654; c=relaxed/simple;
	bh=+2rl+PRyT9qqscmuAzQqwGEvydUUgQkfXYBopw9Ax+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFwEl8qUp2GEFB+QC/k3yNqIBA1PhUKGVkkxaMi099pyury4EfpM3MC6PSAVyG3awUrkQY0p6WFyt8aL1uR/lDllhGzpbQuqp72QDJ4IlGuV1C4mXugZgMwWUTfIfTRe7RU3OeDBZyd/sRojibayUsgoSC8C/PgLDHuUQHsrSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAbVnryW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8D1C4AF67;
	Tue,  7 May 2024 23:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123654;
	bh=+2rl+PRyT9qqscmuAzQqwGEvydUUgQkfXYBopw9Ax+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAbVnryWivAT+6YMfLxBUqP+Hv4fxEtBvGY+y47rj+pExkw63FMLZL/FFyhrNyH/E
	 L2jzNRc+NpoG3lueqGD9ITpR9wTv/fuOg0o8IbVs/HDyl6LSt54VUMblWq+ktMtKC2
	 neTmbsQg2huTgkTMeJml3tSLxyfjJTGZWBIsT9xZCMNjcHazUxUmAkDVdycIUALoXJ
	 58Hz8V+ZPp3XUBeXbc4O4tIHo1URyP5bFNygL9VCyatCXaDgGJiAVKhFWFW0/TPRJ0
	 mv2EYLx/HcJiQ6AdGWvTgZDnnBwO+c1z3KiGVf2kMt4mVmRNEvIemPy8kdz7TUMfTu
	 GhvF6o0QU1VmA==
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
Subject: [PATCH AUTOSEL 5.10 4/9] ASoC: rt715: add vendor clear control register
Date: Tue,  7 May 2024 19:13:59 -0400
Message-ID: <20240507231406.395123-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231406.395123-1-sashal@kernel.org>
References: <20240507231406.395123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
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
index 361a90ae594cd..c0f09c3bcb6e3 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -110,6 +110,7 @@ static bool rt715_readable_register(struct device *dev, unsigned int reg)
 	case 0x839d:
 	case 0x83a7:
 	case 0x83a9:
+	case 0x752001:
 	case 0x752039:
 		return true;
 	default:
-- 
2.43.0


