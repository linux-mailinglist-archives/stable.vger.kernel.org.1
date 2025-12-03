Return-Path: <stable+bounces-198353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DAC9F85D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 095DA30007A9
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D0313E3B;
	Wed,  3 Dec 2025 15:37:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876A3148C1
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776261; cv=none; b=RZSQOh/PA7FyOQqSfo2pIpXnfDTca422rCW1Af3319yuw798uGrBMPl27COCNP6jjqvaHCa2dWY6j6oURsHb3tGibUyiSwvLgdnGzY5DACEnEeAqLzuPJLkJVFjd3UIRICJqlNQrkiHKgDxTkDtBHm3ukKLlb3R0Elp3px14u8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776261; c=relaxed/simple;
	bh=URwIkXoJGIhaf6h4erzozKo5YdtNlIml7iZ5wYMoZNY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XD3eR+lGanPEOhfJ8SKhE/axNgZrpzxyFowxNHDTKvI96NYkQ0ZaUIHzveYZ1rDCweHBth4KoL3kE2WJAtdINZzyS49mNSNEodFHNvxioa0DEultYErffkt3fMkXE1Mj2uSxP6r2Q1V8ttFX2XMEdIjIV8EqfXvTUNHySHrrIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6574f0d2537so3098755eaf.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 07:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776258; x=1765381058;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/elcimwPgXstgKnTlIN9KfZhixTnvPoLHjpdzZzVoOY=;
        b=Hsj9FJVezLm1StpGHEkK8yHUoXEWzFJz0MId5+T5MsYTg94S4wOpdnwvBnUZaKMclQ
         9oww1BvtdSfCWjvBetLIrLxHnkJXz5j5l32bfFzduLO69qpm2GFJnFIRB1+Y/iUfj0lI
         8gKvTbEVvCxairlLUiTlWIxtbEK9pjEALrG4HLdDT0FLo4TY5RVVY2csx9XJsx5Iy8j0
         ulDDsJUernKCkDeo+RDMB1fnT7+tIwESuXZu7d8X8/fC9gzEATOQYthKyPK2LadFI9wg
         Bn2j7SZIqPtVvTeYxjbI5K2IikZ9l3sEPqd+7EACSDbLGCgrzXGVsToUS+3xHfQ44eri
         AkcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsRH5pUTL9WOAbZJD9vSjZG0PCOAzWZtTnPvJM4ZaiqpWnE6rIcbuTi8mbK2J/gOGESJoSZhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywVMrIIRRdiAuFRgn/7UHUPfJtGWEQs5Ps6r/ZxSrmVFv1V7O2
	bxDvOzj6NE1mDseQp+0tK5W+BGiv3Cd2ioBA8jjCLRAe5FDgeQfJ53vUQueQIhl8Lgbqp42wlLQ
	WLArBFrg77QY4or8dL11nOELHnweQZnFs+aRfTcS0gF3FPWR9n5L/QpFX6Mc=
X-Google-Smtp-Source: AGHT+IF/HJsWGbBN8Hj0XK2wsI5QnGAyQ231nFm6XhVliXXmKL+EBsLT0hjyi+becUo9ruJxPN0hqSM6G8/bFhVyeFdh1xNyhduY
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2209:b0:451:4d82:b6e1 with SMTP id
 5614622812f47-4536e3ae6a6mr1322895b6e.13.1764776258114; Wed, 03 Dec 2025
 07:37:38 -0800 (PST)
Date: Wed, 03 Dec 2025 07:37:38 -0800
In-Reply-To: <20251203152405.317330579@linuxfoundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69305942.a70a0220.2ea503.00d1.GAE@google.com>
Subject: Re: [PATCH 5.10 127/300] jfs: fix uninitialized waitqueue in
 transaction manager
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org
Cc: dave.kleikamp@oracle.com, gregkh@linuxfoundation.org, 
	patches@lists.linux.dev, sashal@kernel.org, ssrane_b23@ee.vjti.ac.in, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> 5.10-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> [ Upstream commit 300b072df72694ea330c4c673c035253e07827b8 ]
>
> The transaction manager initialization in txInit() was not properly
> initializing TxBlock[0].waitor waitqueue, causing a crash when
> txEnd(0) is called on read-only filesystems.
>
> When a filesystem is mounted read-only, txBegin() returns tid=0 to
> indicate no transaction. However, txEnd(0) still gets called and
> tries to access TxBlock[0].waitor via tid_to_tblock(0), but this
> waitqueue was never initialized because the initialization loop
> started at index 1 instead of 0.
>
> This causes a 'non-static key' lockdep warning and system crash:
>   INFO: trying to register non-static key in txEnd
>
> Fix by ensuring all transaction blocks including TxBlock[0] have
> their waitqueues properly initialized during txInit().
>
> Reported-by: syzbot+c4f3462d8b2ad7977bea@syzkaller.appspotmail.com
>
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/jfs/jfs_txnmgr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index 6f6a5b9203d3f..97a2eb0f0b75d 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -272,14 +272,15 @@ int txInit(void)
>  	if (TxBlock == NULL)
>  		return -ENOMEM;
>  
> -	for (k = 1; k < nTxBlock - 1; k++) {
> -		TxBlock[k].next = k + 1;
> +	for (k = 0; k < nTxBlock; k++) {
>  		init_waitqueue_head(&TxBlock[k].gcwait);
>  		init_waitqueue_head(&TxBlock[k].waitor);
>  	}
> +
> +	for (k = 1; k < nTxBlock - 1; k++) {
> +		TxBlock[k].next = k + 1;
> +	}
>  	TxBlock[k].next = 0;
> -	init_waitqueue_head(&TxBlock[k].gcwait);
> -	init_waitqueue_head(&TxBlock[k].waitor);
>  
>  	TxAnchor.freetid = 1;
>  	init_waitqueue_head(&TxAnchor.freewait);
> -- 
> 2.51.0
>
>
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


