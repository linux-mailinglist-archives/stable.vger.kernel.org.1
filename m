Return-Path: <stable+bounces-196193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D69C79AE8
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0C5BE2E1A0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88AE314D2F;
	Fri, 21 Nov 2025 13:46:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF6134DB6F
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732817; cv=none; b=RGAM+wTgw6Kv3WSGTlrxD7it8h5kuVWKhLb374dA5klaJYFUhLRcfypUE+BOX1lkVO1MdwLfRUWlJKqeYlife2keWmIgYAaY0YWShiXwlTRGg/Ks5EYboUmitSXEjOWWqjx/LjhFkYmb0TTQkpEjksjQvdzYqsjdBZmnvvU+OUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732817; c=relaxed/simple;
	bh=kS3u8fbyJUVfH7ZouDgx6pPG5LryYlblfHXZF1UMjzc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=YpVvIrFjuPj+RHh7QD7ZqYnPfCio72MApm6cu8kpiH4I/jQt9Yc+CvcSCIoB9P85jXeE4LzuEIs+IlO/ZR/xjqFVfcRPU6zJEeG/PhV0A2V4Iqd10UHsUl6YiXRElH0ZJyP6GYNZRnrR264nKXbVTLyspuGjMwl6WvSk2pfwGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4337cb921c2so20824385ab.2
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 05:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763732815; x=1764337615;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfM96cPDGqpbPBn7PPbQ4n5yVw9OLFafeLZIYjP6vEg=;
        b=UHmm+NEOdan9sWIA9QcP6gbChpBXKfFF+yZNZ1dPPBkp72NYKBgx9GvgPYxr6HAgcy
         aoMiwXvzxRHG6iOsTogphN7D46c+bkVLfu79o+4uV+GktHoy50BAaYcC8InjGEYdgfsB
         ub/NNKpmlimJSN9aBUW3xKkaSldle5VpPNK/Zvlv8eqH1PRVmNsCxY8Qfou/chORXeVS
         1BA1I39BiWql91DD91IkICyB6uxaQRy3RozriXdmzknzg8yRkriGvnvQqywf+XimAb8y
         KFM/9yANC/p2ZsA/gjq+SgiI/4NC+yDhUoCaERTJGptuqd3R1ExfqssFRG1+HQ85TR0U
         eyUA==
X-Forwarded-Encrypted: i=1; AJvYcCW9GNmPtEZMRKOEwf13PRsU9gbq5530newt5qjHQUsMOG/4ectmRzyxamafhBzLapNv2yDPl9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqma+c/lavMr1iwd1/eq/2iKNCgXML+m6GUIDxay0CxgfCo3Y
	cwRvSp06VCRPDz2AXEcLHYPAnUQDRcZgMOFTZVQlM7TeOP9m1UfRblG/GWq+sWNIwHYC3rBYInD
	1RqeJ+Tk9Yzl+iubsVZ+cgB7koqU34WfybBlk7iERdVR0LvknXUyP+pAHnj0=
X-Google-Smtp-Source: AGHT+IHaeW1/gE1ZzEFWFfTj6KK9QOuddSw168iFNmQa5PZLlhIEVAFnmkaLSDS87hZOc0qRjL8wFnvOvPIkFlAaq3urMSTR6Xub
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:430:c491:583b with SMTP id
 e9e14a558f8ab-435b8e598d6mr18972995ab.14.1763732814933; Fri, 21 Nov 2025
 05:46:54 -0800 (PST)
Date: Fri, 21 Nov 2025 05:46:54 -0800
In-Reply-To: <20251121130240.021598827@linuxfoundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69206d4e.a70a0220.d98e3.0046.GAE@google.com>
Subject: Re: [PATCH 6.6 253/529] jfs: fix uninitialized waitqueue in
 transaction manager
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org
Cc: dave.kleikamp@oracle.com, gregkh@linuxfoundation.org, 
	patches@lists.linux.dev, sashal@kernel.org, ssrane_b23@ee.vjti.ac.in, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> 6.6-stable review patch.  If anyone has any objections, please let me know.
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
> index dccc8b3f10459..42fb833ef2834 100644
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


