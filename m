Return-Path: <stable+bounces-261050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HnEwHd9DJWqBFQIAu9opvQ
	(envelope-from <stable+bounces-261050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8C64F63C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uy9Tg9OQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261050-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261050-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98AF43002F4F
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A5E2E739E;
	Sun,  7 Jun 2026 10:11:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22302E2DDD;
	Sun,  7 Jun 2026 10:11:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827098; cv=none; b=FZNGPS+D7Mqbyl2PEvTY4mSvQAp6SKaFDJlA6NbyBTSWQ2bK5R9GRTDJVfo0FGqqvaahC9OGkFEu+PzyxOLPy/FhuVW0pyWACk3GOm6S8+25v/cCI+0xHOvT8bQnsETbOfTvmitNd+WOukaJSDHfei+RlPirOy1qpbdnPAdoT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827098; c=relaxed/simple;
	bh=ZysLHZEAFQIs1V9stxUEVhQFfxEV0sNPTuCe5aOflNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwC6la/HcGpLJ5c66hBbVfWYrYNHUgKCq3TkOfhrzQ3IMji9GKLFdvCBx73YPRnfNUIiuiirv9NlxHzh/GDT8PujvlD+gK+DyuenLPAScmc+mCT/B45wueGwdy2KRegSRztJfNaIBAAWbvbkgxXUw2IjjD4GUforXSFooJlLu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uy9Tg9OQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919621F00893;
	Sun,  7 Jun 2026 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827096;
	bh=BTA3ayOCUI5CvHT1Wu4aEAXEfMdrmTo26xokmgbvU/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uy9Tg9OQn+qgdpI3rFdCsw938jojulK4kahp1e1dTpjPpONpj4WwifmJ96He1ggP1
	 dHjBBirZ+4F9vlmtCIjn/VuzV/E+k79bxMjh5Azr/Jcm9to9xntF2IQQqfu+d0P+UJ
	 x2O6KVGzVpUIA1Yjz1XrROqxo778tw+xtrC1VnsE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 062/332] ASoC: codecs: simple-mux: Fix enum control bounds check
Date: Sun,  7 Jun 2026 11:57:11 +0200
Message-ID: <20260607095730.408997341@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261050-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:cassiogabrielcontato@gmail.com,m:broonie@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77D8C64F63C

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit f63ad68e18d774a5d15cd7e405ead63f6b322679 ]

simple_mux_control_put() rejects values greater than e->items, but
enum control values are zero based. For the two-entry mux used by this
driver, valid values are 0 and 1, so value 2 must be rejected as well.

Accepting e->items can store an invalid mux state, pass it to the GPIO
setter, and pass it on to the DAPM mux update path where it is used as
an index into the enum text array.

Use the same >= e->items check used by the ASoC enum helpers.

Fixes: 342fbb7578d1 ("ASoC: add simple-mux")
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260527-asoc-simple-mux-enum-bounds-v1-1-3f805b9fc671@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/simple-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/simple-mux.c b/sound/soc/codecs/simple-mux.c
index 069555f35f7359..c2f906a3f074ce 100644
--- a/sound/soc/codecs/simple-mux.c
+++ b/sound/soc/codecs/simple-mux.c
@@ -51,7 +51,7 @@ static int simple_mux_control_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
 	struct simple_mux *priv = snd_soc_component_get_drvdata(c);
 
-	if (ucontrol->value.enumerated.item[0] > e->items)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 
 	if (priv->mux == ucontrol->value.enumerated.item[0])
-- 
2.53.0




