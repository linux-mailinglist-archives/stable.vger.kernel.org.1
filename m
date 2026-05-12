Return-Path: <stable+bounces-246493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM3+GEN0A2rf5wEAu9opvQ
	(envelope-from <stable+bounces-246493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:41:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A5527F86
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB373075BAE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3D34E744;
	Tue, 12 May 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q97l5gM5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF81342509;
	Tue, 12 May 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609368; cv=none; b=NbVRez+4cpfqb+ZjY7GbLmytVFSWSQHcdSt/6zLRNOhDaIirMKtJ+jNRu3wMHWs5afWln4NiIMrOYvmgBxG78GqxDQCwmPQBBOCjHa1kJ+22qKQ9F64me7fNu1iZAUsvcBSwhmFFh+L5nwrdmXfxkmUpBhoRYdxXszGJsTFf8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609368; c=relaxed/simple;
	bh=D4yuZRGWEnsz31DzAFDz0wvPtStLFxwimyb0XNC8lUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiRf+CfPyKFgxqBCrQeWPQyBQy7s+kpHKQ7/KbBUF010xifxpbwwttLzbHxM19wCfc0+EAkqRGFvi1A/TeZVcS0RV897lEPnUzcbzBDxvaYGhqRTTDXbrtN81Mffpr+6gYBKcCKYkvp+wELjirpgE2rwPiQQF2EzuKcVMVZrXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q97l5gM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94FCC2BCB0;
	Tue, 12 May 2026 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609368;
	bh=D4yuZRGWEnsz31DzAFDz0wvPtStLFxwimyb0XNC8lUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q97l5gM5Y9CdFyGMST1OGJOgNjq9zAu+3UvPV1xvDB1fxkwSKWKFCniUmjCw10tJ6
	 ZZoPUHmCaAiWLWNBNMLF/NgL9O5MOJ5gVg5G0C0QOJul8GUxYLdc1bnAAvM9Ul/Mm3
	 PiXp20/paRiEOCLy9hJGqZWgVy9iXRRsSb8Uopr4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Jian <lazycat-xiao@foxmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 169/307] ASoC: ES8389: convert to devm_clk_get_optional() to get clock
Date: Tue, 12 May 2026 19:39:24 +0200
Message-ID: <20260512173943.686457080@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BD1A5527F86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246493-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,foxmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Jian <lazycat-xiao@foxmail.com>

commit 8ed3311131077712cdd0b3afec6909b9388ad3e4 upstream.

When enabling ES8390 via ACPI description, es8389 would fail to
obtain a clock source, causing the driver to fail to initialize.
This was not an issue with older kernels, but since commit
abae8e57e49a ("clk: generalize devm_clk_get() a bit"),
devm_clk_get() would return an error pointer when a clock source
was not detected (instead of falling back to a static clock),
causing the driver to fail early.

Use devm_clk_get_optional() instead to return to the previous
behaviour, allowing the use of a static clock source.

Cc: stable@vger.kernel.org
Signed-off-by: Li Jian <lazycat-xiao@foxmail.com>
Link: https://patch.msgid.link/tencent_7C78374FB9F4B3A37101E5C719715D8BC40A@qq.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/es8389.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -892,7 +892,7 @@ static int es8389_probe(struct snd_soc_c
 		return ret;
 	}
 
-	es8389->mclk = devm_clk_get(component->dev, "mclk");
+	es8389->mclk = devm_clk_get_optional(component->dev, "mclk");
 	if (IS_ERR(es8389->mclk))
 		return dev_err_probe(component->dev, PTR_ERR(es8389->mclk),
 			"ES8389 is unable to get mclk\n");



