Return-Path: <stable+bounces-191401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D2C1369F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 09:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29BEC4E962F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E32D592D;
	Tue, 28 Oct 2025 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="wW8s3UMt";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="hD1NkpdS"
X-Original-To: stable@vger.kernel.org
Received: from mta-01.yadro.com (mta-01.yadro.com [195.3.219.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1A271454;
	Tue, 28 Oct 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.219.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638384; cv=none; b=OnK7VtrRJyMX/1eGnn9nkTJmVd0XUpuBV5o4vF76FU8/6RR2X1qyhfIbp7+lqrZ3/AjYnKokbyyqj13WxE14qjDP9NzNpMOm5TMNWLrUHcjQGpACs+E7R6OpatNJ1BAb3gH7BzdsR91qD08vVk1n2M21ywHmJn2POOf7bBHbcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638384; c=relaxed/simple;
	bh=/1RIS9IGTY5mmE8VkBgLL8dKwXagjr/uRKUBq08Tsx0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgB3Pn+TTQcEeFagHHxA8UUHTlNVXEMdwVrkKo124T3OjnaBU3bi/Lrxcwe9bUykznbspoCB2TWEUeGyhy3fpWJx7Zn4UBj6xXKiyD2VrxrwUuoKh4ipX3h8eU7qBPYbSpwOWK8C25TD7i9hWQdnQ5Fo+9iugwWx5IEDFrhCfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=wW8s3UMt; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=hD1NkpdS; arc=none smtp.client-ip=195.3.219.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 2320520006;
	Tue, 28 Oct 2025 10:59:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com 2320520006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1761638371; bh=C6DWKCrqeMd8yEie8ux+bImvLbKULsBRhRlilfIMAOc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=wW8s3UMt9YkpLDmA8dnGrRYvWBq5XJoXtVqgbcr78PCCKGClf8vzNvk23W0cROX4R
	 MQCm7zjT00VdWQKK9dOv2DxBUNyZBG4dYomaUaKR+xj3NrCQO9vhLQUoUCIKJX7d0O
	 Gv9MndjlkW1xD3m6+WFL34hXK0Uq9SMGyaTTTUXoOfwdngLdW+b4Kx5Kzjue2CUS6Q
	 L7PfOgij7DyZ+VRE/RHk7lGKU2R+TZNzWjfWFAwd6l9GOpDzlQw8LecRrZKOJTXdsL
	 NxfEVf8p55W6GSOlCysymTFrX2OXyV4nimwKjiJTinjoRXPWQt+TXXc4IjJ78CtlHs
	 v9Wi4ezxLMCcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1761638371; bh=C6DWKCrqeMd8yEie8ux+bImvLbKULsBRhRlilfIMAOc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=hD1NkpdScXWFkWQbIKfU5Zi9iCBTPjUAMf06Pel1c+5+V4pBQYfUrGy51sHYUKdBE
	 zd517/sZswtybZvck+paZu4gsnAu5KQymBaZ8kee/jZXn+2NOKDlUo3XkW/81ePeri
	 aPiWOefE6rKEeWG4mXAqZBQm7y9TbIjq0yMIz2rAV6vYNP+D09BoKB6yJXRivoHzrM
	 lEhZe7GBrN+SglVNV048riNNlm0cEl9ivZh6vW/i34Nubzg+lAZeORo9MIUXAHF3aB
	 H0oXkdN79sSwOSnBeWkYL75kcSjFdHIqDU7hbwj0ljB+uenHQWvCxn7kB9D03x+C6/
	 Vj0yEqg8uAQ9A==
Received: from RTM-EXCH-01.corp.yadro.com (unknown [10.34.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Tue, 28 Oct 2025 10:59:28 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (10.34.9.214) by
 RTM-EXCH-01.corp.yadro.com (10.34.9.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Oct 2025 10:59:26 +0300
Received: from yadro.com (172.17.34.55) by T-EXCH-12.corp.yadro.com
 (10.34.9.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 28 Oct
 2025 10:59:25 +0300
Date: Tue, 28 Oct 2025 10:59:18 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, Stuart Hayes <stuart.w.hayes@gmail.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux@yadro.com>, <stable@vger.kernel.org>
Subject: Re: [RESEND] [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <20251028075918.GA14902@yadro.com>
References: <20251027163627.12289-1-d.bogdanov@yadro.com>
 <aP-m9btCap_dt32Y@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aP-m9btCap_dt32Y@kbusch-mbp>
X-ClientProxiedBy: RTM-EXCH-01.corp.yadro.com (10.34.9.201) To
 T-EXCH-12.corp.yadro.com (10.34.9.214)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/28 03:53:00 #27799916
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

On Mon, Oct 27, 2025 at 11:08:05AM -0600, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 07:36:27PM +0300, Dmitry Bogdanov wrote:
> > nvme uses page_frag_cache to preallocate PDU for each preallocated request
> > of block device. Block devices are created in parallel threads,
> > consequently page_frag_cache is used in not thread-safe manner.
> > That leads to incorrect refcounting of backstore pages and premature free.
> >
> > That can be catched by !sendpage_ok inside network stack:
> >
> > WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
> >       tcp_sendmsg_locked+0x782/0xce0
> >       tcp_sendmsg+0x27/0x40
> >       sock_sendmsg+0x8b/0xa0
> >       nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> > Then random panic may occur.
> >
> > Fix that by serializing the usage of page_frag_cache.
> >
> > Cc: stable@vger.kernel.org # 6.12
> > Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> > Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> > ---
> >  drivers/nvme/host/tcp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 1413788ca7d52..823e07759e0d3 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -145,6 +145,7 @@ struct nvme_tcp_queue {
> >
> >       struct mutex            queue_lock;
> >       struct mutex            send_mutex;
> > +     struct mutex            pf_cache_lock;
> >       struct llist_head       req_list;
> >       struct list_head        send_list;
> >
> > @@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
> >       struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
> >       u8 hdgst = nvme_tcp_hdgst_len(queue);
> >
> > +     mutex_lock(&queue->pf_cache_lock);
> >       req->pdu = page_frag_alloc(&queue->pf_cache,
> >               sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
> >               GFP_KERNEL | __GFP_ZERO);
> > +     mutex_unlock(&queue->pf_cache_lock);
> >       if (!req->pdu)
> >               return -ENOMEM;
> 
> Just a bit confused by this. Everything related to a specific TCP queue
> should still be single threaded on the initialization of its tagset, so
> there shouldn't be any block devices accessing the queue's driver
> specific data before the tagset is initialized.

Hmm, we are both right. You are right that the preallocated requests that
are part of hw queue's tagset are preallocated at hw queue creation.
But there is one(per hw queueue actually) more request objects that
are preallocated for each block device - it's hctx->fq->flush_rq. I am
talking about that one.

The call stack is the following:
nvme_scan_ns_list =parallel on all CPUs=>
 nvme_scan_ns_async->nvme_scan_ns -> nvme_alloc_ns -> nvme_alloc_ns ->
 __blk_mq_alloc_disk -> blk_mq_alloc_queue -> blk_mq_init_allocated_queue ->
 blk_mq_realloc_hw_ctxs for each hw(TCP) queue do ->
  blk_mq_alloc_and_init_hctx(queue) -> blk_mq_init_hctx ->
  blk_mq_init_request(flush_rq) -> nvme_tcp_init_request ->
  page_frag_alloc(tcp_queue)



BR,
 Dmitry

