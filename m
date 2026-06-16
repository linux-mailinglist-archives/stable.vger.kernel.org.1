Return-Path: <stable+bounces-264191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0vGQM0NzMWqijgUAu9opvQ
	(envelope-from <stable+bounces-264191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:01:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D4B6919E7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:01:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pgnfseGV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264191-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264191-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76375314314A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51F45BD5C;
	Tue, 16 Jun 2026 15:43:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9A4534A4;
	Tue, 16 Jun 2026 15:43:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624612; cv=none; b=pSM1z1dNW5R02yeem9DbzCPTWkxhC4LzYEKkny9i1rGj1sKJGUANE75i/jOeukx1Zr5Svk4akTotS3WiCWz/SajtOiGJrP5ieXoCNO3oL1cI2wiHafUneeaoSqaqFPgfrBIIwxNlkV1fXOUOfHSnKn2wEApf495LcNrDHKBRxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624612; c=relaxed/simple;
	bh=NdBrvqR/3tAWV45v7Q0/Onl0vImIuk1TKwPyiKEUCbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+3nMPYUFd/aaoTh3v09TvrmGHO24/kOpNaLFi30UrdLgMlZ/0Fpx726wbcCgZ5MdyT2o2kmKAo+sQh4PHWMD6GtMQuBQT+RAW7J4QtLaRdhKUwnssvpV7lfeaInnStWbHvORb7MyfY3I2VOWopBf4A3QA282Nok8ynsyXNCrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pgnfseGV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB031F000E9;
	Tue, 16 Jun 2026 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624611;
	bh=qCi+ynFEM+XNtlNufw+ZweK7sVNtXzg83hxyhbQEBwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pgnfseGV7fjJSFEBy6ozLoXPD8j+as4fb3V472rvqfvDT8V8pzjwNYEp/XIhq7Q4J
	 OdorheRw882DQrjebKDh3+1hViR9Xr+oXFULvibk42F4wCGIYbpizGWWzNDtFrC10H
	 4u8GHVVId+xRkGasA7mSYjYnUvqg0XCixoYZMHyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7.0 366/378] wifi: mac80211: tests: mark HT check strict
Date: Tue, 16 Jun 2026 20:29:57 +0530
Message-ID: <20260616145129.395861399@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264191-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johannes.berg@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37D4B6919E7

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 0cfff13c94cb5fa818bb374945ff280e08dc1bb9 upstream.

The HT check now only applies in strict mode since APs
were found to be broken. Mark it as such.

Fixes: 711a9c018ad2 ("wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/tests/chan-mode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mac80211/tests/chan-mode.c
+++ b/net/mac80211/tests/chan-mode.c
@@ -65,6 +65,7 @@ static const struct determine_chan_mode_
 		.ht_capa_mask = {
 			.mcs.rx_mask[0] = 0xf7,
 		},
+		.strict = true,
 	}, {
 		.desc = "Masking out a RX rate in VHT capabilities",
 		.conn_mode = IEEE80211_CONN_MODE_EHT,



