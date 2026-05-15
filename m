Return-Path: <stable+bounces-247839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBK2HwBBB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:51:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73C552698
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF3713075E8A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B054E376E;
	Fri, 15 May 2026 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GL/kxzcx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6QAamW7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E53F9271
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859388; cv=none; b=sArwaYcMFGbDUgEQOohgTAlu7yQE3Tvz7JIN5TMWvmFWPqUofMaEPmi8tS+pXdfe3j1ZdyV7bNBQ2MSDb9dyDPBzc0UYMIgZHeAe9myYQV8YxscYdfwnB/JYuNL/+P10CkrxiX2Lkd/COiOJ6yAlR4BppOxvsMSTf7Q2iN2LG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859388; c=relaxed/simple;
	bh=KxLABsT4GW6xy83byG9jRVMNzNmX8FC8tAkv3Z+4gY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbuOInvuTXCh2k9P+saQUCJ8ysAGRd569x2izSK5p5kjwVGAGeljbpE92FLmEWm03Z/JFl+btE8DRdVb02zrBspuVGdFC4S+HN6qoioRlptX+glBRQ6jEEtRwtx+AulhRll2WvXo6EhYQO7SmqGIPJwuq+KOihI60QPu7AuC2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GL/kxzcx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6QAamW7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778859382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSUwP/nePskW3SE3+3GAjWBn5fs5Ffp9tDDPc7lUU/I=;
	b=GL/kxzcxoLtsa+By73TSeuFMupG3Tphgn/99nhil3h+QcxiVWJTrfpfcnAgf9H6Wcmf7bX
	y2oC6xKZ9/atIpR6eMRDYNqvXaTFhFBhzJwqZ631ID+TUoOKyLkcsLJ9z/KEmZPtomDLGl
	+KzUbLc3rv4OWNhIhCgQrNXBDjWQh34=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-fqYXJfxMOqWAJh5gZsI1oA-1; Fri, 15 May 2026 11:36:21 -0400
X-MC-Unique: fqYXJfxMOqWAJh5gZsI1oA-1
X-Mimecast-MFC-AGG-ID: fqYXJfxMOqWAJh5gZsI1oA_1778859377
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48feb0298d7so7128315e9.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778859376; x=1779464176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CSUwP/nePskW3SE3+3GAjWBn5fs5Ffp9tDDPc7lUU/I=;
        b=g6QAamW7dNMGrJgga8LMGwNTOI/FHxVHcM8Kj/zPIQ87o7LSPC8HvcbmDpyWSuKrXS
         FRV26l8MGucIdJ5LaKPih5AzUwFpN9eFXNplt9wAWVc62SQO36hZECMfcehEbMBbTwOd
         h0v06zJ50q+MAh688KYKT0yNlmlDJ0EqlWRaZObb7yYgth/WwpGSW7ny9b//U9TrWSrv
         923lzPeKAnmRRyUh7dvZ373RWkPAWWbXLXnEpNzQePaFGbpJ2gUj8dTUvQTqLti+Wpxt
         AcOCMd3MwjBAC6Uizmt1kKHN0W2wkU+a9AUfzQB/nrpPh9XUwSbw+f/0RtGahMwHxRAY
         aSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859376; x=1779464176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSUwP/nePskW3SE3+3GAjWBn5fs5Ffp9tDDPc7lUU/I=;
        b=Pk8jkC/mPkhfcrm9IC35nD0zxX9tgBsVOr2j+MhOKrf6H6kEQj03jzgCcpyvkdxFdN
         SlV6rKAlG6Q2EeXUuGKmFg44krDUGW7dHpEISJ0+gSKVf/hNzy3B6QSvSqODEOga1MpV
         mx5prk6vL1vKCqMyfYlSs/Q7bGVQlmKbb72TlzumodLX964wm0vZ9+m5/K5RxZHLpWgh
         PjJgS8RDcOMlQRsEsty+AifTb1e/pL5iQ9I+Coog/nZCtvfo06ptnLAh9m1OMr7UnJZb
         8fo87mVW3wA3IyyEpyso9yh/f1/Ln23SWElDSjLYidSuNV/hPUeG9nkUHpBW4MjT8jba
         FRhQ==
