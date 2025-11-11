Return-Path: <stable+bounces-193837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A74A8C4A9F7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C0F04F36E1
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB72DA757;
	Tue, 11 Nov 2025 01:22:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1173263F52
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824123; cv=none; b=rjR8Vv/W5Q+fuJDXQOtYybDp86mVxZOMbgdeCYCCa0BzO0JIHpoFc3PtTiZs8jPykvck3RaK3c0+bfIIh/5O1d9ydFB2kCeIGE/3R6H232aoB7pfwOez60a0qZUGEgPI7hrLjAhsnTTd9CQkWt96uUJjMXpXYPdH0Vz94nrR8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824123; c=relaxed/simple;
	bh=1Saewuj3B+oxPukwQPEoUCgMCPyS+mq1oCUOFby9KXU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=LyfzCHLmailTwUNY5hZJlVVxIbEAexxdHN/EikyNedO8vHXjzxD4z4ABdKUPh1vkDfBwwwOWwTRq3gFjaRZhl46p6CyHNsND+QJlMXdtwXEYD2pz4Kamij7M90gOWP2rZf+x70OqJ2yR3+0iKen2EYOYcEy0lFG4pubj5B8zgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4330ead8432so38903795ab.0
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 17:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762824121; x=1763428921;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgTHUyA6jLiZEgsIlU1BHXJL99ZEBvfYu/B6KIbfPcI=;
        b=W4/SRusCN8w7p77sXeI8k+RRyRnk/39NycY5SAbvqfKI5dzsBiEb5kovgLbynRWtj4
         r9pdaPFXJ1iG/isU9z9Jts0EgUXp94s6xysx0Xumz39Q9QiHA0ksBlisvNS3lJlGtkHa
         1Z8RQiApiLi4CJPN+lALM6wLwZCgfKC/2nj1UWXwYA0I5VxjfYjiDCg8hr3gZcQxWiTb
         5NgaXT6DTwiAWAjKBbwnQ5c8Hvvwv1V0Ko/CE2zSM6yBDikg96NxGhF06SQb2EuJ3CAf
         y4bcEDLvNmfs1BiJEPBo2uHYq7M7wjq7wbNiEgqmshcDWz01GJCgwCjO4FFoh0obJvPE
         sXbg==
X-Forwarded-Encrypted: i=1; AJvYcCVziRPlTo85QhC6DzBv/vLY/Xyft4CI3/UVg/S//CEJspXp68QZGZk146YWtsXgk6GZqLBIKPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4eSslrbrcw+rl/39HI8P8tMtAqE9UcLv3kNIZJ1bY/V/w9gY
	QauY/xptPs+fasQvwBe9Zz/sL8kunZpvy7tw4hi4iWCvTQ8amL6WIALR85Y3MJzQOQuZaoxFjK9
	g6ao3Ra63lHJG8sxg9Z+dLOTd3SmzJ74tOQeicyMT1FsiotvfqSHOY7SBx2o=
X-Google-Smtp-Source: AGHT+IF3YFxFacr3KDbHpq5A+caT8jYHZKNqmASlSPxhn0zJLG8UjHgI2+NyHenfwkEKYFMzfCzIe/11H/4hPhr6H2dMvY/OyAng
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d44d:0:b0:433:71a9:8f9e with SMTP id
 e9e14a558f8ab-43371a99638mr90879525ab.7.1762824121147; Mon, 10 Nov 2025
 17:22:01 -0800 (PST)
Date: Mon, 10 Nov 2025 17:22:01 -0800
In-Reply-To: <20251111004535.668292559@linuxfoundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69128fb9.a70a0220.22f260.011a.GAE@google.com>
Subject: Re: [PATCH 6.12 391/565] jfs: fix uninitialized waitqueue in
 transaction manager
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org
Cc: dave.kleikamp@oracle.com, gregkh@linuxfoundation.org, 
	patches@lists.linux.dev, sashal@kernel.org, ssrane_b23@ee.vjti.ac.in, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> 6.12-stable review patch.  If anyone has any objections, please let me know.
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
> index be17e3c43582f..7840a03e5bcb7 100644
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


