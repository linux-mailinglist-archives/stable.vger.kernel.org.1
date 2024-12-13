Return-Path: <stable+bounces-104151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA079F1551
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 19:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B9C1885424
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132561E4113;
	Fri, 13 Dec 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnRPMXOp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288DD1547CA
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116218; cv=none; b=dDqVK5wus3hnn6T4Q2uzg9VPRtboJ0ZteDPH69lD2CYiHXp3b1OHTMlig0N9YamEZhYdbF3T7jupw+J7pt/MvFkl2rVJ93x3aU+r/EHW8vcgthc/OAX8MLm/i/HyYF0kVUFwgA6ohzDU6wrvj0VkGmKpqfjEi7+wGubvdOiq5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116218; c=relaxed/simple;
	bh=0e8+O4JghJjhOQLcENPhwMKgyqxGrawAEp6trfJkwX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdw/Nke38gF64vp+3DVlUnBipbgBQQrReUrnNdJGijUPiTvz7tiQi6yiyYddnyfUznTVDNIsGYnDosX17gcnMz7cI/X8kTN491qPlQTQgqkZsOoXKtx/ED9bkAAoECboqhZSeH5nZMMEAXBcbHMdvoGN/jG2LPgbBOB9ZofGQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnRPMXOp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734116216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSWErHRXKNGRotJcX4TX+3LoaFXgTw2aXPJkQdAFSEM=;
	b=KnRPMXOpsKOihYrvkieEIGLTyoGNt/OqBmo8k75MBzsTKZkjAOEEOC5N9eZeU8SmmDIfpU
	Uo6kYvc88p0TmxIaYETISiCR1d4I3RILPqv1Qjb2V7vIlunC2gmI7sRaL/+YhRgPJTzv3X
	1MHeKrCQBViPnu1H9EKrUjrHBaqV1a4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-JBRweVjpOPSFwctf2x2oHw-1; Fri, 13 Dec 2024 13:56:54 -0500
X-MC-Unique: JBRweVjpOPSFwctf2x2oHw-1
X-Mimecast-MFC-AGG-ID: JBRweVjpOPSFwctf2x2oHw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385dfa9b758so908156f8f.0
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 10:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116213; x=1734721013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSWErHRXKNGRotJcX4TX+3LoaFXgTw2aXPJkQdAFSEM=;
        b=Xs0p45p17bMcotJk3TOs2xe6XqDB0Vj+oh34I3vgEQfOI9rs5D5zaW9O76L5kMJ8aD
         XomJ0RxcKDclmnY4TwBCFlFfIK5qHC1TwJe4rhQLMcuV8fOftpBwKRpZrz57sSFDzA6P
         ZUVbIi8h+9lj7G1s9GAi0t1qft9/g3mvs/APbVnWAlfnjl2mkyqol/OCFDItswQDkS1D
         /H03D0wYlP37bUPx/0lL0Kx/KdNBLd2O79yQ6e3szukV01a+9UAtO/de45h1+s5KGMkd
         N3AAyB2yxDsFM3QsIF0CcEzsQqOFqQLDZvTz6alAOLOr8mtzhT9unW2hUSUXlT+wG8Mt
         5BSA==
X-Forwarded-Encrypted: i=1; AJvYcCVJXx405QvLhklRoz/8QoFW0EdnlotV0LSFjVzoajH3acX9hBxttOBNOep/Os3toWy/DVw63qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQG+fgU85Fwd1xTAcUO0jqwp71l57AVDbHwWVH1DVN00RRAz1
	9eRtYwgO3zUoQzFWKpJ1fQkPyS4MTOPdi8Vux6+nd9piexGulKTTVPovC4ksB4mo42wl6QmGJg2
	0OHfoiVvMF5SqgDDQNraSBTwxbhDoC2mnhB0jyCVB1B0t+5H0GNexXQ==
X-Gm-Gg: ASbGncuOc9Chb50Q7A4GNPvP0A/e7rqKo/TDH9xnm1wV32hQizFWX6IhdMepd8C/aq0
	OjD8juTN8k24C1BA44E3dmOMNe9G+FPdLrdlw/N0JLZGC5B65k87UIj1Ogj4ncSGVWIT7++YGWc
	5yTZN6UPFQ3JSsXAvAUcfIi+8sfoBh7yII+vWjCBrozqCka5X9tQ5nvoDNSeD/iOihrB51S6EB3
	LCe7p8/CEVkjuSngAWQ5mk9TlielEppIX9IL9NgrtNkJjhGyA==
