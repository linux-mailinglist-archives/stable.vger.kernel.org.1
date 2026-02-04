Return-Path: <stable+bounces-213556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMhGE61dg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:54:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3756E78FF
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18BE030185B5
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4C2C11E4;
	Wed,  4 Feb 2026 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="06dR7soF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D84286A4;
	Wed,  4 Feb 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216730; cv=none; b=l5Ayt8TCCuzxv17Z6Q1lVhYiRNugJV566gHbGxrrqTLGx7eTbCsSbu4XblT7mj3HMtB1VuD+hhINfUyeRXvhHggeETWBIpsbP0xGWSSRL/7vfdylDhKhjVh5Amn1GVCZ2JPDOTbzZiJ7d5p6XsBztZbLjS0UIqER11M9Bh+k8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216730; c=relaxed/simple;
	bh=GfgjpmnQ2T7+/scDBrgTOfHkWKzJYZCDmTfb1urC7eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahy2+4ykeL21FTLEXeafunoaCySHJsc0uPfbLkpAKQAEjq3XA2NtO2dt8IbGQTu5KNmblL/Q5Oa/9JX5cwuBE49zOAi7fNssdjdz3ZUhJZ7dDHJX/Lrfv/J+Sv0mjVl4DpI0qA4tCc9VWidtjQcc8aPTzsmBfdy3Z+MzTNRakus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=06dR7soF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ECBC4CEF7;
	Wed,  4 Feb 2026 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216729;
	bh=GfgjpmnQ2T7+/scDBrgTOfHkWKzJYZCDmTfb1urC7eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=06dR7soFV3sNsOC51NJKcx/eGT52I8MNCEE/0CKveAUM7xtp0aMBED2RBswBkMmj2
	 iHCVQp58Uo0iDrB6u55Nk/Lc2JMQL+ps4KoIwhU4OOhFc7hdLfSyQX1HOKp1GCuSoW
	 KKjBHJ2Z8tCXiGnsIVF+SOzlt7a3oFIFKTlf9eeY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emil Svendsen <emas@bang-olufsen.dk>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 014/206] ASoC: tlv320adcx140: fix word length
Date: Wed,  4 Feb 2026 15:37:25 +0100
Message-ID: <20260204143858.717674699@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213556-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,bang-olufsen.dk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: C3756E78FF
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Svendsen <emas@bang-olufsen.dk>

[ Upstream commit 46378ab9fcb796dca46b51e10646f636e2c661f9 ]

The word length is the physical width of the channel slots. So the
hw_params would misconfigure when format width and physical width
doesn't match. Like S24_LE which has data width of 24 bits but physical
width of 32 bits. So if using asymmetric formats you will get a lot of
noise.

Fixes: 689c7655b50c5 ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
Signed-off-by: Emil Svendsen <emas@bang-olufsen.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://patch.msgid.link/20260113-sound-soc-codecs-tvl320adcx140-v4-4-8f7ecec525c8@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320adcx140.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 06d2502b13478..f7fbe3795f98a 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -673,7 +673,7 @@ static int adcx140_hw_params(struct snd_pcm_substream *substream,
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 	u8 data = 0;
 
-	switch (params_width(params)) {
+	switch (params_physical_width(params)) {
 	case 16:
 		data = ADCX140_16_BIT_WORD;
 		break;
@@ -688,7 +688,7 @@ static int adcx140_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		dev_err(component->dev, "%s: Unsupported width %d\n",
-			__func__, params_width(params));
+			__func__, params_physical_width(params));
 		return -EINVAL;
 	}
 
-- 
2.51.0




