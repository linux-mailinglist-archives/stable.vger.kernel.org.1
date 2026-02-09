Return-Path: <stable+bounces-215050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGmqBHrwiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:34:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC311074E
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F0093041788
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FECB37AA87;
	Mon,  9 Feb 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTBB1HUW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D882222B2;
	Mon,  9 Feb 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647508; cv=none; b=dHylWfb6YupTdthTkCe5xX6SkHszIuOsmasGSjeV0NeaWpKwlKtq7xKhbkzbTB3gyGOtsvL8bfmNmqKtFy/NZ76pj+ib92VzDJxZaJSDtuSwv2N9kwk5bMunDnbMZxoZ2DGXWrq0dyS8srfqMO/GTHxXHk3MtcP0R5zVoUs2Cz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647508; c=relaxed/simple;
	bh=EqTyuBmTSMfhQRJ1kCdQCu2V9MKhYBqf8KQsKNGWbl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In8uQTzzPTiomm/Gon3IuXA6qcypogGa3ICjtSAM7pbH+JqDJ+H8FRtsmUaRSA8nJBLW4fz/3fUbv28pVspj3wXwOyboZRU+pw93dHGfw+HOYrQvRIxJxIugfXjXUIvr4QKGBTvDFiVgOUNjzZZvq3xrXcXSr1w3/npKxCSPexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTBB1HUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764E1C116C6;
	Mon,  9 Feb 2026 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647507;
	bh=EqTyuBmTSMfhQRJ1kCdQCu2V9MKhYBqf8KQsKNGWbl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTBB1HUWUzFbTzYvWwu1KdrarYUvoizs2YvbrSf7X5eZLISDKFoZH4NtkHF1YRJfH
	 OJRgfptAdk5Ux9ybxew+iFBqF29AYv2/NM4B2gK3YtrpJCF9PyzNkFYms8ul5nzQWz
	 797ydtIWQxYuPihg9bB64yOKBXvYbnnhmTPrxNfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 119/175] net: add skb_header_pointer_careful() helper
Date: Mon,  9 Feb 2026 15:23:12 +0100
Message-ID: <20260209142324.691794445@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215050-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71AC311074E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
Stable-dep-of: cabd1a976375 ("net/sched: cls_u32: use skb_header_pointer_careful()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a7cc3d1f4fd11..50f127451dc65 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4301,6 +4301,18 @@ skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
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
 static inline void * __must_check
 skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
 {
-- 
2.51.0




