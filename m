Return-Path: <stable+bounces-210656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHgiCRU/cGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:51:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B881450097
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 215CA628651
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14A34B408;
	Wed, 21 Jan 2026 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgLrc5dC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1234AB07
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963665; cv=none; b=YrFOfsoYOR/NEApx225k4aMnduXViq4LCzZYKVlb6vjJaDQ+G/gKFQfY0TgZIqYj6xHNo4JuTdwgvihhrvk2JHMq6yT/smkhF8bm9MMlZDS9PnJfcSBOdOekTsGIq6iauQbwiqWDLJ8xCitom/Ah6Vme7M8rW1SL8L+FLL/UkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963665; c=relaxed/simple;
	bh=Ju7J1REp7CRvJSJ/A7h6VLmZN0iReNy0MN4kh3Tuwjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwtQs+c4xETRxn419GRLLK9Cgjd006tjotq33c80toq7MzrePi0zmZvJp2BXlWSs3G8WkR9u9yGFOXrAIUMkRs6hOabkGfcz33qEMjs1Whxja4k87l0ZaVQ3iY2foASBjTePc5EdFk42G8NJNQicNWM48a88iuF6XBjODru3a3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgLrc5dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37613C19425;
	Wed, 21 Jan 2026 02:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963664;
	bh=Ju7J1REp7CRvJSJ/A7h6VLmZN0iReNy0MN4kh3Tuwjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgLrc5dCp/R9SYX6V4qfXiA81AP9qBLX2kSNPHj8fsnHksNIHvwaQYI//tVfyG/VD
	 KdwrrsSrtwIiI/1fgomYLKp9XearDjKGaQBKUtbLRFwSezfdAgFaUBiEKlv6wtx7++
	 oi2FERFnpZPY/XDzqoHdwwMLqYpkGHWmCW6iFp+IdZdD+4uhpDp6kOksVBe6wr/4do
	 GKFhHnXU803Ao52cwwl36lIqR/izGqUZwNZDTLZGybM4kJvkS/1Exy6u+RW6TbD8AW
	 impOWBI/I64gIqfVD6ceVH3ua/0wevVSs7ALPBLFiygJghtGYT4kpYCmrwzGTJnXqT
	 W23awhcz3ZQEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] ASoC: codecs: wsa881x: Drop unused version readout
Date: Tue, 20 Jan 2026 21:47:39 -0500
Message-ID: <20260121024740.1145743-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121024740.1145743-1-sashal@kernel.org>
References: <2026012029-possibly-cornhusk-03c3@gregkh>
 <20260121024740.1145743-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210656-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: B881450097
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 3d2a69eb503d15171a7ba51cf0b562728ac396b7 ]

Driver does not use the device version after reading it from the
registers, so simplify by dropping unneeded code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20240710-asoc-wsa88xx-version-v1-1-f1c54966ccde@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 29d71b8a5a40 ("ASoC: codecs: wsa881x: fix unnecessary initialisation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wsa881x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 24f3a92037d4c..80625efc2fc7e 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -681,7 +681,6 @@ struct wsa881x_priv {
 	 * For backwards compatibility.
 	 */
 	unsigned int sd_n_val;
-	int version;
 	int active_ports;
 	bool port_prepared[WSA881X_MAX_SWR_PORTS];
 	bool port_enable[WSA881X_MAX_SWR_PORTS];
@@ -692,7 +691,6 @@ static void wsa881x_init(struct wsa881x_priv *wsa881x)
 	struct regmap *rm = wsa881x->regmap;
 	unsigned int val = 0;
 
-	regmap_read(rm, WSA881X_CHIP_ID1, &wsa881x->version);
 	regmap_register_patch(wsa881x->regmap, wsa881x_rev_2_0,
 			      ARRAY_SIZE(wsa881x_rev_2_0));
 
-- 
2.51.0


