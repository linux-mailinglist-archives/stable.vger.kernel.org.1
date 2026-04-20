Return-Path: <stable+bounces-239853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MNFEtxb5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:01:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4AF43061B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BBA4317133C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4E534107F;
	Mon, 20 Apr 2026 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MXUwA1pW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF011336EE1;
	Mon, 20 Apr 2026 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701383; cv=none; b=M/8ImqM36g7m6JOg9sTAWnwgCRbtBkVnB/CTt/b3myPJAljnvQMoEhS0qzqH56HxCOQmZ7ru/7NlhxujIoBfxQlFZt2mJNwk6kDoASWYDqtljTfDbTVrog9tf9fWu0pGkt+IpjAoJDydYgtRxsk4TNKG7puGMYV0LqHKNkTJQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701383; c=relaxed/simple;
	bh=IbsVS2MGydAkg0n8mdx2xqXtkRCbv4jF6Q5EwIqYKBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpAjWTE3Jh2LpGaEEwj0BczZ0ZhXAV3rUJFJTlFiN6a5I3GTgmFhJdtG9tkL3jQJcTpfR1gu/ImhsMmnMcXHi0FMibkgpLNBaVdrwDQc5gSnhvP09N1KZt53Pghuky3LIbytSJvorWLfDuUq9I0XQ3CPYqtFJmoz9x4lUQHm4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXUwA1pW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDB4C19425;
	Mon, 20 Apr 2026 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701383;
	bh=IbsVS2MGydAkg0n8mdx2xqXtkRCbv4jF6Q5EwIqYKBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXUwA1pWVxIPuOnbCR2GFPGpGtKehWE737PMU95pdScz/TfFptrCH5hpybqzzqJ4M
	 GMJo5+LAVKlxA7qPvFrQ9yCgbXtEmFu5eJDbPgue8sk2q+duViObykWHc+RZteIYE6
	 M3+k8YAoTPRUngVQmHjxhnJwg/wINQi45xm9fHr8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxi Qian <qjx1298677004@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 093/162] nfc: llcp: add missing return after LLCP_CLOSED checks
Date: Mon, 20 Apr 2026 17:42:05 +0200
Message-ID: <20260420153930.404130904@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239853-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD4AF43061B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxi Qian <qjx1298677004@gmail.com>

commit 2b5dd4632966c39da6ba74dbc8689b309065e82c upstream.

In nfc_llcp_recv_hdlc() and nfc_llcp_recv_disc(), when the socket
state is LLCP_CLOSED, the code correctly calls release_sock() and
nfc_llcp_sock_put() but fails to return. Execution falls through to
the remainder of the function, which calls release_sock() and
nfc_llcp_sock_put() again. This results in a double release_sock()
and a refcount underflow via double nfc_llcp_sock_put(), leading to
a use-after-free.

Add the missing return statements after the LLCP_CLOSED branches
in both functions to prevent the fall-through.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260408081006.3723-1-qjx1298677004@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/llcp_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1089,6 +1089,7 @@ static void nfc_llcp_recv_hdlc(struct nf
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
@@ -1180,6 +1181,7 @@ static void nfc_llcp_recv_disc(struct nf
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	if (sk->sk_state == LLCP_CONNECTED) {



