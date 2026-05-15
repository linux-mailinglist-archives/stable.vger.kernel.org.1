Return-Path: <stable+bounces-247833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALD4M6E8B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:32:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 406635522C9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9FA13035B4A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC764ADD91;
	Fri, 15 May 2026 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEp7J8Ku";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pJcdJGil"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332F4963AC
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859120; cv=none; b=VGQjBrR+b0irprBpaJqF9peaCQBHNdBpyaMRHNM2NWnX9zmQW9wU1rqOLZkedyZ3WNSgg8B4bKzrKDXiEsInS+xlnltDrb9jAVk1tMhV+X2CsMPWiEOqPZOZ/DL6kZRAtV6jEE4SPbwS0DpwJSMObfZj4I5sKoZVohYDLvs8SeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859120; c=relaxed/simple;
	bh=eVU3MNy62hkr4mZA2kAadzm/wO61vBgqYeIJY4Hn+Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q60/LpRxQoVLzJ5qlWmJJCf/y20xVSg4WtmwAaKlX0HnD+0Zma1VvPUany2XPLl1GBPtalOqtQ5dtazlF+sy9j/FaQlocWUPJqAQ6VPSbXNaKhDyzYbb6AzVhBIa7zQ+K+vL+U9VeOkxgllVX/39r4i19i760P1Jp+YY7xU1AAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEp7J8Ku; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pJcdJGil; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778859118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNoThb3GH/r9XH/lrFbBvY61nIvTAMuk1snRo8d5TUs=;
	b=XEp7J8KubaT1DTA+gnWifqbzMbfwgT9yo3efyfSnNsiTxTdiVIInzpCdExu3BdLBDkV3Kl
	2b1BFXBKwiOVuUxXxGD/Xbq674SMmTtKIPJpFq4PWTzRc97fKBYiNX7yU+2IND0AutwrIM
	drx/M973gnoCPbb3u+PVm/f7/BoUBVE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-s0B20IbXPA27NfDiTy5JzA-1; Fri, 15 May 2026 11:31:55 -0400
X-MC-Unique: s0B20IbXPA27NfDiTy5JzA-1
X-Mimecast-MFC-AGG-ID: s0B20IbXPA27NfDiTy5JzA_1778859114
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43fe791a398so8295891f8f.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778859114; x=1779463914; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NNoThb3GH/r9XH/lrFbBvY61nIvTAMuk1snRo8d5TUs=;
        b=pJcdJGilH0499eSCkkTgR8HiVwppi58x/GgmM6g/Rv37M5F65deqfaI1m/b4v3ihb3
         s7dfNTfezNO8TLXDYoD+uXcJ6BUFC1gliu+9EiWRPQEaHaBCCWFJiLSl1zNcBNFjOoDL
         r/x6irCng5604OuFeA9oDHTpAX3IE/lTPx69ZsXBaSyjpRw8Y/W82q3zLLxsfwiPux67
         AZP2bGNrHnZXXZztGhwwnmSk4oWRTrmpDc4G3eNVIVRVsyLzIll7uwPamJsD9+4WAUkH
         e+XHBkIVXlItWmW1+6UloP4eNUV769H6XxROlIKJM8Ae29sx1EQ1zq6NVBT23O+A6xxE
         Qmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859114; x=1779463914;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNoThb3GH/r9XH/lrFbBvY61nIvTAMuk1snRo8d5TUs=;
        b=qp2elANSIqNGIu+45x2oXdR2fKUrMTcaMf2hftclz1dh2zVRcEp7R4hSP0rUDPtTYm
         mEILCYlntwWPDf2khW9oh9Vtr7LiQHb9Wyz8lQf2fGItkcfyPfEja42REAIHtQLWAcMr
         pgyMwRnhmIVYzWAWOCp5PpzCTKSCf1DjCNcVeVIR8RvFISz13A497FDNQi6pUV+k9t7G
         2+Jy82kWBVKSjiTyEkzWUZjhJyCJ4nftf6pktLalaep+q68EBYFE6cUAovMjBucwGagR
         7/1UvpmReyjppB8cL6TyeZRR+BcmeGwJwZrE24x2TYy0jmEXWHEwdo558xqLl2jJLkqJ
         Q3YA==
X-Gm-Message-State: AOJu0Yyfam8ttyi3qIoCNiQGzr/pc3CMZEmAK38GXId9C1Azx63KXeIY
	R+8//D523q6Muc5SJfpvm9Sv+vE1XJ61UJ7gEMdA6lD9dRZkpv+c+ljrt2S64VOYZpS907x8Jut
	aoovrKItwee8bI+GT7PyCge9bvlBYKID1wYSoo4cDfkWrqcHir6mnN9oT0A==
X-Gm-Gg: Acq92OFnR9U6QjG23j+L8AJDKYepYlrSezKw8RawZ2NrMQfrOyifi5oz3raVv1ilTbF
	TC/rKfMN8nHw5O3inA9dUQWOJdP9QZnweMOBD/C0BNgnCGv1icy9HA6gwctMQvBodJOMVTKX3tF
	jljY2hgZmP4op2CxIqk9GkaPqf7cZV0Lk8mbsMq9IsaC8U6JjQtCLDzien9qUGT1wSecWrx8TrV
	uRRY7+RilHTrmIChGxJT/jUUY/FlaY6WpLnTcnXLMA8UOG42e1PomhzZz9AYjrqNcJkZvumLetL
	kLzBKPljUeyyvcbM7Ls/hmZJzudhWWGj0G5+1q/zIwcEKSvg5VvH7Vek7mcskseHwdYcEDJ7iSJ
	row1xuB7AnmxS6zbjQHOuyK0A0L9n8gaLVqrO/y2O
X-Received: by 2002:a05:6000:290a:b0:43d:1bf6:30f7 with SMTP id ffacd0b85a97d-45e5c5d2c12mr6598350f8f.18.1778859113652;
        Fri, 15 May 2026 08:31:53 -0700 (PDT)
X-Received: by 2002:a05:6000:290a:b0:43d:1bf6:30f7 with SMTP id ffacd0b85a97d-45e5c5d2c12mr6598277f8f.18.1778859113136;
        Fri, 15 May 2026 08:31:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm16563554f8f.31.2026.05.15.08.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:31:52 -0700 (PDT)
Date: Fri, 15 May 2026 11:31:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260515113100-mutt-send-email-mst@kernel.org>
References: <20260515-dumazet-v1-1-73468c902889@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515-dumazet-v1-1-73468c902889@redhat.com>
X-Rspamd-Queue-Id: 406635522C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247833-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,msgid.link:url,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:22:12PM +0200, Luigi Leonardi wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5
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
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Eugenio Pérez <eperezma@redhat.com>
> Cc: virtualization@lists.linux.dev
> Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [LL: Fixed conflict since this tree does not use buf_used added by commit
>  45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 4c374c36c29d..86e3051d000e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
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
> ---
> base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
> change-id: 20260515-dumazet-07c0c855a9e2
> 
> Best regards,
> --
> Luigi Leonardi <leonardi@redhat.com>


I am not sure we should queue this for stable yet. It causes regressions
that we are now trying to fix.

-- 
MST


