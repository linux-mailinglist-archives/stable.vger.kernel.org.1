Return-Path: <stable+bounces-236306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDECDwEZ3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4A3EEE0D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 680C83072A88
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726D302756;
	Mon, 13 Apr 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wryHEMaB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0753016F5;
	Mon, 13 Apr 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096568; cv=none; b=GjnLhzb8KbF4XYKydJ3c6xn+QqllbYk83nYhm0BTFKvPE1CKhWxhBhBlH0YPAzYhVYqUv+pcb2ZkTJ8TZxWiU7ttO2LZt9vhQ2iULGbqW2gIBLn3LYwkWUZ1I1U55jqlTcK/9T8SsWRcYB23C4Rn+cWs+y6wFtIBpUCMyDnrgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096568; c=relaxed/simple;
	bh=TAN6qjPmGkFIbhvhjNOPWpRZKKV193LP6CRFIpMLtt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs/MqoDJo8PLZHWELH/2HsKSyYL6xGZMvrkouBUfg2b4Xzl7G1OY9DVdJVgRtNjYR3maceQFpMOd6xj8NlcYWD9cRMEw3ONIz6HZW3RMw2iSMpMOYGyftbS1wZTGqrWP6mPd7k3/iGhKQ6WAScgX5ETK2Hl10kx9Tu3WneqodL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wryHEMaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3CBC2BCAF;
	Mon, 13 Apr 2026 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096568;
	bh=TAN6qjPmGkFIbhvhjNOPWpRZKKV193LP6CRFIpMLtt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wryHEMaBs4Kx3EInwyssMvK0syAGG23l3piA+jzoe/4s3VatwrlM8CoM3YnMXO2bV
	 uvf2PBUoVwAiKzkSvmV9x8sGLz3U2Hvdv1loUMYFDQDI2vkmsI2j2vOGL2Kf8s4cqF
	 2bwS9ynC3gIf3EfLa4I6ow0wJEGp6DWUqLzqRpVY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.18 61/83] net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()
Date: Mon, 13 Apr 2026 18:00:29 +0200
Message-ID: <20260413155733.288161489@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236306-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4C4A3EEE0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

commit 59c3d55a946cacdb4181600723c20ac4f4c20c84 upstream.

When lan966x_fdma_reload() fails to allocate new RX buffers, the restore
path restarts DMA using old descriptors whose pages were already freed
via lan966x_fdma_rx_free_pages(). Since page_pool_put_full_page() can
release pages back to the buddy allocator, the hardware may DMA into
memory now owned by other kernel subsystems.

Additionally, on the restore path, the newly created page pool (if
allocation partially succeeded) is overwritten without being destroyed,
leaking it.

Fix both issues by deferring the release of old pages until after the
new allocation succeeds. Save the old page array before the allocation
so old pages can be freed on the success path. On the failure path, the
old descriptors, pages and page pool are all still valid, making the
restore safe. Also ensure the restore path re-enables NAPI and wakes
the netdev, matching the success path.

Fixes: 89ba464fcf54 ("net: lan966x: refactor buffer reload function")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260405055241.35767-4-devnexen@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c |   21 +++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -813,9 +813,15 @@ static int lan966x_qsys_sw_status(struct
 
 static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 {
+	struct page *(*old_pages)[FDMA_RX_DCB_MAX_DBS];
 	struct page_pool *page_pool;
 	struct fdma fdma_rx_old;
-	int err;
+	int err, i, j;
+
+	old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
+			   GFP_KERNEL);
+	if (!old_pages)
+		return -ENOMEM;
 
 	/* Store these for later to free them */
 	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
@@ -826,7 +832,6 @@ static int lan966x_fdma_reload(struct la
 	lan966x_fdma_stop_netdev(lan966x);
 
 	lan966x_fdma_rx_disable(&lan966x->rx);
-	lan966x_fdma_rx_free_pages(&lan966x->rx);
 	lan966x->rx.page_order = round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
 	lan966x->rx.max_mtu = new_mtu;
 	err = lan966x_fdma_rx_alloc(&lan966x->rx);
@@ -834,6 +839,11 @@ static int lan966x_fdma_reload(struct la
 		goto restore;
 	lan966x_fdma_rx_start(&lan966x->rx);
 
+	for (i = 0; i < fdma_rx_old.n_dcbs; ++i)
+		for (j = 0; j < fdma_rx_old.n_dbs; ++j)
+			page_pool_put_full_page(page_pool,
+						old_pages[i][j], false);
+
 	fdma_free_coherent(lan966x->dev, &fdma_rx_old);
 
 	page_pool_destroy(page_pool);
@@ -841,12 +851,17 @@ static int lan966x_fdma_reload(struct la
 	lan966x_fdma_wakeup_netdev(lan966x);
 	napi_enable(&lan966x->napi);
 
-	return err;
+	kfree(old_pages);
+	return 0;
 restore:
 	lan966x->rx.page_pool = page_pool;
 	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
 	lan966x_fdma_rx_start(&lan966x->rx);
 
+	lan966x_fdma_wakeup_netdev(lan966x);
+	napi_enable(&lan966x->napi);
+
+	kfree(old_pages);
 	return err;
 }
 



