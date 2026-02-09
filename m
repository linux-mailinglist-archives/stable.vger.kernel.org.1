Return-Path: <stable+bounces-215460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMpUE0H5iWkiFQAAu9opvQ
	(envelope-from <stable+bounces-215460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:12:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE3111B23
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0E2330398B8
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D928312F;
	Mon,  9 Feb 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JvfbPc2a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EB29A9C3;
	Mon,  9 Feb 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648867; cv=none; b=VVmsCYwmNAKC3gRjFWI0ZGznHcQLa13oUZeR1JAeGbrmTNky6dLs0DbZKMu6lQpdg5v2bSSc6jDy0/xVnIGR43LWzMEkmc6IgUPFL7PLemP9kkHDEJXe0MksOVGQX/UCo8q21WkLUQx0K9aBbRhpD7nYe8d2axPwvjV82kTvyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648867; c=relaxed/simple;
	bh=d/aOVj8vY7VlUhWFsPnPMLufiwN9ztxji9R5jndi+JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2bzXlvHt4a7oRoN3hd6c6fFXV+HyjaD1MUVQLaWAPz6E5jX6PtyhOOUx4l7OoMxmkjHOylrm798ZAP7a9KytpXkrQ54Ovl9MRov9QtyfvXeMyXTRWsPXxCbrMW3cmrRPwGVPleEwRIBGxrREr9/eHA8Lj8b/+rCH4KTNiffpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JvfbPc2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B824DC116C6;
	Mon,  9 Feb 2026 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648867;
	bh=d/aOVj8vY7VlUhWFsPnPMLufiwN9ztxji9R5jndi+JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvfbPc2aBEWTqLgC9H9CGTeFXVWq3P2NUfE+gRqslrB4x+Z5dFPdIoM2aChZGrf7m
	 qIBXuKkoO/inDZzTSpMDMsJLQtCX/+vojO3YmG70/cd6QV1lQUyoHbyqlZFLDjic3t
	 GQHezV/wQwMASU7/83GgGzCK5xlh6Ugd7FDB2HZ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dimitrios Katsaros <patcherwork@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 39/75] ASoC: tlv320adcx140: Propagate error codes during probe
Date: Mon,  9 Feb 2026 15:24:36 +0100
Message-ID: <20260209142303.254311871@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215460-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,pengutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 97BE3111B23
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dimitrios Katsaros <patcherwork@gmail.com>

[ Upstream commit d89aad92cfd15edbd704746f44c98fe687f9366f ]

When scanning for the reset pin, we could get an -EPROBE_DEFER.
The driver would assume that no reset pin had been defined,
which would mean that the chip would never be powered.

Now we both respect any error we get from devm_gpiod_get_optional.
We also now properly report the missing GPIO definition when
'gpio_reset' is NULL.

Signed-off-by: Dimitrios Katsaros <patcherwork@gmail.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://patch.msgid.link/20260113-sound-soc-codecs-tvl320adcx140-v4-3-8f7ecec525c8@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320adcx140.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index f7fbe3795f98a..46560d5eb4b1d 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -1098,6 +1098,9 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
 						      "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(adcx140->gpio_reset))
+		return dev_err_probe(&i2c->dev, PTR_ERR(adcx140->gpio_reset),
+				     "Failed to get Reset GPIO\n");
+	if (!adcx140->gpio_reset)
 		dev_info(&i2c->dev, "Reset GPIO not defined\n");
 
 	adcx140->supply_areg = devm_regulator_get_optional(adcx140->dev,
-- 
2.51.0




