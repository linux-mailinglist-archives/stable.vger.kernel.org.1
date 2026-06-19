Return-Path: <stable+bounces-267446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uDATJNyqNWpS2wYAu9opvQ
	(envelope-from <stable+bounces-267446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 22:47:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173D6A7B3A
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 22:47:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267446-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267446-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C65343053EA2
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2463B71DE;
	Fri, 19 Jun 2026 20:47:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD0305679;
	Fri, 19 Jun 2026 20:47:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902038; cv=none; b=AQxsybLRvr1DW0FQJXf8HCmOtxciGR2iorLhrdA5n7AZc9cyamru3xOAYwfepbp07OMX6L77HbGHS3mQfRpbI9oxIbGgbF30pLeCb2O1U1swhnDTPHmklv2ivsjRY+rpPasAcAOH2NGH7ri1dPqW/jbThg53z1pW/mw9+rTcFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902038; c=relaxed/simple;
	bh=W4sjcb3Prlb75DVEnVTqZCcKEmcVLgxZ4fTRXOtD4nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUQIn17+SN3tqEGjb1yfx3s2ygAxnzr5nEMrQgKaJuRP0valT5OoRimI56eACuk8CVEnd5VBdLTUHOMsIkBg6ywL8XQdttbIH3S1lkQU8NhzyXwLRLIgWJH4gUQFvlbCwroVz6F2HIQ3m3/RzPiVOPxBcHEiSKg5sSxuE3Uxaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id E2F0CC0221;
	Fri, 19 Jun 2026 22:47:13 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	aleksander.lobakin@intel.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] mac802154: llsec: add skb_cow_data() before in-place crypto
Date: Fri, 19 Jun 2026 22:47:07 +0200
Message-ID: <178190201874.812652.7427337929247870005.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526183726.56100-1-doruk@0sec.ai>
References: <20260525161806.96158-1-doruk@0sec.ai> <20260526183726.56100-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[datenfreihafen.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267446-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:miquel.raynal@bootlin.com,m:doruk@0sec.ai,m:stefan@datenfreihafen.org,m:aleksander.lobakin@intel.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:security@kernel.org,m:stable@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[stefan@datenfreihafen.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com,0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefan@datenfreihafen.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[datenfreihafen.org:mid,datenfreihafen.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1173D6A7B3A

Hello Doruk Tan Ozturk.

On Tue, 26 May 2026 20:37:26 +0200, Doruk Tan Ozturk wrote:
> llsec_do_encrypt_unauth(), llsec_do_encrypt_auth(),
> llsec_do_decrypt_unauth(), and llsec_do_decrypt_auth() all perform
> in-place cryptographic transformations on skb data.  They build a
> scatterlist with sg_init_one() pointing into the skb's linear data area
> and then pass the same scatterlist as both src and dst to the crypto API
> (e.g. crypto_skcipher_encrypt/decrypt, crypto_aead_encrypt/decrypt).
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] mac802154: llsec: add skb_cow_data() before in-place crypto
      https://git.kernel.org/wpan/wpan-next/c/84a04eb5b210

regards,
Stefan Schmidt

