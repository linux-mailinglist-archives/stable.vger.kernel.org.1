Return-Path: <stable+bounces-237135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKZQLAgl3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:16:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E33F1189
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993C7303746C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEF13128CC;
	Mon, 13 Apr 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KiV68lHx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EA2BEC3F;
	Mon, 13 Apr 2026 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098679; cv=none; b=NCCVZR1rSmetks8MdG4tOA2ucZcV3Dk9ANuQc+Snm9F+9FeWsopqFEcI1hl2o7k2dLR4GjWGh8IHN+Sd1DauGETCHbJz0SdQemYUWCcN45z1xeF0k2fp3cSfql5BmjBx7fmnMCBIEGlVpvachPOWca8tZ8cXVv+W/EHn1uedBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098679; c=relaxed/simple;
	bh=9IPG6/EeMsdkXFZOxD7NV2VV4IzELnKflTzYI0Wa2zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuyYAPtR9M2qlrZcvYWQhKKCYJkQVqpBlKNG/fO30UJGePDlwIPnqluvpzlVI/TlVTgBGLIlQDdIwrqFWXgWSrKEXPek88mw/7EUV4oSy5POYsiRwtEy/0M/1HIlcuvEY6nnYEcwkzt5ypF6+iytlyxow2oW1Xbf2y5PK+I7Wl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KiV68lHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BE2C2BCAF;
	Mon, 13 Apr 2026 16:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098678;
	bh=9IPG6/EeMsdkXFZOxD7NV2VV4IzELnKflTzYI0Wa2zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiV68lHxADqRy2WAMh9EabWU1EsI1G66EWq5ko27egIIIDPmifzssvT+pqYVjLQ4Y
	 cOBqreCk2FWibVW8NhRgz+SSZSSbuIBu1/JA57djdun1ZLaTPwWfSey2gpGejXbExm
	 I8Bh8C11JGOFR1xnk2b6D+SL418Nu2BGY1qn9Cbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 047/491] nfc: nci: free skb on nci_transceive early error paths
Date: Mon, 13 Apr 2026 17:54:52 +0200
Message-ID: <20260413155820.813817016@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237135-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,dama.to:email]
X-Rspamd-Queue-Id: 134E33F1189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 7bd4b0c4779f978a6528c9b7937d2ca18e936e2c ]

nci_transceive() takes ownership of the skb passed by the caller,
but the -EPROTO, -EINVAL, and -EBUSY error paths return without
freeing it.

Due to issues clearing NCI_DATA_EXCHANGE fixed by subsequent changes
the nci/nci_dev selftest hits the error path occasionally in NIPA,
and kmemleak detects leaks:

unreferenced object 0xff11000015ce6a40 (size 640):
  comm "nci_dev", pid 3954, jiffies 4295441246
  hex dump (first 32 bytes):
    6b 6b 6b 6b 00 a4 00 0c 02 e1 03 6b 6b 6b 6b 6b  kkkk.......kkkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace (crc 7c40cc2a):
    kmem_cache_alloc_node_noprof+0x492/0x630
    __alloc_skb+0x11e/0x5f0
    alloc_skb_with_frags+0xc6/0x8f0
    sock_alloc_send_pskb+0x326/0x3f0
    nfc_alloc_send_skb+0x94/0x1d0
    rawsock_sendmsg+0x162/0x4c0
    do_syscall_64+0x117/0xfc0

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reviewed-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260303162346.2071888-2-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 188677c322f4c..873c9073e4111 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1014,18 +1014,23 @@ static int nci_transceive(struct nfc_dev *nfc_dev, struct nfc_target *target,
 	struct nci_conn_info    *conn_info;
 
 	conn_info = ndev->rf_conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		kfree_skb(skb);
 		return -EPROTO;
+	}
 
 	pr_debug("target_idx %d, len %d\n", target->idx, skb->len);
 
 	if (!ndev->target_active_prot) {
 		pr_err("unable to exchange data, no active target\n");
+		kfree_skb(skb);
 		return -EINVAL;
 	}
 
-	if (test_and_set_bit(NCI_DATA_EXCHANGE, &ndev->flags))
+	if (test_and_set_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
+		kfree_skb(skb);
 		return -EBUSY;
+	}
 
 	/* store cb and context to be used on receiving data */
 	conn_info->data_exchange_cb = cb;
-- 
2.51.0




