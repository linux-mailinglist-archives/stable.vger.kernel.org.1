Return-Path: <stable+bounces-264932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I8hPAhSCMWq6lAUAu9opvQ
	(envelope-from <stable+bounces-264932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:04:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB0692B20
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:04:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bLBnSJKH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264932-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264932-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB3113292419
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D95466B4B;
	Tue, 16 Jun 2026 16:50:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF1449EC3;
	Tue, 16 Jun 2026 16:50:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628646; cv=none; b=no832EcNXw7KTxbt3i4MuO+dEbPHCvm0Rs/C9LiV1tlty4E0Oo7s9HCpEt2d53t6cmjPQO16LEd6mv/y7QWYj1NP3yXeamCWTldWerqMwVpmlz1nZJjmvhJfhyKXa8DntuSzDpA4M3NHt/i5BKTMTzfTtoCferhdK1+ehZoCx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628646; c=relaxed/simple;
	bh=qJdrgxyf4oy3z+UfOIvwK/b9hIPliyxdGV/NhyZsvwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgnQkvcfA79bvQYmPIrZdCv7Ia0AL3v4eRMcrN3/ZFL9aggxtc7LZit1/XwYuc8SFG1lO7juR5AClC2G6qtyI0uV2a3jg6E9SbQiWcHGDKiZGf+juJqqqHLr0SbaRsJcWHysmPOmzfrVcBzNthacquMV5sa1yelwHF2IJ2QLLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLBnSJKH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B751F000E9;
	Tue, 16 Jun 2026 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628645;
	bh=fzLNSi93zWpwk3VBtULl8ppT7HnMc8OIszlZo/++F5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bLBnSJKHN3y78UUnIUcw5RsUyuM5NcTyZ2k12VGeATmuNaN0DgbC4Hvakq6rqBOWs
	 59Kxsn5hl/KQOR//pApF2eQUrwl1fz08/NCyMd5gRp8RP2YJOmjdvQVX3mU0FQrsJy
	 sZoUETFzJJD5jARCRdYXe+q4N2s9aSQdZDjeP7Do=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Ashutosh Desai <ashutoshdesai993@gmail.com>,
	David Heidelberg <david@ixit.cz>
Subject: [PATCH 6.6 135/452] nfc: hci: fix out-of-bounds read in HCP header parsing
Date: Tue, 16 Jun 2026 20:26:02 +0530
Message-ID: <20260616145124.822756229@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264932-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:horms@kernel.org,m:ashutoshdesai993@gmail.com,m:david@ixit.cz,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,ixit.cz];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,ixit.cz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55AB0692B20

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ashutosh Desai <ashutoshdesai993@gmail.com>

commit f040e590c035bfd9553fe79ee9585caf1b14d67b upstream.

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
Link: https://patch.msgid.link/20260505170712.96560-1-ashutoshdesai993@gmail.com
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/hci/core.c |   10 ++++++++++
 net/nfc/nci/hci.c  |   10 ++++++++++
 2 files changed, 20 insertions(+)

--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -861,6 +861,11 @@ static void nfc_hci_recv_from_llc(struct
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
@@ -904,6 +909,11 @@ static void nfc_hci_recv_from_llc(struct
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
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -439,6 +439,11 @@ void nci_hci_data_received_cb(void *cont
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
@@ -482,6 +487,11 @@ void nci_hci_data_received_cb(void *cont
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



