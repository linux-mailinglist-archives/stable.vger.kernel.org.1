Return-Path: <stable+bounces-198222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CBC9F310
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 14:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC8B3A6C8A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34FC2FC887;
	Wed,  3 Dec 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtTUx3px"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59022FBDFA
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764769980; cv=none; b=UWYtm8ISgetojs3y0D+s/A/kz1yn0H06bqm2unznStK5Au4EG+2Jgw93TEjljzI9TEXZ5v7zfcfe/xXaK9OUBr//nIIEV87mVY0t5febgRco7bSiUMc4ds6Nc1i/jYxTM0lm7L9G28bHf40e6bZ1lDOzB3r7D5HjXi0Er2ZDgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764769980; c=relaxed/simple;
	bh=iJbMxEQ9KJpTvPN+2PQqEYTSPK3xO4X8CyvtwKXMehw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enIqSx6TXMxCvSLCtuyUtdeB+J/2vUNphMkioqTJho1j9ncvrAII8QkefuXNoYDkATAVQiCZJkhBaioWuI7x1uqa6jI+cFeP8NJYHA5TLi3/t58oV+HLanQi9cAxnjjt8tNfsJxNaOsazKq7hjkgeiuJE+BLR3ncfDztckQECOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtTUx3px; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764769977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4fKd3XETzmPiJvqAM1yYm/oyS3lsGvYrwgCa3QS6rc=;
	b=EtTUx3pxL240V9KB6xjFX1opNCikiL+S84z6YNaaikjN4HXuWx+CrvOiscp3Q/UvLaC/JE
	3dvEv2Q8QPv2yR3oCcbLnbP5mHOs1+hX9JwJuHKDvr9pB4emXd+nxwZlPzD1RGWHrd2sdU
	ajaT8dgDjZzdB1aS+XHK8V5GO+Iqy0I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-91EOFT0ZOZi4GHrpEfqSeA-1; Wed,
 03 Dec 2025 08:52:52 -0500
X-MC-Unique: 91EOFT0ZOZi4GHrpEfqSeA-1
X-Mimecast-MFC-AGG-ID: 91EOFT0ZOZi4GHrpEfqSeA_1764769970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC67E195605B;
	Wed,  3 Dec 2025 13:52:49 +0000 (UTC)
Received: from thinkpad (unknown [10.44.32.234])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA0C119560A7;
	Wed,  3 Dec 2025 13:52:43 +0000 (UTC)
Date: Wed, 3 Dec 2025 14:52:39 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Arvid Brodin <arvid.brodin@alten.se>, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	khalid@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net/hsr: fix NULL pointer dereference in
 prp_get_untagged_frame()
Message-ID: <aTBAp3axHXSkrYKO@thinkpad>
References: <20251129093718.25320-1-ssrane_b23@ee.vjti.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129093718.25320-1-ssrane_b23@ee.vjti.ac.in>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Nov 29, 2025 at 03:07:18PM +0530, Shaurya Rane wrote:
> prp_get_untagged_frame() calls __pskb_copy() to create frame->skb_std
> but doesn't check if the allocation failed. If __pskb_copy() returns
> NULL, skb_clone() is called with a NULL pointer, causing a crash:
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
> CPU: 0 UID: 0 PID: 5625 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
> Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 23 29 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
> RSP: 0018:ffffc9000d00f200 EFLAGS: 00010207
> RAX: ffffffff892235a1 RBX: 0000000000000000 RCX: ffff88803372a480
> RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
> RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
> R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
> R13: 0000000000000820 R14: 000000000000000f R15: ffff88805144cc00
> FS:  0000555557f6d500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555581d35808 CR3: 000000005040e000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
>  hsr_forward_skb+0x1013/0x2860 net/hsr/hsr_forward.c:741
>  hsr_handle_frame+0x6ce/0xa70 net/hsr/hsr_slave.c:84
>  __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
>  __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
>  __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
>  netif_receive_skb_internal net/core/dev.c:6278 [inline]
>  netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
>  tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
>  tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
>  tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x5c9/0xb30 fs/read_write.c:686
>  ksys_write+0x145/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0449f8e1ff
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
> RSP: 002b:00007ffd7ad94c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f044a1e5fa0 RCX: 00007f0449f8e1ff
> RDX: 000000000000003e RSI: 0000200000000500 RDI: 00000000000000c8
> RBP: 00007ffd7ad94d20 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000003e R11: 0000000000000293 R12: 0000000000000001
> R13: 00007f044a1e5fa0 R14: 00007f044a1e5fa0 R15: 0000000000000003
>  </TASK>
> Add a NULL check immediately after __pskb_copy() to handle allocation
> failures gracefully.

Thank you, the fix looks good to me. Just a small nit pick (this can
probably be done when applying): please add the empty lines around the
trace again. Other than that:

Reviewed-by: Felix Maurer <fmaurer@redhat.com>
Tested-by: Felix Maurer <fmaurer@redhat.com>

> Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
> Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
> v3:
>   - Keep only prp_get_untagged_frame() fix as the other two
>     NETIF_F_HW_HSR_TAG_INS checks are not needed for this bug
>   - Move NULL check immediately after __pskb_copy() call
>
> v2:
>   - Add stack trace to commit message
>   - Target net tree with [PATCH net]
>   - Add Cc: stable@vger.kernel.org
> ---
>  net/hsr/hsr_forward.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 339f0d220212..aefc9b6936ba 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -205,6 +205,8 @@ struct sk_buff *prp_get_untagged_frame(struct hsr_frame_info *frame,
>  				__pskb_copy(frame->skb_prp,
>  					    skb_headroom(frame->skb_prp),
>  					    GFP_ATOMIC);
> +			if (!frame->skb_std)
> +				return NULL;
>  		} else {
>  			/* Unexpected */
>  			WARN_ONCE(1, "%s:%d: Unexpected frame received (port_src %s)\n",
> --
> 2.34.1
>


