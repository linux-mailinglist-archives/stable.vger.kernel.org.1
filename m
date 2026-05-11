Return-Path: <stable+bounces-245118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFkMDEmIAWpscgEAu9opvQ
	(envelope-from <stable+bounces-245118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:42:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B80905096C5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD0F830A9F0E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E881386C2A;
	Mon, 11 May 2026 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="C4VITw3J"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47738644D
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484580; cv=none; b=AgXuSzDbsJc7/aPfonrb1l0Sg9p/EZyFj+MpqX+eoBznW0+kA0UnIU9x+QMvEhIOmsCBtTaytJ4LaKB2z+Mir1B1rAGHFPkfTBhFiCPTuJRusIBvMRUbdv8/ZKPp1G/6iB5vJr/d/sOv0Kt4ZEtSKPTjYxgsM+II/DJFNv9Y2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484580; c=relaxed/simple;
	bh=JXrjneuAn9Ae5z9sA4iVxdOSO9XmIRCu7o5Oyyd6wpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkIOMS2blx1Bt9Kk/1O3ULZRk9Rl1JIRxNnFpq0o6gWD0OUSfusZsNfuRztV9gqSkDoYNbyE88P+SiOJCJre29AiAqvypvERFj1u4tZ0S2QOPW/XTuzgKhPGvX8SRUaOwcNQHhrGBMsrZQHMq/koREPE+oP4Jkv6TnKsa2y62XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=C4VITw3J; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778484567;
	bh=yoH0m259h+tujdU2Bt2+9g3IC7ckgCztEcIwiTPYCHM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=C4VITw3JZVLP+rfTO8PqfIhGZHa4IfrS9VJrd0vzSNFb7Vrz5/CT/uXMFwczDksnr
	 ZA1IBOv05cevUPMrMZjW6ipqCE7QNGbOKaLASbMhBOsgNbGquR4AmcukQOxsbMSrPT
	 jbQibddmVGvVnbK92PUlTLW3QPbhI7KDhIbtph9Q=
X-QQ-mid: zesmtpip4t1778484550t03e567c1
X-QQ-Originating-IP: 9m5JFEQrOW3DInwB2GsIVcgRmfq3gYDRrSdjs3GmsCk=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 15:29:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2619856663150363017
EX-QQ-RecipientCnt: 13
From: Wentao Guan <guanwentao@uniontech.com>
To: guanwentao@uniontech.com
Cc: dhowells@redhat.com,
	gregkh@linuxfoundation.org,
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
Subject: [PATCH 6.12 v2 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Mon, 11 May 2026 15:27:51 +0800
Message-Id: <20260511072751.55056-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260511071833.44144-2-guanwentao@uniontech.com>
References: <20260511071833.44144-2-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MQjKSzVfaU5nkmgK0F7O5vyLdbwlobGrDJ6c++vOoC8f3tUGhk6tuY4j
	dRYwRx7QanUoPLY3sjRi34VhyN78PLP0IxZw2F7KkEy/eL1QZAAm8CmEm3LtLidoXBVXG2A
	kJpa3665xyCfHignGEfD3QXlYKOdCcya4hsqKiOqUcOooHZyZQz3j3m9CGHdW/ElJia7/OX
	fsle+fdbp+y4SepEZWZ/IU6YpYz1QIZwxiC3CQnoZ6mVZVOYYhncrkQxNrmn6f0CLr38K0P
	/rFyQySeWFspYYh7cguMwTyri54faR3FhKTA4tj7b6sJ0GMUCjm41bqEXmSeF9wFFOH3HbH
	jTwVWN0WQDP01Y/xXz/ZtNpaeaIlI2KqZgAcl20+BMoEL3NRp2632Z9+IM/A8eX4V1S3Jr9
	mK7ivGe5hjqohkoo7y09CD/f6g+iCS18MYhEvoZkZNg8IzyrMB4UXM8HOgwDPYGgvS7RHQc
	bBkuSa7uF/Fody6inwcjUlTB7wHbDThFpHcBky31bgKhXYG6Q9wHv2F1cRQwNGJ/e4GPa4h
	Qw4tt+HzbKui8FCe2PCK8uKjMf2GSOQoaF0le7BpnC6fQGWSssoBs0MQGmK/fHzzW+DTez0
	RPu3Ysm3xeOHa3WEEI6UcczsOnA+Yqd2Lo4wWoWB5gMBIWfUGEFEnZUt76WSKaByF/iuzH4
	sFgoem8C4JpwGh+VIC+roDyzvz3eGCw6T9Gwr2yvQyaICVuzOv9CGCEDJghWOG1E4YSodoY
	VRe9SHbA+gaeul2vgeCHvLuoJ9/fwNS/wKQlbMUhoMv+T1ocGStRTA8cEHg0rD6SJtyqaG9
	0t9LFQCpcjQHgM/i2iQuuqqVG4HIp4Z30KA18SvmsXLDKdu5h1nzKg6/pQfT+0Bt8nZTcMg
	QMyXveNswzAbtFU74eg0B2zQW8Hp3jdLtSptwDtDpOKzMxF49dkZcFN8580ZX/J3y6VyarK
	Ou7aVNL7XavpNDEdmVfUfEkaUkC5d2ixn98hol+f1da4do3lZHMhIxCGGqCdJcEOzXz+yIj
	GyoFKnQZtc/aJnTUMvepNPxpfXHCT17kBBs+ihMQZt4QokHM23JrPNC0cCjkrsXdQEinarr
	0CLdKYZfhS1UJBpTsul/s8Bk8qNm4Np5Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: B80905096C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linuxfoundation.org,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,auristor.com,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245118-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,msgid.link:url,auristor.com:email]
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
index 9377acad0c5f9..e42ead95362ae 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -146,6 +146,7 @@
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
 	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
+	EM(rxrpc_skb_put_response,		"PUT resp-cpy ") \
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


