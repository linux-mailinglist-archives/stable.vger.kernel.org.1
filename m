Return-Path: <stable+bounces-89500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E24A9B9458
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615CB1C2129A
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D151C5798;
	Fri,  1 Nov 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATj/O2r/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57961C305A
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474663; cv=none; b=pxsuGbqgRVB/d8Ho/iqgGnO2sQZHDWr9ehAvjmO81oeaiJ/ViEf1odb3YPEX9xFQwlHFzSF8s7DWfiKp9t1PAPmS2PG5+LbKNz6KRtELemvEaMVzhtVNXC5vSvjw/4ye595o03TTv/8oTU/tolsJRruQGtfbKZGhIOfIrkH7Tgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474663; c=relaxed/simple;
	bh=diTCW4qTtDfwfS7lLKgetDjfOEF/mU/kFvhsVV5YSGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6zx36eAroDwt/i0J7QK8VZMAU0AMiFrMuI69AD7PJ1EBXq0UJQiZ81tEGs0OateR6prUh5QCGEgtNy1JijmAaKVXX0DJhc+s6gIHvUCXVfCWGFBumNZ8cHgCEwnSa0yQwlMKs0WQ+xTUrz5RG02u1ilXUpoNTR6Cx5ItuB7JPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATj/O2r/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460969c49f2so172761cf.0
        for <stable@vger.kernel.org>; Fri, 01 Nov 2024 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730474660; x=1731079460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raRsxRjVcEgcdY/ZjtRUayGmAPhpZMiAspCxm3USwNY=;
        b=ATj/O2r/LIYpGW+Z5C48ScjCjPVK9a4sInlTHgBvgSsGaBHEogxZ1Z80yCSG97HAfm
         ZZG9dtrxL8shaaM3EyhN9mtAs/HsBmlJ1g/wwFQXge1cZmUU0LyTeWyZJDfjfQHxFJzy
         TETKb02WgDDKeFx5LJjkDezq2EGXaQPQkWOyxrV8cvuVcXieuWV5ocLsygjzZ4isAjQc
         7yb1PFDnh7bVnhfu9d76mJmnQTs/0ZH7LagRtAfKB48YATNNSJCXURD8MdX9G95jMZwK
         B2+ppsWX9S9ZfY/3EsCupjtFGC6NpB0s9oba+SAdwx7/xGayjOPEpJZuUrQBu62fnBcu
         fYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730474660; x=1731079460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raRsxRjVcEgcdY/ZjtRUayGmAPhpZMiAspCxm3USwNY=;
        b=W5PIuIIm61BD/ve/lG8njqd1pJX/zXNkUD5MYRtqYBn024pWSAxy/YLdIVTcMZOEYt
         5JYWNkAk8DQQM0JfJeM1rNc4ExxquXUbc4oCDecqgWuFT99ekocM0O9mPxGZbEIr24t2
         sid97jldwgML+q3DAevOyc7mpjRyOO8Jpa8QkdZepP6wmOR5hNRS5heq2zsqmuG5rYGz
         HSZ9KHhZPcPUzTAB7zFgrB+nX+q/xl1gsEonZI+Sqh4c/Kj/HpZqCJXXU4iDtzpMlVvb
         UxVNJBgWQoPRxR/N5ioXid6Ofw0mMKPmdGNenLqRtraxS+FDqu6vD4F4DnMtpzdgOC5r
         XO3A==
X-Gm-Message-State: AOJu0YykaI18eF77bbEwv47KFBivx04RirM6/oK0Fa4oePRT12G5XAK3
	zJy58r0AGCzHqwWPYO6sfgK5oZxgSaYKMOXNqJRclbnKkoMobEF4jdGTeLMl4Ia778X0xKqjaj5
	O1q6H2WLtSq5wvWKGpDvZLFPd2JLrrLjqzk6Tm4q1NpFseSFzusZI
X-Gm-Gg: ASbGncvMi6rCT12wti1caMF/s88Dfi5/MGucs0z6VO1w4KkFTLG8814YjjdNhAZMm8p
	tbqcR5UZA2nmluEY5qFQplNTeMCkq7tw=
