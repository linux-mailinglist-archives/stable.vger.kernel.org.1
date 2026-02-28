Return-Path: <stable+bounces-220313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Of+LNwwo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B31C596C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1D53417E55
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB23907DB;
	Sat, 28 Feb 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz+EG5Hw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9643907D3;
	Sat, 28 Feb 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300215; cv=none; b=Lb/ibxQGIUx6JguLcpFlKoy06CryObpAdHIo6lVenRW4oux8kJlqP5oTyZSGOlrA3n4pa8Mo8D3qiaAXXz6N1J3GTsaGu6//YMLJEZpPHnFZdgiJtwJJGMtWqaH1yep/ayABmohvNDxGcPUUA3U7DNrtW6AzKvaG+doh3F6uvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300215; c=relaxed/simple;
	bh=YZAeivByqG0CxOjlVDNH88qy95Dk6/eIfkugnyP5LoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=libv/HecNQKWSkClpFkS7Bo9tGilVv/Kny2f3zW11dXqs7TuqrTg2RXhN/6LvQFhvF2TOdmecyiGTbPffIKm0TB7xeNfJ/8itF8IQYepxc15j8v7OoSUJL7DMk2SflG+e74fhi6drhFvWp0E804KbHKOLqEGpbMiKayHElOe2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz+EG5Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B2C19425;
	Sat, 28 Feb 2026 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300215;
	bh=YZAeivByqG0CxOjlVDNH88qy95Dk6/eIfkugnyP5LoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lz+EG5HwTnLdsyNbt98FYMfZ5p8cRRvNV84CZ1uCElRQCkFEGYuBznFwfYb3PZDjB
	 CJ/EA6rr6yii+G6dbRVMFAN1kd6EtowS7nooYCmYkAOtjs0LUWKYQ+BIHVkE40GxVl
	 1S7pSVfNUEzSM9eQFbuPTtdIBURri3FnI1paICsnj5oSemxEy0nl32AAU5zACBVocV
	 bRQxVNfqLCDGff2FvMZRGexdGsxoTShZjv5Pk3+7a2QABS+jy9boD570saTFCLzTu0
	 H3bh1YsrZiuW6iJ7RDROMEniAULB5qZ3Az5nVgUp9Chdg4FjGYVR5jiL5GifKoIpE5
	 PMKH2mvk1zlzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsieh Hung-En <hungen3108@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 235/844] ASoC: es8328: Add error unwind in resume
Date: Sat, 28 Feb 2026 12:22:28 -0500
Message-ID: <20260228173244.1509663-236-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220313-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 306B31C596C
X-Rspamd-Action: no action

From: Hsieh Hung-En <hungen3108@gmail.com>

[ Upstream commit 8232e6079ae6f8d3a61d87973cb427385aa469b9 ]

Handle failures in the resume path by unwinding previously enabled
resources.

If enabling regulators or syncing the regcache fails, disable regulators
and unprepare the clock to avoid leaking resources and leaving the device
in a partially resumed state.

Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
Link: https://patch.msgid.link/20260130160017.2630-6-hungen3108@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8328.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 1e11175cfbbbf..47c6b0c218b2c 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -758,17 +758,23 @@ static int es8328_resume(struct snd_soc_component *component)
 					es8328->supplies);
 	if (ret) {
 		dev_err(component->dev, "unable to enable regulators\n");
-		return ret;
+		goto err_clk;
 	}
 
 	regcache_mark_dirty(regmap);
 	ret = regcache_sync(regmap);
 	if (ret) {
 		dev_err(component->dev, "unable to sync regcache\n");
-		return ret;
+		goto err_regulators;
 	}
 
 	return 0;
+
+err_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(es8328->supplies), es8328->supplies);
+err_clk:
+	clk_disable_unprepare(es8328->clk);
+	return ret;
 }
 
 static int es8328_component_probe(struct snd_soc_component *component)
-- 
2.51.0


