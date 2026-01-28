Return-Path: <stable+bounces-212011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAaPDaAsemnd3gEAu9opvQ
	(envelope-from <stable+bounces-212011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:34:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1EA4008
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700E73164714
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA4D36BCF7;
	Wed, 28 Jan 2026 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QM5zEFvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B3936B07E;
	Wed, 28 Jan 2026 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614099; cv=none; b=UMY8EWNxsXXpqjEy5Sos7gecGZHzEg5ChpKj54w0lnZAHGsDBUFwK3AjYyulyepe5hGppjYciyJoLtXEnlvgNxvb+VS5oRrhOfDJTm3jLdq3SCADnqe8SzG9i9uBxIPNDamE6ZZyGTigwzUFcgaQD0q9gTUIrdDMjkeqZP9crAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614099; c=relaxed/simple;
	bh=CvdzRGdff/5bJV1hKiR9eSebu6KPnaEgJBdRfzPKiic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlrogcncgE+Q1tRaGjtrVkQ3y6QDQ7OECnN3cK88lFfZTwsmGzwxb8XuzvoKYjNrESgSKnLtl74dk6EXdRssGWZzXTlmprRAKIG6bDaEgqPksOmjHNe3Uqnm1CZKIchuZrn7FOWzf5ud8paWhaE2h9xadtZlOHJTNY8JCqvqELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QM5zEFvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBCAC16AAE;
	Wed, 28 Jan 2026 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614098;
	bh=CvdzRGdff/5bJV1hKiR9eSebu6KPnaEgJBdRfzPKiic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QM5zEFvp2xtuCU1t+a6R2GuU9+yyTlCD0enPbslOJ1mCURorB8ZoTTKVgolKcgth7
	 +eDfEBNTc6mq6bpESGR3EAnXnCc6tev2C2g0lI5vnwZsWew6HY46510wSqelaSnw3W
	 rNq33s9ZraGr/yYSphmCBSex+RM32qS+aGR05k9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 004/254] ASoC: codecs: wsa884x: fix codec initialisation
Date: Wed, 28 Jan 2026 16:19:40 +0100
Message-ID: <20260128145344.862117668@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212011-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 99E1EA4008
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 120f3e6ff76209ee2f62a64e5e7e9d70274df42b upstream.

The soundwire update_status() callback may be called multiple times with
the same ATTACHED status but initialisation should only be done when
transitioning from UNATTACHED to ATTACHED.

Fix the inverted hw_init flag which was set to false instead of true
after initialisation which defeats its purpose and may result in
repeated unnecessary initialisation.

Similarly, the initial state of the flag was also inverted so that the
codec would only be initialised and brought out of regmap cache only
mode if its status first transitions to UNATTACHED.

Fixes: aa21a7d4f68a ("ASoC: codecs: wsa884x: Add WSA884x family of speakers")
Cc: stable@vger.kernel.org	# 6.5
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260102111413.9605-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wsa884x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -1482,7 +1482,7 @@ static void wsa884x_init(struct wsa884x_
 
 	wsa884x_set_gain_parameters(wsa884x);
 
-	wsa884x->hw_init = false;
+	wsa884x->hw_init = true;
 }
 
 static int wsa884x_update_status(struct sdw_slave *slave,
@@ -1884,7 +1884,6 @@ static int wsa884x_probe(struct sdw_slav
 
 	/* Start in cache-only until device is enumerated */
 	regcache_cache_only(wsa884x->regmap, true);
-	wsa884x->hw_init = true;
 
 	pm_runtime_set_autosuspend_delay(dev, 3000);
 	pm_runtime_use_autosuspend(dev);



