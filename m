Return-Path: <stable+bounces-236054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B0UKIvn3GmUYAkAu9opvQ
	(envelope-from <stable+bounces-236054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC03EC3DE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17F79306B0BF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C2F3C8724;
	Mon, 13 Apr 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UD/d/nP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98B3C8707
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084649; cv=none; b=VJ7GZViWQT+AgrUNeCWnErgZkUHpcfHeulfMcRVhp0yfnLexRtRM5dgENRfjnbgjhJl0JPHVNTWlC7jADKtq8d3hN0iqd+mjp5Vr+Txt+W2sgbwPLNc/KKyAXK5UmCCQYm2zSalao+Oblj/GfeVcCoUUjoRstOAPyKughim31no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084649; c=relaxed/simple;
	bh=ZgfHEjIA6eh9lX00CTQ3lbMgJ+RFC6PMLmZCd3DZd24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IieoUlWvdw5j+rmemorUBfEZ6J0trgZiAR9Bbu6gfzEhuff/fe+kIpyK1M5znNX0g18fZeXddBMv2GhoN2zeKg7cN8vZg2kXKjC73A+zDanZCdZytfa6yMRmseQhUo9ALxmc9N1K0VSho/zaWNQ/sTlDmw5z3UWPZhiv8KQ0DMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UD/d/nP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD4AC2BCB4;
	Mon, 13 Apr 2026 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776084649;
	bh=ZgfHEjIA6eh9lX00CTQ3lbMgJ+RFC6PMLmZCd3DZd24=;
	h=Subject:To:Cc:From:Date:From;
	b=UD/d/nP3XryiBT3C4eMq/Kv2cyGl8sFnC15Awcp/o8q3P0yEyZtGZLwDTXhEwz/Vl
	 ID6sXHszeqdUaVSm/NH2NuMA+NhVuasPINegNqu9ExMfz6TPO/K/chlnGuD+UCJEsn
	 PRito97C0zscbivIOXoKwbpPAYdbKw6xD89a9joo=
Subject: FAILED: patch "[PATCH] rxrpc: Fix anonymous key handling" failed to apply to 5.10-stable tree
To: dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:30:12 +0200
Message-ID: <2026041312-iphone-tattoo-12b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236054-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,sashiko.dev:url,msgid.link:url,auristor.com:email]
X-Rspamd-Queue-Id: EBFC03EC3DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6a59d84b4fc2f27f7b40e348506cc686712e260b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041312-iphone-tattoo-12b6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a59d84b4fc2f27f7b40e348506cc686712e260b Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 8 Apr 2026 13:12:31 +0100
Subject: [PATCH] rxrpc: Fix anonymous key handling

In rxrpc_new_client_call_for_sendmsg(), a key with no payload is meant to
be substituted for a NULL key pointer, but the variable this is done with
is subsequently not used.

Fix this by using "key" rather than "rx->key" when filling in the
connection parameters.

Note that this only affects direct use of AF_RXRPC; the kAFS filesystem
doesn't use sendmsg() directly and so bypasses the issue.  Further,
AF_RXRPC passes a NULL key in if no key is set, so using an anonymous key
in that manner works.  Since this hasn't been noticed to this point, it
might be better just to remove the "key" variable and the code that sets it
- and, arguably, rxrpc_init_client_call_security() would be a better place
to handle it.

Fixes: 19ffa01c9c45 ("rxrpc: Use structs to hold connection params and protocol info")
Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-4-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 04f9c5f2dc24..c35de4fd75e3 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -637,7 +637,7 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 	memset(&cp, 0, sizeof(cp));
 	cp.local		= rx->local;
 	cp.peer			= peer;
-	cp.key			= rx->key;
+	cp.key			= key;
 	cp.security_level	= rx->min_sec_level;
 	cp.exclusive		= rx->exclusive | p->exclusive;
 	cp.upgrade		= p->upgrade;


