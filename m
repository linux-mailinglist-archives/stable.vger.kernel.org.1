Return-Path: <stable+bounces-43344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C18BF1E7
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7F61F22D30
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADDC14A088;
	Tue,  7 May 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E58oaQ2v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CE149E1D;
	Tue,  7 May 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123457; cv=none; b=VVRlLZlmEsim59xb4DrjaSJvYXBfXf14c8C+r/k1zFuj1y/YlDhGO+nC3eKaWHVRSoLO59gYtREVHnKkSazqfbMlPmpgabrvWvyBKxk495g8PaHKSB/NFuK7w99Uz4ImrjmVFYYdYNetBqOBlQo6LeRYp0+iDMKlKEGfEYCPSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123457; c=relaxed/simple;
	bh=o/ODnhmhN1qH7N+ff6lbhvRSq87JfgrZG6RDa7NzEv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwgpwwe/YlW/zK7Yl7RmYdYqXb5i3EJ0b1ZztTVsGJJ2OnEPb2Q9K38IbbIaVOpqCtqznKx61hT24mkL5c7NTnFAhWwwqsSkBZGP9+1K8MLcCBLZ8AJAUYsxvTg/UG3rir9MjzMKeuCJXroI/E9odd30pdHTy6BCGHJWJHGmiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E58oaQ2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443A5C2BBFC;
	Tue,  7 May 2024 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123457;
	bh=o/ODnhmhN1qH7N+ff6lbhvRSq87JfgrZG6RDa7NzEv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E58oaQ2v/6HvRxLFGh0nZwH1s9ubDI3nkzx2FsF9/UYGMn4eh5iZvyw274euPOpaN
	 AsIFwi7KR3Y2TT4bCdPqTgpO3XlG/9IUChjFInoVUANCE5XwMs/zM/F2K0FQfIb6ur
	 UmkzQoJnge2SILeenw0CnVQRWIDSrrY3+V8XxRCENBVSYAr9urzJdZv9/pnsTVPhzq
	 ighhqhe1WogXM1jngPKoB7C1c8NfQqPLePNCZT6jwvshRf7cE7OC8qpaXtgE0lZszU
	 2GJKUNTyuYY9lwj53QShG8DxotM9jNRgVl9YbICb6McKnDGH3XMHbsXK616MYKPmpl
	 8nFgck6BGxKzA==
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
Subject: [PATCH AUTOSEL 6.6 13/43] ASoC: rt715: add vendor clear control register
Date: Tue,  7 May 2024 19:09:34 -0400
Message-ID: <20240507231033.393285-13-sashal@kernel.org>
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


