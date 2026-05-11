Return-Path: <stable+bounces-245114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O8uCTaEAWoFcAEAu9opvQ
	(envelope-from <stable+bounces-245114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:24:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC75091A1
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D93ED30038E9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4AF376464;
	Mon, 11 May 2026 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MXDk2doV"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C6375AB2
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484036; cv=none; b=KG9kVWibVXsbX3/FQglIwAZHhzcb7Gqva+Q0ijenV3RVL7LRHhHywSfX7Wd3eVjLWaQ/iiY//UKOpJJ1T29Yz44X9+qOauXvwE/ILRg0Pc4XpR4XMA0Wz3GZAvXz9KBbh4snIe89VTo+txmk1JwBsVY6Ko56BtjYagBfM9vcsfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484036; c=relaxed/simple;
	bh=UK0iln2cnzKnMt3TOTtsLfYTjaEPXAHrq8D/I1M+bok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EH1kzOwPrEPDjekREpSgJ3lw1in05d7fWh1dL+5c0z3hVqKoErqDIqsmjxf47Sb9RIhqtTKYlWnzlo6nfb5QzlhOfWeuMirdwGK5mydkvWegeSzHJmp4JJqhFWjwn0sc2hM4DuxsuyIUFGzmFyygqvqEGdOSTkqCJ/hwmk8nkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MXDk2doV; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778484016;
	bh=z+lFIltDSfPetPBr+/HDujs/jY10aKdoJLjcZAB9tDM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=MXDk2doVUl7bQquVgQcvdVSd6L/mx2c+4J/iDBIezECtd8Iih3XZi1eXOk3q+vdGU
	 rnWoWbDte8PKvPjTBUVdZQA2nfoAoWtGReIKd0Ix/SF2c4XSJ8ijOW3C3dzHJmYGnJ
	 5Oo5gdPqHRZbff5AvMrz6ve5NDtnQzW2NotU8a1s=
X-QQ-mid: zesmtpip3t1778484000te69b36b4
X-QQ-Originating-IP: 5COA3jffw2mp/Bv5N2MWn/cPAq5DVIuNfN5AWUIYsIs=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 15:19:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10082320117274932969
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
Subject: [PATCH 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Mon, 11 May 2026 15:18:32 +0800
Message-Id: <20260511071833.44144-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051109-ocelot-dwindle-a7e9@gregkh>
References: <2026051109-ocelot-dwindle-a7e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NzKFrlI9LzSQNOWuN05dLKN2Zx2O4Y6KWL1sOn63gRs30TH0BarFBGhB
	DON0y0+SK0nHtTnqJmtGlcASVcHEeyxQXJNdVxl0+Jw3BKoI+Mdt+91wDMX0JAGGK5lgOyL
	/6BfbkBUwOKLC+OlsAS5DPzzQ3pEaaCQ1cxKQXS1ia/omMo5r5+tj8hSXzydKbeLkeKb6R1
	lcECbefygUQfrO5ETT4CUcw8k0ZSxEAoyidC0mAQbTeM9WWAqLYHmJtn7IxHyz2EfJHV6yd
	PRE46InOqM6ct8RBNTiNvlTmb8ShEetcDQIR64sRwov5i7R0bzZrW4uJdI9fUtS18hKSr7w
	fHvP9t+3hzhFjFA0JAgo5UXDdhkCGSOLQgoF01thJwpmz5xqE+GoeEjSuQx5VrKdswLSkhH
	xCUWkF7gNEfEBWWdHOh/NN3OWzp+N8wpBjJ8MRFw+Q+NXpgWS0ZbMBWsyxfa9RRe6Z8WH+k
	dniIJ5EBuRsYs+x8g/i91sUASZmMQP/SINeMRDZJ3s0MG+8A4bMv4I4xW1G5eDrIqGjQ6Ds
	wTgKtx+ap6nhqV6fDddoGfAXSI9G1z352nmqm98DcQxtWjyHjuf4SEnu/L1N5R9N87cihI4
	BXH0EtmSpMtQA6J9/ZRFcQKolA/z2FEEqVpIBkdT8zugWfTyNlHhB863k6YvGsTZCVaxCrz
	Nlw6UvbsYCAlnsNxBqL8chUF5AhgA/+JALIorH9L+56uHp3aX19g14/zS+djbAO5OfDku4+
	LJPY5Wo7rnaWQ+uEcblOzcN1c7Ba5Pk2KIAEJd4OTKFIBWatMDbyA1CiVT2O3mNU2V1y8Xj
	74MERmjxoXB4SgICtXMAjOzxt1veZpXbX1k01/3bVKI6ZTxcZPooyvmQ8NkNT1WwiPyZYWu
	4OrwdqA0sY/muv5F3vVIZzzBBLOtxarigL+wPrIzUdrsGyg7kzRMcza1E6uFzjZwso1YHIa
	Jv2Ep9TKEXK5dPVz2q7AFn/S4mPPXpvP5nqInUowDRfgGcE0S5fuY7LBB2+vkkzbq8Ln7b1
	xmtGxvEhpkQnlT6+N6rpZtVDt9aipy6TJRMqvHjw+3VGFfpigVKjKgBE5K1iDhvodZ0/NXM
	g==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 26AC75091A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,auristor.com,kernel.org,lists.infradead.org,uniontech.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245114-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,msgid.link:url,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,auristor.com:email]
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
Stable-dep-of: aa54b1d27fe0 ("rxrpc: Also unshare DATA/RESPONSE packets when
paged frags are present")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
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


