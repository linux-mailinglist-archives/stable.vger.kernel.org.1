Return-Path: <stable+bounces-250460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI1OAOfyDWry4wUAu9opvQ
	(envelope-from <stable+bounces-250460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B4E5946D8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D36F3242747
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1A373BEB;
	Wed, 20 May 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfBtwzdq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21577370AE5;
	Wed, 20 May 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295470; cv=none; b=NYbZVbeWLTIXItCgResQcWQ1rnA3IlOTtHHmnEOUX2Rnf8N6DOHFqQBGua31gSDAtOZcMpqe2eUXLJz76HCb+yjKOcfUlbnf/+sOx65rTG7MhVlZO18GdxEfFCdPp/wHkxkkKPMDz4TS5Bym1SCw9SELPhW3NWKqS9ix1yLzh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295470; c=relaxed/simple;
	bh=OK3KRorpkksQ03t2Ahz0wQetQBy+A+vs+pdFJAnjPyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMmOsUjRq+iEZdy0pWZcgXmP+CnuaVPvynwDhWYOhnLH39+5C6ZdQPPJkWx9u1FLzdvdLH7TeizLyZDpC8jQAx+CxfwbZMBZzOj1LoguvozA4Z+WdMdUVhDJeytJJER0fverYCLYegAbuXb3rOfuBx1R2xCuOEs8/1LYUMsMYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfBtwzdq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F081F000E9;
	Wed, 20 May 2026 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295469;
	bh=q7vGZ3xK6AEr0GDEFMdP3LoTOGMcVs7R3c0aN5/b0RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sfBtwzdq69cr5icJfplgKK1JqtXvkQXus8odiy3Bv1d1uYPR/lvot/tTr3jvfUfMg
	 PoQ3Uyi8CVXb+qSsRkUeIVSx+WzYfsWCo++ypZq1pPi5oYcavgVYnnlVRKzhMA6ZLp
	 z1juQRkHW1wFRULiW1qfx4pnjMDgjigxmoNSwOgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Denis Rastyogin <gerben@altlinux.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0391/1146] ASoC: rsnd: Fix potential out-of-bounds access of component_dais[]
Date: Wed, 20 May 2026 18:10:41 +0200
Message-ID: <20260520162157.048169368@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250460-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxtesting.org:url,renesas.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 57B4E5946D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Rastyogin <gerben@altlinux.org>

[ Upstream commit f9e437cddf6cf9e603bdaefe148c1f4792aaf39c ]

component_dais[RSND_MAX_COMPONENT] is initially zero-initialized
and later populated in rsnd_dai_of_node(). However, the existing boundary check:
  if (i >= RSND_MAX_COMPONENT)

does not guarantee that the last valid element remains zero. As a result,
the loop can rely on component_dais[RSND_MAX_COMPONENT] being zero,
which may lead to an out-of-bounds access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 547b02f74e4a ("ASoC: rsnd: enable multi Component support for Audio Graph Card/Card2")
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/20260327103311.459239-1-gerben@altlinux.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/renesas/rcar/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
index 69fb19964a71d..2dc078358612d 100644
--- a/sound/soc/renesas/rcar/core.c
+++ b/sound/soc/renesas/rcar/core.c
@@ -1974,7 +1974,7 @@ static int rsnd_probe(struct platform_device *pdev)
 	 *	asoc register
 	 */
 	ci = 0;
-	for (i = 0; priv->component_dais[i] > 0; i++) {
+	for (i = 0; i < RSND_MAX_COMPONENT && priv->component_dais[i] > 0; i++) {
 		int nr = priv->component_dais[i];
 
 		ret = devm_snd_soc_register_component(dev, &rsnd_soc_component,
-- 
2.53.0




