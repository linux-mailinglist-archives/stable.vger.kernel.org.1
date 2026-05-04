Return-Path: <stable+bounces-243161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLuXOPSm+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:02:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 836094BE65B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71A0D302B073
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6353DE42E;
	Mon,  4 May 2026 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXTBiaXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89D3DD53E;
	Mon,  4 May 2026 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903172; cv=none; b=N41DyDt38B50ypy26oFFoo1oRMWgGKYPxdVumT4tObD3mS76PsNqx1tEBv7ygCBGigJvfDAPLXp0J3jzYT8FMl01dL1GT4cjMADNuilUX6swV+LleDk/7epu92dh3BwzRwATumS7jRtn1GoAUxz/hv3KCPoUBB5MDY9RS4sRr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903172; c=relaxed/simple;
	bh=wKGBn0+895elkl4LR/Dh0ctapVEjRBPHkBz/XThvQb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMDrQbt+dVvSPhwbB35mSbXFxmBfJWZIHVIoj+9uUl6X78TokjnaCKyxZZeVVQ6jEt9UdTX/6+vn4ID1Yj+OhgBnYHGXNtApR8FsvrHy/EOIUdodW7ht6jWBfIrHs4zKC5Xp6RItnNBs8/yxsKA2AaKf2daC8oSWH0HEVeqcfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXTBiaXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3829C2BCB8;
	Mon,  4 May 2026 13:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903172;
	bh=wKGBn0+895elkl4LR/Dh0ctapVEjRBPHkBz/XThvQb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXTBiaXPZFnaS4fyH7SoUeEGQdNEryB+VZzlde2bVBGSUBuyVGj4o1/mXBl4UI2qA
	 gYbzrNkIHGNK22YKn2kYYc1kc1Wz8KYJWusTjk+3TLAinqbdQxUh+b9z9U1KiYA5/c
	 F5WPTjl6avfE7ZFBw6w3y1saAHGTxczACzNeQHp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 130/307] rxrpc: Fix error handling in rxgk_extract_token()
Date: Mon,  4 May 2026 15:50:15 +0200
Message-ID: <20260504135147.683245451@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 836094BE65B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243161-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 3476c8bb960f48e49355d6f93fb7673211e0163f upstream.

Fix a missing bit of error handling in rxgk_extract_token(): in the event
that rxgk_decrypt_skb() returns -ENOMEM, it should just return that rather
than continuing on (for anything else, it generates an abort).

Fixes: 64863f4ca494 ("rxrpc: Fix unhandled errors in rxgk_verify_packet_integrity()")
Closes: https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260423200909.3049438-4-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxgk_app.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -245,6 +245,7 @@ int rxgk_extract_token(struct rxrpc_conn
 		if (ret != -ENOMEM)
 			return rxrpc_abort_conn(conn, skb, ec, ret,
 						rxgk_abort_resp_tok_dec);
+		return ret;
 	}
 
 	ret = conn->security->default_decode_ticket(conn, skb, ticket_offset,