X-Google-Smtp-Source: AGHT+IEgmpMgvu33ns03lBdyp+b6mQPZUsvIpsKRG8YoWqpirBztCGmWxAQ3bWHjljJ1P8H24CdP3WAvA68DbhZDcoc=
X-Received: by 2002:a05:622a:cb:b0:461:31b8:d203 with SMTP id
 d75a77b69052e-462ad0fbe9cmr5692531cf.3.1730474660127; Fri, 01 Nov 2024
 08:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101030226.3665414-1-sashal@kernel.org>
In-Reply-To: <20241101030226.3665414-1-sashal@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Nov 2024 08:24:07 -0700
Message-ID: <CAJuCfpFAyvF_ERdiBRaPQS0qfzerBCeA=+W1RGFTZFC1BXu9XQ@mail.gmail.com>
Subject: Re: Patch "lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls" has been added to the 6.11-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, fw@strlen.de, 
	Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 6:58=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> This is a note to let you know that I've just added the patch titled
>
>     lib: alloc_tag_module_unload must wait for pending kfree_rcu calls
>
> to the 6.11-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      lib-alloc_tag_module_unload-must-wait-for-pending-kf.patch
> and it can be found in the queue-6.11 subdirectory.

Thanks Sasha! Could you please double-check that the prerequisite
patch https://lore.kernel.org/all/20241021171003.2907935-1-surenb@google.co=
m/
was also picked up? I don't see it in the queue-6.11 directory.
Without that patch this one will cause build errors, that's why I sent
them as a patchset.
Thanks,
Suren.

>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 536dfe685ebd28b27ebfbc3d4b9168207b7e28a3
> Author: Florian Westphal <fw@strlen.de>
> Date:   Mon Oct 7 22:52:24 2024 +0200
>
>     lib: alloc_tag_module_unload must wait for pending kfree_rcu calls
>
>     [ Upstream commit dc783ba4b9df3fb3e76e968b2cbeb9960069263c ]
>
>     Ben Greear reports following splat:
>      ------------[ cut here ]------------
>      net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_=
fn has 256 allocated at module unload
>      WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_u=
nload+0x22b/0x3f0
>      Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat m=
sdos fat
>     ...
>      Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04=
/2020
>      RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
>       codetag_unload_module+0x19b/0x2a0
>       ? codetag_load_module+0x80/0x80
>
>     nf_nat module exit calls kfree_rcu on those addresses, but the free
>     operation is likely still pending by the time alloc_tag checks for le=
aks.
>
>     Wait for outstanding kfree_rcu operations to complete before checking
>     resolves this warning.
>
>     Reproducer:
>     unshare -n iptables-nft -t nat -A PREROUTING -p tcp
>     grep nf_nat /proc/allocinfo # will list 4 allocations
>     rmmod nft_chain_nat
>     rmmod nf_nat                # will WARN.
>
>     [akpm@linux-foundation.org: add comment]
>     Link: https://lkml.kernel.org/r/20241007205236.11847-1-fw@strlen.de
>     Fixes: a473573964e5 ("lib: code tagging module support")
>     Signed-off-by: Florian Westphal <fw@strlen.de>
>     Reported-by: Ben Greear <greearb@candelatech.com>
>     Closes: https://lore.kernel.org/netdev/bdaaef9d-4364-4171-b82b-bcfc12=
e207eb@candelatech.com/
>     Cc: Uladzislau Rezki <urezki@gmail.com>
>     Cc: Vlastimil Babka <vbabka@suse.cz>
>     Cc: Suren Baghdasaryan <surenb@google.com>
>     Cc: Kent Overstreet <kent.overstreet@linux.dev>
>     Cc: <stable@vger.kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/lib/codetag.c b/lib/codetag.c
> index afa8a2d4f3173..d1fbbb7c2ec3d 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -228,6 +228,9 @@ bool codetag_unload_module(struct module *mod)
>         if (!mod)
>                 return true;
>
> +       /* await any module's kfree_rcu() operations to complete */
> +       kvfree_rcu_barrier();
> +
>         mutex_lock(&codetag_lock);
>         list_for_each_entry(cttype, &codetag_types, link) {
>                 struct codetag_module *found =3D NULL;

