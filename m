Return-Path: <stable+bounces-252672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGLRKfgnDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:30:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC7759AF07
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BE7034AA211
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F93F4DD6;
	Wed, 20 May 2026 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hxBIjZBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA9347515;
	Wed, 20 May 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301287; cv=none; b=ikgXHN/SNc14wEeTC5DHoFFStbVavNih/1ReF/xdEl78neKK7Y1zge5S6HZ8033qzqXcf65k5blKzfLyBrZK/0duNg6WfZLUiz5mNR847KanhwStkneKVANblOnN1rXSksdOKI/QZ76cYppnRQe6NCvpkwE34mCyH3Qk04uSWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301287; c=relaxed/simple;
	bh=fYvk+2UZKFwQbZRFi8QvQCE0TMFX18We0SEY2rx8Pt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzII1gW9IQs4uKIi/9y5snWWhSPsllIu8DcJjgfd2Ix8fZcgK6cA//THXavWPloqX6rpG+huUvl4kpmxXKjCmd/JKe41H0Vhg3XjJ+z/QReI3lvCxTy7snAd0b+JAvit/ygkC1RFAk8EV+zD83dIn/dP0aFkJyrTh1xp5lXu8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hxBIjZBq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E5A1F000E9;
	Wed, 20 May 2026 18:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301285;
	bh=56FA9mq7aN0jOoAoS53xrXFyT+ZNTyeqok61J0BRiFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hxBIjZBq7R6QkqO5GlCS3X8O96PQwtrgG9cvdYXxtwQPPbEC2r3wgryyBd05wN+Yr
	 /rDvQXGEKal+KP6P65TvmrS+r8meLUMoBybyHTX32C0UkNGvPCg0RSvwMzv+E2hRpo
	 j7GOZcGrfZfnDc3+ypFmKIogwPmEFkVHgHILicxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Lee Jones <lee@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 497/666] tipc: fix double-free in tipc_buf_append()
Date: Wed, 20 May 2026 18:21:48 +0200
Message-ID: <20260520162122.033824039@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252672-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,est.tech:email]
X-Rspamd-Queue-Id: 0EC7759AF07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lee Jones <lee@kernel.org>

[ Upstream commit d293ca716e7d5dffdaecaf6b9b2f857a33dc3d3a ]

tipc_msg_validate() can potentially reallocate the skb it is validating,
freeing the old one.  In tipc_buf_append(), it was being called with a
pointer to a local variable which was a copy of the caller's skb
pointer.

If the skb was reallocated and validation subsequently failed, the error
handling path would free the original skb pointer, which had already
been freed, leading to double-free.

Fix this by checking if head now points to a newly allocated reassembled
skb.  If it does, reassign *headbuf for later freeing operations.

Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and contents")
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Lee Jones <lee@kernel.org>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/msg.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc538ebd..b0bba0feef564 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -177,8 +177,20 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 
 	if (fragid == LAST_FRAGMENT) {
 		TIPC_SKB_CB(head)->validated = 0;
-		if (unlikely(!tipc_msg_validate(&head)))
+
+		/* If the reassembled skb has been freed in
+		 * tipc_msg_validate() because of an invalid truesize,
+		 * then head will point to a newly allocated reassembled
+		 * skb, while *headbuf points to freed reassembled skb.
+		 * In such cases, correct *headbuf for freeing the newly
+		 * allocated reassembled skb later.
+		 */
+		if (unlikely(!tipc_msg_validate(&head))) {
+			if (head != *headbuf)
+				*headbuf = head;
 			goto err;
+		}
+
 		*buf = head;
 		TIPC_SKB_CB(head)->tail = NULL;
 		*headbuf = NULL;
-- 
2.53.0




