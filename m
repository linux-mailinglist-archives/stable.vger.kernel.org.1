Return-Path: <stable+bounces-253621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM3jDVxCD2qcIQYAu9opvQ
	(envelope-from <stable+bounces-253621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:35:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3485AA59B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7F2305F147
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D483D9041;
	Thu, 21 May 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzBH2mki"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674237DEA9
	for <stable@vger.kernel.org>; Thu, 21 May 2026 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383635; cv=none; b=CbRH0OFPRYHCCpEDMmoxeGPeREKgcWN1z5eZpuQsygT9JShQcwjQl0CC767UNZ1wS/DKnSod+H2e538z6ykC6iGOVnyAX+vgfv+ZfE9PE+oa3lHt8Eu9LkRqRfa+qZRxl26447TUEgEioiRXMx900P7rbLg5jWB3r+jicjdPqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383635; c=relaxed/simple;
	bh=X9MG1kwNUf8O8KAK/Sm8SuGe/dZdaTwPaR1MzEF3AHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClvOkvRb4agSCPyWdJsGm6QqAkYOy951O5m0mlQg8pgMS7fmchSXqypyuQCLRuKmaaZQaEiBqJ3D3KCkCon3N+vl+v5Piwf33WDo1PdscwLnKfTHNGudLSZEeeZQY7iVdgzy+UhHU4HcCljdwkE28G07jcu4OAjRy913bXzLws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzBH2mki; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so89652105e9.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779383631; x=1779988431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIuChPU1JlP7AlPyeu7nnCYpBOhiwGUpJRXAIqjmuvM=;
        b=nzBH2mkicctXAN/292q5htBM8uJbtgNpVclJmeiZKdI2qZBJzQP7W0t8OkfXqX86a+
         U9FNJkbdGMFuH1WuT5mjjd+aXL57+dA3HUPOPJrdtueEf8H/PeHL0dfOiBJdv5ZdbUEc
         DEEd6F5mW+px4Cqdq3Z4sWqqWrHweRIdrrYt8k6W735dfAkvHALNt/obFyNQnGDjTwam
         DKE5qj2VWkcmqngZnzjza3NOZoIjJHPK5GDe/CQnpCNJJJ9h6JdmWI67EqhKVibqNKPT
         Z0100IzuYtrGo5eGLQMg7cgIc46ZruFAZAvLfMipIL0nLAsXeq8fTQRgHMTfwqNE6MMu
         bkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383631; x=1779988431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIuChPU1JlP7AlPyeu7nnCYpBOhiwGUpJRXAIqjmuvM=;
        b=Jmh5UPDz4mPgb1wTkgaG8JAXzyhG01Ejg7/35G0Hsy2b1MPz7SESfFCwapOZX0PU9h
         TEbeGW1dqnWPRRLL2ZyUwSjSGWTNLM0YHKFrZ/TOf7WFWOcVJ2vXD38TXqNCQFHiIXEn
         5qbw+ECdjtS+mr1B/fchF3jp5t2oYJJqZdJDLVS1kVOLj1VpXubvPPuqsgUJB4MExGaM
         19QdekRnNTQlG2eleOPL5vgjMWue1ElJp31QJuRWM5MUKtlkmDqLUIfB/FgUyKiXoTO2
         Hv05LNX8ABpm17QDg7tlEl7QbDB7uCe9InyxKXO6BQy6kDDVPYkA/uwxMVwweFfhyYH9
         Lj9g==
X-Forwarded-Encrypted: i=1; AFNElJ/Xrf5NvqpqYFC1quQSZe2zo5QdwrspxBW1fRzM628ixiZgGB0UAeVUpqUazqH1hPZDAc1K9l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0LleCXEze95sy/k8cTfBtoKTKRsg27iKZRqGUFJOu1Sb6qJz
	VpWtYBgomN0nBSK18eVqKnhiPWfX1/6UF7zzs9y4xVvY1qGmLV2MRdkF
X-Gm-Gg: Acq92OF+ormHk0IqFsfCYUixpLTl+vZroMHF7OUFhbs4IEB354Kq0BxM90e0PnvvlL/
	4d+DYXHwa8pyrhnT+gmdcyGoMsdaCGgvWKrobkjsVXXOkE7/2NsnoLA7O65mYPGl247Whk2FMKl
	0voncYMsJWI828WetWBVyD3YF6N2R3T82ptB7igMxOiFXiOQ4m8T3QCmCEwaQW8KZD6/bdiUiA0
	1PtECQ/43W78OthHOh7SOZF6CDLllUTFtnR96SodNGuQcT42fhMJg4RKkMmwxKte0+RbzrjzTDB
	Cx6IPkGDTkCMpgDH1Ai5YrI/zmPh+/P9MtSL3ka7hyXHQ+x4r8Kfz/3RR5hYmWGLoMrYETPZgsP
	tjAm2hlz+euezImyc4oniIIQlNotmCds6u/2MGarBnjlkuiaY+aV1GXsQjqVY9xCyxhChSNLfWv
	aatmVJe9QUzlq/pVpdtLtmiFqNzu2dDvQVX7ZMy5L3rElqoRepayREYoLQxZCJYlAZ
X-Received: by 2002:a05:600c:828c:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-4903606b5b2mr58827015e9.19.1779383630691;
        Thu, 21 May 2026 10:13:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cf23bsm4086708f8f.5.2026.05.21.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:13:50 -0700 (PDT)
Date: Thu, 21 May 2026 18:13:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Simon
 Horman <horms@kernel.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Dumazet <edumazet@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260521181348.3d61858e@pumpkin>
In-Reply-To: <20260521124732.125771-1-sgarzare@redhat.com>
References: <20260521124732.125771-1-sgarzare@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253621-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A3485AA59B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 14:47:32 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> to 32-bit values. The multiplication can overflow before being assigned to
> the u64 skb_overhead variable, making the skb overhead check ineffective.
> 
> Cast skb_queue_len() to u64 so the multiplication is always performed in
> 64-bit arithmetic.
> 
> This issue was reported by Sashiko while reviewing another patch.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index df3b418e0392..71198bf23fc4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);

I was thinking this should use mul_u32_u32().
But that is all moot.
'skb_overhead' is a memory size in bytes, 'unsigned long' it more than big enough.
No need for 64bit maths on 32bit.

-- David

>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff


