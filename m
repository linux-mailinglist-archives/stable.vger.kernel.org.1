Return-Path: <stable+bounces-271314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nYEpKC6aRmpcZwsAu9opvQ
	(envelope-from <stable+bounces-271314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:04:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1096FAF31
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:04:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CF1ww1Z6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271314-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271314-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B84D330EDC3E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11533B951;
	Thu,  2 Jul 2026 16:53:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F01C695;
	Thu,  2 Jul 2026 16:53:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011224; cv=none; b=EGqxhAbMoOZxOw+CGB5MUbKC5ddLkBNShmn9R/CedHQ5Q/8qBk+rsi772xZsezlJSvUny5INSq5Vi5nxr0XEWc54ZPqvQ4ymaoJ9DOwLDumkDBjkg8UX5eYjbUmDH1R/4HO0CVM9kdN87F1nhuLSZhjV0KEjxxwkf/MHsChrRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011224; c=relaxed/simple;
	bh=1PS09KeoqrIhp6Bbp/unOnNh0Z9hJk31hwTFcP8zXE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLnTT0sCv6cx4hDzzVYl/cbi0SCmG14pQljUGsaKlWrRov9uor/GtWJEu1TX3G62wZcb5wtYt+LeYGiBTv8yBwo2t4In6VyFVvnZDXZCtRamBmO2GzmFFELa3MvGGEkWFa4J3BEdmb0RebS3EdTqrQ3ku6TAVK4lQs+Dt24n9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CF1ww1Z6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE181F000E9;
	Thu,  2 Jul 2026 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011223;
	bh=SyByX+BNkSUxfLuOSmWfTwHYbzRqfrQEj9nAlISzYIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CF1ww1Z6987TD98oO/gJZiPAIt+zxc/5hhrPuZYF+Wfkvir3tN0UtfhOgUqYayjvR
	 rYC8BTjViBOxI/CtyFRZssMYW6P3Cqu6P1N6AGY0MxiYxF3mVanl3tZ7Nwew4MuYI1
	 NT1VwkEAuY699U0rrBE+WwRL/flSFfpOgGJQ3mcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 027/108] batman-adv: tt: dont merge change entries with different VIDs
Date: Thu,  2 Jul 2026 18:20:24 +0200
Message-ID: <20260702155112.672870697@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271314-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,narfation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D1096FAF31

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit f08e06c2d5c3e2434e7c773f2213f4a7dce6bc1e upstream.

batadv_tt_local_event() merges/cancels events for the same client which
would conflict or be duplicates. The matching of the queued events only
compares the MAC address - the VLAN ID stored in each event is ignored.

If a MAC would now appear on multiple VID, the two ADD change events (for
VID 1 and VID 2) would be merged to a single vid event. The remote can
therefore not calculate the correct TT table and desync. A full translation
table exchange is required to recover from this state.

A check of VID is therefore necessary to avoid such wrong merges/cancels.

Cc: stable@kernel.org
Fixes: c018ad3de61a ("batman-adv: add the VLAN ID attribute to the TT entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/translation-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9f6e67771ffa80..acd8af4446671f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -446,6 +446,9 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
+		if (entry->change.vid != tt_change_node->change.vid)
+			continue;
+
 		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
 		if (del_op_requested != del_op_entry) {
 			/* DEL+ADD in the same orig interval have no effect and
-- 
2.53.0




