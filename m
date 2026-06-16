Return-Path: <stable+bounces-263865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qi1BAnhpMWrjigUAu9opvQ
	(envelope-from <stable+bounces-263865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:19:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6B690E95
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:19:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=w3E6h+Zs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263865-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263865-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47673301727C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E343C05C;
	Tue, 16 Jun 2026 15:14:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA443CEC7;
	Tue, 16 Jun 2026 15:14:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622879; cv=none; b=OnEZGcmE2kdVXfyBtLrN3N8V+/gG+SB93x9IF9nds2x3BiAP+voUSjBxxDj0L+uK4yxae6WxNwPZpZS/JpiRTEDDyTOU0wiymEKUzdCjEagLKMBLmpq4uhVugVT+FUhwuThxPAbW/7t/TxRKkL/kaQKbU5MMdVpN/CQBNpPGEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622879; c=relaxed/simple;
	bh=QjwooAWVjoRofBOdU1ramqjzlW9Jm1nGRqAdk2fBqjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxaLprhme/2pYiUMKp/gM+k5n28V/NsmNNYthJFmMfRsAZ5/T7VqkZZCeMf4rvGXfAPf2/ErvvYnWXxqCljj4oeasa+BrkJptlQoYTS6t0SVquaGw91x9IPj5fr0OpBDI+eulB9AKwjtpBUhu2oCkXu0NQSULriiLNskE1CUZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w3E6h+Zs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA721F00A3A;
	Tue, 16 Jun 2026 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622878;
	bh=xXZBNDCq2GCQjBJ09uEzNy+z9SED89iQFTB7wzm9j00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w3E6h+ZsVB1ZcqpOpSfqKKK9I8j1VHBhRWXMblxXKVHZ0lDeQrWTdvyg1YPXUAZRN
	 jCzzN00V3coPwJmMfJFgo3V60bDq2c/gGKxZyUE86uVlgcRuTE0HCyNzw/m7ENl1dv
	 BTpTbQusw0yEtt02k3755BR8hENROcPxd141N5NA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dudu Lu <phx0fer@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 047/378] Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
Date: Tue, 16 Jun 2026 20:24:38 +0530
Message-ID: <20260616145112.397072449@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-263865-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:phx0fer@gmail.com,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90C6B690E95

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dudu Lu <phx0fer@gmail.com>

[ Upstream commit 72b8deccff17a7644e0367e1aaf1a36cfb014324 ]

In bnep_rx_frame(), the BNEP_FILTER_NET_TYPE_SET and
BNEP_FILTER_MULTI_ADDR_SET extension header parsing has two bugs:

1) The 2-byte length field is read with *(u16 *)(skb->data + 1), which
   performs a native-endian read. The BNEP protocol specifies this field
   in big-endian (network byte order), and the same file correctly uses
   get_unaligned_be16() for the identical fields in
   bnep_ctrl_set_netfilter() and bnep_ctrl_set_mcfilter().

2) The length is multiplied by 2, but unlike BNEP_SETUP_CONN_REQ where
   the length byte counts UUID pairs (requiring * 2 for two UUIDs per
   entry), the filter extension length field already represents the total
   data size in bytes. This is confirmed by bnep_ctrl_set_netfilter()
   which reads the same field as a byte count and divides by 4 to get
   the number of filter entries.

   The bogus * 2 means skb_pull advances twice as far as it should,
   either dropping valid data from the next header or causing the pull
   to fail entirely when the doubled length exceeds the remaining skb.

Fix by splitting the pull into two steps: first use skb_pull_data() to
safely pull and validate the 3-byte fixed header (ctrl type + length),
then pull the variable-length data using the properly decoded length.

Fixes: bf8b9a9cb77b ("Bluetooth: bnep: Add support to extended headers of control frames")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 6770d3a8acdf ("Bluetooth: bnep: reject short frames before parsing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/bnep/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index b3cef7a4db5412..0de5df690bd0b2 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -330,11 +330,18 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 				goto badframe;
 			break;
 		case BNEP_FILTER_MULTI_ADDR_SET:
-		case BNEP_FILTER_NET_TYPE_SET:
-			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
-			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
+		case BNEP_FILTER_NET_TYPE_SET: {
+			u8 *hdr;
+
+			/* Pull ctrl type (1 b) + len (2 b) */
+			hdr = skb_pull_data(skb, 3);
+			if (!hdr)
+				goto badframe;
+			/* Pull data (len bytes); length is big-endian */
+			if (!skb_pull(skb, get_unaligned_be16(&hdr[1])))
 				goto badframe;
 			break;
+		}
 		default:
 			kfree_skb(skb);
 			return 0;
-- 
2.53.0




