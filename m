Return-Path: <stable+bounces-236180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AbUBNwkW3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:12:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9FC3EE702
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4C330C09F4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C4248880;
	Mon, 13 Apr 2026 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULWJrUaO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEE21D6DB5;
	Mon, 13 Apr 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096248; cv=none; b=OTdBpk7y+1f1ylRROrEgmk9BRKdFFep/SwT3UNKvHxsGNS3k0znrs7VAHXjEDitwTYm6n4BQ4FLwT7EmlYKomKgidEieOj5uh0MHxyTu1qpACb4uxPTZUHKqLqYny4PeNCNxC0wUUrl+lXHkGQx2l7yHEOvWGNiErL9XzspChBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096248; c=relaxed/simple;
	bh=bzomDZLcl/Cx4t9lCnFp5XvCuJqKDxonuJN75hK/XgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXEmBMqFryS4J+wMcP+sCv2WyQn7PuDkSj81uvvcNNne+5YTSv3GOXKrpEj5S3jXHHcPel0JC0uvxRNzz9GAd6wobj56+POrbPYAggi0Xw6oIeLrnOkxUtLkzx7yQk54LF2AyyHON5AW+J0EeGpRZg5zGiRzAsSmdx2Xgk8FbLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULWJrUaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FF6C2BCAF;
	Mon, 13 Apr 2026 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096248;
	bh=bzomDZLcl/Cx4t9lCnFp5XvCuJqKDxonuJN75hK/XgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULWJrUaO3QldvuMkAa4ViKNVxOB06L5kTuufW+5V6FPsXSPiybAK7/y2uQcHXIn8V
	 ZjFCx4iqobBcCjLrXCoh4T0s5gBaNiUwQKfIwrFuUgGikETd87vyZRstbWmVoBwqJb
	 Au1YguVVPRZtoSSMXMbpmzPAsMQHW9/EFh7My8yI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleh Konko <security@1seal.org>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 24/86] tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
Date: Mon, 13 Apr 2026 17:59:31 +0200
Message-ID: <20260413155732.477257434@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236180-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,1seal.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F9FC3EE702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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



