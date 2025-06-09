Return-Path: <stable+bounces-152181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D0AD24F0
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB416E188
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71475215F4B;
	Mon,  9 Jun 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8i1ehvK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5884A3C;
	Mon,  9 Jun 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489874; cv=none; b=fe7xWe1gfEuLn47arU5jtFcSpCfZlrTDOYu970l6miLv7xoNsf1qLYgnbxRemRDjyPeg+PuxI6D8YVQzpMhW8e0U15cQj8AiYcxncej1/7EUQ8CdDJ7v3vQ49EioYuqfOJ85cfxH8zw7a8XI/NxevhuaDy+hrzdDnfcxjvpomKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489874; c=relaxed/simple;
	bh=h6bj8cVdChPXIebQFRKMr2JXuU4E9lSx8FDSHkPf8wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCeMgzqcKciRVY1aU7JR1VszRaa33IMZMG5ozuoAgb4XvWsc8w9MjNDV3hgRj9NV5H4aLvddvHsgoTr5617YgNlxZ9LhXpfJUHjW4VeJ7/m3XpzrGuepvoD8f3VTxSKFn83T1RnATAVsmp0bHDnHQ7MImKJODbjEIHoMEhaB7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8i1ehvK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ade3723adso33756051fa.0;
        Mon, 09 Jun 2025 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749489871; x=1750094671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gS5h1Ie0tgERrl+nIzXO9eaCUYI3r/JKh27WNUnM0Dg=;
        b=W8i1ehvKxHlvfrQQmBYjmLiPDLAwUtMItgtSUVyIkINxNKZvII8HN2Zh4iWdztFMR4
         TAtj9d7+ymZTbBp9ENH0MB++kWTlqi4AEppXO2xMdMoaCmvoIB4hYrzrlrUX3Vms8lLk
         FPiFyl0Yc5Qprm7W0aNRUIDaaC33vpfo2grJ+E99EBfmjq3QGvc62JsgBPtpsKBFvWGN
         7+5u/qTYcd+OWvt2aKA7YKcoxhh+z5KLVUZ7b1Coww89N4iUgoNRGs4a7Jt0dFw/Vttz
         J+mhhrgBvNt8ACwIVGv/NKY/3AB2Z/dMgrN3a3TYd5pR8X66kY6DCR0W5/8LuvdcJJHX
         NKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749489871; x=1750094671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gS5h1Ie0tgERrl+nIzXO9eaCUYI3r/JKh27WNUnM0Dg=;
        b=ofhCPL+pkcqHE5Gd8ir7M2jYop/3XdHmWXeW5nrVwXZPhfnn5XleJ96dd2JwlIv6Ji
         WUIMRXCupu35YN/1bkNWA5cm/oxNQ/Bpdnae7tP5uKfEmsGs6MnEzq2qYt5H8mFWHgXw
         psFfW55698GWXbThphqeJAzUa8XxTsM37tKSZN9VBCf3NJX2pVjHquSgGlTVfA7jjcOL
         Rizj+b0GTbtQd4Z0TA60MNYYghN2VLDfvQhBhITus3r1TwjxbtT0rKOCiv1kgKG4MCzC
         hH5oZ6hMEciV01UaT4PEozfRhr+K2GLifSlQWppnNv040x6a+n7TWrjG77SXXk6y0M1v
         Y8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUa1xbW0snCdVMRfjrvVArm8uAcg9EOXDssHf7BvJBi7e79GiZKTqjQ1lJGDst9Z4cOSVmmSUR40lhY4I4=@vger.kernel.org, AJvYcCUcYkTfu3syAsC5TrHL01NJxM6Ajuslru4reGyURgR2HzwwMuCkzhiWm6N4fwod7+qKWts3sTz/@vger.kernel.org
X-Gm-Message-State: AOJu0YwtpbRplpHqbp8bs5utssLXsbKVJliOBrG/hYdSyrjtsZ49gjac
	iRT8tF9xBS1/wmUUG83DzyUc4R0bxA7UY+tR25KoJSfaKQPKJsoF2PPOFk+d4ov9g94tHoEeJVl
	gr2cqE62p30CPJc21WxN8e2PgFuoVuj0=
X-Gm-Gg: ASbGncu/f6JYihgL8u5UsBECy7htU/z0zFaxL1bYkrGRNxS/9q3BRAhfl3tH79fDvH9
	8pKa/P7iw4/XQtetVN8hT0xoyfIbqbezS8UBBnWDsuPhOxMFme9Op3r8QTL1v/APY2iPf22oTVv
	a+i5p9QE24d/lTjsSRwLdrw0TwmSb/F0Rd
