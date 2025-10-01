Return-Path: <stable+bounces-182975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF3BB13F6
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0262318935E6
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D698283FEB;
	Wed,  1 Oct 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="yRnSNY0x";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="YglptEjK"
X-Original-To: stable@vger.kernel.org
Received: from mta-01.yadro.com (mta-01.yadro.com [195.3.219.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AC288AD;
	Wed,  1 Oct 2025 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.219.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335919; cv=none; b=mSa2DAwH2hWAWoAqy+wYpjtIVNO5WjA2xb8BWkKTaLhMqj9aL5OIz+kTSsasJAKDuY2BPRy2drHONQza1YyRt2v6oWiqMA8KxNXsB2RC7uSp2ZZm4w3M2s6/vfddNChPtSTI6XRWPv4W4ua5YwIu998t3wccg9AOcmUAz39Bosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335919; c=relaxed/simple;
	bh=sby8LvC8YKil2IckVU3xLmX+mjLXU2AbUum5CdAphJM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc/fTOph/3imuIkJIWxsOe92BL9nuZeuL12E7QXoxFMLdQ2U0CHGTyQLOj2n6U8B8GTI77xVJx2bNu5P+64EtyrTZnqLEsS782YKjEiTNDGjClWEstcZ5Rh2CyQ63ho35kFlLlsTQi40vE/0KOw+T8PzgzedjGhWaItQKY5oSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=yRnSNY0x; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=YglptEjK; arc=none smtp.client-ip=195.3.219.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id C643F20011;
	Wed,  1 Oct 2025 19:25:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com C643F20011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1759335904; bh=z3trVrrdax10FZKdXjtwDTMG3YFJ7fS0s6ViiPu5BHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=yRnSNY0xPrAsOlIvc21vdIlxivEzTjjBCkVcpDFhvRNg4RZnQsRdR1oz3okSyBoIx
	 kbO3xdJNWJ34hxADqhhRS2HhTcQd0X98rg8rQSw4uMtbxyHc4b+KZidleGTJPXAiTf
	 ayR3vkOwfHKaEPftfHrp3OsmsHYT02QMENotZFZZLeG4r3ogdY7HXaVejZkOBrFe8I
	 t8lPJ8DlhfRhU8I0stL5CbKMUbZyVryT/PvXTkZ3j3D+7Qz4/OvAJG4ptk1SbWcWzj
	 gdCXuSVuTb2gPdunOpbHzpER9UIVRhASgbr2LIYPtl25TitSVGXLIC6PYBuj6t9jsF
	 jWqO4FomhTvQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1759335904; bh=z3trVrrdax10FZKdXjtwDTMG3YFJ7fS0s6ViiPu5BHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=YglptEjK2TXWhCGZqHah1tlH1bgRhKVwM0HebuyHqWTs4eCr0oFewE9uxiJ9AV+Ic
	 XuPOwj5mgaUb1GgfY5Enm88Okx+BfgOzrtfUsM87acG46aLYk95b8pYefMfI9uAhfs
	 d1SCKS3Xsu8JmdFx+6J/+/7ETOD80zYJe3NlefRlZb5l7RDwMMuUwaH6gunkrQtjS6
	 JK87OhZF0AWeCkqH1/AZBW17tev2wa4+BcPmv30hCWw4XJzP5Jb1WCHrLAfnlcvtCy
	 OzXwdR5M+AMUSakzXoK5eiJ14aZHw9z5+S40e3C8Zrzv0fjqJPfbukF8sUYjyL+ddS
	 hxXBBOG4bAPMQ==
Received: from RTM-EXCH-01.corp.yadro.com (unknown [10.34.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Wed,  1 Oct 2025 19:25:01 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (10.34.9.214) by
 RTM-EXCH-01.corp.yadro.com (10.34.9.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Oct 2025 19:25:01 +0300
Received: from yadro.com (172.17.34.51) by T-EXCH-12.corp.yadro.com
 (10.34.9.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 1 Oct
 2025 19:25:00 +0300
Date: Wed, 1 Oct 2025 19:24:59 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Chris Leech <cleech@redhat.com>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Stuart Hayes
	<stuart.w.hayes@gmail.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux@yadro.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: switch to per-cpu page_frag_cache
Message-ID: <20251001162459.GA4234@yadro.com>
References: <20250929111951.6961-1-d.bogdanov@yadro.com>
 <20250930-tableware-untaxed-6a68b2e1e970@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250930-tableware-untaxed-6a68b2e1e970@redhat.com>
X-ClientProxiedBy: RTM-EXCH-04.corp.yadro.com (10.34.9.204) To
 T-EXCH-12.corp.yadro.com (10.34.9.214)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/01 16:02:00 #27871772
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

On Tue, Sep 30, 2025 at 11:34:14PM -0700, Chris Leech wrote:
> 
> nvme-tcp uses page_frag_cache to preallocate PDU for each preallocated
> request of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.
> 
> That can be catched by !sendpage_ok inside network stack:
> 
> WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
>         tcp_sendmsg_locked+0x782/0xce0
>         tcp_sendmsg+0x27/0x40
>         sock_sendmsg+0x8b/0xa0
>         nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> Then random panic may occur.
> 
> Fix that by switching from having a per-queue page_frag_cache to a
> per-cpu page_frag_cache.
> 
> Cc: stable@vger.kernel.org # 6.12
> Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> Reported-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>  drivers/nvme/host/tcp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d52..a4c4ace5be0f4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -174,7 +174,6 @@ struct nvme_tcp_queue {
>         __le32                  recv_ddgst;
>         struct completion       tls_complete;
>         int                     tls_err;
> -       struct page_frag_cache  pf_cache;
> 
>         void (*state_change)(struct sock *);
>         void (*data_ready)(struct sock *);
> @@ -201,6 +200,7 @@ struct nvme_tcp_ctrl {
> 
>  static LIST_HEAD(nvme_tcp_ctrl_list);
>  static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> +static DEFINE_PER_CPU(struct page_frag_cache, pf_cache);
>  static struct workqueue_struct *nvme_tcp_wq;
>  static const struct blk_mq_ops nvme_tcp_mq_ops;
>  static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> @@ -556,7 +556,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>         struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
>         u8 hdgst = nvme_tcp_hdgst_len(queue);
> 
> -       req->pdu = page_frag_alloc(&queue->pf_cache,
> +       req->pdu = page_frag_alloc(this_cpu_ptr(&pf_cache),
>                 sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>                 GFP_KERNEL | __GFP_ZERO);

I am not good at scheduler subsystem, but as far as I understand,
workqueues may execute its work items in parallel up to max_active work
items on the same CPU. It means that this solution does not fix the
issue of parallel usage of the same variable.
Can anyone comment on this?

>         if (!req->pdu)
> @@ -1420,7 +1420,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
>         struct nvme_tcp_request *async = &ctrl->async_req;
>         u8 hdgst = nvme_tcp_hdgst_len(queue);
> 
> -       async->pdu = page_frag_alloc(&queue->pf_cache,
> +       async->pdu = page_frag_alloc(this_cpu_ptr(&pf_cache),
>                 sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>                 GFP_KERNEL | __GFP_ZERO);

This line is executed in a different(parallel) context comparing to
nvme_tcp_init_request.

>         if (!async->pdu)
> @@ -1439,7 +1439,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>         if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>                 return;
> 
> -       page_frag_cache_drain(&queue->pf_cache);
> +       page_frag_cache_drain(this_cpu_ptr(&pf_cache));

This line is also definitely processed in other(parallel) context comparing
to nvme_tcp_init_request. And frees the still used pages by other queues.

>         noreclaim_flag = memalloc_noreclaim_save();
>         /* ->sock will be released by fput() */
> --
> 2.50.1
> 

In total, my patch with a mutex looks more appropriate and more error-proof.

BR,
 Dmitry

