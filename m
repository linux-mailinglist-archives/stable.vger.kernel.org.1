Return-Path: <stable+bounces-245107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOcCDIR4AWpGaQEAu9opvQ
	(envelope-from <stable+bounces-245107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:34:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B2C508936
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09BCD30067A2
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B12BE05F;
	Mon, 11 May 2026 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjQkpKpb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE34224AFA;
	Mon, 11 May 2026 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481212; cv=none; b=QpW/Xt5zYvPgkEJSLUUpPfWoZTLD9oYjMgHQKog0FV91lSn4fGZbF9a4/mJi30Ilpqn3gcE8hD+eZ17kQ22flXGNWQk4fzqdlLHEcxBOMs1WCtX/DyWH/Pvbo0JR1uL/P1Q/B6ARr/mjgB7yrqpqsj7JYMWl63D1RwzBkFoktcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481212; c=relaxed/simple;
	bh=d88VkGtRYOyQOPiDaSzYixZfJOitodoWlOouaTm7k8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqQY0AzenGvamL8dgvqBYWzNvPsv7Sag4PbRV5Gj4ufqozYo8MakTEywzeKdO0661msol68XoVMZ8u+PyFpBMiNi/N9DRDjTs1LH4+lCM/RL32r9mV4R1Kz1X5WD9YtByqYha3aAkZ4ihD7zY9f7bwyzm7fox9wuylNfrXo0Lkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjQkpKpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315CDC2BCB0;
	Mon, 11 May 2026 06:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778481211;
	bh=d88VkGtRYOyQOPiDaSzYixZfJOitodoWlOouaTm7k8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjQkpKpb4f6zgUajD7gGkzJx3wY6oSp1js1L7qcJSQ4KuUZpgVhmiAgKyea/VM+Sd
	 +DoWjHutLBEsDRDnagJASEikhDA5r9aXaho0KlZt3KUJNSnZWiVOv8GAtGdk8N2/gN
	 N9TV7M+1ejrk/KAc0eZ/kU2FC+N147lU24XefO5o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.6
Date: Mon, 11 May 2026 08:33:20 +0200
Message-ID: <2026051119-footsie-tribune-2ea3@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051118-daycare-backboard-5683@gregkh>
References: <2026051118-daycare-backboard-5683@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89B2C508936
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245107-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 6694d125285e..dbc380a9339e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 5
+SUBLEVEL = 6
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fdd683261226..2b19b252225e 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -334,7 +334,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 			    sp->hdr.securityIndex != 0 &&
-			    skb_cloned(skb)) {
+			    (skb_cloned(skb) ||
+			     skb_has_frag_list(skb) ||
+			     skb_has_shared_frag(skb))) {
 				/* Unshare the packet so that it can be
 				 * modified by in-place decryption.
 				 */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index a2130d25aaa9..442414d90ba1 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -245,7 +245,8 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
 {
 	int ret;
 
-	if (skb_cloned(skb)) {
+	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
+	    skb_has_shared_frag(skb)) {
 		/* Copy the packet if shared so that we can do in-place
 		 * decryption.
 		 */

