Return-Path: <stable+bounces-244217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LGGKGQk+mnyKAMAu9opvQ
	(envelope-from <stable+bounces-244217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:09:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A8A4D1D0A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D4F5303CEB3
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0493148BD3A;
	Tue,  5 May 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPYMGG43"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E2264614
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000837; cv=none; b=eCOFjsTSBdUW9BEPOnhuTQg19iVBfFERW9+jzKmQD1accuh9InlGUKcI4/xHaKSiH3frNgdFInbLPO+B1Oz/RTGpcfXgxwCHWCW0rGs0/PsqgZZgvqjV4xNboO3CGM/Ukx6lyjUx9JE0bpcBp8NNBPkxTzmhwV7CuW1b17T5oDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000837; c=relaxed/simple;
	bh=vw1Yz1M6ntRpNsMHRphRJy36953fAzli8KY6gviS25I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FPkNuSa+7taKtPbfjbGyEzRP60CGLt1yVTeXAuw+PNfCg1Ls93y1yAZ097YMr+9P06uEk/Uam5nPlv5dw0mMCWK1u+DzQFSWtem+rUK2/heEw/g0pimcC2KsmOulCqL7xGv+ZFPbxHSMbyr7FefKKft92zEFYraRwi7mDQtVzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPYMGG43; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7de7dc85b74so4959778a34.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778000835; x=1778605635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bgyzmCLBZb8njVeoHc/WQXkO4KGEQm3rkpc/IuvAWz8=;
        b=NPYMGG43WqGp+YAYON7G4MdEUatsKkFlhmNA20fFY6VSU6EisIV2FQGh6i6xGCbexa
         UdUMWYF/d5NM2UlXyLcgrwYyoyC+G2utej7MOIKJRmeCGizPKlBOkUz6I9jqhgaeLXyJ
         e66bCEZaO20xZJMd7Za+FBp9eAwUydLICb8RvaRATxh0EoWrsmI/YZmqeDHSIgyiqpTE
         ZX5ER35Eg+GgpiA2z2Zd2RJCGC7UajKndFsDPTkyYUM49oWSey6r4w+wPR9Tlns56bAs
         oUbcbsJYKvdv7d2KhBj7jGgR9q3V77TkPSR7K+8ezE7se6oeClDeVq7zZ5v0pygvYGyv
         tjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000835; x=1778605635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgyzmCLBZb8njVeoHc/WQXkO4KGEQm3rkpc/IuvAWz8=;
        b=eSrRS3pyoQi4HGALgjuGVMe8DyjiDup0QyteXfkfwyfeQ92Gpg8btKFr6T2mAZJlPS
         V7GWJQIJUW5ngdH8pWIcX4e7UCQH9GBQYxBABAEmTXzvsSreiGKU10ow8qQPQ9icAXpW
         PQGrucB1DntW+MlOWGAVpODdqSX+XZNc9IIV/5vykIFqiPpWDBihICQZ+ZJ0VvOYKn+v
         q7TYpGATfcWWzcbNUsBFq0QHtumSCpkIZzdtJbdHitRZhgWhsaR+9nODZ6Ti+bdP+/Uw
         2yYX59tB6aspPG1SGj+Iham9bh+WlU8kjEwWGiAuLAUPDJoR1HGKx8tRN8CrqtXpGZex
         X+lQ==
X-Forwarded-Encrypted: i=1; AFNElJ8S3emeOdKruoG3xatOuKR39yun/ZhYaKKdV4CnvtZE9o7imHU8YQlPF5+lfjAWJszy3A4loGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfb3dgOI4R9pJmqhBwytNhboUWoEbI1fJHlbTPLp4kFxD/9YxP
	rUW5vuMFUgYVBVfyriwA0zE7tqK78N6ZI86iWKN/QoBGddSTQETQ72NF
X-Gm-Gg: AeBDieul5eiqo/k92hVX6jFMkH2XxnMu3/gxNRveShC2SDOGWXdiit5p68oi/BqisV5
	5rmfsnwxUN2X6aFlUEuAaRVPdThKQyY2/BI3SJNKjOqciblxWlgRTYjY307Hmcp2w/qt4/wJz6Y
	+pl7YG2sdQgXCkPZGtNzlQbQ3H8bZ5VuB0sSUb9RabZrkWKhg83wQzSNL4P6gFEQVe2ZC9c04pb
	sCH9yP5iOiHfn+NH8V7bjtpXXJTk5ngamN1WgT5SP4HUTv58e+Dyj98Uh8t7NIUAqK3rA8A9REH
	b0hTFUFGI9X673GIMQVG3cOXDKJzVJUI9kw0tjvxgAwq5ut4XOtddrDF5lG90T2+DP0HEeKcBaC
	YM+Sa0njHxn4uzAw+rSeKPN5bS2pdl5tzszXyfyTTqcjfBmxzqzbWKIJ4ZXvMmXtqd1e1+2eIO3
	q1wr7tkmwOctGEAPIW7RMJ4RY/cUa9uC0lD+vF+hxfT5ZfK0IRKjMJyPMoNv4La02RGnraMUDLp
	LwUUPE9q8taCzbOuqHTH9wUFjCk+lQvBqR3VPs=
X-Received: by 2002:a05:6830:6686:b0:7dc:d0cc:91b with SMTP id 46e09a7af769-7dee149eb40mr10122943a34.26.1778000835319;
        Tue, 05 May 2026 10:07:15 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d6442d0sm151261756d6.46.2026.05.05.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:07:14 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david+nfc@ixit.cz,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v7] nfc: hci: fix out-of-bounds read in HCP header parsing
