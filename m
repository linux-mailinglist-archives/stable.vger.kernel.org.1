Return-Path: <stable+bounces-146433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB38AC4DC2
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E2B17ECDD
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EEA25EF97;
	Tue, 27 May 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mi1K2ey8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC22561A2
	for <stable@vger.kernel.org>; Tue, 27 May 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345953; cv=none; b=I/2yQvtp9lX/KZxLZxx8KJI0kqRMxn0gOU0UdmxMpR/3Ve7XKQTlV/A3E0wFuGIhPa71ocr9nNQLtjRxoeUsOoVTtqhau74rPfEwBvwky09yNrxVlM4vdzKTZKdXbWq2wAxxyyYA2erOhClVJLV847mCfW+Jd9M0XHKd6aKtmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345953; c=relaxed/simple;
	bh=9+2YBfiiiMqleewiO3f4IwLqSyA9jGkwlr2UI25u4MQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dXtmyiy/pMspWaNsYExA0Z6ep/5Qg/am0utueiutRaTYkHR/2I6EjNeHids8oeQhr47vyD3zrG0nu3d4sfi2vx/aDBlCQpxqeUyEQ0OGJVR3HKZnOzGx0GL4yupZEgHsbKMH8c80++Uj5S854aTl6kGNIe95UoFH2DkwlbiP92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mi1K2ey8; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a37a0d1005so1844781f8f.3
        for <stable@vger.kernel.org>; Tue, 27 May 2025 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748345950; x=1748950750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0MAQYS4M77jxWNkT71QFnLtkooGsJDXRALLpCMZkcw=;
        b=mi1K2ey8/Xnra8h8U0RaLEzof5oGitBtplyUrs6GTMLEhhht7ZphPaRofKLPJa5eU+
         yT8pwUI0vVnTKJciQO7yNH3h57ZLBdN9VhG7dELt3/Ra3Ov+Gp1mvoP3u2VPENUuLsAz
         eKbOrlh7Du2CtWsAarVCkaYFG9ZySVkJ5mZCHAvuWbWKNzH4SRwtIbMDVeRYW8oSFP6/
         w84FztUN0KKFM6v1g3dAFrH7FrwAXMtsx4CfRRLuIeG7muI9s6K2l0tY8T61GgPFbORF
         l9qtgaUvszIKGCSZx4URKBvn3QT4CgHMiDtnkt/+/EIAj+2UCN9TA9qjh2kFDLm79u/Z
         EmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748345950; x=1748950750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0MAQYS4M77jxWNkT71QFnLtkooGsJDXRALLpCMZkcw=;
        b=aaKpu90YCnmSRWf8tw0aWIVP/f9Cxy6VPjWHOJRGB1EhJc2sCvaGXPuNzkEiWr8gdi
         4ihFGmOmJCCCZ/Uel57kHuTXPF+l17OHQDEB+e8fIUVdi6zz1sX8Fs82WiT8jehFpna9
         SsP1+Dabo3LMeaLj/ov6U+DKOkN9BihO+vO1t/TEyPdm+IjZ0DzqsQ9KwKjkKhhDaPWl
         ttwqZp6Jn5+kvNSzdK1UcGgJm0/vJeCHqRxpQ8CY2RNSDCTcmZ6DKFqKl5Rc+EpHmbzT
         ADgF57K/LE6BQlQK40RkLdbwgAaLLUwteM40sj31maIUgqdgTdPH6l3JYXkrkswKsXTR
         0JyA==
X-Forwarded-Encrypted: i=1; AJvYcCVzXxAjWmzXRc/EfL4P+OZOJeDCgRbO0svtByLSMWqEEG/i5dD4qFlkF1qfRyqLYEklic0x5sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUIPjljS5NzioBikvKiabDVaj2Xbc83uhfOSl8tJ4c1HGs14T
	v6g6QmwVK4ioFsRNmttnKv1hg617QTPejBqZL3TSvOCKnF0yU2/9tz5H3UUf8CRrKtNJnX1KYhA
	NULtDFRY9v2OU8PLwWw==
X-Google-Smtp-Source: AGHT+IEtY72Ut24TUfi8A+NQcG9IFZgNNOho7lkI8zuGQsCJOo2RFpVOgykkWl+BYEC0e0TUSJlKQC8vtb7BA9k=
X-Received: from wro14.prod.google.com ([2002:a05:6000:41ce:b0:3a4:dc80:cece])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2008:b0:3a4:dcfb:6713 with SMTP id ffacd0b85a97d-3a4dcfb6836mr3950943f8f.18.1748345950187;
 Tue, 27 May 2025 04:39:10 -0700 (PDT)
Date: Tue, 27 May 2025 11:39:08 +0000
In-Reply-To: <20250524220758.915028-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250524220758.915028-1-cmllamas@google.com>
Message-ID: <aDWkXI83EyznGG2M@google.com>
Subject: Re: [PATCH] binder: fix yet another UAF in binder_devices
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Li Li <dualli@google.com>, kernel-team@android.com, 
	stable@vger.kernel.org, syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"

On Sat, May 24, 2025 at 10:07:58PM +0000, Carlos Llamas wrote:
> Commit e77aff5528a18 ("binderfs: fix use-after-free in binder_devices")
> addressed a use-after-free where devices could be released without first
> being removed from the binder_devices list. However, there is a similar
> path in binder_free_proc() that was missed:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in binder_remove_device+0xd4/0x100
>   Write of size 8 at addr ffff0000c773b900 by task umount/467
>   CPU: 12 UID: 0 PID: 467 Comm: umount Not tainted 6.15.0-rc7-00138-g57483a362741 #9 PREEMPT
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    binder_remove_device+0xd4/0x100
>    binderfs_evict_inode+0x230/0x2f0
>    evict+0x25c/0x5dc
>    iput+0x304/0x480
>    dentry_unlink_inode+0x208/0x46c
>    __dentry_kill+0x154/0x530
>    [...]
> 
>   Allocated by task 463:
>    __kmalloc_cache_noprof+0x13c/0x324
>    binderfs_binder_device_create.isra.0+0x138/0xa60
>    binder_ctl_ioctl+0x1ac/0x230
>   [...]
> 
>   Freed by task 215:
>    kfree+0x184/0x31c
>    binder_proc_dec_tmpref+0x33c/0x4ac
>    binder_deferred_func+0xc10/0x1108
>    process_one_work+0x520/0xba4
>   [...]
>   ==================================================================
> 
> Call binder_remove_device() within binder_free_proc() to ensure the
> device is removed from the binder_devices list before being kfreed.
> 
> Cc: stable@vger.kernel.org
> Fixes: 12d909cac1e1 ("binderfs: add new binder devices to binder_devices")
> Reported-by: syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4af454407ec393de51d6
> Tested-by: syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