X-Received: by 2002:a05:6000:794:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-38880ac4e7cmr3050391f8f.3.1734116213679;
        Fri, 13 Dec 2024 10:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFmEoxZ7oTC7ewoVyzBb6PwbuHE72nB815J+LoRsQZk17+X7REMkpPohPRnME6F2e8xvb8mQ==
X-Received: by 2002:a05:6000:794:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-38880ac4e7cmr3050374f8f.3.1734116213342;
        Fri, 13 Dec 2024 10:56:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:66af:6381:7d28:90f3:9fad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016c0bsm294729f8f.42.2024.12.13.10.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:56:52 -0800 (PST)
Date: Fri, 13 Dec 2024 13:56:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH net] net: tun: fix tun_napi_alloc_frags()
Message-ID: <20241213135635-mutt-send-email-mst@kernel.org>
References: <20241212222247.724674-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212222247.724674-1-edumazet@google.com>

On Thu, Dec 12, 2024 at 10:22:47PM +0000, Eric Dumazet wrote:
> syzbot reported the following crash [1]
> 
> Issue came with the blamed commit. Instead of going through
> all the iov components, we keep using the first one
> and end up with a malformed skb.
> 
> [1]
> 
> kernel BUG at net/core/skbuff.c:2849 !
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6230 Comm: syz-executor132 Not tainted 6.13.0-rc1-syzkaller-00407-g96b6fcc0ee41 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
>  RIP: 0010:__pskb_pull_tail+0x1568/0x1570 net/core/skbuff.c:2848
> Code: 38 c1 0f 8c 32 f1 ff ff 4c 89 f7 e8 92 96 74 f8 e9 25 f1 ff ff e8 e8 ae 09 f8 48 8b 5c 24 08 e9 eb fb ff ff e8 d9 ae 09 f8 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90004cbef30 EFLAGS: 00010293
> RAX: ffffffff8995c347 RBX: 00000000fffffff2 RCX: ffff88802cf45a00
> RDX: 0000000000000000 RSI: 00000000fffffff2 RDI: 0000000000000000
> RBP: ffff88807df0c06a R08: ffffffff8995b084 R09: 1ffff1100fbe185c
> R10: dffffc0000000000 R11: ffffed100fbe185d R12: ffff888076e85d50
> R13: ffff888076e85c80 R14: ffff888076e85cf4 R15: ffff888076e85c80
> FS:  00007f0dca6ea6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0dca6ead58 CR3: 00000000119da000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   skb_cow_data+0x2da/0xcb0 net/core/skbuff.c:5284
>   tipc_aead_decrypt net/tipc/crypto.c:894 [inline]
>   tipc_crypto_rcv+0x402/0x24e0 net/tipc/crypto.c:1844
>   tipc_rcv+0x57e/0x12a0 net/tipc/node.c:2109
>   tipc_l2_rcv_msg+0x2bd/0x450 net/tipc/bearer.c:668
>   __netif_receive_skb_list_ptype net/core/dev.c:5720 [inline]
>   __netif_receive_skb_list_core+0x8b7/0x980 net/core/dev.c:5762
>   __netif_receive_skb_list net/core/dev.c:5814 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
>   gro_normal_list include/net/gro.h:515 [inline]
>   napi_complete_done+0x2b5/0x870 net/core/dev.c:6256
>   napi_complete include/linux/netdevice.h:567 [inline]
>   tun_get_user+0x2ea0/0x4890 drivers/net/tun.c:1982
>   tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2057
>  do_iter_readv_writev+0x600/0x880
>   vfs_writev+0x376/0xba0 fs/read_write.c:1050
>   do_writev+0x1b6/0x360 fs/read_write.c:1096
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")
> Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/675b61aa.050a0220.599f4.00bb.GAE@google.com/T/#u
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d7a865ef370b6968c095510ae16b5196e30e54b9..e816aaba8e5f2ed06f8832f79553b6c976e75bb8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1481,7 +1481,7 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
>  	skb->truesize += skb->data_len;
>  
>  	for (i = 1; i < it->nr_segs; i++) {
> -		const struct iovec *iov = iter_iov(it);
> +		const struct iovec *iov = iter_iov(it) + i;
>  		size_t fragsz = iov->iov_len;
>  		struct page *page;
>  		void *frag;
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 


