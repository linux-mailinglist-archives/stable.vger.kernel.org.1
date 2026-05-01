Return-Path: <stable+bounces-242361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFKlMNeW9GnTCgIAu9opvQ
	(envelope-from <stable+bounces-242361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:04:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2084AC2FD
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D687930045AB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593F03890F3;
	Fri,  1 May 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ENxaTMt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4312EAB72
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637065; cv=none; b=eU1dz+h9qNZlxU05xUkl7NOFPjfoluqqe5AWQkgLFpX6z3AGAPHD4kdBASsHJmRzVLYYy1cz6BmOMqi5YNsBNhiZy0yuV2GR3Os7wXgkZdXI2JsF5Q+IfVyOG6Mc4v0iangjrRioDWB9TUct0MQP7pN7+EycsRjw40QU3opffkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637065; c=relaxed/simple;
	bh=xZHtzLQW4Vj8gqdvYw10S9jGuT6AWXwhWEyhqeZ60KA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GDO7EOwh5pMVaXKf/Lzn/jXGJ6EkItBRYiuBgDyUKYH8OKFFcUkXRTE5YKZ3uLdtygRAX7DlART19eHwEIlexUsDK83AJwaShy1gKEFXq8vO+Bg1IloN8Ww2PqLL3mcnlJNa4yNXjF+n/GuAIZ/PS3Y+JhJbCWGB1cIpR6gnZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ENxaTMt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98365C2BCB4;
	Fri,  1 May 2026 12:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777637064;
	bh=xZHtzLQW4Vj8gqdvYw10S9jGuT6AWXwhWEyhqeZ60KA=;
	h=Subject:To:Cc:From:Date:From;
	b=ENxaTMt+/Ot5SnUrNvKKN4HsC0Dg5LryvFFuKnyPlccIseGIgP0f8YhWgAj5Fy76/
	 W8wTivY8Z5Z/eEb+MzyYBE9OPXRIXcvCCFWAAAT3WzvcMCrBVsZerqGZecK1v0aiO4
	 X93O68CDeoeXELRxE6s6VBMniEKS91Apc8NigURw=
Subject: FAILED: patch "[PATCH] rxrpc: Fix rxrpc_input_call_event() to only unshare DATA" failed to apply to 6.1-stable tree
To: dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:04:12 +0200
Message-ID: <2026050112-saffron-unbaked-79f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A2084AC2FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242361-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,auristor.com:email,linuxfoundation.org:dkim,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 55b2984c96c37f909bbfe8851f13152693951382
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050112-saffron-unbaked-79f3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55b2984c96c37f909bbfe8851f13152693951382 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Thu, 23 Apr 2026 21:09:06 +0100
Subject: [PATCH] rxrpc: Fix rxrpc_input_call_event() to only unshare DATA
 packets

Fix rxrpc_input_call_event() to only unshare DATA packets and not ACK,
ABORT, etc..

And with that, rxrpc_input_packet() doesn't need to take a pointer to the
pointer to the packet, so change that to just a pointer.

Fixes: 1f2740150f90 ("rxrpc: Fix potential UAF after skb_unshare() failure")
Closes: https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260423200909.3049438-2-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index cc8f9dfa44e8..fdd683261226 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -332,7 +332,8 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
 
-			if (sp->hdr.securityIndex != 0 &&
+			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
+			    sp->hdr.securityIndex != 0 &&
 			    skb_cloned(skb)) {
 				/* Unshare the packet so that it can be
 				 * modified by in-place decryption.


