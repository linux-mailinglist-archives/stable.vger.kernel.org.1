Return-Path: <stable+bounces-244703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE7ZMXyg/WmwgQAAu9opvQ
	(envelope-from <stable+bounces-244703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:36:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FB44F3C7A
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5B9E3042029
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77537B02D;
	Fri,  8 May 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SooMpmud"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD3260580
	for <stable@vger.kernel.org>; Fri,  8 May 2026 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229342; cv=none; b=ctyxVul7gH2yBcn9WYzRGvonSB3PC/IP5EXtCEH/Sux+tBC3qhz052NkHRY4e2g3Xhz6lBh2X23FpfigSjsJia9/mK627Z39OecjX7x7sOePKsM16cyKiMcaKjJZbgq6bfe1IoKo9vHLD6stoD4VOGw0xj+YaHKflfxeQriDsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229342; c=relaxed/simple;
	bh=mQ4s1yNfkNIo5BYv3KkF6YlxRkW5CSfBYmT1zCqbEBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8NshMFjXx6dx9heJ9TeOHNI7GKLFL74fF7K7Mp/76HKawW5Id3xuSw85OVlA7tDTuAGe7WIgId3+hxudxIhlSZlvw61Th8CdbEs9Ze+Rgx0ZJVY7h5qrYZ1nrW0IovgN8/nvh9c9KIlG715VYrVQ+aTDijasRKN2IKfU7zntOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SooMpmud; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778229201;
	bh=U2jkwxpA8Z1G/bUSV2gwxNH1q6O6APjULP/vuGhul94=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SooMpmudkS8llurKkboQwuBBx4SOdoR8HENfHwrxAb5BusQC8dLg+5QMiF2tfZQlM
	 F47wTEUFmlTKty4wPw1LiXWFE1K7mvPYAoJZRCmcJwNcS+8eFdBJ6D9y7u6noA5FOS
	 XgRlKUfYKQ7kLj1bGi7DR2xCxH/Wu2FxlPcsxeKU=
X-QQ-mid: zesmtpip4t1778229179te68d7057
X-QQ-Originating-IP: I2KMRu8M27PXzmcHh9SDiKdtc9lsaSgoE3VQww/+750=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 May 2026 16:32:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15676537172005226610
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: dhowells@redhat.com,
	horms@kernel.org,
	jaltman@auristor.com,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	stable@kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH RFC 6.6] rxrpc: Fix potential UAF after skb_unshare() failure
Date: Fri,  8 May 2026 16:31:42 +0800
Message-Id: <20260508083142.1752208-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260503143317.1089945-1-sashal@kernel.org>
References: <20260503143317.1089945-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MJwQnWntXQ1vhzX+uxzl4j4Mez7SQx7MNgZWDx4SBYY2hSWz7QEkKxs2
	GMHSXxEhz4WH/NwyQDn8yn1l87XNJ4pA+Yl0NnAdOmJflS9Gcp/3zZNB1pZ60srracTaByp
	k5NHG+h94lJp8Olexv9eGcQsNLg/z8mbgQEcleRY+R8xPd/k5s9RPAU+jNr90ELJB4nBl8y
	0NNR2CPPRNWw3ErTRXx49glK6ZEucx6AnU4AoVp97N79lrTb3FMMKBoDqK955/yZ9CgY/kU
	s4Mu2OZem+BcZ2FGFiW6kUaqwTbQ6Z3HAslkfIWRHJHq4MnYAlTGf9Ol/iD9YJNOioQD3B4
	NrXkfe88WCklmFq7jwH31NRWCueKap3nTB0Vnf4mWQOHfBysmHYCosEh8LhHvo0JiswrvXl
	B8Aefih7aePaWvi6fDe3Jfyjh0wD/3mrtyyashSWV9DgoM1C9eF7JLV515psM7cTirG/nD5
	9XD7OZYaL0yqDgPkSRYdDI0fDDuhfN6y2ea3GrsCg7EFLy7DcpZnY16FqWK7YyfHHTPPOFZ
	EQL8U7QkwtwdfkuJNuu91jf1mnjrLwEnwkZnTBCqAahpw0UjW97fb0Sj3CE0NI1oLXh4MSP
	EFve984sBLEoYQWHLbiBpAGGey9vHR4hRSxhs3XOaR21aJrCUmioePdURWjrPVRF9gOh56f
	ksydMD+6y7447V4x4x7zJ09EGwImVcUzduQWNOQZjwB7BCeUuJKqCCvxLuXA7WAwgcUdpav
	zOupOxkvhiAN3BAqLebl67TmfWd6PN61MfHevjo5Z5jScWVrqO8t4pcgjbb4isKNxGjNJFy
	fVhd16ew4LaI1i99o8j5vCGJo7ydT0MltVatxxpMIxawBHVEBLk2xu1io/loeHoTt3+LOJi
	6hZ7KUYpqaFo6T+rnu3m70ZNWKqPU+nvQfbS2M8bBv6+aaoyF8r5mKcJTb+ZJ8/cufOByk1
	klcWUtBIrJ3Xs6c5qVgzTFZb2baw1VEXjYQzuQMfxpGHIdcwUFU5eswPYi6gbVhn7/oY2u+
	1h2phsu7zbOZLJh6329n5HM+7jeIFjxeZiKt9OLjx35vsPhguDxVc30KzrK9g=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 48FB44F3C7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244703-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,sashiko.dev:url]
