Return-Path: <stable+bounces-120143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D19EA4C824
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D053A1673C2
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB02620FC;
	Mon,  3 Mar 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXC7kXS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC772620F6;
	Mon,  3 Mar 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019497; cv=none; b=mUk4CH/IMV8HVVGp9lGEw8z+IMNqhkyjdut1tkzKnHwVX01zZgTBVrkwh5fOJhODi2C04l0/p8+Xsvsvy7/pvwEtdWk+uleTfALLTXtVoxBRAQXtMpSlLKG0IB85eQ6mQHpzV+MWLN3inigdytBP6VdIKKzTWaraHnqi2qq36DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019497; c=relaxed/simple;
	bh=Lc6rgszIB+a5D17Ql3l2ipuSEv9/I1TnQjAZ2rhWrcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wbnca/xt4dQsCr/jq2KsMYKNa2GXYLmIe72pJuj7Wkm0+0aLsVjIVtnP8AMhh+kkRs6mcfbqZCzcctt5oUFUdWSkHXeEGsuIeZsFNPuSPKOd6YY/LoqTMvrNIDIMQnFW+vszlOT9NxKKv5PKEEFSIxz/hYMXGOZyB+FdOUQH26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXC7kXS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A458C4CEED;
	Mon,  3 Mar 2025 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019496;
	bh=Lc6rgszIB+a5D17Ql3l2ipuSEv9/I1TnQjAZ2rhWrcw=;
	h=From:To:Cc:Subject:Date:From;
	b=kXC7kXS9sgSfQCRvei6/VwRzalgsRfRB8y2EVTX6y/7mKVFg+xPH3n/2wnubSrDwX
	 PhlcXj6LlvF2mjefoqOO1O6cuWOnwIUO5bWxhZhpNLJK2P/z7FQ93Xq326h+i0W4Q1
	 cbo7ZW5QhPWZjoGJaQ7MOvD4u3fikJo3s/y2wyKdMiA7PwojpHrq6AH+YKg5wY80fl
	 hyxxp0VDpuudGLwfFQqNcTpt+3rTA2c9GBwkd+X22OHT7PQUmHPD7GTXRdkGJFBZMU
	 09kVIwgb5e3WqUNKt1NZNCFFTjMCOM0NxQUjnVa2NiJl9hmMZlY+hhaOPeWHp3sPLn
	 Ydp/lTIuQX5/w==
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
Subject: [PATCH AUTOSEL 6.1 1/9] ASoC: tas2770: Fix volume scale
Date: Mon,  3 Mar 2025 11:31:25 -0500
Message-Id: <20250303163133.3764032-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
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
index 8557759acb1f2..e284a3a854591 100644
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


