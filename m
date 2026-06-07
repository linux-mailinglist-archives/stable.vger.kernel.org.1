Return-Path: <stable+bounces-261207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9I3LEg9GJWqyFgIAu9opvQ
	(envelope-from <stable+bounces-261207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:21:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D765664F8E4
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:21:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zsdzHPYn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261207-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261207-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 430893003635
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736F30148C;
	Sun,  7 Jun 2026 10:21:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A42AD00;
	Sun,  7 Jun 2026 10:20:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827660; cv=none; b=ucFSBv1aAO6dzpvDlKkG9F4fChlrp/4Brfbh2/rcA00302SZp+26UcjIS5HkBicCd7IbxDz2jPZ3xeZoid5O9lm+dXQvx/zi5PNntEdmkHZyhdggQEKN8+DrSWWjZKnyFh9/2JZJbGwKXsCFFKA+wBUcNoaVqgzlqc5bdMa5A44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827660; c=relaxed/simple;
	bh=GQfoZVCq8o5nUC1rbyE2cOMXBKvRKvHx41K/9Y3yzGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHgGyZdlycJOdgTkR/bMoh9SrY8g1oqGddzwjn6TTO6nWeO2sNS5kQwEvDPHuHlv7oJKWxcnIRYWlTDYq5Bzn9FbfriZVJqOsvsFWNzdTrk2kni9zqNH1O6EnyD5IxltKM4O0qI5UMWgJHnMDloA5GkKA1bVLAUc4wmNBPoC7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsdzHPYn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906521F00893;
	Sun,  7 Jun 2026 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827659;
	bh=/Y9O9t691YeoJYDgrJpsmtZz8HQt17BwQtxl4qjwiGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zsdzHPYnNBhhP66iMS7DF8URC+bCzYCFxzp9H2RL/mgYjg9BMcupaHXA4NvOg7yVL
	 XFG9zZIlKC8IBgH/Z9anKjqYuOmA/qC2tmnRrmNY9aAeP8M5Sn9FehRcPhZEtQxBws
	 JtMt3A3Kc+EaVolnePA2QRSHTyk2r3kBDqsEwgM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 112/332] net: skbuff: fix pskb_carve leaking zcopy pages
Date: Sun,  7 Jun 2026 11:58:01 +0200
Message-ID: <20260607095732.227474620@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-261207-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:minhnguyen.080505@gmail.com,m:willemdebruijn.kernel@gmail.com,m:asml.silence@gmail.com,m:willemb@google.com,m:kuba@kernel.org,m:sashal@kernel.org,m:minhnguyen080505@gmail.com,m:willemdebruijnkernel@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D765664F8E4

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit ff6e798c2eac3ebd0501ad7e796f583fab928de8 ]

When SKBFL_MANAGED_FRAG_REFS is set, frag pages are not refcounted but
their lifetime is controlled by the attached ubuf_info. To make a copy
of the skb_shared_info, we either should clear the flag and reference
the frags, or keep the flag and have frags unreferenced.

pskb_carve_inside_header() and pskb_carve_inside_nonlinear() don't
follow the rule and thus can leak page references. Let's clear
SKBFL_MANAGED_FRAG_REFS from the original skb to fix it. It's the
simplest way to address it, but there are more performant ways to do
that if it ever becomes a problem.

Link: https://lore.kernel.org/all/20260523085809.26331-1-nvminh232@clc.fitus.edu.vn/
Fixes: 753f1ca4e1e50 ("net: introduce managed frags infrastructure")
Reported-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/1e2086aa69217d7f9c8da3d38f5be7160f1b4cd1.1779993185.git.asml.silence@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 13af6f35428d52..95ef64fad657d3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6847,6 +6847,11 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	skb_copy_from_linear_data_offset(skb, off, data, new_hlen);
 	skb->len -= off;
 
+	/* Remove SKBFL_MANAGED_FRAG_REFS instead of trying to honour it
+	 * while refcounting frags below.
+	 */
+	skb_zcopy_downgrade_managed(skb);
+
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb),
 	       offsetof(struct skb_shared_info,
@@ -6958,6 +6963,11 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		return -ENOMEM;
 	size = SKB_WITH_OVERHEAD(size);
 
+	/* Remove SKBFL_MANAGED_FRAG_REFS instead of trying to honour it
+	 * while refcounting frags below.
+	 */
+	skb_zcopy_downgrade_managed(skb);
+
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
 	if (skb_orphan_frags(skb, gfp_mask)) {
-- 
2.53.0




