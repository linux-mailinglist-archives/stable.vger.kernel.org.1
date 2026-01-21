Return-Path: <stable+bounces-210836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICk+D9gmcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:19:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9051B5C023
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF04EB0F082
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6273218DD;
	Wed, 21 Jan 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wwvy0dOl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A1322B77;
	Wed, 21 Jan 2026 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019546; cv=none; b=qRgzhPm7OHLHG32gHCWSU9Arkff1Ii6zhiylNnhYEnj1p6c7YfnQF1AwJpKWMXSG1iZPDPx7aZGotQi8h2gVogyAJzgSo6sjG/ORKmImjDrL8lYys2AodBblzjf2UgB0FG8PN6KtEQqvFbZj1sw2kS9tEnNyWxZTm7b6Zf18vyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019546; c=relaxed/simple;
	bh=9nMJp7qnwskoAHqp/6RmHWuDOLAjJpwL7sM+7odRO2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ybkcc7sPpXw0DpsGNRJ1au0/fQqoB14Ntmq5K5A+vmytRxWKWzeNZ2YydRQOw4kwULpvlV0XTv7QoCiYHQVWG8C+dKRnabUdjuVhnPugkzoEw9MtXb5xMLKcEvHJnBb1+SmGA1BgvW+E/3vcbB8wWcdWATuhel3wnxkPvs9JvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wwvy0dOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E805FC4CEF1;
	Wed, 21 Jan 2026 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019546;
	bh=9nMJp7qnwskoAHqp/6RmHWuDOLAjJpwL7sM+7odRO2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wwvy0dOl3UrUCz7b/+7jiW51LUiPar6sKVbbq99Vn2nq1eJQmLKL8V28W7+5f4zQ8
	 AX3neW6e6/AMza2HacPnQbn5URtYhKDnEYMEVxQhQEv1gWWs2cLo4EvL37u5A23nLe
	 xKCDC73g1JoWe3gu6woLoJjUKzFL0VkQYhOTSshM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emil Svendsen <emas@bang-olufsen.dk>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 038/139] ASoC: tlv320adcx140: fix null pointer
Date: Wed, 21 Jan 2026 19:14:46 +0100
Message-ID: <20260121181412.826249860@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210836-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 9051B5C023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Svendsen <emas@bang-olufsen.dk>

[ Upstream commit be7664c81d3129fc313ef62ff275fd3d33cfecd4 ]

The "snd_soc_component" in "adcx140_priv" was only used once but never
set. It was only used for reaching "dev" which is already present in
"adcx140_priv".

Fixes: 4e82971f7b55 ("ASoC: tlv320adcx140: Add a new kcontrol")
Signed-off-by: Emil Svendsen <emas@bang-olufsen.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://patch.msgid.link/20260113-sound-soc-codecs-tvl320adcx140-v4-2-8f7ecec525c8@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320adcx140.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index d594bf166c0e7..ccfec4c0c159a 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -23,7 +23,6 @@
 #include "tlv320adcx140.h"
 
 struct adcx140_priv {
-	struct snd_soc_component *component;
 	struct regulator *supply_areg;
 	struct gpio_desc *gpio_reset;
 	struct regmap *regmap;
@@ -701,7 +700,6 @@ static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
 {
 	int pwr_ctrl = 0;
 	int ret = 0;
-	struct snd_soc_component *component = adcx140->component;
 
 	if (power_state)
 		pwr_ctrl = ADCX140_PWR_CFG_ADC_PDZ | ADCX140_PWR_CFG_PLL_PDZ;
@@ -713,7 +711,7 @@ static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
 		ret = regmap_write(adcx140->regmap, ADCX140_PHASE_CALIB,
 			adcx140->phase_calib_on ? 0x00 : 0x40);
 		if (ret)
-			dev_err(component->dev, "%s: register write error %d\n",
+			dev_err(adcx140->dev, "%s: register write error %d\n",
 				__func__, ret);
 	}
 
-- 
2.51.0