X-Rspamd-Action: no action

From: David Howells <dhowells@redhat.com>

[ Upstream commit 1f2740150f904bfa60e4bad74d65add3ccb5e7f8 ]

If skb_unshare() fails to unshare a packet due to allocation failure in
rxrpc_input_packet(), the skb pointer in the parent (rxrpc_io_thread())
will be NULL'd out.  This will likely cause the call to
trace_rxrpc_rx_done() to oops.

Fix this by moving the unsharing down to where rxrpc_input_call_event()
calls rxrpc_input_call_packet().  There are a number of places prior to
that where we ignore DATA packets for a variety of reasons (such as the
call already being complete) for which an unshare is then avoided.

And with that, rxrpc_input_packet() doesn't need to take a pointer to the
pointer to the packet, so change that to just a pointer.

Fixes: 2d1faf7a0ca3 ("rxrpc: Simplify skbuff accounting in receive path")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260422161438.2593376-4-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Relocated the unshare/skb_copy block from rxrpc_input_call_event()'s rx_queue dequeue loop to existing `if (skb) rxrpc_input_call_packet()` site, and substituted rxrpc_skb_put_call_rx with rxrpc_skb_put_input. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Readd rxrpc_skb_put_response_copy() or will cause a build fail with commit 24481a7f5733 ("rxrpc: Fix conn-level packet handling to unshare RESPONSE packets") ]
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog:
add rxrpc_skb_put_response_copy to include/trace/events/rxrpc.h
to fix the build err if bring the upstream commit
24481a7f5733 ("rxrpc: Fix conn-level packet handling to unshare RESPONSE packets")

---
---
 include/trace/events/rxrpc.h |  4 ++--
 net/rxrpc/ar-internal.h      |  1 -
 net/rxrpc/call_event.c       | 23 +++++++++++++++++++++--
 net/rxrpc/io_thread.c        | 24 ++----------------------
 net/rxrpc/skbuff.c           |  9 ---------
 5 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 539801f8ee282..f0560087637ed 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -126,8 +126,6 @@
 	E_(rxrpc_call_poke_timer_now,		"Timer-now")
 
 #define rxrpc_skb_traces \
-	EM(rxrpc_skb_eaten_by_unshare,		"ETN unshare  ") \
-	EM(rxrpc_skb_eaten_by_unshare_nomem,	"ETN unshar-nm") \
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
 	EM(rxrpc_skb_get_last_nack,		"GET last-nack") \
@@ -146,12 +144,14 @@
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
 	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
