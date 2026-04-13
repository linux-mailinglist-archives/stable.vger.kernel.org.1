Return-Path: <stable+bounces-236445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOGgIwMa3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B51AF3EF16E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 552663052413
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C64A309DB5;
	Mon, 13 Apr 2026 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QY6+iQx6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1327280A;
	Mon, 13 Apr 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096923; cv=none; b=FvhkePdnRAGITMT9VIngClpLQCSlNzK4t72IRmXfH/mTmhgdYgUBZz1jJ/A7zpGajRPwp8dRPQDav5jDEbxL64CBS12co8E9pK+VMdLglLawdENfpeIsUhCUAelmHZbGQP+Cv3tYc1CKWBbSkdDPL+7f+S5nGXGPdMUq08zzPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096923; c=relaxed/simple;
	bh=TuoigOs+0z2n5917aZI5JZqh3NcQqDQMAgnEcLXp3j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/J02q++In9JK+7ThHi1MTnYrRP3mJXkEDWB5ayZSGx52hH997i6WlrIQQjqrmbd0eNQ3vSaGJCQY5HdHMMO63tUwEr2YwzP2LNJziZkZy60ABeICWV6MsjMM6GNDoBl/S73XikX1sCDD9l4qugCJttX2pJGkYeOdTiFmbVyFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QY6+iQx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A25C2BCAF;
	Mon, 13 Apr 2026 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096923;
	bh=TuoigOs+0z2n5917aZI5JZqh3NcQqDQMAgnEcLXp3j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QY6+iQx6uP78DKEHHrBOVybDdyHe1VbwkVjwDCjzsU6Jw3SqhFVdtDYd6rHwBqGhX
	 vMM/YTaeSp+t89rVR6GqJgq4rzN3KkQQuxQQskUNfSXBGWtDOdSx5zEVrS5DeJ+51D
	 0877QJaCJl5NL+M/I3XQ1Yqc9TDPsa9ts0PQxwqE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Douya Le <ldy3087146292@gmail.com>,
	Yuan Tan <tanyuan98@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 45/50] rxrpc: Only put the call ref if one was acquired
Date: Mon, 13 Apr 2026 18:01:12 +0200
Message-ID: <20260413155726.192289562@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236445-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,auristor.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,lzu.edu.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: B51AF3EF16E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douya Le <ldy3087146292@gmail.com>

commit 6331f1b24a3e85465f6454e003a3e6c22005a5c5 upstream.

rxrpc_input_packet_on_conn() can process a to-client packet after the
current client call on the channel has already been torn down.  In that
case chan->call is NULL, rxrpc_try_get_call() returns NULL and there is
no reference to drop.

The client-side implicit-end error path does not account for that and
unconditionally calls rxrpc_put_call().  This turns a protocol error
path into a kernel crash instead of rejecting the packet.

Only drop the call reference if one was actually acquired.  Keep the
existing protocol error handling unchanged.

Fixes: 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and local processor work")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Co-developed-by: Yuan Tan <tanyuan98@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-11-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/io_thread.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -389,7 +389,8 @@ static int rxrpc_input_packet_on_conn(st
 
 	if (sp->hdr.callNumber > chan->call_id) {
 		if (rxrpc_to_client(sp)) {
-			rxrpc_put_call(call, rxrpc_call_put_input);
+			if (call)
+				rxrpc_put_call(call, rxrpc_call_put_input);
 			return rxrpc_protocol_error(skb,
 						    rxrpc_eproto_unexpected_implicit_end);
 		}



