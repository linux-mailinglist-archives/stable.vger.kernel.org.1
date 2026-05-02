Return-Path: <stable+bounces-242612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG7bAvEm9mkASwIAu9opvQ
	(envelope-from <stable+bounces-242612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 18:31:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0C4B2D01
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B4363003827
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFCF38228E;
	Sat,  2 May 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s80wTa5L"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BE033F591
	for <stable@vger.kernel.org>; Sat,  2 May 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777739499; cv=none; b=TiD22+26c3hyzyQQwyyEZ5ZW3xnOgGwP1LgtKakRWwvcJKKGZhpQk6m2HiVTAyv+1F2GKIn2ehYUDPL6Wuja9Dylia5V5Zcd/iBAj8ec5FqEvPTk6Gtb7EIkxJQWDBDguX+r4DgGYSu3koieANk/IvHL+Y+vMH97XQ76WXMLojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777739499; c=relaxed/simple;
	bh=WVKJdgc/QUTT/L8tYYDqk5ux1njNQl6pEco9+XPg/tw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZK+drJ5OhtSFfwDFHX4cs4k2MLbHr1N4vF6eU/lcvYf+5yhb5R8LQk28Rb3snRerMsnuQ9cHcsWeBMRqGS5qsQlNRKL6yJ1TVoeOrGWUQT1VOmWWx/z5XtTA6HjnZwLxoHUv3r22sBJABEheWxQEqLUG055WhAyYbXNopW2YSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s80wTa5L; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so26202466d6.2
        for <stable@vger.kernel.org>; Sat, 02 May 2026 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777739497; x=1778344297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JHSGmWJLA8XXidhFzeVkn9Y0uqp8yNzjVJ9f8OAcqY4=;
        b=s80wTa5L125eZl3v5fwTG/ISft18rvkTZnfSncqZFLp1Sb3rwwKii6MLXolhwzTUQ+
         RWq3XyCxcG6jGMpAF2Yqp2DXMC7UgOntYF769LvV1Hhanrvy3nDD0vkjl6u0KJ1vf2ae
         ls0YsSoujjxOEjcMpRzQp2FXq6YJB2h9og+LPn0ttoy8xCzssixUwZ+SK5aWUEW5TXPl
         2AJBKHnJAWmelu3TQmiHJcyJDhRbnZyaZTXmmXxfszNC+BGMCLCe8HYTuD2pEY/Gf3km
         hX4b3EMMRNwVlJFiNLs01Nv+aeczeYsbUHuZtu8ChXBZAEWaGw3vI1T10JZftoWlxzf1
         wZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777739497; x=1778344297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHSGmWJLA8XXidhFzeVkn9Y0uqp8yNzjVJ9f8OAcqY4=;
        b=fM/z8TUNMK7lN9mzs3Y8apG0BAQHKQ6kZdqztLBc5EDcLcX66uRtOdSTu+CkToL24M
         Et11gIrbAHv2LevbWRqiS3qDkIotRIUSoGWtSUqPe+rUy2SRWnB23Gxn66VSHFTNlAGp
         TaOTBGege1bE9bEPwOHSUWGp9Ac4EuxVprTbfHXxttVCujVnZ4cIQY9jGcHYs8jSYDgc
         PGFr7N6fM9lYC3ZpVFGkZp5LXehoZt8uH6O0sZGv1iz3h3bfTDnKbNhsqDunh+xUcnDI
         d5wv8rAycKNDGGGb8PUgU12rZ+botbRk/Dlx+34jgGu58VgC5dV5ZELeSgOenMI3WJFQ
         Z3ew==
X-Forwarded-Encrypted: i=1; AFNElJ/vWfC3cqz/Kn3GErAa5ABjfGpEg6dtomkzDvo1oVmu9Rlq+loASXd3qRJZjclT1DoWHjg+vcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0KW0LuyreNhu69QeZIuRAJzGJlCZPnYn6EWQES37U+IIkBGB
	PBnPHn+vD3dd9QzytzZ2/eluKbjXG3467l8pOnvDx/KL0SPOvvF7KcO1
X-Gm-Gg: AeBDiesCNFa5j+cY8Yi2aMPIuM28L+JjN5phw1CjNpLfH8aujd0oBkZ8AIffInVOjqE
	SCTumFS9A0uhMmRvWh3de5bDX3QLqJVjZcSopqLKeThupOxO2DEh2LF7f1uqhN8R3ubEhnEgeHY
	HAt1ST6pBJKfhD8KSLP9Ibw4I+wpNghABJTjiY4Cey9elHCoJ7TNtxU0ruESUTjgB/um0NPWCIg
	EilalP4xtt6CfT/ZdR2H/nE/Vpr1I+LMqpZEnN/ZxIbQcAdzWcMgrpr+IavgjOGrkcYWHDE/ZVk
	FzY3uhc12/SWa2j70tDl9gr692etAtHKoCuuBVQNjwRlxpjPqUgsKbNdByl1lW+zpKmS+froDHq
	Sw73MDS6mHiKMJZkVwCkYdxZRNur33Z2voepkYte8Q3bRU/slrvDQddAw69PsDs8+kTcqSmEcCt
	e++jFInpQJCy7Nbip4xn1swmyr8GP3TrZ3T/fidz6rV5KB0VIOUIupbig18TCYZ4DewP22FIBC7
	byagp0LL6jeyNGEPAPm4XnPWMbY1nX8sLMZyXQ=
X-Received: by 2002:a05:6214:6014:b0:8b3:f59d:e6a4 with SMTP id 6a1803df08f44-8b6665f1d8emr66141656d6.17.1777739497391;
        Sat, 02 May 2026 09:31:37 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e7ebdsm71694846d6.29.2026.05.02.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 09:31:35 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v6] nfc: hci: fix out-of-bounds read in HCP header parsing
Date: Sat,  2 May 2026 16:31:16 +0000
Message-Id: <20260502163116.3409687-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CA0C4B2D01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242612-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
Changes in v6:
- Add pskb_may_pull(skb, 1) at function entry in both functions before
  packet->header is first accessed, to fix OOB read on 0-byte frames
  and prevent integer underflow in the fragment reassembly path
  (Paolo Abeni)

V5 -> V6: add entry-point length checks per Paolo Abeni's review
V4 -> V5: fix whitespace damage
V3 -> V4: add Fixes tags
V2 -> V3: drop redundant checks from nfc_hci_msg_rx_work/nci_hci_msg_rx_work;
          remove incorrect Suggested-by tag
V1 -> V2: use pskb_may_pull() instead of skb->len check

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


