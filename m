Return-Path: <stable+bounces-271512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2zV7JTecRmpoaAsAu9opvQ
	(envelope-from <stable+bounces-271512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:13:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C86FB23A
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:13:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jWdFbR2r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271512-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271512-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D973B30A70A5
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E92FC893;
	Thu,  2 Jul 2026 17:02:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9F1FA859;
	Thu,  2 Jul 2026 17:02:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011736; cv=none; b=aOJCerKTfXHrWvvVbTrVdhoj5T2PQcJjeJYh6Rr3ifmbA3VZYjqZiOGxsTYBujcuL24awodE/4/T6NtLDexgwLSXtlhykQZ/3LjCkWAcEsW3LQ/bEqd5qswo/U6mrWT+v4QkFzEJ9jA8iAadWrf5WSLhvIcQGDHQuzxAGHREw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011736; c=relaxed/simple;
	bh=/DJS2PeKux1TzP/Mv3hcvCuDnpbKnnP8IoavdUUBq6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOBatPsryQeGfqaRpz5RDbLc1OrZ7W6fmo8BuyFshDS+TA4TYC6KbGPDmnpke4q67KbEj0ZxOjMTGusMpjXq1afzv+PO6JKicWIygsQfyrj2EM7g9m0ohfFsfhFTTxnD6XkwNP+KnvYmb5AZAk1UU2hXkAB0jEMRmCUtXJ4eams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jWdFbR2r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82521F000E9;
	Thu,  2 Jul 2026 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011735;
	bh=DjinC9YyAIYUB1+hxxcIuIgmzy3afT9yAXCHgiSyyyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jWdFbR2rwrKyOeLYkSjLmlZ96svTivU2tkZYWYlzahP2+K0dHo2R67IkwS9vpett0
	 /KVaIivhuYLUojDaSVpk2x+3nxSi0adNMDh7K7ey6iG6CLzehlaf1mRhuO1b9zkQ41
	 hG1ob4WtqXviWNi8LCYBRDg3jczygu/SDiwBjdn0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 7.1 096/120] power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()
Date: Thu,  2 Jul 2026 18:21:32 +0200
Message-ID: <20260702155114.945011006@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271512-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:sebastian.reichel@collabora.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D4C86FB23A

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 8eec545cde69e46e9a1d2b7d915ce4f5df85b3bd upstream.

Move of_node_put(dn) after the of_match_node() call, which still needs
the node pointer. The node reference is correctly released after use.

Fixes: e2f471efe1d6 ("power: reset: linkstation-poweroff: prepare for new devices")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260407073025.271865-1-vulab@iscas.ac.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/reset/linkstation-poweroff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/reset/linkstation-poweroff.c
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -163,10 +163,10 @@ static int __init linkstation_poweroff_i
 	dn = of_find_matching_node(NULL, ls_poweroff_of_match);
 	if (!dn)
 		return -ENODEV;
-	of_node_put(dn);
 
 	match = of_match_node(ls_poweroff_of_match, dn);
 	cfg = match->data;
+	of_node_put(dn);
 
 	dn = of_find_node_by_name(NULL, cfg->mdio_node_name);
 	if (!dn)



