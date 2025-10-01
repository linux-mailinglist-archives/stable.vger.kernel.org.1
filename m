Return-Path: <stable+bounces-182896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA6BAF3DE
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 08:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9CC3C0442
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493726F467;
	Wed,  1 Oct 2025 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hp4xQ+EU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71226C3BE
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300471; cv=none; b=nmw36Sju1JUFF46+c0wYJs8K9PE1hhl3lvGJRFRbBbRMn0mSUWReQGFYPEF3bW6j+o0QIZyethy/xwKevJ5VYt9rfh9EUtK/iLnd/UK9k0AYfqxEj8Cy5yWdAcd+EVi526qCA8INCmVZ7TLBZ2opIvMwJcywVC1HlGyTw0yRdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300471; c=relaxed/simple;
	bh=Uw7x8ZcUkVRLUyMASOXDiODXajwhU4rdStY8cCiz5Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbtigP1FB6iEIP7zPMYDUvqQyIdGtb0jj+mGB7vUPuDkNG2/wHyDX0kPQWSG6JPRiISJw1htq2UpfrmqmcUTehzDr69vWC040uFDuGqXNPagq/qDifx9mQ56u3zSeiMRVhzIS8ffHW2YnoEe0OXQABPNK0LWm698mQ9wtQZAq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hp4xQ+EU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759300469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=woBCeinsl2yhDRlycgTtLA3M5vo8Y9Z+g5BKloQJavA=;
	b=hp4xQ+EUZJygImuaazxv6rjCq1K+jRHDCVJlQbrGeZ+hf4gh4kVTQyPoIQ80hZetIedESr
	DM/xbTrlcn9BR5UdrNAYyP2Mt3wQsT//+szJp60wNAkkANNMrgoM0IzMcvTZtbgJeQrGv5
	j9tTREMpjSrKhF43NliuQNw00BNYAyg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-an3NFwN6PFODZu5Q0_s1Mg-1; Wed,
 01 Oct 2025 02:34:23 -0400
X-MC-Unique: an3NFwN6PFODZu5Q0_s1Mg-1
X-Mimecast-MFC-AGG-ID: an3NFwN6PFODZu5Q0_s1Mg_1759300462
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F5D51800366;
	Wed,  1 Oct 2025 06:34:21 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.44.32.240])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D05EA19560B4;
	Wed,  1 Oct 2025 06:34:16 +0000 (UTC)
Date: Tue, 30 Sep 2025 23:34:14 -0700
From: Chris Leech <cleech@redhat.com>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@yadro.com, stable@vger.kernel.org
Subject: [PATCH] nvme-tcp: switch to per-cpu page_frag_cache
Message-ID: <20250930-tableware-untaxed-6a68b2e1e970@redhat.com>
References: <20250929111951.6961-1-d.bogdanov@yadro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929111951.6961-1-d.bogdanov@yadro.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

nvme-tcp uses page_frag_cache to preallocate PDU for each preallocated
request of block device. Block devices are created in parallel threads,
consequently page_frag_cache is used in not thread-safe manner.
That leads to incorrect refcounting of backstore pages and premature free.

That can be catched by !sendpage_ok inside network stack:

WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
        tcp_sendmsg_locked+0x782/0xce0
        tcp_sendmsg+0x27/0x40
        sock_sendmsg+0x8b/0xa0
        nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
Then random panic may occur.

Fix that by switching from having a per-queue page_frag_cache to a
per-cpu page_frag_cache.

Cc: stable@vger.kernel.org # 6.12
Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
Reported-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/host/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d52..a4c4ace5be0f4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -174,7 +174,6 @@ struct nvme_tcp_queue {
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
 	int                     tls_err;
-	struct page_frag_cache	pf_cache;
 
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
@@ -201,6 +200,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static DEFINE_PER_CPU(struct page_frag_cache, pf_cache);
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -556,7 +556,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
-	req->pdu = page_frag_alloc(&queue->pf_cache,
+	req->pdu = page_frag_alloc(this_cpu_ptr(&pf_cache),
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
 	if (!req->pdu)
@@ -1420,7 +1420,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
-	async->pdu = page_frag_alloc(&queue->pf_cache,
+	async->pdu = page_frag_alloc(this_cpu_ptr(&pf_cache),
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
 	if (!async->pdu)
@@ -1439,7 +1439,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
-	page_frag_cache_drain(&queue->pf_cache);
+	page_frag_cache_drain(this_cpu_ptr(&pf_cache));
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	/* ->sock will be released by fput() */
-- 
2.50.1


