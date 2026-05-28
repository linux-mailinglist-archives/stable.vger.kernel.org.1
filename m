Return-Path: <stable+bounces-255170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAWQCyyeGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 984A05F7839
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A31E3028379
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19782330B2D;
	Thu, 28 May 2026 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l4BNFB6F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50433F5B4;
	Thu, 28 May 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998161; cv=none; b=lTARPaUXgCt/Izq7LKdTly5Tp8kqSQ/fWL6jBcUtuCT1FCAT0iQ+W6vRe6wzImeeRSbh0/vTdAuIPGlAFBkoHjV0RwhpM+lSUc0Ve8itc5vSZ9l+w3aq+8xoLPjwGvyC4svCkpk1nnGVtinkeEtpfrkqICPW5e+DJbeAEwG3Q8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998161; c=relaxed/simple;
	bh=IgtkHiNeUmmoiyOjgOLtwdqhKIhPOLULWljEV5S7ADw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ7yf6JxPclqwfgp4h73T9fl4dGVwjN518UKSCpcz6AVhGQrwU2WP7xaDUMBKRtDEaB9NBwmDJhZuXJTzoBs14ALV1LnvDRkQh4lQhDmtZuS9xgqEnK25ChC40xi56PMB9E020U/uSXSi8ghoIjsLufHyq11JyhFjWMYmnSoX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l4BNFB6F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C5A1F00A3C;
	Thu, 28 May 2026 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998160;
	bh=wFHsFa3LVJVcmdUPyyz3PLzbOlVxcz6ahrUv73QfWuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4BNFB6FZz+HLNwUiSVFwbIxTcp/QTQepzEeul64B5KW57mUOQPQMmW4dEclI5Mjo
	 gQ3ygZCww1PTXgs6S8o5XWwgKFk7b9BNtLAXVqlnJ9TsG+AONOZ5GVkKzKuC2ht918
	 p2PK8dzOgWnAEUzUlM/HAf3duNOafRblMfYSu8NU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 074/461] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Thu, 28 May 2026 21:43:23 +0200
Message-ID: <20260528194649.059143043@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255170-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,broadcom.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 984A05F7839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minh Nguyen <minhnguyen.080505@gmail.com>

commit 99e22ddf4edb63dc8382bc028af928056d3450cf upstream.

vmci_transport_recv_connecting_server() returned err = 0 for a peer
RST in its default switch arm:

	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;

That made vmci_transport_recv_listen() skip vsock_remove_pending(),
leaving the pending socket on the listener's pending_links with
sk_state = TCP_CLOSE while destroy: still dropped the explicit
reference taken before schedule_delayed_work().

One second later vsock_pending_work() observed is_pending=true and
performed full cleanup: vsock_remove_pending() then the two trailing
sock_put(sk) calls -- the first reached refcount 0 and __sk_freed
the socket, and the second wrote into the freed object:

  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
  Write of size 4 at addr ffff88800b1cac80 by task kworker
  Workqueue: events vsock_pending_work

Treat peer RST like any other unexpected packet type (err = -EINVAL).
All destroy: arms now return err < 0, so vmci_transport_recv_listen()
removes pending from pending_links synchronously and
vsock_pending_work() takes the is_pending=false / !rejected branch,
dropping only its own work reference.  This also closes the
multi-packet race Sashiko reported on v2: pending is removed from
the list before any subsequent packet can find it.

The pre-existing sk_acceptq_removed() gap on the err < 0 path of
vmci_transport_recv_listen() that Sashiko also noted is not
introduced or changed by this patch.

Tested on lts-6.12.79 with KASAN: 52/100 unpatched -> 0/100 patched.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Acked-by: Bryan Tan <bryan-bt.tan@broadcom.com>
Link: https://patch.msgid.link/20260519102310.237181-1-minhnguyen.080505@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/vmci_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1164,7 +1164,7 @@ vmci_transport_recv_connecting_server(st
 		/* Close and cleanup the connection. */
 		vmci_transport_send_reset(pending, pkt);
 		skerr = EPROTO;
-		err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
+		err = -EINVAL;
 		goto destroy;
 	}
 



