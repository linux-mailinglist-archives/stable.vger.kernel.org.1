Return-Path: <stable+bounces-245144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AlXG5mKAWp4dQEAu9opvQ
	(envelope-from <stable+bounces-245144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:51:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CACFF50998E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4C930465C3
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A4B39D6D6;
	Mon, 11 May 2026 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EcEjiu8q"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A539D6F6
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485394; cv=none; b=KxTwEoB6f2zG7PXnnnoihc1NyrkdR9xpc95hhyYSN3pyUJxqrkwtcamBQAWex+g/74Qj/3CP19yAMQg3k/5qnybpdEyPE5zgEfLn85MfQfwY7bVgkOl+LIhMV4FcdaDmiTyjMDlP9X1qV+aXAzKUkgdf1REuEfimZY5w5sPEc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485394; c=relaxed/simple;
	bh=J0d5KBJlYhb4G+hYPHDCrsWOzCzLKYiXGMM+cG4jJnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAywoBxP9BjYOFnSWD3HqHYKr1QaiCEEmbkr+/JKY89C0VC6dGnewOdOzaNHYbj3SXuMBhkks2CzzXzK+r2bCzUYBghGi32JfICVN5HmblOqg2/itqMk37jqNCBpAWsH+lvxKk9xki14T5qGB+CL0luHaPcBy9QyBwWORmV4m38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EcEjiu8q; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778485362;
	bh=v1KKfYmrUY8b4UQxl1lzM5vF1VMF0m9JO9Tl1UIxiKQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=EcEjiu8qs6yE92aq+F/7U43Bdi6TxniAq63jpd5vp6Z+6s6bjP8UeW2vK5wFTMwa+
	 xA4bnn31yz/s5GpjlxS65Ufi+U1ypzRBuXfFrshxwScEomEKq0sD8NqXjr9nyPtzDE
	 hG5T/mpvwVWo4/IezM8I2WteXUkBPbkM/VwZGzh4=
X-QQ-mid: zesmtpip2t1778485343t275879ae
X-QQ-Originating-IP: v5hs4R2sFMgzUUE2s5UM10LppigihY6NgSZ0AaVPBtY=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 15:42:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7227412292921570934
EX-QQ-RecipientCnt: 13
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	guanwentao@uniontech.com,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y v3 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Mon, 11 May 2026 15:41:04 +0800
Message-Id: <20260511074104.60836-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051132-equity-umbrella-a786@gregkh>
References: <2026051132-equity-umbrella-a786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NVt3aLSv6AKCDI0Tx8poMBlHNyLHLFvyuZ6it7qB3TGQzAnozrJmvaVT
	SeRtc7z/Ug7dKig2sdbsWF0rW5u93LpA/q+xGbzlhz987W6ILAnRRTew/DM8p3izGuWALLL
	qjfxVDFHKl9Qgoqx+CEmO1Eqf7NwsXVyE3hu4rc1AgtmQzOnK2KEQCOgamykplyLQt2kHhM
	SPJns0qDthaLADZqWPlo2XzOVCVdbLhz2oeFqpRsbHhkCyK2OUqPv73cU4Uy4soRlB14znZ
	yUhGpa0ijBbcgvYUkzjPIvWLJFEbhP6tzkwx26NSoYf7YiEXJlwLqmNpZGlKy3iLjLpdGdM
	ngZESGMvn0N01rny0YZhs/zqLemLN1t+WMtShZvqPK7QXSgQpMgYei5r0YAsspTs30YARK9
	OxZKtvbUz0gjhCpTR30S0SRwGsjVaxQRWloS9mF0erFpITwRHx0duvaTy6Kkd8U7n2gjXOs
	JMVJHgnsG4twLw5wxo7Iqoh/5+wwTYgvifKObeegpisyCrl7vBhpuICilfq6dXbpzI6RNSs
	WNzE0+bgOY8sO2CoN63k37s8YKshCIWCHhcu/dCGIXv12uuafMr9uK3Xtw0NnPSdcRgt+v/
	rYNcyR3V271yGYZXvW5MtkBzfRnFk36KFj+XiayCqrv/dB4ZLrcRUDc77JM0VThSRHAI3ho
	DcWWvC2u82gb3mvwa8ztXMjLX7tavYaApCLUeyrYZJB0wqE9+FX+wIvTcOpCGxDDksXOj74
	UzWK02eZTMKehKcpQkq7arCgp0/a7N1z8SvzQw9726uF7hTbEfqxZ82fGP1v7mDiyLbD+Y9
	6mUgAlAHszcZZ5kOsQyT6dGx7iFz33S3FZZ55X3GfstAZ2t96dT5iESAur+iIfmwB+rs03L
	r57bE9YVBh5suU90or+ziVR/pc4YMVht3o27ecwu6xg4e319SgzwsPQ2tne7a1NTe2ElhdN
	M9T+JTaMNlbIY82vjgzcd5fSnB0hZiAzp+mcfk5rKPBG4l00bPkrfGxLYPCaIWbn9paAu3u
	wdAHzfDgZGgV2YRyyIbthYXe7EtBNQbFpTjlEfQNM6Q/wGR9TeGeh1n4aqUnIISF5zKvLlc
	yV2mLcr0IBxi0vvVrTEUBNpgHZM8NpZkcg7c/NlqsaGiCIUxSHO3DZ8pK9Maj09lOeLAelC
	5QVblp0YE1vgI7IEU/2/xu6Ki5Wi2v718sTkJnF9G75bQJ8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: CACFF50998E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,uniontech.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,auristor.com,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245144-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,auristor.com:email,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: David Howells <dhowells@redhat.com>

The security operations that verify the RESPONSE packets decrypt bits of it
in place - however, the sk_buff may be shared with a packet sniffer, which
would lead to the sniffer seeing an apparently corrupt packet (actually
decrypted).

Fix this by handing a copy of the packet off to the specific security
handler if the packet was cloned.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260422161438.2593376-5-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 24481a7f573305706054c59e275371f8d0fe919f)
[Readd rxrpc_skb_put_response_copy which missed in 016725807ce3 in v6.12.86]
Stable-dep-of: aa54b1d27fe0 ("rxrpc: Also unshare DATA/RESPONSE packets when
paged frags are present")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/trace/events/rxrpc.h |  1 +
 net/rxrpc/conn_event.c       | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 9377acad0c5f9..63efc9e4e4102 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -146,6 +146,7 @@
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
 	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
+	EM(rxrpc_skb_put_response_copy,		"PUT resp-cpy ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
 	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 82cc72123c9c9..6dcfaed1f7485 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -226,6 +226,33 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
 		rxrpc_notify_socket(call);
 }
 
+static int rxrpc_verify_response(struct rxrpc_connection *conn,
+				 struct sk_buff *skb)
+{
+	int ret;
+
+	if (skb_cloned(skb)) {
+		/* Copy the packet if shared so that we can do in-place
+		 * decryption.
+		 */
+		struct sk_buff *nskb = skb_copy(skb, GFP_NOFS);
+
+		if (nskb) {
+			rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
+			ret = conn->security->verify_response(conn, nskb);
+			rxrpc_free_skb(nskb, rxrpc_skb_put_response_copy);
+		} else {
+			/* OOM - Drop the packet. */
+			rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
+			ret = -ENOMEM;
+		}
+	} else {
+		ret = conn->security->verify_response(conn, skb);
+	}
+
+	return ret;
+}
+
 /*
  * connection-level Rx packet processor
  */
@@ -253,7 +280,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		}
 		spin_unlock(&conn->state_lock);
 
-		ret = conn->security->verify_response(conn, skb);
+		ret = rxrpc_verify_response(conn, skb);
 		if (ret < 0)
 			return ret;
 
-- 
2.30.2


