Return-Path: <stable+bounces-236468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEgANVIa3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:31:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 545613EF22D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F0D83029602
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A930C360;
	Mon, 13 Apr 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7OMdAef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C12FFFBE;
	Mon, 13 Apr 2026 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096983; cv=none; b=bpB9mcjaRfzRMBFzETyl+aDcrpetWgouy2qRqJ8jYLriKC/6uJDIJIR7afDEDAPBNM/GhA3w7yYOliPxqLJ0ob2Zj0fKc4LvwRdSoTs17iEfgbPG2A0xnaxMSkIhsrrYSvQDyQ/S8OiVkuK9ge3yFiZ4WUKfHD/pj79v1169kh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096983; c=relaxed/simple;
	bh=jexA9D5srWhjvKMhONGHDsBzmMDid8pjZvIIKKa0Ojk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+e/BJIg8s5BGY3U11unqo5AUKupjbaPLSeJ6h2C6ZS7nYYVP6IjJH142emJzhZOk00zXSOSJTkBFBdmYG9gKTb9EfPzhVLrI+3urHVvQ+qL6H42kymLLofxJ0tD/gFYN/jazj+14GNhn+99T87v7gM7x5mqpRQkRe748zYyILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7OMdAef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812F5C2BCB6;
	Mon, 13 Apr 2026 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096982;
	bh=jexA9D5srWhjvKMhONGHDsBzmMDid8pjZvIIKKa0Ojk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7OMdAefWBocdj9mV70asMKVuICl01jvqls2Li5IPbi1Pp5/xr06ISv1RFxsnR6oe
	 3J16X9sgFU2/AZCUrwp8RDWAwo/QpE1oHKOZz8BK573vPL147SZi7R0+6fwG1L7zsU
	 VjmBHVTdhd+1DA6mufClT2j7AyiCMV+EceA/xkPc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 04/55] mptcp: fix slab-use-after-free in __inet_lookup_established
Date: Mon, 13 Apr 2026 18:00:38 +0200
Message-ID: <20260413155724.990918103@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236468-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 545613EF22D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@linux.dev>

commit 9b55b253907e7431210483519c5ad711a37dafa1 upstream.

The ehash table lookups are lockless and rely on
SLAB_TYPESAFE_BY_RCU to guarantee socket memory stability
during RCU read-side critical sections. Both tcp_prot and
tcpv6_prot have their slab caches created with this flag
via proto_register().

However, MPTCP's mptcp_subflow_init() copies tcpv6_prot into
tcpv6_prot_override during inet_init() (fs_initcall, level 5),
before inet6_init() (module_init/device_initcall, level 6) has
called proto_register(&tcpv6_prot). At that point,
tcpv6_prot.slab is still NULL, so tcpv6_prot_override.slab
remains NULL permanently.

This causes MPTCP v6 subflow child sockets to be allocated via
kmalloc (falling into kmalloc-4k) instead of the TCPv6 slab
cache. The kmalloc-4k cache lacks SLAB_TYPESAFE_BY_RCU, so
when these sockets are freed without SOCK_RCU_FREE (which is
cleared for child sockets by design), the memory can be
immediately reused. Concurrent ehash lookups under
rcu_read_lock can then access freed memory, triggering a
slab-use-after-free in __inet_lookup_established.

Fix this by splitting the IPv6-specific initialization out of
mptcp_subflow_init() into a new mptcp_subflow_v6_init(), called
from mptcp_proto_v6_init() before protocol registration. This
ensures tcpv6_prot_override.slab correctly inherits the
SLAB_TYPESAFE_BY_RCU slab cache.

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260406031512.189159-1-jiayuan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    2 ++
 net/mptcp/protocol.h |    1 +
 net/mptcp/subflow.c  |   15 +++++++++------
 3 files changed, 12 insertions(+), 6 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4264,6 +4264,8 @@ int __init mptcp_proto_v6_init(void)
 {
 	int err;
 
+	mptcp_subflow_v6_init();
+
 	mptcp_v6_prot = mptcp_prot;
 	strcpy(mptcp_v6_prot.name, "MPTCPv6");
 	mptcp_v6_prot.slab = NULL;
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -677,6 +677,7 @@ static inline void mptcp_subflow_tcp_fal
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
+void __init mptcp_subflow_v6_init(void);
 #endif
 
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1993,7 +1993,15 @@ void __init mptcp_subflow_init(void)
 	tcp_prot_override.psock_update_sk_prot = NULL;
 #endif
 
+	mptcp_diag_subflow_init(&subflow_ulp_ops);
+
+	if (tcp_register_ulp(&subflow_ulp_ops) != 0)
+		panic("MPTCP: failed to register subflows to ULP\n");
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+void __init mptcp_subflow_v6_init(void)
+{
 	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
 	 * structures for v4 and v6 have the same size. It should not changed in
 	 * the future but better to make sure to be warned if it is no longer
@@ -2032,10 +2040,5 @@ void __init mptcp_subflow_init(void)
 	/* Disable sockmap processing for subflows */
 	tcpv6_prot_override.psock_update_sk_prot = NULL;
 #endif
-#endif
-
-	mptcp_diag_subflow_init(&subflow_ulp_ops);
-
-	if (tcp_register_ulp(&subflow_ulp_ops) != 0)
-		panic("MPTCP: failed to register subflows to ULP\n");
 }
+#endif