Date: Tue,  5 May 2026 17:07:12 +0000
Message-Id: <20260505170712.96560-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1A8A4D1D0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org,ixit.cz,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244217-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,nfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:email]

Both nfc_hci_recv_from_llc() and nci_hci_data_received_cb() read
packet->header from skb->data at function entry without first checking
that the buffer holds at least one byte. A malicious NFC peer can send
a 0-byte HCP frame that passes through the SHDLC layer and reaches
these functions, causing an out-of-bounds heap read of packet->header.
The same 0-byte frame, if queued as a non-final fragment, also causes
the reassembly loop to underflow msg_len to UINT_MAX, triggering
skb_over_panic() when the reassembled skb is written.

Fix this by adding a pskb_may_pull() check at the entry of each
function before packet->header is first accessed. The existing
pskb_may_pull() checks before the reassembled hcp_skb is cast to
struct hcp_packet remain in place to guard the 2-byte HCP message
header.

Fixes: 8b8d2e08bf0d ("NFC: HCI support")
Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
Changes in v7:
- Add David Heidelberg <david+nfc@ixit.cz> to CC (NFC subsystem maintainer)

Changes in v6:
- Add pskb_may_pull(skb, 1) at function entry in both functions before
  packet->header is first accessed, to fix OOB read on 0-byte frames
  and prevent integer underflow in the fragment reassembly path
  (Paolo Abeni)

V6 -> V7: add NFC subsystem maintainer to CC
V5 -> V6: add entry-point length checks per Paolo Abeni's review
V4 -> V5: fix whitespace damage
V3 -> V4: add Fixes tags
V2 -> V3: drop redundant checks from nfc_hci_msg_rx_work/nci_hci_msg_rx_work;
          remove incorrect Suggested-by tag
V1 -> V2: use pskb_may_pull() instead of skb->len check

v6: https://lore.kernel.org/netdev/20260502163116.3409687-1-ashutoshdesai993@gmail.com/
v5: https://lore.kernel.org/netdev/20260416051522.4154698-1-ashutoshdesai993@gmail.com/
v4: https://lore.kernel.org/netdev/177614425081.3600288.2536320552978506086@gmail.com/
v3: https://lore.kernel.org/netdev/20260413024329.3293075-1-ashutoshdesai993@gmail.com/
v2: https://lore.kernel.org/netdev/20260409150825.2217133-1-ashutoshdesai993@gmail.com/
v1: https://lore.kernel.org/netdev/20260408223113.2009304-1-ashutoshdesai993@gmail.com/

 net/nfc/hci/core.c | 10 ++++++++++
 net/nfc/nci/hci.c  | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index 0d33c81a15fe..ba6f0310ffd7 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -861,6 +861,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	struct sk_buff *frag_skb;
 	int msg_len;
 
+	if (!pskb_may_pull(skb, NFC_HCI_HCP_PACKET_HEADER_LEN)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)skb->data;
 	if ((packet->header & ~NFC_HCI_FRAGMENT) == 0) {
 		skb_queue_tail(&hdev->rx_hcp_frags, skb);
@@ -904,6 +909,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (!pskb_may_pull(hcp_skb, NFC_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)hcp_skb->data;
 	type = HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NFC_HCI_HCP_RESPONSE) {
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 40ae8e5a7ec7..c03e8a0bd3bd 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -439,6 +439,11 @@ void nci_hci_data_received_cb(void *context,
 		return;
 	}
 
+	if (!pskb_may_pull(skb, NCI_HCI_HCP_PACKET_HEADER_LEN)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)skb->data;
 	if ((packet->header & ~NCI_HCI_FRAGMENT) == 0) {
 		skb_queue_tail(&ndev->hci_dev->rx_hcp_frags, skb);
@@ -482,6 +487,11 @@ void nci_hci_data_received_cb(void *context,
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (!pskb_may_pull(hcp_skb, NCI_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)hcp_skb->data;
 	type = NCI_HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NCI_HCI_HCP_RESPONSE) {
-- 
2.34.1


