Return-Path: <stable+bounces-181871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97FBA8FE2
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F583A562F
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D872FFF9C;
	Mon, 29 Sep 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="t5uYZlPz";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ceggO/6A"
X-Original-To: stable@vger.kernel.org
Received: from mta-01.yadro.com (mta-01.yadro.com [195.3.219.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB7E2FBDFB;
	Mon, 29 Sep 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.219.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144807; cv=none; b=eoCIzXCv+nfIh6BxYIg7w9mGCBpblTHON8zbNVe0JlfMzGCQ26pxeuYfwsrNJaAH7Gzok2VJuZ0tHQTeKbitzuCNqCW1JgfwR4tuvnJ5Rygz9T9lcpFhuKfxzA5uiyeuLsypj6fxOneal5gH1VIk4fIaEPpiO8kBAAFs5KbQBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144807; c=relaxed/simple;
	bh=FThlKf9mPp6z/y8Uoh/3G44IfMfSzTwr6+FTkAYPw3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OrdWQzHuA4sJFPulMXoK3C4I5RiMvCEddJS4XaFa1DZbidQr0jO34vI6lwKObw5RERFk3onFqiFzNicNGtIZs9YCoJngXLXa6TwJbrHqbPPgbrumFDNkslzkYE/RLay226HNumWd8jX0f/AM3VJELy21GO8xtaaOI6dY4GSSxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=t5uYZlPz; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=ceggO/6A; arc=none smtp.client-ip=195.3.219.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id D26CB20005;
	Mon, 29 Sep 2025 14:19:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com D26CB20005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1759144793; bh=mfpLLcjjSLHnXsHxBUMYqBg3s2C4zQ/P2NyM/Se6WAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=t5uYZlPz4ICjN+/R1xdwctEZsTZbghoL9Q7+bNNYqbo/iSECAew0Be8M2KyR7LKIt
	 pnLVHyVcCfZ3PoUiOOo39wEgtP8Q8Gp2amnIkWVglI+hg7p1Z60owmqw/mcmiXToOC
	 PN06dCNQkXGTEW9Ykf0oobDWTUBKazMqTGEN21Ca5vLHOOuNdCN7wi8bDrpIHxiIg+
	 6DAEYcikxw3BQupVejjGkftxn5SHC75dVQqJexOa2tahGOqRUNCi2yH5rmUAl3keWP
	 RNHjlq1aOL9MsgrYYMWBZyvl2Ya+DI6Flxg1xiIN1kGp6kG0QUPxdc6CsxDfBO55b1
	 Ly2qhL8wC4KtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1759144793; bh=mfpLLcjjSLHnXsHxBUMYqBg3s2C4zQ/P2NyM/Se6WAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ceggO/6AAv5UQV+WgF8xzTdYagifQdxIfBihz1VKidrQU/LM5Cve4VtsUiHmm6Mru
	 LBt+F4eQ7+rXtL0Qd3jCmBZwCqap7oJ83vtNn8Bsz8E/ho1fGrmnz2qJmBP+IHci/Z
	 CnJYsHdAGVUMagy21AkdGbvy+oGm1mX1SImf08Tc33M0j5iBxF3ClSZ8IGETsvy/SU
	 6ESBMSSTxoZn1pUN8wSHIcCJlNHx8BTBj0gUOXszu/nibkqiOeOvA47J432LXZz5q9
	 oDvQ3KOYE9Fb6Ru4Olnl7jXRe/htRGpQriyH8jYLFtgGcFzzSmDxv1E3qzva9YHBox
	 zZvwhV6ymz06w==
Received: from RTM-EXCH-01.corp.yadro.com (unknown [10.34.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Mon, 29 Sep 2025 14:19:49 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (10.34.9.214) by
 RTM-EXCH-01.corp.yadro.com (10.34.9.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Sep 2025 14:19:50 +0300
Received: from NB-591.corp.yadro.com (172.17.34.51) by
 T-EXCH-12.corp.yadro.com (10.34.9.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 29 Sep 2025 14:19:50 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Stuart Hayes
	<stuart.w.hayes@gmail.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux@yadro.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] nvme-tcp: fix usage of page_frag_cache
Date: Mon, 29 Sep 2025 14:19:51 +0300
Message-ID: <20250929111951.6961-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTM-EXCH-04.corp.yadro.com (10.34.9.204) To
 T-EXCH-12.corp.yadro.com (10.34.9.214)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/29 07:44:00 #27864461
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

nvme uses page_frag_cache to preallocate PDU for each preallocated request
of block device. Block devices are created in parallel threads,
consequently page_frag_cache is used in not thread-safe manner.
That leads to incorrect refcounting of backstore pages and premature free.

That can be catched by !sendpage_ok inside network stack:

WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
	tcp_sendmsg_locked+0x782/0xce0
	tcp_sendmsg+0x27/0x40
	sock_sendmsg+0x8b/0xa0
	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
Then random panic may occur.

Fix that by serializing the usage of page_frag_cache.

Cc: stable@vger.kernel.org # 6.12
Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d52..823e07759e0d3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -145,6 +145,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1420,9 +1423,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1450,6 +1455,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1772,6 +1778,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1903,6 +1910,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
-- 
2.25.1


