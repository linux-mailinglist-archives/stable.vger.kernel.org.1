Return-Path: <stable+bounces-229854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKyPOTh+wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:54:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91A2FA940
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC4630E8516
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C63B8D4F;
	Mon, 23 Mar 2026 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XhbjZT9D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858E3B9D85;
	Mon, 23 Mar 2026 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283041; cv=none; b=uUQZhnRiWa//9r4VzYeSIFdeUkK6RhM7riMHZDRjLiOmE0z3gnDCeCBIulsVrjp4uGlarYXtt9zsJ6n3sgBvdJ2mdKqAx0odaIIIToRyw7P0E2pxw93q1QRYbA5l0LQg4SOn3r+F0oNcnzwsvoAQtPYz7AzfxjgOsOxpob0uQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283041; c=relaxed/simple;
	bh=jmKf0lqshLQLL3DN/8KBmWPbNkET/qy9QxuS46krRWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svH4bEQqZpmPJeWatZyE4buqbDrpRlLPI1NCh6L+jir6awPu0VPDmgZHdU5nr7f3ttFulNucol1mvPV5PS4oAedBj9T3s/UyJgA4dP1BO9bQS6yxVbkOXBRH8UqD86gKUkD8X/IiVllYhfChLBq20KgkSbkLRHcPiK2kWGeR4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XhbjZT9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723D7C4CEF7;
	Mon, 23 Mar 2026 16:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283041;
	bh=jmKf0lqshLQLL3DN/8KBmWPbNkET/qy9QxuS46krRWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhbjZT9DcK+N+fd5Gme4fP48eezlvmcv6w00hI+JBKz17waGvcS6eW2bKXP6dpamR
	 TIz2+CtuFVohrJB5jZ5Eqco74ISYPrmxx7B/Bz6sHXSZ5FYKZv+8KRCza19eXQg4Bi
	 lj2Tb5i8soMN1fZZ/9UL3L1gsEQSsCW2lauu3oBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.1 381/481] net: add skb_header_pointer_careful() helper
Date: Mon, 23 Mar 2026 14:46:03 +0100
Message-ID: <20260323134534.419114830@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229854-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,kernel.org,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 4A91A2FA940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 13e00fdc9236bd4d0bff4109d2983171fbcb74c4 ]

This variant of skb_header_pointer() should be used in contexts
where @offset argument is user-controlled and could be negative.

Negative offsets are supported, as long as the zone starts
between skb->head and skb->data.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260128141539.3404400-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4113,6 +4113,18 @@ skb_header_pointer(const struct sk_buff
 				    skb_headlen(skb), buffer);
 }
 
+/* Variant of skb_header_pointer() where @offset is user-controlled
+ * and potentially negative.
+ */
+static inline void * __must_check
+skb_header_pointer_careful(const struct sk_buff *skb, int offset,
+			   int len, void *buffer)
+{
+	if (unlikely(offset < 0 && -offset > skb_headroom(skb)))
+		return NULL;
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
 /**
  *	skb_needs_linearize - check if we need to linearize a given skb
  *			      depending on the given device features.



