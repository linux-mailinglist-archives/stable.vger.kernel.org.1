Return-Path: <stable+bounces-120132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD44A4C7F2
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606AA170DB1
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99225D909;
	Mon,  3 Mar 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToJ35Yhe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1F25D8FF;
	Mon,  3 Mar 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019472; cv=none; b=bbk8PvDtP5S0+F7evV0bXNEQUHRhkPOjDumKKehC307jK5UIWH2PBxtk0yqnt5S7CMlEqo3cMcQWmRk+QMJ/QAFc9fJpEPidHJHyuu61flESqnJ7ZaW1FO3RxOwB9IZgnIi2A7poCEdlRBCL3RoPtcLMzT9IjZjNKR4X8ogzSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019472; c=relaxed/simple;
	bh=hx93jLR53uH3E0AQch+hqR0YBwZljF/nGuXbge9YJJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1bJgLe+s/23y81n9sf9RKRat6ZrAzVEFiX0jlvXXqntrRvFKwcQF8yvllhCgBKlkW0g0dU5tPIA89VfQO00yddWhwK9rgGEUJY0rWRJ5C8tiaUygUgWGSAAjI8KLWnaQ2lfmsjzh6e2eR7J2XLm6YC1K2OtyGXwm0zmai9/c8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToJ35Yhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34E6C4CED6;
	Mon,  3 Mar 2025 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019472;
	bh=hx93jLR53uH3E0AQch+hqR0YBwZljF/nGuXbge9YJJo=;
	h=From:To:Cc:Subject:Date:From;
	b=ToJ35Yhehc/rsyOS1UujsLm89F0ZPwWImy+k+JbgQ/VnOXgy7bLzE8Wkc+HLKykk+
	 +RpqA4RNilw/qsnQttBFUGCVGjL9yYvAxCSZIQPLksobCAxYoJ+60M2MQ4XNKCJ4wX
	 pkP3Z13x0giaJcup5KWOfQ9WoVFRT/X7KWTqWvNEmPDQVEyw8SwWRjmk89dtfH9fSa
	 OefZLQ63xVEexNhbyEFuYjZc3mQKYILPkfLWWuBi/hV6ZmDuXUFokojx3anfE/mcXh
	 MwRRQmcc3xLBY4IF/mzySdrGQasSHkWohpAaAsNndAifgHy1bjDxMoBZyLzpMNGaam
	 MwD17zMxMy5gw==
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
Subject: [PATCH AUTOSEL 6.6 01/11] ASoC: tas2770: Fix volume scale
Date: Mon,  3 Mar 2025 11:30:59 -0500
Message-Id: <20250303163109.3763880-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.80
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 579cd64b9df8a60284ec3422be919c362de40e41 ]

The scale starts at -100dB, not -128dB.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2770-v1-1-cf50ff1d59a3@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 99bf402eb5667..5c6b825c757b3 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -508,7 +508,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
-static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
 static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Playback Volume", TAS2770_PLAY_CFG_REG2,
-- 
2.39.5