X-Google-Smtp-Source: AGHT+IGh0KA+fGHr2H+2Jp/BnYa7lpx49d2kmZmN36sDroN9zo1IL+JjcscoHWhhH3gN1YBNeSmz+MKNR3CsoRj1tQI=
X-Received: by 2002:a2e:a595:0:b0:32a:6e20:7cdb with SMTP id
 38308e7fff4ca-32adfcc5cd4mr29740751fa.17.1749489870182; Mon, 09 Jun 2025
 10:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609171751.36305-1-ryncsn@gmail.com>
In-Reply-To: <20250609171751.36305-1-ryncsn@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 10 Jun 2025 01:24:12 +0800
X-Gm-Features: AX0GCFvXp8Z9b7xzJaO49rmXecnUchAIEdcdnv0ahpVgg0lak-hlmevqgvMLCEE
Message-ID: <CAMgjq7C-71z3w1Tf2eMwLvpi2Nt5md8z43jtM4o_L35F82uCVA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem, swap: fix softlockup with mTHP swapin
To: linux-mm@kvack.org, stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 1:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Following softlockup can be easily reproduced on my test machine with:
>
> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
> swapon /dev/zram0 # zram0 is a 48G swap device
> mkdir -p /sys/fs/cgroup/memory/test
> echo 1G > /sys/fs/cgroup/test/memory.max
> echo $BASHPID > /sys/fs/cgroup/test/cgroup.procs
> while true; do
>     dd if=3D/dev/zero of=3D/tmp/test.img bs=3D1M count=3D5120
>     cat /tmp/test.img > /dev/null
>     rm /tmp/test.img
> done
>
> Then after a while:
> watchdog: BUG: soft lockup - CPU#0 stuck for 763s! [cat:5787]
> Modules linked in: zram virtiofs
> CPU: 0 UID: 0 PID: 5787 Comm: cat Kdump: loaded Tainted: G             L =
     6.15.0.orig-gf3021d9246bc-dirty #118 PREEMPT(voluntary)=C2=B7
> Tainted: [L]=3DSOFTLOCKUP
> Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
> RIP: 0010:mpol_shared_policy_lookup+0xd/0x70
> Code: e9 b8 b4 ff ff 31 c0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 41 54 55 53 <48> 8b 1f 48 85=
 db 74 41 4c 8d 67 08 48 89 fb 48 89 f5 4c 89 e7 e8
> RSP: 0018:ffffc90002b1fc28 EFLAGS: 00000202
> RAX: 00000000001c20ca RBX: 0000000000724e1e RCX: 0000000000000001
> RDX: ffff888118e214c8 RSI: 0000000000057d42 RDI: ffff888118e21518
> RBP: 000000000002bec8 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000bf4 R11: 0000000000000000 R12: 0000000000000001
> R13: 00000000001c20ca R14: 00000000001c20ca R15: 0000000000000000
> FS:  00007f03f995c740(0000) GS:ffff88a07ad9a000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f03f98f1000 CR3: 0000000144626004 CR4: 0000000000770eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  shmem_alloc_folio+0x31/0xc0
>  shmem_swapin_folio+0x309/0xcf0
>  ? filemap_get_entry+0x117/0x1e0
>  ? xas_load+0xd/0xb0
>  ? filemap_get_entry+0x101/0x1e0
>  shmem_get_folio_gfp+0x2ed/0x5b0
>  shmem_file_read_iter+0x7f/0x2e0
>  vfs_read+0x252/0x330
>  ksys_read+0x68/0xf0
>  do_syscall_64+0x4c/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f03f9a46991
> Code: 00 48 8b 15 81 14 10 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd e8 20 a=
d 01 00 f3 0f 1e fa 80 3d 35 97 10 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff=
 ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
