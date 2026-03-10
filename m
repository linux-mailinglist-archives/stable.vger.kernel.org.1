Return-Path: <stable+bounces-224590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEITJMCTsGkukgIAu9opvQ
	(envelope-from <stable+bounces-224590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:57:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E08922588EA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2C7F30888ED
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA763ECBC9;
	Tue, 10 Mar 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b="1LMof0gK"
X-Original-To: stable@vger.kernel.org
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E153CA4BE
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179785; cv=none; b=qEoVBsASkWjvL0v3AcG8LFLsIBMLBuyoduu+F11XzBW9hGxw0vZEiZCe3zfdglvOyfcZIS+cbyrOi8stIPRNZxLrWP8UGIk7TKpa4h1xhwdqScp1ErAbmbIlD8Cj4ezndJ7g7uf5GmO3g8qzRl8mqSBFfjFQMnCTKyWizJlEVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179785; c=relaxed/simple;
	bh=koGOcD/39JRJlUIo/80r7zi0PGrQKcjt1Zjdekk9KaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMzt/V2pjuj5/S6y94YrQYlcK4NwRxS+zfm15jan1O4ZSfRPGF8rRgut+R1mzjFxrVz4ioFTjOj2SOsp00cnyMbjnfiA0vGD4P+WtkgKW4LPFOtQ+SkIC+Od4TdH8dfvIwD1vm/w8K8D+wvNg/ussykXeNACQ58pbM2axQwJD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev; spf=pass smtp.mailfrom=johannes-moeller.dev; dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b=1LMof0gK; arc=none smtp.client-ip=185.70.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johannes-moeller.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=johannes-moeller.dev; s=protonmail; t=1773178262; x=1773437462;
	bh=hZEJp9rUkZ10x1+tyxfdIyN6b5ZE3brXj1HdhI3Pomo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=1LMof0gK2yRk7Ab74enYH3/Dw/YEoAW5smPd/N5BNLHLHZ0LxuM8fI36tWkh3DOOp
	 uA5hk0yzkgQTdCRwKnnT3hojCtxU+NxjPhRhf5bmpixrgrSm6/FI0a1odnRWGCO4iu
	 lReHfydQLnV+W7iohKkzO6gryWIrirnbkka0X/0UbdVYsej0CTvgj6eQj6zPgXHm/V
	 sNFoimKkd5fdj+5l2zaXWBFNWpfNyXm1SE86ldBMWHGZiDZzti2qbGnZmkk8vm1kAw
	 6xg/U9yGdvpGgQ7K8GmasAcWWdHeC3ugEXsP5wf7EZ/3gxu1sL06fvaDME0Jyuzpry
	 8pA3z0AoK1SJA==
X-Pm-Submission-Id: 4fVn9x4JcGz1DDL3
From: =?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: security@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
Date: Tue, 10 Mar 2026 21:29:49 +0000
Message-ID: <20260310212949.74577-2-research@johannes-moeller.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310212949.74577-1-research@johannes-moeller.dev>
References: <abBJh7sJ11RKVGhd@1wt.eu>
 <20260310212949.74577-1-research@johannes-moeller.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E08922588EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[johannes-moeller.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224590-lists,stable=lfdr.de];
	DMARC_NA(0.00)[johannes-moeller.dev];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johannes-moeller.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[research@johannes-moeller.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,1wt.eu,johannes-moeller.dev,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,johannes-moeller.dev:dkim,johannes-moeller.dev:email,johannes-moeller.dev:mid]
X-Rspamd-Action: no action

l2cap_information_rsp() checks that cmd_len covers the fixed
l2cap_info_rsp header (type + result, 4 bytes) but then reads
rsp->data without verifying that the payload is present:

 - L2CAP_IT_FEAT_MASK calls get_unaligned_le32(rsp->data), which reads
   4 bytes past the header (needs cmd_len >= 8).

 - L2CAP_IT_FIXED_CHAN reads rsp->data[0], 1 byte past the header
   (needs cmd_len >= 5).

A truncated L2CAP_INFO_RSP with result == L2CAP_IR_SUCCESS triggers an
out-of-bounds read of adjacent skb data.

Guard each data access with the required payload length check.  If the
payload is too short, skip the read and let the state machine complete
with safe defaults (feat_mask and remote_fixed_chan remain zero from
kzalloc), so the info timer cleanup and l2cap_conn_start() still run
and the connection is not stalled.

Fixes: 4e8402a3f884 ("[Bluetooth] Retrieve L2CAP features mask on connection setup")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f8ed03095592..93e41d9ac124 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4616,7 +4616,8 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 
 	switch (type) {
 	case L2CAP_IT_FEAT_MASK:
-		conn->feat_mask = get_unaligned_le32(rsp->data);
+		if (cmd_len >= sizeof(*rsp) + sizeof(u32))
+			conn->feat_mask = get_unaligned_le32(rsp->data);
 
 		if (conn->feat_mask & L2CAP_FEAT_FIXED_CHAN) {
 			struct l2cap_info_req req;
@@ -4635,7 +4636,8 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_IT_FIXED_CHAN:
-		conn->remote_fixed_chan = rsp->data[0];
+		if (cmd_len >= sizeof(*rsp) + sizeof(rsp->data[0]))
+			conn->remote_fixed_chan = rsp->data[0];
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
 
-- 
2.43.0