X-Forwarded-Encrypted: i=1; AFNElJ85v8ZLfUcJLe5ApGiytfyqfSktV5l+2i63L33Jn14fri63XfHK9eqn5wKpKxW0KaS7ppdT/G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVESs0WMPs9IDpiJGt0w9moJLzSBpPs2tpzCqIesXEmntkljv
	ph5a/xPhAAfV5C4FdXK8Xa1b3y1RgxWoTFfegv+Ux1rXgaao0/pzI5Ynq/IelBrPbnZoizlXyg0
	8JBrfguUVaFnjadd2CJlUIgIXVaG0NbtODm25rbAazzngO0Q3/CTSIIJeIA==
X-Gm-Gg: Acq92OGDqOyuNENRbuknoQxRtfHzivjdOASpATHQmStx7u+ODKA48w2XpO/FdawH9GY
	KVSBSBLBEe3jy9TihDPXKDdZzVqaMrL9tU/4DuFGCPRobezkxaZR9sgKiWnzgxubq+UMoIJMCk2
	eyjSuJWN4OoVKH73e7oLkX7FGbn6n6ULxrApoeDoPz4KhpwUfNmvCydvcSXuse4d2NMI6k8Uzi8
	7AEsXRic+fiFumyMP0Yz9ccDMdZSS3g6thDl+PnBPRKe9h843JoIB1KaQw5AumpQihvlesFCjII
	mH4yFhGSQBcHNOaFS3Lem/S6LSIUWVlSib290i8tCyMNpIMa6+D4WR6VhIxXn6nYuhxKQ2AZ0kF
	WyDDrl9qsExdPMUq6YphIu0KPI+Lbw6IqGoBvka1u
X-Received: by 2002:a05:600c:c10b:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-48fe60eb0f6mr44773425e9.9.1778859376431;
        Fri, 15 May 2026 08:36:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c10b:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-48fe60eb0f6mr44772895e9.9.1778859375931;
        Fri, 15 May 2026 08:36:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe78aadsm15492085e9.29.2026.05.15.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:36:15 -0700 (PDT)
Date: Fri, 15 May 2026 11:36:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gregkh@linuxfoundation.org
Cc: AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com,
	jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <20260515113503-mutt-send-email-mst@kernel.org>
References: <2026051553-santa-unretired-a417@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026051553-santa-unretired-a417@gregkh>
X-Rspamd-Queue-Id: 2D73C552698
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247839-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linux.dev:email,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 05:21:53PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     vsock/virtio: fix potential unbounded skb queue
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      vsock-virtio-fix-potential-unbounded-skb-queue.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Yea I have some doubts. It fixes the DoS at the cost of losing
messages. We are trying to fix that upstream now, maybe wait
for that?


> >From 059b7dbd20a6f0c539a45ddff1573cb8946685b5 Mon Sep 17 00:00:00 2001
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 30 Apr 2026 12:26:52 +0000
> Subject: vsock/virtio: fix potential unbounded skb queue
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> From: Eric Dumazet <edumazet@google.com>
> 
> commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5 upstream.
> 
> virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> 
> virtio_transport_recv_enqueue() skips coalescing for packets
> with VIRTIO_VSOCK_SEQ_EOM.
> 
> If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> a very large number of packets can be queued
> because vvs->rx_bytes stays at 0.
> 
> Fix this by estimating the skb metadata size:
> 
> 	(Number of skbs in the queue) * SKB_TRUESIZE(0)
> 
> Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: virtualization@lists.linux.dev
> Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [LL: Fixed conflict since this tree does not use buf_used added by commit
>  45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/vmw_vsock/virtio_transport_common.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_inf
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	if (vvs->rx_bytes + len > vvs->buf_alloc)
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +
> +	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
>  		return false;
>  
>  	vvs->rx_bytes += len;
> 
> 
> Patches currently in stable-queue which might be from edumazet@google.com are
> 
> queue-6.6/net-fix-icmp-host-relookup-triggering-ip_rt_bug.patch
> queue-6.6/tcp-call-sk_data_ready-after-listener-migration.patch
> queue-6.6/net-sched-sch_red-replace-direct-dequeue-call-with-peek-and-qdisc_dequeue_peeked.patch
> queue-6.6/ip6_gre-use-cached-t-net-in-ip6erspan_changelink.patch
> queue-6.6/vsock-virtio-fix-potential-unbounded-skb-queue.patch


