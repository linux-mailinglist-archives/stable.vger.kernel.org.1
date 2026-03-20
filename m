Return-Path: <stable+bounces-227608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKrdDoKivWkM/wIAu9opvQ
	(envelope-from <stable+bounces-227608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:39:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62982E0255
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7E8030BAF05
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 19:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF2A3EF67F;
	Fri, 20 Mar 2026 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7NxU6tP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IpnhCvBx"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421AC3F077E;
	Fri, 20 Mar 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035069; cv=none; b=aqp+wj9cOynX5I0Y9hyp5eq+NzeBbWfYJpw9TPwr359LbVTeoIuvv/CcSMR+ce9tA87TMQcR3CipnDtInT30pgGoKDwARtjPx5IxZ5Mz2VISBa5PaxOyoVhs0832kESCbBpUD8WF07L9mfJfcSpanaEvDAf6/Y+Th4b3DcHxlvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035069; c=relaxed/simple;
	bh=wUFBbt8p9qSJgvvtK72uqiY1FChedImvcX2ezM1uS3I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MSy9HzqATkFSM1Afk0BS2qKyLPY5r15UV+Q4JkeLVe+h5g4E6a1tSr/QmDcLlmQ6oYj5N66017VhFPvwyjefKPWtP++3AOz5qYYV6wwy/VNzHQaINWM5ZB1obsujwdf+mLgOKgKgLKgX1HXPEnIc8mE4X6NxywpXD1XNMciXcH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7NxU6tP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IpnhCvBx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Mar 2026 19:31:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774035066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TI5+lqqq0Exxk6ajvVWXnUxVykRsPkkMe++QEp0zTQA=;
	b=Z7NxU6tPFFEZDrcar/t1n1mHSXW/OYgjNbM9nUCiwUzP2logIgQcr01ENkmqaoWmXQYWSw
	bSzqh6EqQ8H9bo/cdOKjVtdJUAXAL9W+C6CyP/wsWJZ3HG4bE2P6iTgUwk77UnN/jzFFHn
	oGf6tiRWkdji52v5c/Nvjs1j2HSCuRD2iI35kCB2IyqedErotrzVaToSS9vTyGB19fJ5ca
	7nwDPCl84hrOEuOiUjLRKF2RzoAWUulCEv0q6horYqXYKDLPGGDNpEu3ON1csL+bFHMtxt
	vscU8Xeuy9IcToLLvEuF0JGlhpRXN2zcWxYyX3pRmrf4TrlKQRFvA85J6y2XYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774035066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TI5+lqqq0Exxk6ajvVWXnUxVykRsPkkMe++QEp0zTQA=;
	b=IpnhCvBxwLMNe4fzaclGwg6+jF+Bv6gWDEY0ybvAhhRKq9Pr/X4juEJynY3Z0ioEsuSBeh
	IoGUmoAhAuC7DlBQ==
From: "tip-bot2 for Kyle Meyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Handle deconfigured sockets
Cc: Kyle Meyer <kyle.meyer@hpe.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ab2BmGL0ehVkkjKk@hpe.com>
References: <ab2BmGL0ehVkkjKk@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177403506478.1647592.16874302286474436327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227608-lists,stable=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: A62982E0255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1f6aa5bbf1d0f81a8a2aafc16136e7dd9a609ff3
Gitweb:        https://git.kernel.org/tip/1f6aa5bbf1d0f81a8a2aafc16136e7dd9a6=
09ff3
Author:        Kyle Meyer <kyle.meyer@hpe.com>
AuthorDate:    Fri, 20 Mar 2026 12:19:20 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Mar 2026 19:01:03 +01:00

x86/platform/uv: Handle deconfigured sockets

When a socket is deconfigured, it's mapped to SOCK_EMPTY (0xffff). This causes
a panic while allocating UV hub info structures.

Fix this by using NUMA_NO_NODE, allowing UV hub info structures to be
allocated on valid nodes.

Fixes: 8a50c5851927 ("x86/platform/uv: UV support for sub-NUMA clustering")
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ab2BmGL0ehVkkjKk@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic=
_uv_x.c
index 15209f2..42568ce 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1708,8 +1708,22 @@ static void __init uv_system_init_hub(void)
 		struct uv_hub_info_s *new_hub;
=20
 		/* Allocate & fill new per hub info list */
-		new_hub =3D (bid =3D=3D 0) ?  &uv_hub_info_node0
-			: kzalloc_node(bytes, GFP_KERNEL, uv_blade_to_node(bid));
+		if (bid =3D=3D 0) {
+			new_hub =3D &uv_hub_info_node0;
+		} else {
+			int nid;
+
+			/*
+			 * Deconfigured sockets are mapped to SOCK_EMPTY. Use
+			 * NUMA_NO_NODE to allocate on a valid node.
+			 */
+			nid =3D uv_blade_to_node(bid);
+			if (nid =3D=3D SOCK_EMPTY)
+				nid =3D NUMA_NO_NODE;
+
+			new_hub =3D kzalloc_node(bytes, GFP_KERNEL, nid);
+		}
+
 		if (WARN_ON_ONCE(!new_hub)) {
 			/* do not kfree() bid 0, which is statically allocated */
 			while (--bid > 0)