+	EM(rxrpc_skb_put_response_copy,		"PUT resp-cpy ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
 	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
 	EM(rxrpc_skb_see_recvmsg,		"SEE recvmsg  ") \
 	EM(rxrpc_skb_see_reject,		"SEE reject   ") \
 	EM(rxrpc_skb_see_rotate,		"SEE rotate   ") \
+	EM(rxrpc_skb_see_unshare_nomem,		"SEE unshar-nm") \
 	E_(rxrpc_skb_see_version,		"SEE version  ")
 
 #define rxrpc_local_traces \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index f4512761f572d..1db479f3d6d3c 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1269,7 +1269,6 @@ int rxrpc_server_keyring(struct rxrpc_sock *, sockptr_t, int);
 void rxrpc_kernel_data_consumed(struct rxrpc_call *, struct sk_buff *);
 void rxrpc_new_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_see_skb(struct sk_buff *, enum rxrpc_skb_trace);
-void rxrpc_eaten_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_get_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_free_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_purge_queue(struct sk_buff_head *);
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 0f78544d043be..c8a4a4c979eb6 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -456,8 +456,27 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		resend = true;
 	}
 
-	if (skb)
-		rxrpc_input_call_packet(call, skb);
+	if (skb) {
+		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+		if (sp->hdr.securityIndex != 0 && skb_cloned(skb)) {
+			/* Unshare the packet so that it can be modified by
+			 * in-place decryption.
+			 */
+			struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
+
+			if (nskb) {
+				rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
+				rxrpc_input_call_packet(call, nskb);
+				rxrpc_free_skb(nskb, rxrpc_skb_put_input);
+			} else {
+				/* OOM - Drop the packet. */
+				rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
+			}
+		} else {
+			rxrpc_input_call_packet(call, skb);
+		}
+	}
 
 	rxrpc_transmit_some_data(call);
 
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 0491f2bbf61e0..f542eda13ff0b 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -167,13 +167,12 @@ static bool rxrpc_extract_abort(struct sk_buff *skb)
 /*
  * Process packets received on the local endpoint
  */
-static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
+static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff *skb)
 {
 	struct rxrpc_connection *conn;
 	struct sockaddr_rxrpc peer_srx;
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_peer *peer = NULL;
-	struct sk_buff *skb = *_skb;
 	bool ret = false;
 
 	skb_pull(skb, sizeof(struct udphdr));
@@ -219,25 +218,6 @@ static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
 			return rxrpc_bad_message(skb, rxrpc_badmsg_zero_call);
 		if (sp->hdr.seq == 0)
 			return rxrpc_bad_message(skb, rxrpc_badmsg_zero_seq);
-
-		/* Unshare the packet so that it can be modified for in-place
-		 * decryption.
-		 */
-		if (sp->hdr.securityIndex != 0) {
-			skb = skb_unshare(skb, GFP_ATOMIC);
-			if (!skb) {
-				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare_nomem);
-				*_skb = NULL;
-				return just_discard;
-			}
-
-			if (skb != *_skb) {
-				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare);
-				*_skb = skb;
-				rxrpc_new_skb(skb, rxrpc_skb_new_unshared);
-				sp = rxrpc_skb(skb);
-			}
-		}
 		break;
 
 	case RXRPC_PACKET_TYPE_CHALLENGE:
@@ -479,7 +459,7 @@ int rxrpc_io_thread(void *data)
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
 				skb->priority = 0;
-				if (!rxrpc_input_packet(local, &skb))
+				if (!rxrpc_input_packet(local, skb))
 					rxrpc_reject_packet(local, skb);
 				trace_rxrpc_rx_done(skb->mark, skb->priority);
 				rxrpc_free_skb(skb, rxrpc_skb_put_input);
diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index 3bcd6ee803960..e2169d1a14b5f 100644
--- a/net/rxrpc/skbuff.c
+++ b/net/rxrpc/skbuff.c
@@ -46,15 +46,6 @@ void rxrpc_get_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
 	skb_get(skb);
 }
 
-/*
- * Note the dropping of a ref on a socket buffer by the core.
- */
-void rxrpc_eaten_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
-{
-	int n = atomic_inc_return(&rxrpc_n_rx_skbs);
-	trace_rxrpc_skb(skb, 0, n, why);
-}
-
 /*
  * Note the destruction of a socket buffer.
  */
-- 
2.30.2


