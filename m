Return-Path: <stable+bounces-239682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLE3NfVg5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:23:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C097431148
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D893621B0A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB433F59D;
	Mon, 20 Apr 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wRAAFHDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184733EAF9;
	Mon, 20 Apr 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700946; cv=none; b=UufzPCHCRhZJ9equZy0VIXsm7e2HhitxzbtPxzIrcxh+Q/n95/B3QyH6EwOECIdw5w3ciJfG/XBmX8kqZnyahNfthWcDR2cGv7vDkLYVweghUO2+uBAdxQktE/ytWw8of4v+Qof2tbUykIK00JytPIBr+FqJyRZtoaCn4DXiWqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700946; c=relaxed/simple;
	bh=nwt22t0nK3r42Ot6R2b+7kc6v2OuPUDYv6sZ/r8Kc88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehZaOFLdg9EThIt9y54JaoNTW7XSosDTFv2ZhmdUnyh4jYsbP1MiQf1WgaMKG8mDXexn76OVM5dWiU7Pm4MZYT0YJLoEozL2PxehFjRmev9grFdK2AMWypmposYC268OuGmEJwVFO5sxo8Jf/UyeTLGJUV0oZORPU3gltog60us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wRAAFHDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6B2C19425;
	Mon, 20 Apr 2026 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700946;
	bh=nwt22t0nK3r42Ot6R2b+7kc6v2OuPUDYv6sZ/r8Kc88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wRAAFHDZDmlyovdv/715uM+tf0b/FZ3810jwMTOHjiY4YmwixBsQxznGAjDOD2bV7
	 yNValR2Qzzrs7u3rwVqWEEmeg3QS8wcOIOnG4oT1DLqgiVXd3PM+MpHdn3Z3t1eJQp
	 Iyg9xNmzB+T1LmS39dr384O9XtPLay3FRHBEM4Io=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxi Qian <qjx1298677004@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 122/198] nfc: llcp: add missing return after LLCP_CLOSED checks
Date: Mon, 20 Apr 2026 17:41:41 +0200
Message-ID: <20260420153939.998212567@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239682-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5C097431148
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1091,6 +1091,7 @@ static void nfc_llcp_recv_hdlc(struct nf
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
@@ -1182,6 +1183,7 @@ static void nfc_llcp_recv_disc(struct nf
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	if (sk->sk_state == LLCP_CONNECTED) {



