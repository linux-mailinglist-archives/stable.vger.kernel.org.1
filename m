Return-Path: <stable+bounces-58805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E47792C02F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC061C22DA4
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0A19FA85;
	Tue,  9 Jul 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI203x25"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D419FA6D;
	Tue,  9 Jul 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542151; cv=none; b=Z9AwxQ6gKK/4zrGI86k5/LKJTHdTrCQdYo7SyOYUlN2Qoan4JY/1gEThducuJuk0i1vSN/cop3KR9Zf/eGOA/9eYP6gVN+encZokfOPg0M7Q7CHuIfaCz20yAKCRobYNvx+orMI/QvE68ssEJkZYgrwTEUJlvcmJscCFp5tZcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542151; c=relaxed/simple;
	bh=SiFJ4lU8qHQLywWxv3ObcupbtgalfaAOEwKyvSyYOw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuskM8+CNSDB8fjO5Z8kb75D2gJLGSUXH+DJgPO/YVlvhXutLjpHokVl5Xv0EHGkbSFh9nmofqkDZ73DzLWWFM9HzANOkAJFVHiwLcof3l2wCo98j79ggyNCF0k5eybQOzwVBttWPTQsw+GJnsXgOJY8WGF+jWIyHIBmEagxpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI203x25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3112C32782;
	Tue,  9 Jul 2024 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542151;
	bh=SiFJ4lU8qHQLywWxv3ObcupbtgalfaAOEwKyvSyYOw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZI203x25cWDTQqrVJ5nb2KAxbuPRNkRdgila1onHMkAIbXmzhfCg6cI5SOq7mM06u
	 +9w9ea+hM6d/TtThW+ZQMFtWlTkjMee7Hzqba4JddmSdhi4DrMoi1yw0zcA06NkcTT
	 YawPVSFM+9AViBqml33aqEmdkNfEUvZskEAdu5rj+/L/1jvqqTL6yowRAvKoj7z8+7
	 zj4j9IyXFiZbWcux55u1/7cLgbqEfJNeg24AGZuYTkwjayeF8m+AoJ9+Ufswn/BSX5
	 WrwZZxNuAEw0tbbrfSU6zaeIQo58rqd5uDvbQzpLr9K9MvzcVOAnz4aco6CAqaoUsz
	 F1Rw5tPivcOuA==
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
Subject: [PATCH AUTOSEL 6.6 03/33] ASoC: rt722-sdca-sdw: add silence detection register as volatile
Date: Tue,  9 Jul 2024 12:21:29 -0400
Message-ID: <20240709162224.31148-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
Content-Transfer-Encoding: 8bit

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit 968c974c08106fcf911d8d390d0f049af855d348 ]

Including silence detection register as volatile.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://msgid.link/r/c66a6bd6d220426793096b42baf85437@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 43a4e79e56966..cf2feb41c8354 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -68,6 +68,7 @@ static bool rt722_sdca_mbq_readable_register(struct device *dev, unsigned int re
 	case 0x200007f:
 	case 0x2000082 ... 0x200008e:
 	case 0x2000090 ... 0x2000094:
+	case 0x3110000:
 	case 0x5300000 ... 0x5300002:
 	case 0x5400002:
 	case 0x5600000 ... 0x5600007:
@@ -125,6 +126,7 @@ static bool rt722_sdca_mbq_volatile_register(struct device *dev, unsigned int re
 	case 0x2000067:
 	case 0x2000084:
 	case 0x2000086:
+	case 0x3110000:
 		return true;
 	default:
 		return false;
-- 
2.43.0


