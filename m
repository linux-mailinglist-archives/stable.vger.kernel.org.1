Return-Path: <stable+bounces-236592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFGnEYgd3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-236592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 980493EFAE7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361943031EAA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182D02FE056;
	Mon, 13 Apr 2026 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3B/xpPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C326CE32;
	Mon, 13 Apr 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097303; cv=none; b=R/iFYVR6pL9rYiKrU3nbs33mjhT7Cu0cf7pYZqneFEy3VY3mWq8U3NQu6epaH+QFEe4WMY/OADl5GIvat39zuXG5Nob/f5HLsJhJjg2mesktJWKgAE9nIerpj3ZGHehGtz7n4H9BI+Dc5YcOD9MJW0McWd8RlzVHkcEYd7sYF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097303; c=relaxed/simple;
	bh=CXxy2SNjvE45kcp3PkPd29p4SL+2Oj2tycB/57No+qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB6sKpLCOomJ5hA3Zx4a1Q2boZE85UISNYPtJs458RYtdTH+11gGLKuzMcwcfvUxsxfquX+kmeKJEHZp9xDCoUlWzp/yBrwbKVXbUd3J93TIiydHautvVTKzt5pWkGroAviQTBR8BMWjjqrL6gSELspG5Y0SroTU39fIhnFuu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3B/xpPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6766FC2BCAF;
	Mon, 13 Apr 2026 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097303;
	bh=CXxy2SNjvE45kcp3PkPd29p4SL+2Oj2tycB/57No+qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3B/xpPrjL4mGWXf++tMUc/KANWx49llxA07luUQtywpYSVPPoBtAqVEQ5eFw+aRe
	 eH+Yh9iyYpOT/GuCau2qU1+4jyOjqKiFJL3wwbi+HEZOrUdX/1GK1qb6/tr0boQPoF
	 eTQqwMUv1u6q56wB1KJZNfORtlZtsUeGNzdDpluY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/570] nfc: nci: clear NCI_DATA_EXCHANGE before calling completion callback
Date: Mon, 13 Apr 2026 17:53:34 +0200
Message-ID: <20260413155833.553087594@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236592-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,dama.to:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 980493EFAE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 0efdc02f4f6d52f8ca5d5889560f325a836ce0a8 ]

Move clear_bit(NCI_DATA_EXCHANGE) before invoking the data exchange
callback in nci_data_exchange_complete().

The callback (e.g. rawsock_data_exchange_complete) may immediately
schedule another data exchange via schedule_work(tx_work).  On a
multi-CPU system, tx_work can run and reach nci_transceive() before
the current nci_data_exchange_complete() clears the flag, causing
test_and_set_bit(NCI_DATA_EXCHANGE) to return -EBUSY and the new
transfer to fail.

This causes intermittent flakes in nci/nci_dev in NIPA:

  # #  RUN           NCI.NCI1_0.t4t_tag_read ...
  # # t4t_tag_read: Test terminated by timeout
  # #          FAIL  NCI.NCI1_0.t4t_tag_read
  # not ok 3 NCI.NCI1_0.t4t_tag_read

Fixes: 38f04c6b1b68 ("NFC: protect nci_data_exchange transactions")
Reviewed-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260303162346.2071888-5-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/data.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 3d36ea5701f02..7a3fb2a397a1e 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -33,7 +33,8 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
 	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
 	if (!conn_info) {
 		kfree_skb(skb);
-		goto exit;
+		clear_bit(NCI_DATA_EXCHANGE, &ndev->flags);
+		return;
 	}
 
 	cb = conn_info->data_exchange_cb;
@@ -45,6 +46,12 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
 	del_timer_sync(&ndev->data_timer);
 	clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
 
+	/* Mark the exchange as done before calling the callback.
+	 * The callback (e.g. rawsock_data_exchange_complete) may
+	 * want to immediately queue another data exchange.
+	 */
+	clear_bit(NCI_DATA_EXCHANGE, &ndev->flags);
+
 	if (cb) {
 		/* forward skb to nfc core */
 		cb(cb_context, skb, err);
@@ -54,9 +61,6 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
 		/* no waiting callback, free skb */
 		kfree_skb(skb);
 	}
-
-exit:
-	clear_bit(NCI_DATA_EXCHANGE, &ndev->flags);
 }
 
 /* ----------------- NCI TX Data ----------------- */
-- 
2.51.0




