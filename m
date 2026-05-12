Return-Path: <stable+bounces-245821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI+EDOdOA2r63gEAu9opvQ
	(envelope-from <stable+bounces-245821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:01:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64E524447
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6374F324E406
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC16397AE5;
	Tue, 12 May 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OXbrSzT/"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DF37F013
	for <stable@vger.kernel.org>; Tue, 12 May 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599450; cv=none; b=TT3TuSBRGX2iMVG6g11kaVl7BQAHVWA3Z0CKFFgnWyDa6880AOyaaPjrqTzfYF2sbF+PhaYVO8TkOzFJL4Hkj04l7D4U3UPfroMPO7OtJtKw387U4VZknzOpsbOdMOMgEsVIGJRRVJJEfBLNEtPYsVI6++KT2BZZp3hPu9ZK9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599450; c=relaxed/simple;
	bh=8y19u6FKlRbA6wsMtRmivz22hpsvlnBv/p4vL+2GZBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skMfJ+zYJB9uZzhR7rQj4jJe5rsL4IXRBSHLNotYIgnmifYY64JWEfq+uWiH6JkyvvCHzo8eLJn/2auKe2SLOlPvdxfbR9zRWYgPP4Wka0dm34dlvfOviQJUY7EoF04XzJprBXbqDCz044unAgTdW6GNlTCjrEk/LsQ21AD9Cd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OXbrSzT/; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778599416;
	bh=eJIrDBEiN/WHqqggFZF3AEfa0jcMkPYDQtskv/U5iUs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OXbrSzT/xQKBUaKJI5/WDDHlLJEf8/21zijMdK70FuJyFazWMwZm4iq5MRfvNmYHg
	 /XtRzB9ZckZ2PXOk3n73GsjDTzy+BYnG6rD6cRswvffPsHIcxeDtq1uOyJuijntxYA
	 upk4pG2Vc4J3v11eROWRYS17xrC9GAihblaWldOc=
X-QQ-mid: zesmtpip2t1778599400t27bface2
X-QQ-Originating-IP: JwC/Ft5Jc/flr2t6ILPYOazJEbGsAOtrAdqCN004r8c=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 May 2026 23:23:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8356190642930684226
EX-QQ-RecipientCnt: 13
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Tue, 12 May 2026 23:21:59 +0800
Message-Id: <20260512152159.90879-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MirVMgCRub9oiVTOxdnezf6sZXnAR4ZcBzu55oQJkemNRe81Anowcbau
	+f5J37v35DX0cQ0JH6tfZse7GuvwpfxH1Koqp/9kpOCiuMGWGwk8JLr5oHHAzCuObEMNO+j
	86f3mO8KOgvUOpzuBlySikGNAFn4qynaHNVk5WRRWYgtraB6NtYbcBX/MVgL9xn8csl2Q33
	zpeCzJCTNdhPFQ6fqg6GS5ND+fK/012Po2Yegib3i3My846Vfzr3XiFgz+AaS3V0EzbqI+o
	izRvVIxf2zpZONZ/VzN4bROIULXH8yJZx0cG3LupVjlrbZTwT2n91Btap52CQJCG7hvkXyZ
	loOsZJPcuRDOK+VeI4j2YgWXqlCkXqbv0HSw3R/eNUJ0iwcNkpL0DmZy6cLO/E6XCYtGG52
	s2LH5vMt62KHF8i+4fUoeDoHSSWjLGw/0M2e52Nv66lbnElYJ/bh9Khme3tKVSqpO5b9oCP
	Agvc6TzsOU/kKUcks7HNNfVs7UOVrHJAmhclvs9fl5UJpSkFCly63rqW/EgdnVMq3CrFQu6
	pSy/PpZFlis2GNJUBVJUZCcK64q9ZP/6h9pRH+qLy8xmqN/kS3X7erSNaM8k9T/ot14Ru68
	cPuopO2tm53yG0z1tRvO0RTxPWG29XW9N58LO1LQeWAFhCgqFuj/G5bXAJllBCPesUSMefH
	89DVBznvXOenRPLwgusNT7Rqd8YkWcmsBW2DvATtriGQw55qDyVzoIO53jf170MK3IxgiQ8
	ykHVu6I8XUYt3w/PZZ+QpmQIBMkl6nNhe6uFfpY4W/WPaXPqoSAzKJEER6abD4XBZ9g4Kf4
	sAB6j+4fOgL0ntPWkfpjZuKGwDNzBBKTKuSwnFtazU0BaSW6YFswgWsrs1M6mTfstB2DwpV
	J+aQJsEOkV2u1vGQcvTki87hfT9U0tWkXWf1pgO8rxV/3NgdsMx56/6th03oG/FGQzZQX1S
	MKfJzYv/2NOhjf/JsANDGg5Ps8D+Y/BMf5TnjUsKi/47+zf9dS9/ZTqyFng7xEIgIbxnDR0
	v4sYJDILZEUfKMRjnK2RmWQSuyQCpBuq8fEysg7ildD0OCvu7cKuU0K+QTnPuRZphjoqWwU
	b5GGp43XHQAYuDXziKVFKp/xRSESXJ9ZgLVz8U8JZJoKiJw1/srjvIBB3S5oayk7E+UYnn/
	HlbQGm7GdJxqHxEF++97BBYz/A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: AB64E524447
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[infradead.org:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-245821-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,auristor.com,kernel.org,lists.infradead.org,uniontech.com];
	NEURAL_HAM(-0.00)[-0.999];
	RSPAMD_EMAILBL_FAIL(0.00)[dhowells.redhat.com:server fail];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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


