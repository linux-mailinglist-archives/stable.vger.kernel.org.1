Return-Path: <stable+bounces-255215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEJ0DXmeGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAFE5F7920
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABA58301F790
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C379733CE8A;
	Thu, 28 May 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zzyU362X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3F330B2D;
	Thu, 28 May 2026 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998284; cv=none; b=ouVvmQQCJWt2REFEm6yrMfS6xSmYPXeKWRZySMOPnkDy1O8jpfFZZuuxR/eSX02UPP0dfR5leBpYE8uUCFiAcjN8gp68mxDfrYpkNzdl4CJOqjcSBKOh2nvG5Z/0WHLmiuQ8+U37pLT1lXnOVu5Eh9MJvNeTNlP5nYFlX6yjVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998284; c=relaxed/simple;
	bh=sRDjgwfXHRXZW42Yy9PWjjmsNt/mDk14Nu26FTSGFyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxN5BE5kjs75NTgsvdRRf9dbBnCGe3ua53wiG/yNO2Nz21Uo49j5y/bV+RSsE29qKFyqlT9mdFMEr9tjwnmdmgvFnrVd3wJfDJm6vAto1muuzzurXl3SsMUTY93nwx2/SrjCWG3MnbBucdHO7NqJzBN3uTTVS2AD9w1yPoAdNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zzyU362X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009DF1F000E9;
	Thu, 28 May 2026 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998283;
	bh=4xfVPEEfF9vYQMn0akKw+TZFfUOgXBJbo/itvGDE2Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zzyU362X2XDvoLvKDhLC6m1fhP+W5vmX6DrJ+1NRAzoZt2eRFb80pJHXVLLEvzIjf
	 GS5S7Mztw+PiOoH5ja5SCjXxbIU51nIbut3diMRUFNSFhF6qZ3mZhiy8gWD4FHykSf
	 SkaXvoLiztcyeMPqBrwqv3MNKZKa33Pp2/BkhpPE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 7.0 083/461] mptcp: do not drop partial packets
Date: Thu, 28 May 2026 21:43:32 +0200
Message-ID: <20260528194649.321344411@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255215-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: BAAFE5F7920
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

commit 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85 upstream.

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data. Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion. Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix has been sent by Paolo Abeni [1], but had
issues [2]: it also added a zero-window check and changed rcv_wnd_sent
initialization, which caused test regressions. This version addresses
only the partial packet handling without modifying receive window
accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.1763075056.git.pabeni@redhat.com [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600 [2]
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[pabeni@redhat.com: update map]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-1-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -397,12 +397,26 @@ static bool __mptcp_move_skb(struct sock
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-	mptcp_drop(sk, skb);
-	return false;
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+				      MPTCP_SKB_CB(skb)->map_seq;
+	msk->bytes_received += copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)



