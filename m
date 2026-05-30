Return-Path: <stable+bounces-257437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPPzAjocG2p3/QgAu9opvQ
	(envelope-from <stable+bounces-257437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:19:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7D60F67E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07B203014BE2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD441395AD8;
	Sat, 30 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/yyOxHT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B63148DA;
	Sat, 30 May 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160993; cv=none; b=qcAhs1y2keKMo5dnkzJRMztZ0xFrY+NJZoehbF1PK6BJVTkVtSZWA18bA6wBjo34ugWxKFC/qCe9N+Tjs9CDdBQCPn9wTYfLVxnnif20eXBYqSRdDXdvebb+S+FX7Cbg94lXFni+C07urIpBclF1QtBGlQc3RqAk4mDRmVxuoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160993; c=relaxed/simple;
	bh=KyD9ub65fXdZ/stWG/lrogv+v/ajFzan7T7S4rOjnJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W26f6dfpw67IvsD4rd13ItxvKoLgLBrbbutjeEwhuKz6UN1iQNiP18hq6fcKSTDTELj0z73qMVmI0ATmsPwGqGMstJtDbVwQFjeAqg9jRDOZBAv7Iq1MV8/GdmGJhPuz2Ey7DtxdsxdcbYt7xh2t++4G4P1Jv5DAuL7lCezfA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/yyOxHT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEBE1F00898;
	Sat, 30 May 2026 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160992;
	bh=POxAFIt0tZLkqLDwV5SNEavsXv0ZLNOD9wNXCRqqhes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/yyOxHT+nKV+ogJW73yQM3gUqyVERCh83ztOTaZpLjptGfuqSsx4+9bvhNVlWfOs
	 /g9MkktZwIHyltY8t5E3RFP+WosK0yr6M8gN9KzihLwdW8aZV2vnw8xHvyUJB2fN6y
	 qM2t0jojno/d6Ecw3tcPcm0JcdLeNOR+R70P2ZWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sander Vanheule <sander@svanheule.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 494/969] ASoC: sti: use managed regmap_field allocations
Date: Sat, 30 May 2026 18:00:18 +0200
Message-ID: <20260530160313.959467533@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257437-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4DA7D60F67E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sander Vanheule <sander@svanheule.net>

[ Upstream commit 1696fad8b259a2d46e51cd6e17e4bcdbe02279fa ]

The regmap_field objects allocated at player init are never freed and
may leak resources if the driver is removed.

Switch to devm_regmap_field_alloc() to automatically limit the lifetime
of the allocations the lifetime of the device.

Fixes: 76c2145ded6b ("ASoC: sti: Add CPU DAI driver for playback")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Link: https://patch.msgid.link/20260220152634.480766-3-sander@svanheule.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index e5c4e5245b255..da07f825f3c5f 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -1028,11 +1028,11 @@ static int uni_player_parse_dt_audio_glue(struct platform_device *pdev,
 		return PTR_ERR(regmap);
 	}
 
-	player->clk_sel = regmap_field_alloc(regmap, regfield[0]);
+	player->clk_sel = devm_regmap_field_alloc(&pdev->dev, regmap, regfield[0]);
 	if (IS_ERR(player->clk_sel))
 		return PTR_ERR(player->clk_sel);
 
-	player->valid_sel = regmap_field_alloc(regmap, regfield[1]);
+	player->valid_sel = devm_regmap_field_alloc(&pdev->dev, regmap, regfield[1]);
 	if (IS_ERR(player->valid_sel))
 		return PTR_ERR(player->valid_sel);
 
-- 
2.53.0




