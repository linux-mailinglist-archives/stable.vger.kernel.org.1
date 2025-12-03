Return-Path: <stable+bounces-198843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF185CA07EB
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 837F530F1270
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA1F3446CD;
	Wed,  3 Dec 2025 16:04:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E434403B
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777854; cv=none; b=X8mdLQOem35Ho14OvO/izuTx9Coqgp5Vx91KEb0mYfA3bMrGReREMYiELnnoyi/nN+ABxKsSGMpQffrvaFdEP88ZbvK7dMnqInnZkPetO7BReLZGYcqayfBF9yesa1bsvBHblzpX+liQu3HTRvSdYUMzT/xcUMAVfrfgrx9kWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777854; c=relaxed/simple;
	bh=nJqjEdow/Zt/TuLDaoijl8cu4nclMMywIodJXAD54i8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Ce7QJI7G8/wWfuxYcFVak/co0TU9ebGzk0nPy76CB7Z6F6fQzFnAqmHbq4guanDMcDsDIqK6qWeySYGAKiWD+zo9DlcbHSvXllGDuHchrPvg1ktd/6oGdvF9t5m5vlmJqWEADO2z1sLLS/yuyexmMfP3MSje30XX64q1V3xQLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4514cb26767so2871599b6e.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 08:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777851; x=1765382651;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJDgUU97V4GjWs3LWgSaDK8Muw/itNKU1HQ88yeQQgE=;
        b=dHhoPO7HbT7nsaOjElArJNIDckhh2+k+moVKcuXZLv+IoyyDZb22HKqqBrcrNg9ZoV
         xcEdN2tJ49etoxo+E0R40y/qC60bGDuVXZbFTUzeZD2mkrYazJ5jcu7U/GyijHmaZAVe
         3V7fz/qtD4/kJPbjVPARW488ScpZNHpNsBo8EaICZ9Ec/5Ke47iSr/FkMs7jn1wY/g5Z
         0CfnpPyJ7akdl7VMaxhvxBzIr2v77dL50VAasbA3hwD+2Bxr83edB1PRP4a7jQh5zTo8
         gqDGKtaifQUJMipfr/upGVFxJlRo4YVKsPiScxAuCiLwNfN7BP0raLSiaFXESFmK5YcP
         YMSg==
X-Forwarded-Encrypted: i=1; AJvYcCWjHZRQmMNXik1cEVJryiBBdznX6RuIbA8qVm5mOCIWtDtHlEag5wsO3Aakn12M+8PwVonb0/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmLvt11BwTwTQ/LupP1Xy8Xgm3rAQqb9PkpKPi01VOgWap74Z
	mN9+LIKlvNwelg22hDf9NEKmtSNxVBQr4fPGFpS4OJ0IB+uqFjmgaTgSUquWbtuBX7+IHBxRUFK
	bweuhHl0kM9h7AU63d4bdQeTCTvptLM6N5P/n/i6FwB8/5zzGx5kqtYJugJo=
X-Google-Smtp-Source: AGHT+IGIMPejztAdrOQZy+vUI1/EMQ6vqwWNhRz4fHJX8PNwx1mu3VnZup8np2VmdmJ5HnNUv0iFfcAQ+xerwSOAbzmr3iffr3L7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:150f:b0:450:c0ef:8092 with SMTP id
 5614622812f47-4536e51a33amr1440205b6e.34.1764777850859; Wed, 03 Dec 2025
 08:04:10 -0800 (PST)
Date: Wed, 03 Dec 2025 08:04:10 -0800
In-Reply-To: <20251203152420.150891955@linuxfoundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69305f7a.a70a0220.2ea503.00d3.GAE@google.com>
Subject: Re: [PATCH 5.15 165/392] jfs: fix uninitialized waitqueue in
 transaction manager
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org
Cc: dave.kleikamp@oracle.com, gregkh@linuxfoundation.org, 
	patches@lists.linux.dev, sashal@kernel.org, ssrane_b23@ee.vjti.ac.in, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> 5.15-stable review patch.  If anyone has any objections, please let me know.
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
> index 3a547e0b934f2..d322a22477e49 100644
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


