Return-Path: <stable+bounces-212219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIFmJmQvemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:46:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D614A4621
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD41B3024374
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73742F3C1D;
	Wed, 28 Jan 2026 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qut1Z/iH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897962F3618;
	Wed, 28 Jan 2026 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614783; cv=none; b=BdiRiFjawRXaCPXcegaKgLN2AGFw8ZTrWdtPCxnSz+bXcV8m2X2EzpMN9NmBn5Vl8b2P1Y5RdGiUQsDwQiuCxdB7G6MoQMxD0hz4yVd56LONiytkBQi21FOtD9J7HeI7DUdTMd3Aq3+Y9JPM+ntmKgNHY4caGYnMTLVPAmueh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614783; c=relaxed/simple;
	bh=BomN3kcH9VqHb3Ckkt2kPxBMEYT62U/Ti7rhBsntgy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzXKGpLq/H7a0PM+N95o0obaJ4nzej5slarnDAggzJZYILOsLx500lEq8IWoVz2J6eG9puPMZs0P51ioFIg18zfVPvEd1TbymlGxbhRhh4MCb8VI958hcJh6SxDHjzkss65HN8JsJS0I9Z7+7Mmmr+TV21/Q+ioKsOkwvp8KX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qut1Z/iH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01366C4CEF1;
	Wed, 28 Jan 2026 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614783;
	bh=BomN3kcH9VqHb3Ckkt2kPxBMEYT62U/Ti7rhBsntgy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qut1Z/iH8PU57/AWHZd9HW2fzc7DjG5BGRKebn/wSP4gJ2WL49AkFOWuyJ8COUrYe
	 4nmVv5uGl0wFyMDmpCmOAWQh8Be/k2CcK31donpcqoNqLbBJFD8RTabyL4FmVcnw6T
	 3dJcyevadRRK7ZhaQ7wpDAOod03dQJbppdc5RLgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 239/254] ASoC: codecs: wsa881x: Drop unused version readout
Date: Wed, 28 Jan 2026 16:23:35 +0100
Message-ID: <20260128145353.394425910@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212219-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 2D614A4621
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 3d2a69eb503d15171a7ba51cf0b562728ac396b7 ]

Driver does not use the device version after reading it from the
registers, so simplify by dropping unneeded code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20240710-asoc-wsa88xx-version-v1-1-f1c54966ccde@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 29d71b8a5a40 ("ASoC: codecs: wsa881x: fix unnecessary initialisation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wsa881x.c |    2 --
 1 file changed, 2 deletions(-)

--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -680,7 +680,6 @@ struct wsa881x_priv {
 	 * For backwards compatibility.
 	 */
 	unsigned int sd_n_val;
-	int version;
 	int active_ports;
 	bool port_prepared[WSA881X_MAX_SWR_PORTS];
 	bool port_enable[WSA881X_MAX_SWR_PORTS];
@@ -691,7 +690,6 @@ static void wsa881x_init(struct wsa881x_
 	struct regmap *rm = wsa881x->regmap;
 	unsigned int val = 0;
 
-	regmap_read(rm, WSA881X_CHIP_ID1, &wsa881x->version);
 	regmap_register_patch(wsa881x->regmap, wsa881x_rev_2_0,
 			      ARRAY_SIZE(wsa881x_rev_2_0));
 



