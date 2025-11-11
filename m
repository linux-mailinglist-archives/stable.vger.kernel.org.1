Return-Path: <stable+bounces-194136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCFC4AD69
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A3188F765
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056A307AC6;
	Tue, 11 Nov 2025 01:34:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC3263F4E
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824889; cv=none; b=H26l5zVyUQ+uVG/qC6nGLVq+iTvXp2su3Z5QK9s7LwaW63Xt786rVsTOTFawu7nsCIDoJqDZk+pE9K4Cqfb05R3lnhmLtEjKL26EyROgVQ7MOAzrYgW5WEW4/ZkAW0SElO9ekJTTAM9WApgKQqVwuwzR3j/qrVfg6Mxjt9PbRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824889; c=relaxed/simple;
	bh=G9s9R549Bj0/8DmLMijlDCCQFUoEsEcNQ4J5IbrxMCo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EiECiIGJNivKDTIR7wM8xGFVs9A/qe940JYriKL2h1Ra6Bjh7TriJp0lYay0brhOpEddjx5QyQv74o5RxuXS3UCmEQSQb54rQPKScPCI62fA+ZGcCDYA++xrVDjf6aoCAiQ7imBjxl5VvOAR0hnfq7sRqivBy4IadpuWtKpJU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso16991339f.0
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 17:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762824887; x=1763429687;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFdhnMtQbvk+cxGkbCmb0GUX1So7hpWDFjTG3gplQc0=;
        b=WdK5d1YF9vZj1wupPkul9t/HUaaEO3U1laBfuEZlsTb4egDbTyMTbEi6ZIXLrtA844
         NBgmaG+hKv/lxGUXCu0AKAeMtt+sq9hWgQmdb8WkINEoDbfRM7NB0XWPjNKkJEvwIvhz
         gBys0wVaetOA6eg71B+DHe1kktdsYM7Egw1ZPbb7jlnNEcyrSfK0IsDNgt9RSc8KUYB/
         3rr0vOwAj8FjX6Q3rsc0g0N5OzIsetVGyfUWeNsiRwEgl5JNN6lrfujrfzkmt12FoeUh
         MjKbgIp2+N5E9pN1A6VLAMiekdSF3c+8Rb5s38F8ZcqH2W7dL3KaCnCDWpaVJHDTZ3ix
         LJBA==
X-Forwarded-Encrypted: i=1; AJvYcCW9PnkH5boq+fwqCDmYYoUmu8yFcaknHQdA0LNAx809+w4rEeiWGR8JpHqyEaywqBR+oEF6BM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxumf6uXcZjNVRRGFq54+RPDe/DHvqgG/nKzxqC33hAG4VEuu/1
	g+/g3QHY5J+F4jtJxN6CkO0bnwepe+vLWowDO3EBDW6WcKlaY8bjZd83JCwhy750QqVo+VsWXUb
	mjThUuEwCmM8y7oa489XyEXmQo+owv+4qZG8TJ1DPfIIlyal0ATgBQl+CGnE=
X-Google-Smtp-Source: AGHT+IHSHE/ZwvX7/pJgiSzkq1D2fW7OKj4ywqUFD2FdrJzS5Suqixrr3UkXqTx5ck6CZwqCjmTC4ff7cxFBFIS4FV83DNAeGizX
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:228f:b0:433:28c7:6d7c with SMTP id
 e9e14a558f8ab-43367df3b3bmr173309345ab.12.1762824887377; Mon, 10 Nov 2025
 17:34:47 -0800 (PST)
Date: Mon, 10 Nov 2025 17:34:47 -0800
In-Reply-To: <20251111004550.712161392@linuxfoundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691292b7.a70a0220.22f260.011c.GAE@google.com>
Subject: Re: [PATCH 6.17 591/849] jfs: fix uninitialized waitqueue in
 transaction manager
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org
Cc: dave.kleikamp@oracle.com, gregkh@linuxfoundation.org, 
	patches@lists.linux.dev, sashal@kernel.org, ssrane_b23@ee.vjti.ac.in, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> 6.17-stable review patch.  If anyone has any objections, please let me know.
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


