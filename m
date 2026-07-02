Return-Path: <stable+bounces-270554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3BePEp6FRmorXwsAu9opvQ
	(envelope-from <stable+bounces-270554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 17:37:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951916F97E8
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 17:37:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mXy6SBIN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270554-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270554-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4EA1317EB6B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481F37A842;
	Thu,  2 Jul 2026 15:26:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77FB353A9C
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:26:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005986; cv=none; b=hAvJPE3Zt2ckQnKEkHp9E/tRkCQNqnXc26hf8w445IRHtg/kX15Sz1WhtMdZI476nHAtEY91RUOsXHHPU4om+c6oepp1ZY3MM7eRxupvzp0c+EPZ7+4v1hAPWPR8VZvEe2LjnUSB/fmemdw3p4dGhhVR1kIrEI47SO7MwbUpXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005986; c=relaxed/simple;
	bh=mJYdfpPY/lwApNR5ua9R/bwuNEsXBVQe8jSFKtKY4CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNkRnOV8FurbFoePpg2BCVo4AT4JSAUnjuyBgO8V/MsaEkHGIJObnApMwCLLmMr8a8hjaairI/EHxsbJXSr3/CSzGBJ/B9Jnsa6cn1248u9rZz8mQBONd65B52QxNXbQtyZAQzQafKiVxh73EFO/awx6C7ty5t9oFz35UYAARsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXy6SBIN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025EB1F000E9;
	Thu,  2 Jul 2026 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005985;
	bh=/4/sSEphaCaMaKqVNdBcLzHlxtevHqXv3aHhOGjZ9sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXy6SBINMigm1/io/Fvhj1jagHfDRmzOpX/5TfY9Ok+Rhi9eoMBgm0dV4PakN0Bf8
	 kdZQbT/uVOZYhcMwoDEYqDF9J+FV4jdIbOTWG97WQQay8UWckieOqyN8TldSXGAjOn
	 sM21Nidogs5+ykLieRde3H5Oe9Uodd4NxERv6uIB6Rl+Lyj+5+ywuxYw7ygeD/+I8F
	 dnWEd4ujSeCPYzM66f9GLkGyUp11Y9MCIidN4BxbByt/1FVhFkO3Zx7gmxhWN6gir/
	 lGxYAVq6+ak1/RwAPrPiWNjO7dWHofn0q7AvuWTRUNYFoOypxu9/dqDlZec9xegDvr
	 Rsshoeqao2Qgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] skmsg: convert struct sk_msg_sg::copy to a bitmap
Date: Thu,  2 Jul 2026 11:26:22 -0400
Message-ID: <20260702152623.3530248-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070246-backer-dating-7275@gregkh>
References: <2026070246-backer-dating-7275@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270554-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 951916F97E8

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5a8fb33e530512ee67a11b30f3451a4f030f4b01 ]

We have plans for increasing MAX_SKB_FRAGS, but sk_msg_sg::copy
is currently an unsigned long, limiting MAX_SKB_FRAGS to 30 on 32bit arches.

Convert it to a bitmap, as Jakub suggested.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 406e8a651a7b ("net: skmsg: preserve sg.copy across SG transforms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skmsg.h | 11 +++++------
 net/core/filter.c     |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index e9e9fabbfedd89..1e041bc2ce8e3b 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -29,7 +29,7 @@ struct sk_msg_sg {
 	u32				end;
 	u32				size;
 	u32				copybreak;
-	unsigned long			copy;
+	DECLARE_BITMAP(copy, MAX_MSG_FRAGS + 2);
 	/* The extra two elements:
 	 * 1) used for chaining the front and sections when the list becomes
 	 *    partitioned (e.g. end < start). The crypto APIs require the
@@ -38,7 +38,6 @@ struct sk_msg_sg {
 	 */
 	struct scatterlist		data[MAX_MSG_FRAGS + 2];
 };
-static_assert(BITS_PER_LONG >= NR_MSG_FRAG_IDS);
 
 /* UAPI in filter.c depends on struct sk_msg_sg being first element. */
 struct sk_msg {
@@ -235,7 +234,7 @@ static inline void sk_msg_compute_data_pointers(struct sk_msg *msg)
 {
 	struct scatterlist *sge = sk_msg_elem(msg, msg->sg.start);
 
-	if (test_bit(msg->sg.start, &msg->sg.copy)) {
+	if (test_bit(msg->sg.start, msg->sg.copy)) {
 		msg->data = NULL;
 		msg->data_end = NULL;
 	} else {
@@ -254,7 +253,7 @@ static inline void sk_msg_page_add(struct sk_msg *msg, struct page *page,
 	sg_set_page(sge, page, len, offset);
 	sg_unmark_end(sge);
 
-	__set_bit(msg->sg.end, &msg->sg.copy);
+	__set_bit(msg->sg.end, msg->sg.copy);
 	msg->sg.size += len;
 	sk_msg_iter_next(msg, end);
 }
@@ -263,9 +262,9 @@ static inline void sk_msg_sg_copy(struct sk_msg *msg, u32 i, bool copy_state)
 {
 	do {
 		if (copy_state)
-			__set_bit(i, &msg->sg.copy);
+			__set_bit(i, msg->sg.copy);
 		else
-			__clear_bit(i, &msg->sg.copy);
+			__clear_bit(i, msg->sg.copy);
 		sk_msg_iter_var_next(i);
 		if (i == msg->sg.end)
 			break;
diff --git a/net/core/filter.c b/net/core/filter.c
index 27550e8b05a655..878b79529a006f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2677,7 +2677,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	 * account for the headroom.
 	 */
 	bytes_sg_total = start - offset + bytes;
-	if (!test_bit(i, &msg->sg.copy) && bytes_sg_total <= len)
+	if (!test_bit(i, msg->sg.copy) && bytes_sg_total <= len)
 		goto out;
 
 	/* At this point we need to linearize multiple scatterlist
@@ -2900,7 +2900,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Place newly allocated data buffer */
 	sk_mem_charge(msg->sk, len);
 	msg->sg.size += len;
-	__clear_bit(new, &msg->sg.copy);
+	__clear_bit(new, msg->sg.copy);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
-- 
2.53.0


