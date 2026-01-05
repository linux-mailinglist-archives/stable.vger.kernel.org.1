Return-Path: <stable+bounces-204819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76340CF4492
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02F473083603
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1017B50F;
	Mon,  5 Jan 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDZLRLav"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D920FAA4
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624699; cv=none; b=q142DSk/kNJ1DAKEDGxix3pByFNTJdVGN8ot8QSA6p1YYxxgVZLRy8aiFa/HuSzGFz8hKNS2dnKj59wXdYwgwHRUC9ZfYxolOMMr8pIXwecrSlxiCfmg3rEgI1gZ/yS1hGvv2YUXSrHuk6xTKneOwmwqcSle0Ph1OTeuMfiU9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624699; c=relaxed/simple;
	bh=k+daCvINb8Gu/FbqdRQoyOIuWqoJ68EQNqT3JkHxbYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmFZTBmskqLAXBwIX9q045CLJ9mPUr8de2paAIMDfOBuzO/0kAXYm6A06Pa/IpDA3R7WhmvFIzf0lSRRhjirKd/r+/Rx61EVngqPAkpghA3UUbeVgRzpSt/LTv1ebWohq0RNS/AufLWsCMrY4cyv2MYHyjU7u4qeedE42uCGVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDZLRLav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFD6C116D0;
	Mon,  5 Jan 2026 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767624699;
	bh=k+daCvINb8Gu/FbqdRQoyOIuWqoJ68EQNqT3JkHxbYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDZLRLavU6CEALtAcAjIcR8z+JwXjmRZ5vARZR1CJAvehqMjK1xUNhM++x1zqwrpu
	 YickcJlaY1mnsIcDPOtv7o13k+KbQ0KQ3nKVzNGfxQT0oolkJqB02ilgxqHudVrkeG
	 AHc8bQnIUpmKAE8RPDQDszihTpgDLYb+3nU/gTOmlyBEIlJ+JkddwS+QP2qjIdKMKx
	 3euTRGqOQhOhB3GXu4m/t8jLDQ+ECsXGtg0h9KNVjW0oRNQTUVGs8iRPCr4uWz46+y
	 53l+0dmeK5FsknhU1uwkgG9adefmQ+m0n/rxuLJ9yjCyKKoQTyzRl8GrxzOV5bfpzz
	 JupDJCn4pR1SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	olivier moysan <olivier.moysan@st.com>,
	Wen Yang <yellowriver2010@hotmail.com>,
	olivier moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] ASoC: stm32: sai: fix device leak on probe
Date: Mon,  5 Jan 2026 09:51:33 -0500
Message-ID: <20260105145135.2613585-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105145135.2613585-1-sashal@kernel.org>
References: <2026010551-divinity-dislodge-aca5@gregkh>
 <20260105145135.2613585-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit e26ff429eaf10c4ef1bc3dabd9bf27eb54b7e1f4 ]

Make sure to drop the reference taken when looking up the sync provider
device and its driver data during DAI probe on probe failures and on
unbind.

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
Fixes: 1c3816a19487 ("ASoC: stm32: sai: add missing put_device()")
Cc: stable@vger.kernel.org	# 4.16: 1c3816a19487
Cc: olivier moysan <olivier.moysan@st.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: olivier moysan <olivier.moysan@foss.st.com>
Link: https://patch.msgid.link/20251124104908.15754-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 23261f0de094 ("ASoC: stm32: sai: fix OF node leak on probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 8e21e6f886fc..df167c389b98 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -127,6 +127,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	}
 
 	sai_provider = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
 	if (!sai_provider) {
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
@@ -143,7 +144,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
 
 error:
-	put_device(&pdev->dev);
 	of_node_put(np_provider);
 	return ret;
 }
-- 
2.51.0


