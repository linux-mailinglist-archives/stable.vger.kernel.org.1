Return-Path: <stable+bounces-245822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ3LCe5OA2r63gEAu9opvQ
	(envelope-from <stable+bounces-245822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:01:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC95524449
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 023FC32879B1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B333ADB9B;
	Tue, 12 May 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fkngVI9S"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFD388876
	for <stable@vger.kernel.org>; Tue, 12 May 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599452; cv=none; b=ip+9JaUBdIE/MmecTcsViKtm+gi4IRV6UcuxqlFwSrGq7RJ7BB2eFhDwOT23AOCSfey2zRe8IN99U2DbDaQFsmVSKLFaXXVxqt4tI0EG7W21K6qbd6CaBEbXYQ5scQD6xDpAtmuYdku24VNxZgEc61cSGp0OrrJbeP8pGy8qsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599452; c=relaxed/simple;
	bh=8y19u6FKlRbA6wsMtRmivz22hpsvlnBv/p4vL+2GZBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CB+WyXusmpDnunxHcP5zNBk1EeE/4C43fjJ+B5Ho/xvYypbH9kkvwswuWR1k2ED/95XaHWcRHIr2AAsGTF+k9PumHWZcNM/MItJ0Xb13Cpf/7Sk7zalVDkd2fdqgcQarBBH90iyVCo6lOgY03Q+Zg7EQIrMlmXy5ZH10X0HJsWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fkngVI9S; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778599372;
	bh=eJIrDBEiN/WHqqggFZF3AEfa0jcMkPYDQtskv/U5iUs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=fkngVI9SLppMX3rETVEBW1w7CAyrwY4W7jI/I0GeZGoDN+NoD9jZngHkxHJYljN3n
	 gNaJ9OpfXfExADk5Ywh4QVO5kkbRw4xwzwK0hdsXx9mkpDBPLTTJ9znl6hxO4wZ5cE
	 OjaYdpVCUTb1PSJ+Rut5pyVbE0w+7SpqEc4p3sGI=
X-QQ-mid: zesmtpip2t1778599367t6bcda2a2
X-QQ-Originating-IP: d46U1eb146fuWLXdj37mpNT3JxZdhyTVfR9bkivw1G4=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 May 2026 23:22:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17977722599249870248
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Tue, 12 May 2026 23:21:23 +0800
Message-Id: <20260512152123.90749-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051113-sponge-uproar-1d30@gregkh>
References: <2026051113-sponge-uproar-1d30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OHMBGvC4grOuYpoPJv1i0QAo8vkO4WaDyF0SL16RmAIZ/hwUVNYWRI33
	Eaph+1KbqZsyel6IYKJOu6IiqtKDVWxBMvTzBp/Zx2dvDEPqpEsMJMb/0xx7uJgarJ5iR+H
	tA/HnoR7VoC3gXWml8bRjOCiM5akevukKCR2+hP8ZF7D8snjOLG0Y6Ci1rvAXp84cJilxSN
	aQPLEf2Yf7UEo8a98XTP3hZl0duncvKbJs75I3i6parGkF5nKq13qXmY/rmp7wv/egvQW9E
	YRz+NRG1ZyqxCpAR7NHUSYFgK3o0067DOOEDwNQmUZpOdSZeUvONn2lPkdicdThQj/OGHTi
	LCxFBeIbdECH2QmvmqI2z8NF2bR7f9MXlmVxLU88CPQDk5+GrQluxRscc8ZkaeksHy6T3TF
	xsKV4GQG7mMlsSzFQGlxQNoRLW7IISu1cgDO8yFXYHHjRxT6ugKjCM6s68UWS81/Etz1mjO
	TNRya33Ne+MTLnbLsh/wWrphP/MDMdszQlAdyF0l8OSPNY9/C8bJfQBWDXuO9x0fAYg6WOL
	txOLnCde1oL+AKIETZLugCJFRV01K4KCBKEkwmIsh/Tvp868PayPxqsR64RTw++q83cYfej
	VXoF16uixku7yjbw0/pGYSNyc0zdULfj5+gzZHwvEqrQhq485fFO8LB0YGeBNDoUW5qB6NJ
	ZiwaxiS+H7YFo/aSTm/2KEBEDfr53Ned2KV9w+UcCim5x2mNLmBFKTak53N8g/0OZhCC6g/
	hn3WWnNI+MRA8Th3B7EZZ6EOJg+/FIpsqthJxRVr32BMnxB0PkLtar04hLL/NOsbzIsaHqE
	nbFBq2FoLfM6poxX2zpWog+qPRKkncy+zjYuZWX2gH0VKi9bTIuVyrXKCO1nLBJpafcb5fo
	BcWRGSV+5jLA/78t5ZhJ2uHDACm0As/4PX5vl0h7sG420iVeS5rAUGK9WzWAh/iwCeeS/Qn
	DFT6YmFSkVx6x6JVtii9CHBxaK6Ho2Sus4UXO0DbChfqV42S0GEINv0woJGvg+ZP05MV/sH
	AqEaB+mI4CoL6uhQjlYUsfobn+gUSr6UsASP/16S5q9rsdzhLhCgIopQxzwEb9u/rSAdLGH
	GjQsboW2ciw
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: BBC95524449
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-245822-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
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
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
NOTE:
Pls apply these pathes after commit in stable queue like:
(HEAD -> for-stable-queue) rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
(refs/patches/for-stable-queue/rxrpc-fix-rxrpc_input_call_event-to-only-unshare-dat.patch)
Subject: rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
---
---
 net/rxrpc/conn_event.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

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


