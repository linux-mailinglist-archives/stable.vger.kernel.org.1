Return-Path: <stable+bounces-264421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d65mKNpzMWrXjgUAu9opvQ
	(envelope-from <stable+bounces-264421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:03:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB07691A63
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=roO1RkdX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264421-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264421-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D45F3028DFF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6653A451060;
	Tue, 16 Jun 2026 16:03:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980844DB64;
	Tue, 16 Jun 2026 16:03:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625795; cv=none; b=LbZy4xEHFlL1qW05K5IGg/axTqZnkrKtmy44JTBDeFw10VGWkdyIhZctBJKpqPP0GKhAEB2aZav4ULHUB+Ye3BDHYm7nD4HqQ/mLuVIkyo4a3QcQh6+TBnE4QwEtsTQq8Q/UFRSkLvz18BcsXLOeO4KtBcZbfY5luckVmMZMm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625795; c=relaxed/simple;
	bh=FYHeUcGVAIC6O7EKDq9WaYr/R1XGDqNWm2KQCIOAdJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P11Bh4IXm5Wqip7ChQiQ+QZ2WoegXQmMf830B6l3ARtRkAd7cvfYvWcEfdTurCM1lZ2gVnIFE85NYj8DlUUTu6ldzm9bJBei9XYb1MfRykvHeEagXr2nxDNVMoX/uENbCMikfeLqeaz/btZXqj9rCq9pZERmY5aKyVhhvuWhFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=roO1RkdX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF5A1F000E9;
	Tue, 16 Jun 2026 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625793;
	bh=3+0G6J88I84LXdz4zoSgCPzqGvux6W1CP/vocIb/2DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=roO1RkdXWmarDPTAxJGTU5u2e05nj/PnuTIARP+0cN2Jgwr8RFR0HLvEgaj+WSWqC
	 WcjWNdzZr+mCUabfMsC/PxGFHcf8GRn34RtSuxbfqqZJTfLgj/Th3qIIVikMN8Axal
	 wcjTI8lxM8GUAmjIdkQpQfK2CoETBvu3NOOr+37A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raf Dickson <rafdog35@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.18 207/325] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Date: Tue, 16 Jun 2026 20:30:03 +0530
Message-ID: <20260616145108.374856288@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264421-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rafdog35@gmail.com,m:sgarzare@redhat.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DB07691A63

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raf Dickson <rafdog35@gmail.com>

commit c05fa14db43ebef3bd862ca9d073981c0358b3f0 upstream.

When vmci_transport_recv_connecting_server() returns an error,
vmci_transport_recv_listen() calls vsock_remove_pending() but never
calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
permanently.

Repeated handshake failures (malformed packets, queue pair alloc
failure, event subscribe failure) cause sk_ack_backlog to climb
toward sk_max_ack_backlog. Once it reaches the limit the listener
permanently refuses all new connections with -ECONNREFUSED, a
silent denial of service requiring a process restart to recover.

The two existing sk_acceptq_removed() calls in af_vsock.c do not
cover this path: line 764 checks vsock_is_pending() which returns
false after vsock_remove_pending(), and line 1889 is only reached
on successful accept().

Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
the error path.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20260526104356.469928-1-rafdog35@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/vmci_transport.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -972,8 +972,10 @@ static int vmci_transport_recv_listen(st
 			err = -EINVAL;
 		}
 
-		if (err < 0)
+		if (err < 0) {
 			vsock_remove_pending(sk, pending);
+			sk_acceptq_removed(sk);
+		}
 
 		release_sock(pending);
 		vmci_transport_release_pending(pending);



