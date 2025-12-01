Return-Path: <stable+bounces-197802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF12C96F97
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BC03A698A
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47CE2E5B36;
	Mon,  1 Dec 2025 11:29:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B313253958
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588569; cv=none; b=fxtGk2f6jkQ4h0vcn5W8n+qjaV46dVNEGhZkd9b7B48sA6uTPBlqRTiFHkSO7ibWoCleBSCB4Oktg6BD7IsRNO/KJlUomDQMkhy3A5RXa1Vxyr/rraCew+CCVis0X24OevsG/rb7N2nDaZaMdBb08SVdVztg6qDhik9xcNtf6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588569; c=relaxed/simple;
	bh=1e3xXhcPNHWgicbIPtgAm1Z3M8jEizauH6ZfvImQYHc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QwRlho1b/1DQOo0Bc6IN92BDdR+SoWRGT6tQFBvQah+yzmC/qZvxjZJsl62EjS8gykccfDFgtRAOQziFuN8pZGQ0x/hVroLP+1ruIPiospGwvHkTtvv0tyMDZB6F2GCWTqq8K/L2xYD+ANhtumMlYQVHu5MS9Qbh8f4erePGmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9486c2da7f6so241479639f.2
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 03:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764588567; x=1765193367;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfHZ+dazpAoEJkFZ0dyA7E//xH/NuSxVKK2DI5VlixI=;
        b=wYXzn1yuvDV7UwJ8NkJi4vVQyCQg4FH0l2X80LUQDrUkhhbQw1/NYXcFeJF/nrTj7W
         4WwiPWZscuYs11tKFAq3vlRx7WDXov39Z6fUoWCx4ssMeS/8bsjE/I862dQaSCjOofZa
         Qp72qHKD0PQTI37GLCvBp+a2BZ9NJZLGlqfw0jtDxzHof/bbSQe8xogW936n+V05p9jJ
         yW952UNT1+S9qezDLkJC7DE3olcbjgRsBtTH/vhjpi01lZ+VT3jn7yzuzMX4I5gv9Suq
         lVGdWH5zjvLuJwNKVfZYxQj1ITWYhKlu6CNjQuWMfgNEEF9eLuSIhaeyJ8VAkYCgFx3i
         OQVw==
X-Forwarded-Encrypted: i=1; AJvYcCXM0HlkrDXCcEtBTpYg4nhEzT8MKR63C+pL+JWRTAWb3KzCM+lbEjzRhsvIKiXxpz3LXJVBtAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjodA1jqjn8x4bi2nUkgN5Wp8hAaWOXD+AF6FQ6k5xG6Laj7FF
	+wlQbY6VGZXBMiAbMWgd3O1b0SwQuIxvsBssU6fw+PiyEOxTteIylxMNs+0hga8D0HOxpb9Yeum
	ydiFHgYDMYihkXxSO7Cka2op+oubfn4Z3WvSNgtdrpjZMzzdVDYbf3XdEzN8=
X-Google-Smtp-Source: AGHT+IGnOvmSMJiHTilz4QuvC4k33TNb6q929ZN9GMb5ns1D6ua+GNTnzx+AdRtKSiWT2jPRvhmUSNF7ofcblWO29+0vvE0jiKUA
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1589:b0:948:89f2:ea34 with SMTP id
 ca18e2360f4ac-949488ffe08mr3497024139f.5.1764588567171; Mon, 01 Dec 2025
 03:29:27 -0800 (PST)
Date: Mon, 01 Dec 2025 03:29:27 -0800
In-Reply-To: <20251201112244.638235384@linuxfoundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692d7c17.a70a0220.d98e3.0185.GAE@google.com>
Subject: Re: [PATCH 5.4 094/187] jfs: fix uninitialized waitqueue in
 transaction manager
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org
Cc: dave.kleikamp@oracle.com, gregkh@linuxfoundation.org, 
	patches@lists.linux.dev, sashal@kernel.org, ssrane_b23@ee.vjti.ac.in, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> 5.4-stable review patch.  If anyone has any objections, please let me know.
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