> RSP: 002b:00007fff3c52bd28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007f03f9a46991
> RDX: 0000000000040000 RSI: 00007f03f98ba000 RDI: 0000000000000003
> RBP: 00007fff3c52bd50 R08: 0000000000000000 R09: 00007f03f9b9a380
> R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000040000
> R13: 00007f03f98ba000 R14: 0000000000000003 R15: 0000000000000000
>  </TASK>
>
> The reason is simple, readahead brought some order 0 folio in swap
> cache, and the swapin mTHP folio being allocated is in confict with it,
> so swapcache_prepare fails and causes shmem_swap_alloc_folio to return
> -EEXIST, and shmem simply retries again and again causing this loop.
>
> Fix it by applying a similar fix for anon mTHP swapin.
>
> The performance change is very slight, time of swapin 10g zero folios
> with shmem (test for 12 times):
> Before:  2.47s
> After:   2.48s
>
> Fixes: 1dd44c0af4fa1 ("mm: shmem: skip swapcache for swapin of synchronou=
s swap device")
> Signed-off-by: Kairui Song <kasong@tencent.com>
>
> ---
>
> V1: https://lore.kernel.org/linux-mm/20250608192713.95875-1-ryncsn@gmail.=
com/
> Updates:
> - Move non_swapcache_batch check before swapcache_prepare, I was
>   expecting this could improve the performance, turns out it barely
>   helps and may even cause more overhead in some cases. [ Barry Song ]
> - Remove zero map check, no need to do that for shmem [ Barry Song,
>   Baolin Wang ]
> - Fix build bot error.
>
>  mm/memory.c | 20 --------------------
>  mm/shmem.c  |  4 +++-
>  mm/swap.h   | 23 +++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 9ead7ab07e8e..3845ed068d74 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4313,26 +4313,6 @@ static struct folio *__alloc_swap_folio(struct vm_=
fault *vmf)
>  }
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> -{
> -       struct swap_info_struct *si =3D swp_swap_info(entry);
> -       pgoff_t offset =3D swp_offset(entry);
> -       int i;
> -
> -       /*
> -        * While allocating a large folio and doing swap_read_folio, whic=
h is
> -        * the case the being faulted pte doesn't have swapcache. We need=
 to
> -        * ensure all PTEs have no cache as well, otherwise, we might go =
to
> -        * swap devices while the content is in swapcache.
> -        */
> -       for (i =3D 0; i < max_nr; i++) {
> -               if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
> -                       return i;
> -       }
> -
> -       return i;
> -}
> -
>  /*
>   * Check if the PTEs within a range are contiguous swap entries
>   * and have consistent swapcache, zeromap.
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 73182e904f9c..a4fdfbd086f1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2256,6 +2256,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         folio =3D swap_cache_get_folio(swap, NULL, 0);
>         order =3D xa_get_order(&mapping->i_pages, index);
>         if (!folio) {
> +               int nr_pages =3D 1 << order;
>                 bool fallback_order0 =3D false;
>
>                 /* Or update major stats only when swapin succeeds?? */
> @@ -2271,7 +2272,8 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>                  * to swapin order-0 folio, as well as for zswap case.
>                  */
>                 if (order > 0 && ((vma && unlikely(userfaultfd_armed(vma)=
)) ||
> -                                 !zswap_never_enabled()))
> +                                 !zswap_never_enabled() ||
> +                                 non_swapcache_batch(swap, nr_pages) !=
=3D nr_pages))
>                         fallback_order0 =3D true;
>
>                 /* Skip swapcache for synchronous device. */
> diff --git a/mm/swap.h b/mm/swap.h
> index e87a0f19a0ee..911ad5ff0f89 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -108,6 +108,25 @@ static inline int swap_zeromap_batch(swp_entry_t ent=
ry, int max_nr,
>                 return find_next_bit(sis->zeromap, end, start) - start;
>  }
>
> +static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> +{
> +       struct swap_info_struct *si =3D swp_swap_info(entry);
> +       pgoff_t offset =3D swp_offset(entry);
> +       int i;
> +
> +       /*
> +        * While allocating a large folio and doing mTHP swapin, we need =
to
> +        * ensure all entries are not cached, otherwise, the mTHP folio w=
ill
> +        * be in conflict with the folio in swap cache.
> +        */
> +       for (i =3D 0; i < max_nr; i++) {
> +               if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
> +                       return i;
> +       }
> +
> +       return i;
> +}
> +
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline void swap_read_folio(struct folio *folio, struct swap_iocb=
 **plug)
> @@ -202,6 +221,10 @@ static inline int swap_zeromap_batch(swp_entry_t ent=
ry, int max_nr,
>         return 0;
>  }
>
> +static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_SWAP */
>
>  /**
> --
> 2.49.0
>

I really should Cc stable for this, sorry I forgot it.

Cc: stable@vger.kernel.org # 6.14

