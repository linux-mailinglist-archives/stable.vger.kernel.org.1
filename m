Return-Path: <stable+bounces-264822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JHAyE5F+MWpFkwUAu9opvQ
	(envelope-from <stable+bounces-264822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:49:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A466E6927A7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:49:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NPDxTDtF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264822-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264822-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C69D30D5DD7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD033AD9B;
	Tue, 16 Jun 2026 16:41:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585B46AED1;
	Tue, 16 Jun 2026 16:41:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628072; cv=none; b=l5n+Uj3TJ7khvN/Ftk8O2btj64SOiipCnNxXMtSB3RmMFHIzZKkwvikh0UkUIP5/RZKj7Z+QDG5AInQ1Iu0QGkx7FEMddWTacgWRa39FDW6ftq1VIKZNgYDxmvKQQTvjAvDNYRPE/bXBfGooGlWhvDS7gjk7akdeU6VcSKnA7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628072; c=relaxed/simple;
	bh=LK8A/y7VpoMIkbmRJJxp0INVknFwMvYaXzu4vgioIZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lV2rqPF/tJhQMN9nfKV1RNC9uNAmOjrA6QvwG7y3JvPk+d2Qlz8q0ZQs4/epY2s2y8/3imXNbT6nAaYl0VIjAmnsF3+9RcZmFcgijwghZXccnmFCCXCW5pY0WLu5OXmnb0VSyOPEEFIzd3nZiobjMc+UvlD7OYqOCm5ka3BfstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NPDxTDtF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610B61F000E9;
	Tue, 16 Jun 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628071;
	bh=ACNt1lXu1Js5/FUlxxtDHMeOJe82wYFIOyMVyGtZ7xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPDxTDtFEeKEWxhUffJIJuCztG7GNIsxejslmqBnfNLNirDzJFSfcMTuy3aaUYY5m
	 w31qNjhAbNRcsZ6x2WwHT/f9FW+e6Bclf1R9sfExmXlvr/6mP4Y3PgpQUaj/r6sX5l
	 tOd4buU3PiUZVqQgckq7jqlQ9bvRIk+F7DNPVMu8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	David Heidelberg <david@ixit.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 008/452] nfc: llcp: Fix use-after-free in llcp_sock_release()
Date: Tue, 16 Jun 2026 20:23:55 +0530
Message-ID: <20260616145118.232016973@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264822-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lee@kernel.org,m:david@ixit.cz,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A466E6927A7

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lee Jones <lee@kernel.org>

[ Upstream commit f4268b466190dae95a7585f69b4f1f8ad097632c ]

llcp_sock_release() unconditionally unlinks the socket from the local
sockets list.  However, if the socket is still in connecting state, it
is on the connecting list.

Fix this by checking the socket state and unlinking from the correct list.

Fixes: b4011239a08e ("NFC: llcp: Fix non blocking sockets connections")
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://patch.msgid.link/20260429134115.3558604-1-lee@kernel.org
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/llcp_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index d5344563e525c9..cd1fdf0beefb6b 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -633,6 +633,8 @@ static int llcp_sock_release(struct socket *sock)
 
 	if (sock->type == SOCK_RAW)
 		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
+	else if (sk->sk_state == LLCP_CONNECTING)
+		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 	else
 		nfc_llcp_sock_unlink(&local->sockets, sk);
 
-- 
2.53.0




