Return-Path: <stable+bounces-255939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGWfLVunGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC45F91A7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4F2130089A2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3C223328;
	Thu, 28 May 2026 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJhk4VDH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CB31DD97;
	Thu, 28 May 2026 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000302; cv=none; b=P+bT1sYAo7uXc8kXgcPjP6sF6MmrMoo+EIABn7PxbhkAiRdeH92zUNcx71JwIfUuF4+W3+g1yZGhelv+bSdWIPorZ+8T5xLzX99BDzFk7nFtXOeVZbh67C3+5wPKijA8UyTZ0Cc3hCsrHYJAo8hHmCR9DrR/tdYN0Bb8Fis9jW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000302; c=relaxed/simple;
	bh=KpN5t9Q7zxxQa+3sUAF73JPvIDQgTmDblgRlE9pg/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCwBtHnHL9PRxwLalR7cwZBUqC9+PZQHVGucuF5i278fgw/jafewmR2vAbHsmYRKNu1Qbso/F9aCwAANz70npZwZ++Ljk4jdRMwiHYgyH4BwIPkvThocmdhT04niUNN8M4o92wDI+JagnoLascTlpjwssKF+W5bidvtH3tMSdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJhk4VDH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547DF1F000E9;
	Thu, 28 May 2026 20:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000301;
	bh=KbqpRcjXIahw5vS9tIPISdv6synbIJCBnJrf12ElNK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJhk4VDHy7aBgBxJd30XKHBOGCJRPrjrzDiP97oJI+4xwtpp8K6mEa2jPVU50g8Fm
	 TT6j7aRm0kkxShzKYD79PH0a1GHL4EwTlozJ1j/9AiC9FgJiCGrlAdSxEuTnNu+CYu
	 yzWLlg3sMV7MKOYkL7NuTzLA0OqBX5YmnIiKVTuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 374/377] net: gro: dont merge zcopy skbs
Date: Thu, 28 May 2026 21:50:12 +0200
Message-ID: <20260528194649.259609463@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255939-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,queasysnail.net:email]
X-Rspamd-Queue-Id: 88EC45F91A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 4db79a322db8c97f7b73b8a347395ef4d685eb40 ]

skb_gro_receive() can currently copy frags between the source and GRO
skb, without checking the zerocopy status, and in particular the
SKBFL_MANAGED_FRAG_REFS flag.

When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
on the pages in shinfo->frags. Appending those frags to another skb's
frags without fixing up the page refcount can lead to UAF.

When either the last skb in the GRO chain (the one we would append
frags to) or the source skb is zerocopy, don't merge the skbs.

Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 867611d171dbb..b5f790a643d49 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	if (p->pp_recycle != skb->pp_recycle)
 		return -ETOOMANYREFS;
 
+	if (skb_zcopy(p) || skb_zcopy(skb))
+		return -ETOOMANYREFS;
+
 	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
 		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
-- 
2.53.0




