Return-Path: <stable+bounces-210644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANiNIV40cGkSXAAAu9opvQ
	(envelope-from <stable+bounces-210644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:05:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F64F7A9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8DA3B6DD40
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE16B311955;
	Wed, 21 Jan 2026 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="te+w5mEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D1296BCB
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961070; cv=none; b=KxZ6R3TbqZzk/KcScAUvJb9O/v/rrmPTMp0C7WzHsAM2L4rvoG9CqY8Jlrc4tt89nDTiaSk5+7DNdLEwlfEfibqobIB/Jp3dFGCu1fRd2RxKA7QXD7UWQjI3mOd+kQGsrCs8JAllBb2rlO4tCA/sZnfLsc5WGnuQFe4rZT63Q4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961070; c=relaxed/simple;
	bh=66kWOSSW1EhxfVBTbUqZaF2uDdAf5BoqLGdnkdc2qZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7JEW5invGQbSpj6gMvS7zQ5VKWdYDkYB6K79iOXZYTIzgx6e04oZxXuQSsbL7qMd63NzdsrFG9WTgn2qp1VVtMaRDaVoqZbMwraOOtli9eC+iVGDecvxLL+IAvOUiLLl1Su9hfEeSLdJfYJ5kGdcNKYtvi9oBvc2Kt7R8KmsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=te+w5mEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B6BC19423;
	Wed, 21 Jan 2026 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961069;
	bh=66kWOSSW1EhxfVBTbUqZaF2uDdAf5BoqLGdnkdc2qZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=te+w5mEmOAkfooiMkFwwpJFMJNFR6alYEx06FwhbZnw/NYAXSKWXOmTLrJX8F6iS2
	 IE5F7KqCSg+53ELwOv1gxcwY0cy/lgp6kwOiSHZQzJ6cne+WwNYtVxbWI7hKnPkjzI
	 pWZnWXSmxIyNFWZuBiYCiT09Yc8hZVIyMN6UGysLB4kfgwOIfJi23tPyZfsI81bnp6
	 xAX+iSb387qkJbNVLi0ay9RbzuMy+AmC298/fFSnJhG/DoV5zncCP/w3k/08apZwzv
	 g1z1DaQBVJ3qYSBhPOr7gC2v9+YgogvRnjjYLL3nScfVpw8yA1W8vKTv6AtbggQT0g
	 8iZIsci039Nsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] ASoC: codecs: wsa881x: fix unnecessary initialisation
Date: Tue, 20 Jan 2026 21:04:24 -0500
Message-ID: <20260121020424.1123218-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121020424.1123218-1-sashal@kernel.org>
References: <2026012029-aflutter-entrap-629f@gregkh>
 <20260121020424.1123218-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210644-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: F08F64F7A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 29d71b8a5a40708b3eed9ba4953bfc2312c9c776 ]

The soundwire update_status() callback may be called multiple times with
the same ATTACHED status but initialisation should only be done when
transitioning from UNATTACHED to ATTACHED.

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Cc: stable@vger.kernel.org	# 5.6
Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260102111413.9605-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wsa881x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 5762dbaa2ecf0..86060b4e1d44d 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -684,6 +684,7 @@ struct wsa881x_priv {
 	 */
 	unsigned int sd_n_val;
 	int active_ports;
+	bool hw_init;
 	bool port_prepared[WSA881X_MAX_SWR_PORTS];
 	bool port_enable[WSA881X_MAX_SWR_PORTS];
 };
@@ -693,6 +694,9 @@ static void wsa881x_init(struct wsa881x_priv *wsa881x)
 	struct regmap *rm = wsa881x->regmap;
 	unsigned int val = 0;
 
+	if (wsa881x->hw_init)
+		return;
+
 	regmap_register_patch(wsa881x->regmap, wsa881x_rev_2_0,
 			      ARRAY_SIZE(wsa881x_rev_2_0));
 
@@ -730,6 +734,8 @@ static void wsa881x_init(struct wsa881x_priv *wsa881x)
 	regmap_update_bits(rm, WSA881X_OTP_REG_28, 0x3F, 0x3A);
 	regmap_update_bits(rm, WSA881X_BONGO_RESRV_REG1, 0xFF, 0xB2);
 	regmap_update_bits(rm, WSA881X_BONGO_RESRV_REG2, 0xFF, 0x05);
+
+	wsa881x->hw_init = true;
 }
 
 static int wsa881x_component_probe(struct snd_soc_component *comp)
@@ -1074,6 +1080,9 @@ static int wsa881x_update_status(struct sdw_slave *slave,
 {
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(&slave->dev);
 
+	if (status == SDW_SLAVE_UNATTACHED)
+		wsa881x->hw_init = false;
+
 	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
 		wsa881x_init(wsa881x);
 
-- 
2.51.0


