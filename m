Return-Path: <stable+bounces-141191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1FFAAB655
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457F11BC2F8A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADEC3C7D62;
	Tue,  6 May 2025 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i71IipO/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0A2D1104;
	Mon,  5 May 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485469; cv=none; b=B7HNiLRakNhFhkZ8mY9X+A3UthuHERNT6ZCLXoVNWjb2EIWSD39aUGjmoR7flSLImKpSe9MNZnxXh1U5gqY/Mfruv0yKn2KodPUHyc9AZiHFC7xHStxHDdzFH7v0ZTfjfnGxqkw1AWe9nJJDKInYmYYNxAyZs4w+ka3EG9NjvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485469; c=relaxed/simple;
	bh=0p6a0dm0WZpDnUSrzP1TWMURgSuCGh+2SAPykeJYoGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ksi1ckMg+nleYuOmezPw5xKa221HqxI4ag/ymAnyLh5XX5yweSucczRodMfcTMqVEl/FxBB7wlVDZEt26ASttK+fF8iA9Q2zyE5Mc15RXZvUozn2eGmcV288zqlX41YsWlxT2Nsvk01jWo1hRXrmLJkhZux1kVsV30m0G0B08KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i71IipO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA773C4CEE4;
	Mon,  5 May 2025 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485467;
	bh=0p6a0dm0WZpDnUSrzP1TWMURgSuCGh+2SAPykeJYoGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i71IipO/hpOSAr8wrZte69bo+HzOgIlkUKINLobRYW7BUrTJ58ndMDKVmuErDmt1C
	 CF0wcK8D6mLC/n1Co1VbrChVhzNIppC0aCVNSW1r8FWibWOjPtkgnRM443Tcyok9Qm
	 W555GvkajGsW1Z/1KowjKxwFC27fokJgDhbgw0vErfwLMGoR/3W2Ftn96+coIOVxeQ
	 h6DwM1gzEGNONDB1/RBM//eWZ6Ah8fdU3AikKuStbUlUMmysTPBp/dnBcXgHHBw3FJ
	 pCQIbIyDOKrNVFIfkZMe2ZxOzMZZV9cpTD03pBtv2ZoAOw5+nX7slMGfdekUbtYvjq
	 CiaZCPfRae6Ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 328/486] ASoC: tas2764: Mark SW_RESET as volatile
Date: Mon,  5 May 2025 18:36:44 -0400
Message-Id: <20250505223922.2682012-328-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit f37f1748564ac51d32f7588bd7bfc99913ccab8e ]

Since the bit is self-clearing.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-3-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index bc0a73fc7ab41..31f94c8cf2844 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -652,6 +652,7 @@ static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case TAS2764_SW_RST:
 	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
 	case TAS2764_INT_CLK_CFG:
 		return true;
-- 
2.39.5


