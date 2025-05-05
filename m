Return-Path: <stable+bounces-141559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E04AAB473
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6E81B61090
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6EE2F0B9A;
	Tue,  6 May 2025 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Goop1idN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A62F0B99;
	Mon,  5 May 2025 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486696; cv=none; b=Zos1bb1QiGvNIe28r6ycgqAqr54IGR0q5wpnd3Y5Pnkf2Pw4dgHRCzH2FKUeTQQ+Y5S6GEyESSgPFSHP/ZTNmKBmR2yW96WdHISh/zhbuKB6kwjBdFBs1q7FlAH0TRdd2el2IQ1LgNlBg6QnxaCCNUElwhSLEq7BPD7iNumvakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486696; c=relaxed/simple;
	bh=DcBtJovJsu3jpYnB8W3UhYdmyseKevG4gSm6pkrtvrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfuRcF5HTe7gF+sH5aIiRC8YEmXr2vHw5bXV7ioFWKzn+NS6gz7aMpcShnm/e4Klkl+BUQqfeFVxw9yJf5j232akUuTj5kF+d8Vt2vf7FEK90MoC20cXk4h98eHX7j7KN83JFMXk1gOQRbIsw+/PiRx9bR9l6/dS8hcv2S2xApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Goop1idN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9158EC4CEEF;
	Mon,  5 May 2025 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486695;
	bh=DcBtJovJsu3jpYnB8W3UhYdmyseKevG4gSm6pkrtvrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Goop1idNhNdSkiBwyu6ei3HKSTpNbFV4ffY4N8ChvW/j5ze0m8g8XoSGoSQIa3d5b
	 zGSA4kQA+vR9bdkQYMzfU9ztf/eBtPNrZS4nehjcrFtXDUEnMqoJ4I8PemorxpM8PE
	 88eGdgh2RCTKSf+h6cgQidpVYsz36goG+QKOV28f5ZeVHmfSruw+T5dEmyql/wk9NX
	 tjkw3ZbaG2IvsCPFtowRg61LhHq4jXUVaANgCdCZuMz/hhZ65DCF8X/aHL+R7Y2d9o
	 ngsEeNcWqTV4b+3UeClqmhL772fF2yRzkd01o1XQ3Np4PBnrLbELMcAM2cQbXnvTY2
	 zfWgIhGUkw7nQ==
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
Subject: [PATCH AUTOSEL 6.1 156/212] ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
Date: Mon,  5 May 2025 19:05:28 -0400
Message-Id: <20250505230624.2692522-156-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit d64c4c3d1c578f98d70db1c5e2535b47adce9d07 ]

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-4-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index fc8479d3d2852..72db361ac3611 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -636,6 +636,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
-- 
2.39.5


