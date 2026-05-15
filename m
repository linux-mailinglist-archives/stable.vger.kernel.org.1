Return-Path: <stable+bounces-247793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLwjAOstB2pSsgIAu9opvQ
	(envelope-from <stable+bounces-247793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:30:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF0D551740
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2158F303EC25
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A95385D9F;
	Fri, 15 May 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXjxnACs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="REXWZkSp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0E2FFF8D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855042; cv=none; b=ovOugjjFd4QQV9/89iHfCq8PbL7+3JXxQ+OKpI7LtH1oFAtasI+MCBR3CTleSdDcgnMVuHPu7bCCnMikI9CcdyTk3AbisehN5fEVCZN64Ly1B/X4agNbAO3kgSJ6lyXT9up4qs9+JqCauZK0QkIAYDYTy0EXZSLlzGkrvY9mjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855042; c=relaxed/simple;
	bh=8tMd4kBQi6Hy9PmLRVOHEXCV4eeVaKBxaPfChs5q6/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFUsKlIGi2fhm7hZFM94cWYn+JxL5SEy4CMEzyCu1KNVYgNStClCRyQ8+T5BRSJrTVp3cZ3j2qQk3PQDMd8uJVVM3U63twWUKMIoyuEsEL3bXn/FLoj+CiNBtTAWkoo5LtHiQGOPceAI/DvcnU5YqIbuHT8VuBML+UgVlFCKbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXjxnACs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=REXWZkSp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778855039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIVZ/gYLJQUpRzC6abUVWLp7JCDoikQOBxMDIsDaUrM=;
	b=CXjxnACs22vjibw4orU1K+aJe1+7zoyB9xZ1nLDoq/XIwADT/+yQ0PQdhSMcNqBb4asMjE
	Eu/DiWKS2yfmtvO9TZittt3PBTjKJS/usJ6tz49tRHLLaCCz39QiFuDSu4yshncC6jEwCe
	1Xvu3heLzf0H+NrgOV/xKA38jc2iwIc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-lEsyxxgtMg-SsaQk7JWdbQ-1; Fri, 15 May 2026 10:23:58 -0400
X-MC-Unique: lEsyxxgtMg-SsaQk7JWdbQ-1
X-Mimecast-MFC-AGG-ID: lEsyxxgtMg-SsaQk7JWdbQ_1778855038
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90fb1490e2cso698012085a.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778855038; x=1779459838; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lIVZ/gYLJQUpRzC6abUVWLp7JCDoikQOBxMDIsDaUrM=;
        b=REXWZkSp8NzTTY3L7F6URJWjOmBciYmL9mbWzmZbzx8MK9wnk11PbVhLGAVEYtrAS6
         u0hkulSv3sN5thUg2lnrIh0R3Rzrcv4kSmS8Gomiwqq1EPFxMsk38IbEKHtODhn6s5V4
         089akn0ygQdiBK6VVUQyIkx3kDdAY8xY4nJ6/TVSaiIjR5w90TZun6mQHXCOE1IWUq9K
         0FwCs1TphftXAnxyIrDI1N4MjcVoJSbw/Jx4/zxYY3t5U162Gs7Xa20fPJXOGTvmWQSr
         umKLxC8U2beGm/ynG/4mchBHRnDN6Yz+StWQj5g7asn2yqVgplDzn/sGUzGXEX1apWdu
         Bo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855038; x=1779459838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIVZ/gYLJQUpRzC6abUVWLp7JCDoikQOBxMDIsDaUrM=;
        b=HcE+/eiXzAZtuyTRynIMCiWWdQmNelWRa4wgPfbFLVR/ZEmPN1JNM2jJibfWHHbs2H
         FRjhnZAykTOPmJz+h+0ZiLyPCutnbD+xNukqseNcNN+Q1LD67skpOQ2jcDt/CcDhP4Zn
         rQh5JHISU3VGGOAcDHe0cLHN0GJDm4NmZPPeLIp12LCjrqC8SyWdToWmcZ1uwdKQ/A0L
         +5cnsgILooSQFN+MFEETNcpC0mhDHLhEjZWjq5xlss5J4RZxBBzNghkKSys4nU+GW24t
         BgOjQZI8NX6+KiCTbLhOEXDFlnEn7g4QBhBNfgAUVdi/vdghiR8SAMWDzDmlBp+UdALD
         0dKQ==
X-Gm-Message-State: AOJu0Yz+UgYiOZ8xGPEbBxeB8tryHpZ3H6k0GQQ0fRv8E+8DLP0WOuBN
	umko6o1LR96lPcROs8EmgpSomyhiajeyWs9j61TU1t3zWb9EN8+4FW/4Ux5sLWY+Hy07bmNOsZ/
	TBLNyhW2spDKQ3yiiwBRFt5PuVw+TVBoSILxLLhFj2efx2SrNSktHjBdpfbaJbd1Q00YccmnsNi
	+yinJwzF7MkyQ4/UoCwx4+jRPY+0ibcJce9piRADu7Aw==
X-Gm-Gg: Acq92OFsKKmAlREkJZ/nioTqD/nIcJ+ZOTly2I9+qDWLNcHLo3W4hAkAv89ePacD9wi
	0b9onISTMqtJaOP5SW0eWrEfiKj0RULseUFXF+V8njkq5o8smrOyg1r1wdV0HmEgICbWPAegUiY
	EypbIumF2NZ4dg1bqItE7hU8AEBE3aIQOo5hiZNECq9J/tCaFhqVFzOpiQskTUOe3te3VdvLLPy
	b707f8q5P3CTpLjtvvAYxTlqNdnHaOOVBpUe9KGFIuUItbVdcUwk8q8Og8AqP2TzoVj8sN9wfEW
	M30/on3AgBCWHOFHfrxf6RN1jsoIHBtjsCvAl7C+Zzr/IFmzBn7zmdOT5lE3ixYW/GClkoziIhR
	lyPoIXtSzQA9b3bYtlyOJqT3jc2pO1/GZ7n/zyUciIccU/zNE1s1RjJ2/IHw=
X-Received: by 2002:a05:620a:ac0a:b0:912:61f8:cab1 with SMTP id af79cd13be357-91261f8d5b2mr222479985a.25.1778855037889;
        Fri, 15 May 2026 07:23:57 -0700 (PDT)
X-Received: by 2002:a05:620a:ac0a:b0:912:61f8:cab1 with SMTP id af79cd13be357-91261f8d5b2mr222472385a.25.1778855037128;
        Fri, 15 May 2026 07:23:57 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd620fbcsm570309485a.42.2026.05.15.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:23:56 -0700 (PDT)
Date: Fri, 15 May 2026 16:23:53 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] vsock/virtio: fix potential unbounded skb queue
Message-ID: <agcsQ4LlG9ZsvBGR@leonardi-redhat>
References: <20260515-dumazet-v1-1-73468c902889@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515-dumazet-v1-1-73468c902889@redhat.com>
X-Rspamd-Queue-Id: 5CF0D551740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247793-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sberdevices.ru:email,alibaba.com:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:22:12PM +0200, Luigi Leonardi wrote:
>From: Eric Dumazet <edumazet@google.com>
>
>Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5
>
>virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>
>virtio_transport_recv_enqueue() skips coalescing for packets
>with VIRTIO_VSOCK_SEQ_EOM.
>
>If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>a very large number of packets can be queued
>because vvs->rx_bytes stays at 0.
>
>Fix this by estimating the skb metadata size:
>
>	(Number of skbs in the queue) * SKB_TRUESIZE(0)
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>Cc: Eugenio Pérez <eperezma@redhat.com>
>Cc: virtualization@lists.linux.dev
>Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>[LL: Fixed conflict since this tree does not use buf_used added by commit
> 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4c374c36c29d..86e3051d000e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 					u32 len)
> {
>-	if (vvs->rx_bytes + len > vvs->buf_alloc)
>+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>+
>+	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
> 		return false;
>
> 	vvs->rx_bytes += len;
>
>---
>base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
>change-id: 20260515-dumazet-07c0c855a9e2
>
>Best regards,
>--
>Luigi Leonardi <leonardi@redhat.com>
>

Forgot to add this is material for 6.6.y stable tree.

Luigi


