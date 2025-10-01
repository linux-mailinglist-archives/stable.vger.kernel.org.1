Return-Path: <stable+bounces-182895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6468BAF3CF
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A577A8007
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 06:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A84326F293;
	Wed,  1 Oct 2025 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cibIS0T9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92A21770C
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300301; cv=none; b=Jz0T8+XrEjg5OV8UUo2lrI4CZbkcvmkpuqC/PTgiLeEQxscmEjEHulp95GXVNR2X4rILOe7B6HLG43dua7LfRw4GOODPxwmHgY0RBWNDgB0dQUWRZ/jQkVGPgkzppdHUIgCmgRuz+hNvjtgZqVXMrjVbw2MdGBmSvyoC7aNAH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300301; c=relaxed/simple;
	bh=IEVlakWTGv+PJAnS8rZYIPFCiZchAVp3Y2kyqtWbXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zfx5hkKZXWKgEXplZJui1fBoTukguuZmM8li4iP808qIrqb6gpchLxntxrZNzBmYJRB6V/+Jx+XpAymZl5LN76XEQT34gNgobL/W/eO7f+b6Xik9f0c3u6R9k0KM3vujv7E71P6Y+puyXjeJbwQTdElWfUo5yvDOXjZJ7vMyUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cibIS0T9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759300298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rz+qqYLXcweI5rmzquO5nvJ1eJ440qoev3IK/G1Kv8=;
	b=cibIS0T9flnTPsLiIb/ytDTtVeUZeo8CnORRN5Qe9IFwxDkan/0kL0GliZofTV4DFHHcaq
	Q/oP+fhlu3m4pIONDHUe+HXqADOjGkRhDrI8ITyP5NsaxeviCgVJTy6++UsPpZ6LwUCa4J
	VNAim9VqObm7cUGqsgRzrsRjgQ03Jyo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-7MSqDb0XPg-2g8oUUsPvWQ-1; Wed,
 01 Oct 2025 02:31:35 -0400
X-MC-Unique: 7MSqDb0XPg-2g8oUUsPvWQ-1
X-Mimecast-MFC-AGG-ID: 7MSqDb0XPg-2g8oUUsPvWQ_1759300293
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F822195609F;
	Wed,  1 Oct 2025 06:31:32 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.44.32.240])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E02CB19560B4;
	Wed,  1 Oct 2025 06:31:27 +0000 (UTC)
Date: Tue, 30 Sep 2025 23:31:26 -0700
From: Chris Leech <cleech@redhat.com>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@yadro.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <20250930-feminine-dry-42d2705c778a@redhat.com>
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

On Mon, Sep 29, 2025 at 02:19:51PM +0300, Dmitry Bogdanov wrote:
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.
> 
> That can be catched by !sendpage_ok inside network stack:
> 
> WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
> 	tcp_sendmsg_locked+0x782/0xce0
> 	tcp_sendmsg+0x27/0x40
> 	sock_sendmsg+0x8b/0xa0
> 	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> Then random panic may occur.
> 
> Fix that by serializing the usage of page_frag_cache.

Thank you for reporting this. I think we can fix it without blocking the
async namespace scanning with a mutex, by switching from a per-queue
page_frag_cache to per-cpu. There shouldn't be a need to keep the
page_frag allocations isolated by queue anyway.

It would be great if you could test the patch which I'll send after
this.

- Chris
 
> Cc: stable@vger.kernel.org # 6.12
> Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> ---
>  drivers/nvme/host/tcp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d52..823e07759e0d3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -145,6 +145,7 @@ struct nvme_tcp_queue {
>  
>  	struct mutex		queue_lock;
>  	struct mutex		send_mutex;
> +	struct mutex		pf_cache_lock;
>  	struct llist_head	req_list;
>  	struct list_head	send_list;
>  
> @@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>  	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
>  
> +	mutex_lock(&queue->pf_cache_lock);
>  	req->pdu = page_frag_alloc(&queue->pf_cache,
>  		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>  		GFP_KERNEL | __GFP_ZERO);
> +	mutex_unlock(&queue->pf_cache_lock);
>  	if (!req->pdu)
>  		return -ENOMEM;
>  
> @@ -1420,9 +1423,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
>  	struct nvme_tcp_request *async = &ctrl->async_req;
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
>  
> +	mutex_lock(&queue->pf_cache_lock);
>  	async->pdu = page_frag_alloc(&queue->pf_cache,
>  		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>  		GFP_KERNEL | __GFP_ZERO);
> +	mutex_unlock(&queue->pf_cache_lock);
>  	if (!async->pdu)
>  		return -ENOMEM;
>  
> @@ -1450,6 +1455,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>  	kfree(queue->pdu);
>  	mutex_destroy(&queue->send_mutex);
>  	mutex_destroy(&queue->queue_lock);
> +	mutex_destroy(&queue->pf_cache_lock);
>  }
>  
>  static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> @@ -1772,6 +1778,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  	INIT_LIST_HEAD(&queue->send_list);
>  	mutex_init(&queue->send_mutex);
>  	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
> +	mutex_init(&queue->pf_cache_lock);
>  
>  	if (qid > 0)
>  		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
> @@ -1903,6 +1910,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  err_destroy_mutex:
>  	mutex_destroy(&queue->send_mutex);
>  	mutex_destroy(&queue->queue_lock);
> +	mutex_destroy(&queue->pf_cache_lock);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
> 


