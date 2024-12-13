Return-Path: <stable+bounces-104144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7277C9F1361
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 18:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A85116B0D2
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159E1E3DE8;
	Fri, 13 Dec 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0/1srb0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01F17C21E;
	Fri, 13 Dec 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110013; cv=none; b=Gu02S5m5EEhUFzH+puoTmQ6SrQmtesIHA1hE0T85ymITdEP6qWxOKJfGq1qmOTWNx1Gc5P1G3mb5SHe0GVxZrnODx5zUJnm7dw0f/rgFBiJlpT+A5jugMZMOBgPveD150uQOlehIaUGKqPnvAc0M7kioArkhr+nmNy3RNoSp4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110013; c=relaxed/simple;
	bh=KlnBFEe5+nvJndOX6pYTv/3IjKYgkkjDUHNefNHqoj0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JXnXdRKKyIirrTH3iRBmEdyZTj5uanXjujWbil3hgVzp5Ht8fOc61vv7yLg7JFDYCG/jaBPDM8+s4F8vrZhTViss6AGpiDSATThSitSJ3+q/xySpxPQrnMrO0W0J/SauXMxrTKUqLh/wu3GDolyuAtCq0YZFJooIZCThr6t6AOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0/1srb0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6f8524f23so176164385a.2;
        Fri, 13 Dec 2024 09:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734110011; x=1734714811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSpK+UbdqxQ0veV5mqvwgQXLknOFmW5nUATW+XvS3aQ=;
        b=Y0/1srb0iFnr/Ijz5d2BQM5JnP6wgR5hcmZM6IOPonHhZhHPcVryfomHhPjdwj+XHM
         c/zvqpPT1AAhCwYowyuJ2bG2nQV9FeTANzAuHbx962A1R27OvTPL5Bvc1M8hL4QgHues
         7EHvW5oudYTDgssFf3I+Z1qsJP/tD0Fpuf9A1HAtPn+e4S2Y0pE3FJ7W+DPxDo79F/Vv
         XoESD6+SCHpkNauUq/0UukhAs+H5rRZh/zMOf7oDvgowT6lISP5z3EmTI58q25nQzVtj
         CBtRlJRMuWjSnfX+6DlVFe3q00kV2mAWvgXqe1nbOYo2zu0cxop0j9tjwjNi+Uz5ZMfu
         Np4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110011; x=1734714811;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MSpK+UbdqxQ0veV5mqvwgQXLknOFmW5nUATW+XvS3aQ=;
        b=mN37LIcWifDyyxG5PG9Iqx8PAPNVGrba07hYkuOsYA+98EFq4JL6KQTYFvoWvBzj06
         KXRktHEZgQSVQZWedmMPuu60Nr2Yad7DnQoOLBt/VMtA00HkVVUWAuYuhDzWf1CLzoNe
         fvnXYpWH6E0LDdAuYNK7rjwsvwG/1aAVBldwfRNpradj1BFj8OGZgAzWd+xWsmFsnkV7
         fJzTi5LgirtruVOrsGELijY+6PGwdeQy0Te4ooR1RqYN0PP5gj/sN7zVM03SHCOkYSnx
         LruyX7QgeOkg+bPVMfxWNmoR2d3bGHSRkTkxWS5Ugsk+BrayYwDtTsYGmSjCxv1nk428
         I6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCU9xvwYlAbCtjrEgyr02FK/979y5myEqpCB5ssF2Nf7uv5XctnhFanh3jZfmsSijsleEQ34tmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznrbJIwqU7U0ol2tgT3zPs90O8xKfZ4dYrHS1NJuO2th2y5UgL
	Tx/V+psMZYJ5hOQyOpRWA37r6u1J/ZDMdja10OLA6awaSwC0/ns7
X-Gm-Gg: ASbGnctWzEbEMf2fd0vW4zJwcIOuigu5jAjYisonf/kTla/yGf3rs2UKDJZ0TMF2rFs
	ndpc6k6tkUVUMvowRXifSbV5pNFUjWxvxRplIW7Hn9NlQdqSw+baIHzBSy1NWynLlv24ZdJ3w94
	jk1GmQwcJtNDHIFFMEYROrswgiU7cDbjQu69pVNYklPh2cYYae8RJbf8Rbmvlk4HGbaURM7lhHK
	nQpujHAXZigqBW6KtmfWqKgOr2bpWWJSdRjfLiT4bqqZa9X9ZO4aygC+/qQFwca9lHZ26mudQsg
	Dc3EPcxA4x5kx+NpipuLREVL/ErP
X-Google-Smtp-Source: AGHT+IGMEQGIsOTQt11ym8MMUR2W8+dZIJkrosrhYwZaouBaFxmp4EpoejBuqbCL1F5VSSGAuB8a1A==
X-Received: by 2002:a05:620a:2993:b0:7b1:50ba:76ec with SMTP id af79cd13be357-7b6fbf7adecmr504313685a.52.1734110010519;
        Fri, 13 Dec 2024 09:13:30 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7033b9abbsm10117985a.84.2024.12.13.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:13:29 -0800 (PST)
Date: Fri, 13 Dec 2024 12:13:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, 
 Jens Axboe <axboe@kernel.dk>
Message-ID: <675c6b3897a14_162b6429443@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241212222247.724674-1-edumazet@google.com>
References: <20241212222247.724674-1-edumazet@google.com>
Subject: Re: [PATCH net] net: tun: fix tun_napi_alloc_frags()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
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

Acked-by: Willem de Bruijn <willemb@google.com>

