Return-Path: <stable+bounces-189507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0D9C09851
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7D81C82186
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D50305940;
	Sat, 25 Oct 2025 16:19:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32431305948
	for <stable@vger.kernel.org>; Sat, 25 Oct 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409170; cv=none; b=F0ElV3AFLPGfowOba/X4H7JoHqArNQs43XC4O0Hupnyp2xybw2WbxDnuQcJySg7mWGJyScFpspicLQdMzOgMUjDBIHHuvtHczJz+EuDhn5HuZsl7EXU/sUtpaiEaw56sa4zlSTZ5j/KcWtyEj1Gw9ud3uAiEDLw907YsJarlQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409170; c=relaxed/simple;
	bh=1UAhRNMwiY8e1loSbd3FnzSqcx+pE0AoZQ5cdLLzwYw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=AXX7T2Ze4nXcrN3OZ4RrFeY81sC1O6T/wnUR7y0kMydus0BtWLs+Ynlub5KDXZoNtYhhxux3KsOY/AhecuPFR5soxbfWHSnNZHj+Qi2+mn7eFcPqEu6l4Hfi5Px1rZiWUFcr38l1RXMcZa5NzqJno9IqKTg8c34fTgBtIWOXJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430da49fcbbso40085485ab.3
        for <stable@vger.kernel.org>; Sat, 25 Oct 2025 09:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409168; x=1762013968;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDL5qUn8r7zj0sFG8H7qyEhZdijB3u/BoMNxYA4F7hU=;
        b=EfjZvNDl7G0+7Yw0l8CDD0UvwGfyyqwVKfJcic+/qov1Ae8CN6rA1Ccf6Pe/RyodbT
         ouzEW9KjhpHwbMRhIwERL+phmTRaHAQ4MLI9HNUjjcDH4y3wi49LItDvNK78B/x6pvRQ
         nIASxud6gX78D+etHHA3qIA3yMdmty0DLHDvcJwKCyFcuQDHxetpbBLQ5dmBT1YydHPv
         suCH4OVTOqM1/JVWVY1adRHq8QVzo/XjCJgr0icRRPALzAewFhxzEQBL6omYXj3rgNK7
         hk73tS7KD4surPv/NGqgcFtNVOGp1ZgvopiHIAgTIr+bZybT5U1l1IxvM6jzsxRZrDkh
         LUXA==
X-Forwarded-Encrypted: i=1; AJvYcCVj9Sask3LIOL0T1trfWQLdWi5AhD8X/aEix95RdZPc5eiuxAy/HABP6TsVkbCIlZL/F8VAeyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSh46FG67XfqNtJMrFhWz9CieLxCI40//ElbrmG40UXCPp7yw
	ORJwFEP6BcJhLVJ+FLD6LFCh7rtddPCRsD2MhjIA8NN/0KzrJUS9LJHEJUD2xpvMnuFXn2L6j1/
	VKVOeDsp0a4Z8lCBW8XKOZWvaX8iBmHRP3fL4h7TI47vvMmX3z0nAK6dJyFw=
X-Google-Smtp-Source: AGHT+IHyDU/FUDHCCq350lspC6NErVthfk4ehnVafDPOWHBjDawZElv4u2ug0d6cNWNJu99xYN/guv5PQJiajp22dXZ/SBHCYA4i
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2307:b0:42f:a60a:8538 with SMTP id
 e9e14a558f8ab-430c52b5afemr394804655ab.16.1761409168407; Sat, 25 Oct 2025
 09:19:28 -0700 (PDT)
Date: Sat, 25 Oct 2025 09:19:28 -0700
In-Reply-To: <20251025160905.3857885-227-sashal@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcf890.a70a0220.12011.0001.GAE@google.com>
Subject: Re: [PATCH AUTOSEL 6.17-5.4] jfs: fix uninitialized waitqueue in
 transaction manager
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: sashal@kernel.org
Cc: alexander.deucher@amd.com, alexandre.f.demers@gmail.com, 
	dave.kleikamp@oracle.com, jfs-discussion@lists.sourceforge.net, 
	patches@lists.linux.dev, sashal@kernel.org, shaggy@kernel.org, 
	ssrane_b23@ee.vjti.ac.in, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> [ Upstream commit 300b072df72694ea330c4c673c035253e07827b8 ]
>
> The transaction manager initialization in txInit() was not properly
> initializing TxBlock[0].waitor waitqueue, causing a crash when
> txEnd(0) is called on read-only filesystems.
>
> When a filesystem is mounted read-only, txBegin() returns tid=3D0 to
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
>
> LLM Generated explanations, may be completely bogus:
>
> YES
> - `txInit()` previously skipped index 0 when priming the `tblock` wait
>   queues, so `TxBlock[0].waitor` stayed uninitialized
>   (`fs/jfs/jfs_txnmgr.c:270-284` before the patch). When the filesystem
>   is mounted read-only, `txBegin()` legitimately returns `tid =3D=3D 0`
>   (`fs/jfs/jfs_txnmgr.c:348-354`), yet every caller still executes
>   `txEnd(tid)`. `txEnd()` immediately calls `TXN_WAKEUP(&tblk->waitor)`
>   on that reserved entry (`fs/jfs/jfs_txnmgr.c:500-506`), which trips
>   lockdep (=E2=80=9Ctrying to register non-static key=E2=80=9D) and can p=
anic the
>   system, exactly as reported by syzbot.
> - The fix ensures both `waitor` and `gcwait` are initialized for all
>   `tblock`s, including the reserved slot 0, by running a dedicated loop
>   from 0..nTxBlock-1 before wiring up the freelist
>   (`fs/jfs/jfs_txnmgr.c:275-283`). No other behaviour changes occur: the
>   freelist population for indices =E2=89=A51 remains identical, and slot =
0 is
>   still excluded from allocation.
> - The bug was introduced when `txBegin()` started returning 0 for read-
>   only mounts (commit 95e2b352c03b0a86, already in 6.6+ stable). Thus
>   every supported stable tree that contains that change is susceptible
>   to an immediate kernel crash whenever `txEnd(0)` executes=E2=80=94trigg=
erable
>   by routine metadata operations on a read-only JFS volume.
> - The patch is tiny, localized to initialization, and carries negligible
>   regression risk: initializing a waitqueue head twice is safe, and no
>   concurrent activity exists during `txInit()`. There are no
>   prerequisite dependencies.
> - Because this resolves a real, user-visible crash introduced in
>   currently-supported stable releases and does so with a minimal, well-
>   scoped change, it squarely meets the stable backport criteria.
>
>  fs/jfs/jfs_txnmgr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index be17e3c43582f..7840a03e5bcb7 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -272,14 +272,15 @@ int txInit(void)
>  	if (TxBlock =3D=3D NULL)
>  		return -ENOMEM;
> =20
> -	for (k =3D 1; k < nTxBlock - 1; k++) {
> -		TxBlock[k].next =3D k + 1;
> +	for (k =3D 0; k < nTxBlock; k++) {
>  		init_waitqueue_head(&TxBlock[k].gcwait);
>  		init_waitqueue_head(&TxBlock[k].waitor);
>  	}
> +
> +	for (k =3D 1; k < nTxBlock - 1; k++) {
> +		TxBlock[k].next =3D k + 1;
> +	}
>  	TxBlock[k].next =3D 0;
> -	init_waitqueue_head(&TxBlock[k].gcwait);
> -	init_waitqueue_head(&TxBlock[k].waitor);
> =20
>  	TxAnchor.freetid =3D 1;
>  	init_waitqueue_head(&TxAnchor.freewait);
> --=20
> 2.51.0
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


