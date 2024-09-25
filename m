Return-Path: <stable+bounces-77091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BD9854F8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738701C20858
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 08:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31B158A26;
	Wed, 25 Sep 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR6qHidh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB41581E0
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251418; cv=none; b=ABRLcBUIQcQ95NG/YjVhc1UP4meSRqJDY0xs/PiR0IvKMWPbTmqClxyjAmxiNPHl4ZpwvunKAm8a5LEjXi2vgz+qdf7ceEFeedBO4JUzQRDu/8l6u9008uAPQZ2QaBXHQGfy6cxkrlqa+XHMvPdI3CoI5X3fxoQRVyZT4lVTzU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251418; c=relaxed/simple;
	bh=n5JKuPaGw5CQ8nPEMcWrFtIjkTH79c5C0k9zl/2LF/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZrAiOa2udlYaNPhK3RPmldCfN9SOBeCSdtfZ6/o4VtLwM5kwWd7O7QUNNDkFP/e4aDiEe8htK1oLVI/fwzs5TCF55OLZ/Hbnwao+YRzixymBMjBTtZcVGVHg5SBZV0mN2wjI5vJ6/Oey53PaDzfRP7HU3lOrw386rAF9b98hc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AR6qHidh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so52471875e9.1
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727251415; x=1727856215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDHNTSivz2B8DeLPge20d3ZeS3ZLnBnNGt50RgCLfVk=;
        b=AR6qHidhGTbWJzix2nwrF/why43KYQofXgrt+CLhyukcG9M+EnnIuOBgOggG1PbRUN
         Xgm4kgO5FOsb5P3KDki8jzuIdDGyse/DIeeUMnkVJDBmXzof46UgBeFkYnReAbqsBWkQ
         JZ+stX6XNFTnscjuMmsPv8J3u3vIoyH3iIaCdrxyvgD3PenrwyCXz91YGIM7VLK0yUCC
         +xmji616higf57TLZEUH2IQ893MTGYeOScffb+hiZvJNhlCjubfZw+B+0G7Wrur7nDeK
         5vkOoFzBAm8PKRUlSsxCHbNGUg1w8nkbfQ2HeJqV5zULrBUWq8Z/zXXtcmIj+1CKl9JJ
         Fb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251415; x=1727856215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDHNTSivz2B8DeLPge20d3ZeS3ZLnBnNGt50RgCLfVk=;
        b=XNnBKX8B+VV6H+pmjE08uiFf5zBbgD1yy+9zzaBJDD3FUHhguN9KnP425AvuIuG4lA
         KZatetga9mNdxpjcywEAHbxiDFftB6MDaZqc4hFrSk9sGheD3zC8GyNDnNN5OFTEVxuY
         9m1sOW4b20oOsHYIsOObBYoVgc1qfaS6wurtAO9kZTyTwzsR/pOilk4sI05A0rfK+ASy
         naLWnRbmtvm8PIKHRQK1oO68MBeX3gygFlk3w61dZtXB9CxpzgKJ4Cb0BKFcE35raRG2
         WC2okiaD1WHwrlCCpHDlyssEf0FoHj3lT46Ti3zQo3PBP6mYyj7cNbz2YqT0wis3e1CP
         5J6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4ErIlrLw89iLIkOVfLUUxJ42niF2Joe5YvyDzbt3zxRwEBG0f2wiC1BhSTI2rSdWGqdhFtV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCLdERc/cm3BirK7rYFcojCkS8r8oKrvMRUDb1tpHKCAhhSzn
	QHfgTMNB28qTOoqMl9GFggnFPdbdb36yqnkIL16/eefCgUVBWRPND3jMkmwDRfQ3obC5Ve/P+VC
	JOxePGhWd2KKS7nzsoREXf0J2i/iFq9STsoDt
X-Google-Smtp-Source: AGHT+IEnBiSYJljKSi+MdOpJ9hL7uRhVjGyyb+98aZTMOSUxu6Q2f+rg6DTdGM246ewSETFRYyIa+CxKY+Kx0IUU+qM=
X-Received: by 2002:a05:600c:4445:b0:426:593c:935d with SMTP id
 5b1f17b1804b1-42e96102f01mr10203285e9.5.1727251414958; Wed, 25 Sep 2024
 01:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-2-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-2-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 10:03:23 +0200
Message-ID: <CAH5fLgi+uvRwUZ1fnro=5Z7nqjTcz5mEEwjRv71-fyX3ew311Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] binder: fix node UAF in binder_add_freeze_work()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:44=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> In binder_add_freeze_work() we iterate over the proc->nodes with the
> proc->inner_lock held. However, this lock is temporarily dropped in
> order to acquire the node->lock first (lock nesting order). This can
> race with binder_node_release() and trigger a use-after-free:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xe4/0x19c
>   Write of size 4 at addr ffff53c04c29dd04 by task freeze/640
>
>   CPU: 5 UID: 0 PID: 640 Comm: freeze Not tainted 6.11.0-07343-ga727812a8=
d45 #17
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    _raw_spin_lock+0xe4/0x19c
>    binder_add_freeze_work+0x148/0x478
>    binder_ioctl+0x1e70/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>
>   Allocated by task 637:
>    __kmalloc_cache_noprof+0x12c/0x27c
>    binder_new_node+0x50/0x700
>    binder_transaction+0x35ac/0x6f74
>    binder_thread_write+0xfb8/0x42a0
>    binder_ioctl+0x18f0/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>
>   Freed by task 637:
>    kfree+0xf0/0x330
>    binder_thread_read+0x1e88/0x3a68
>    binder_ioctl+0x16d8/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fix the race by taking a temporary reference on the node before
> releasing the proc->inner lock. This ensures the node remains alive
> while in use.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

