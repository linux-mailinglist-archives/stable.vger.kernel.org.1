Return-Path: <stable+bounces-237044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFT8HRkg3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:55:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C53F042A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9606730558A8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1330FC0F;
	Mon, 13 Apr 2026 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4scTGQ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC573090F5;
	Mon, 13 Apr 2026 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098445; cv=none; b=TIOdQAnQsMZmob/dwb+Ek6i60L0x4zbJm9dST/N3t8u8g094R6DVFkqT8vRNQP6suM6LbKlHmWd0dY9JLdRUKxqgnpVar/bFUwk2b0NIfA2pQvoKYFA6EUHcmP8Qaeiuc5DzMClj9WHW8qyETmBaryzvzHfmYCXOUHF8pXHPffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098445; c=relaxed/simple;
	bh=Qbm9TkEorcZqdicF3D0OthaE9e2MuvGSqYrKwStbN4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIG7ThzdKcQbvW9woXCEYmVNLAzeiNgohy0knCbNr2atW2Ko8odsgJDIdVhW8A5HiWKRqUk/1i8omBFD1cfay9wL4swM1nxvBPpbGfPUkt4gGWN1mcG2OxFVbA8mZZWpDD9rY/u0bbZMbGfPRNFaWydV2H2pRHeVpF/On7DxAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4scTGQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66F8C2BCAF;
	Mon, 13 Apr 2026 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098445;
	bh=Qbm9TkEorcZqdicF3D0OthaE9e2MuvGSqYrKwStbN4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4scTGQ6Qv9S0I+h3EOrxq0WUxDsyUBThImY8xjv24IZblIyzSqk72q7QFN5QU/0J
	 86S4vcf5/V3K0e6T7TNFHZCsA0h8Ak/75mWTtoP+JdLTbW7TLyu7zYiNRB2OrxQk6I
	 H3xisvB9pXQJvy/c62FJC8T/heRG8KHyE5/22Ngw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleh Konko <security@1seal.org>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 527/570] tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
Date: Mon, 13 Apr 2026 18:00:58 +0200
Message-ID: <20260413155850.190543552@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237044-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,est.tech:email,msgid.link:url]
X-Rspamd-Queue-Id: 717C53F042A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleh Konko <security@1seal.org>

commit 48a5fe38772b6f039522469ee6131a67838221a8 upstream.

The GRP_ACK_MSG handler in tipc_group_proto_rcv() currently decrements
bc_ackers on every inbound group ACK, even when the same member has
already acknowledged the current broadcast round.

Because bc_ackers is a u16, a duplicate ACK received after the last
legitimate ACK wraps the counter to 65535. Once wrapped,
tipc_group_bc_cong() keeps reporting congestion and later group
broadcasts on the affected socket stay blocked until the group is
recreated.

Fix this by ignoring duplicate or stale ACKs before touching bc_acked or
bc_ackers. This makes repeated GRP_ACK_MSG handling idempotent and
prevents the underflow path.

Fixes: 2f487712b893 ("tipc: guarantee that group broadcast doesn't bypass group unicast")
Cc: stable@vger.kernel.org
Signed-off-by: Oleh Konko <security@1seal.org>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/41a4833f368641218e444fdcff822039.security@1seal.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/group.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -746,6 +746,7 @@ void tipc_group_proto_rcv(struct tipc_gr
 	u32 port = msg_origport(hdr);
 	struct tipc_member *m, *pm;
 	u16 remitted, in_flight;
+	u16 acked;
 
 	if (!grp)
 		return;
@@ -798,7 +799,10 @@ void tipc_group_proto_rcv(struct tipc_gr
 	case GRP_ACK_MSG:
 		if (!m)
 			return;
-		m->bc_acked = msg_grp_bc_acked(hdr);
+		acked = msg_grp_bc_acked(hdr);
+		if (less_eq(acked, m->bc_acked))
+			return;
+		m->bc_acked = acked;
 		if (--grp->bc_ackers)
 			return;
 		list_del_init(&m->small_win);



