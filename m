Return-Path: <stable+bounces-190048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A759C0F87E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265D4189C2DB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBA4313E0B;
	Mon, 27 Oct 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d58SYbVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B637E31354E;
	Mon, 27 Oct 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584889; cv=none; b=WDqgBLj+I4Qwb2TSZgmQwkc5Iwp1RbQME9++PMQRG3Sh+yfq02jxd8h3U6qeLZ+ahkzNJ6IiX+Fdwst+qQq1eDPuHBzYPql2qWOyjm3lLBymtV1KoZ7QlJ4FTLeUsjXJri39091QjfskLR5Cz9GZZtqqVsd3gF+SLqw5PXWTGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584889; c=relaxed/simple;
	bh=EilW+nxGrIUIpn2MiL43G+5U1z6hqpgMZANWtWAe0qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9n+MDIb8yVipBQ6pbPDcoJ4+SDwDKfYpv3lOzwaJjOXgL+JWkyoYGCm38xtASTSnQ162RIUt+bpdp3egzFw5WZ+C1dsxsKFC4QfYJ6DPB27YQLJZKZPWXsQ0sXJNa7HgVeUM+rTVoGy6Imhf1A+fNRp/A6SF5nWKD1J6vffxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d58SYbVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FC9C4CEF1;
	Mon, 27 Oct 2025 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761584888;
	bh=EilW+nxGrIUIpn2MiL43G+5U1z6hqpgMZANWtWAe0qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d58SYbVPB+S4nASv/FYx1vUTcI7rYAqA0IL2HECu/iknwt0uJxsm+0yfTlU+dul2X
	 apIp7WafXevK3+wxWdalpq89/F1LlrZA9+01IBpE14YCjuLyZW0+sJ20pZwzBlRvDc
	 XsuICJ86eyNIPqx15FaHw/5TV1ysMLUrjW2dMDID3aivDMagBG+7Fiy1+x6DOrh6Ny
	 FiCWFYrv8ODRM/BuoNKhBIeoJgqrWgozByZpMGB0GvPIDbjCMXIDamuin9zhLnXCCD
	 g8xu7mUlwOl9vkfNrx6c0mJuH/VL/eCH8/v7p5SZgcLnfg36ooBMtHmv/MxJPJrY+O
	 zvVScxptlwPnw==
Date: Mon, 27 Oct 2025 11:08:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@yadro.com, stable@vger.kernel.org
Subject: Re: [RESEND] [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <aP-m9btCap_dt32Y@kbusch-mbp>
References: <20251027163627.12289-1-d.bogdanov@yadro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027163627.12289-1-d.bogdanov@yadro.com>

On Mon, Oct 27, 2025 at 07:36:27PM +0300, Dmitry Bogdanov wrote:
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
> 
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

Just a bit confused by this. Everything related to a specific TCP queue
should still be single threaded on the initialization of its tagset, so
there shouldn't be any block devices accessing the queue's driver
specific data before the tagset is initialized. 

