Return-Path: <stable+bounces-152289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F78AD35A7
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297BE1898251
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3328E586;
	Tue, 10 Jun 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCBo8D8t"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125228E582;
	Tue, 10 Jun 2025 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557404; cv=none; b=bfE9EoDOHmTn67RjftxxFbsluFsyPuc6SC0OfXdRR1ja8srwObXoo+6oCuNhq0fgy72rP6xS33E+YfaALgLz7hm0QEZnnRKyh1gykM9qHLt+UHox0nKD3beNmTA9d9wM9+IiybsbjtKlapa23Z1bCpZyq9po4tKDS9f9AJnoCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557404; c=relaxed/simple;
	bh=ItTGZ6rvcQflVD2CtmqZ+/ejp5BhpdVQRL4hHN9ruUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHl5HKe8D5FXzA/xrHQ4gtXh5k0GYV9hsqNDU5i35r/7/oOwdEUP2FrfUREoql8lMyVs3PPXF03eo9H9OxA08XhaWIty7vSQ5Sb8HdJggkjmlEHxpOkzaCRbBWK6PkTRNidY3XjoZ8RKdb1DDEPEWwcLXFzv10kV0oV4yZUvN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCBo8D8t; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-310447fe59aso51879271fa.0;
        Tue, 10 Jun 2025 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749557400; x=1750162200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YL0ojihKPdNLv/xHN6QLm3jZrEwLGeSVmJyK9Ndi3o=;
        b=nCBo8D8tXdtshNkWEtS594wzYTrrXPauCqvN2pZq9QCIiiXYiiDOMPGzV95Hc8FE5n
         IGYKTd8YYrjqM/xGB7he41uRq/W2qXwJ3qjs2o2btCg4VJ4qX9/ysTZbglL9Tz0gYKet
         hQJA85BYT2P5z80voQ8l0yj2Oh6acOxhQJvXgdzrGuL1tiSDCB8cviDUBCh++YiL4wp0
         3M5T7iND8zMsyjbSHhOEY6TLSC87Qy4QX4UEzJcN0LfRbAoSRKT3RknEXjxoS4i8CV5D
         ljsxQeRlHLKMrOrZ8EYe3ZZScQyyGZSLCKIhT86LBVSqdgosdo2T/Fm+WLEkVNCBHhLp
         NhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749557400; x=1750162200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YL0ojihKPdNLv/xHN6QLm3jZrEwLGeSVmJyK9Ndi3o=;
        b=Zw65FPxy7bzcDe3NuR0a6cCKNBX/+GOYjwEp1umVpTDUJKii29NnvrLolRhCp9Tj0G
         zKc4y0x03NXRey2dpC9Cu3E9lm3nYO6ydKGK7Ft7EC0v0ph5s+92kbvbswFk1ma7waNC
         acx9Tkf9ubOBo5l44zgnyDbKdcaBdquIc0KJwM8KnaJAj/jwSNH38RhyXgyT4ZFiEAzt
         xkonJlRMgaxfqjz6ApHDp2a/sKqC6cX6eraJclcdDUplCXLgtenKPv0DxLpPUH1xUvmv
         uayfpmbnBElIV8LyZ5CgOOIVnImvNLnpU6LNgLAbQk6BtpXnV3cRQGYiVd7kUloKYJWd
         agDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+cDPhRfc7WwTMuEqOSorBWuH5wK0bcXs3m1hd1ZKiEO/KgTtd8WVtlN5NeUtJQoxzQHLPmjtS/1nl/Oc=@vger.kernel.org, AJvYcCWjQmkHAUziLb2iyIn6zuqlVxSCavDpOaQgbVk53CeMku2SuUYY1Y5t9qZvkPlfj8ZtPjfhgIAu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuy/ioRJE2oxmLKDCFuIqqZwQho5oM8JKxOGKupqV4goq+BMdo
	7Q7ZUXDjIpbNmDgURLR3FAO+w90dXlkjWO2lerRm8Sx5TR6Bomt5qLAfRPvvydrMCsmvbsFRwop
	8/YtlyEKgwWap2oUdSy3QxpV8KB5lJNntgR5Fy84=
X-Gm-Gg: ASbGncvRMxuOclR4izrz5ja1ES1OLE0IMAq7jvomNLN2KOlkkIs/hi7dKrhoxxF0z9c
	Ah20GqtoZL+XhHWxIStbPvx7DZsHCy+imiRFS7g2SJfkhqrNozPlCF7AKXVrnEHi3ps4fNINfrH
	xxC+zAv7s2r4RWX/m0BpbNMoc9O5p90NJhEQwEanD8Fjc=
X-Google-Smtp-Source: AGHT+IEvdplytAWoEI0b8tB2VLoXPuB8Mj5MTg4zuYfiVUniSBpWeQl1NNfE+gjuO8yoACZHcvqvzk8X/2/Wce2M5F0=
X-Received: by 2002:a05:651c:154b:b0:32a:864a:46eb with SMTP id
 38308e7fff4ca-32adf98d1a9mr43570701fa.0.1749557399906; Tue, 10 Jun 2025
 05:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609171751.36305-1-ryncsn@gmail.com> <CAMgjq7C-71z3w1Tf2eMwLvpi2Nt5md8z43jtM4o_L35F82uCVA@mail.gmail.com>
 <CAGsJ_4xrk3qbZ2ZLfNsa_rFUk4QDoBa7DREFgJKEkV8L1cxoGQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xrk3qbZ2ZLfNsa_rFUk4QDoBa7DREFgJKEkV8L1cxoGQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 10 Jun 2025 20:09:42 +0800
X-Gm-Features: AX0GCFvuHVV1WPPOy4MqkxoQsCRCqE4wKBt-y4BISmcrDOkwa27_2WBQbF-P6zA
Message-ID: <CAMgjq7AsKFz7UN+seR5atznE_RBTDC9qjDmwN5saMe+KL3b1mQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem, swap: fix softlockup with mTHP swapin
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 5:17=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Jun 10, 2025 at 5:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Tue, Jun 10, 2025 at 1:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Following softlockup can be easily reproduced on my test machine with=
:
> > >
> > > echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enab=
led
> > > swapon /dev/zram0 # zram0 is a 48G swap device
> > > mkdir -p /sys/fs/cgroup/memory/test
> > > echo 1G > /sys/fs/cgroup/test/memory.max
> > > echo $BASHPID > /sys/fs/cgroup/test/cgroup.procs
> > > while true; do
> > >     dd if=3D/dev/zero of=3D/tmp/test.img bs=3D1M count=3D5120
> > >     cat /tmp/test.img > /dev/null
> > >     rm /tmp/test.img
> > > done
> > >
> > > Then after a while:
> > > watchdog: BUG: soft lockup - CPU#0 stuck for 763s! [cat:5787]
> > > Modules linked in: zram virtiofs
> > > CPU: 0 UID: 0 PID: 5787 Comm: cat Kdump: loaded Tainted: G           =
  L      6.15.0.orig-gf3021d9246bc-dirty #118 PREEMPT(voluntary)=C2=B7
> > > Tainted: [L]=3DSOFTLOCKUP
> > > Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
> > > RIP: 0010:mpol_shared_policy_lookup+0xd/0x70
> > > Code: e9 b8 b4 ff ff 31 c0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 41 54 55 53 <48> 8b 1f 4=
8 85 db 74 41 4c 8d 67 08 48 89 fb 48 89 f5 4c 89 e7 e8
> > > RSP: 0018:ffffc90002b1fc28 EFLAGS: 00000202
> > > RAX: 00000000001c20ca RBX: 0000000000724e1e RCX: 0000000000000001
> > > RDX: ffff888118e214c8 RSI: 0000000000057d42 RDI: ffff888118e21518
> > > RBP: 000000000002bec8 R08: 0000000000000001 R09: 0000000000000000
> > > R10: 0000000000000bf4 R11: 0000000000000000 R12: 0000000000000001
> > > R13: 00000000001c20ca R14: 00000000001c20ca R15: 0000000000000000
> > > FS:  00007f03f995c740(0000) GS:ffff88a07ad9a000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f03f98f1000 CR3: 0000000144626004 CR4: 0000000000770eb0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  shmem_alloc_folio+0x31/0xc0
> > >  shmem_swapin_folio+0x309/0xcf0
> > >  ? filemap_get_entry+0x117/0x1e0
> > >  ? xas_load+0xd/0xb0
> > >  ? filemap_get_entry+0x101/0x1e0
> > >  shmem_get_folio_gfp+0x2ed/0x5b0
> > >  shmem_file_read_iter+0x7f/0x2e0
> > >  vfs_read+0x252/0x330
> > >  ksys_read+0x68/0xf0
> > >  do_syscall_64+0x4c/0x1c0
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > RIP: 0033:0x7f03f9a46991
> > > Code: 00 48 8b 15 81 14 10 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd e8 =
20 ad 01 00 f3 0f 1e fa 80 3d 35 97 10 00 00 74 13 31 c0 0f 05 <48> 3d 00 f=
0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
> > > RSP: 002b:00007fff3c52bd28 EFLAGS: 00000246 ORIG_RAX: 000000000000000=
0
> > > RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007f03f9a46991
> > > RDX: 0000000000040000 RSI: 00007f03f98ba000 RDI: 0000000000000003
> > > RBP: 00007fff3c52bd50 R08: 0000000000000000 R09: 00007f03f9b9a380
> > > R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000040000
> > > R13: 00007f03f98ba000 R14: 0000000000000003 R15: 0000000000000000
> > >  </TASK>
> > >
> > > The reason is simple, readahead brought some order 0 folio in swap
> > > cache, and the swapin mTHP folio being allocated is in confict with i=
t,
> > > so swapcache_prepare fails and causes shmem_swap_alloc_folio to retur=
n
> > > -EEXIST, and shmem simply retries again and again causing this loop.
> > >
> > > Fix it by applying a similar fix for anon mTHP swapin.
> > >
> > > The performance change is very slight, time of swapin 10g zero folios
> > > with shmem (test for 12 times):
> > > Before:  2.47s
> > > After:   2.48s
> > >
> > > Fixes: 1dd44c0af4fa1 ("mm: shmem: skip swapcache for swapin of synchr=
onous swap device")
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Reviewed-by: Barry Song <baohua@kernel.org>
>
> > >
> > > ---
> > >
> > > V1: https://lore.kernel.org/linux-mm/20250608192713.95875-1-ryncsn@gm=
ail.com/
> > > Updates:
> > > - Move non_swapcache_batch check before swapcache_prepare, I was
> > >   expecting this could improve the performance, turns out it barely
> > >   helps and may even cause more overhead in some cases. [ Barry Song =
]
> > > - Remove zero map check, no need to do that for shmem [ Barry Song,
> > >   Baolin Wang ]
> > > - Fix build bot error.
> > >
> > >  mm/memory.c | 20 --------------------
> > >  mm/shmem.c  |  4 +++-
> > >  mm/swap.h   | 23 +++++++++++++++++++++++
> > >  3 files changed, 26 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 9ead7ab07e8e..3845ed068d74 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4313,26 +4313,6 @@ static struct folio *__alloc_swap_folio(struct=
 vm_fault *vmf)
> > >  }
> > >
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > -static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> > > -{
> > > -       struct swap_info_struct *si =3D swp_swap_info(entry);
> > > -       pgoff_t offset =3D swp_offset(entry);
> > > -       int i;
> > > -
> > > -       /*
> > > -        * While allocating a large folio and doing swap_read_folio, =
which is
> > > -        * the case the being faulted pte doesn't have swapcache. We =
need to
> > > -        * ensure all PTEs have no cache as well, otherwise, we might=
 go to
> > > -        * swap devices while the content is in swapcache.
> > > -        */
> > > -       for (i =3D 0; i < max_nr; i++) {
> > > -               if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
> > > -                       return i;
> > > -       }
> > > -
> > > -       return i;
> > > -}
> > > -
> > >  /*
> > >   * Check if the PTEs within a range are contiguous swap entries
> > >   * and have consistent swapcache, zeromap.
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 73182e904f9c..a4fdfbd086f1 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2256,6 +2256,7 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> > >         folio =3D swap_cache_get_folio(swap, NULL, 0);
> > >         order =3D xa_get_order(&mapping->i_pages, index);
> > >         if (!folio) {
> > > +               int nr_pages =3D 1 << order;
> > >                 bool fallback_order0 =3D false;
> > >
> > >                 /* Or update major stats only when swapin succeeds?? =
*/
> > > @@ -2271,7 +2272,8 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> > >                  * to swapin order-0 folio, as well as for zswap case=
.
> > >                  */
> > >                 if (order > 0 && ((vma && unlikely(userfaultfd_armed(=
vma))) ||
> > > -                                 !zswap_never_enabled()))
> > > +                                 !zswap_never_enabled() ||
> > > +                                 non_swapcache_batch(swap, nr_pages)=
 !=3D nr_pages))
> > >                         fallback_order0 =3D true;
> > >
> > >                 /* Skip swapcache for synchronous device. */
> > > diff --git a/mm/swap.h b/mm/swap.h
> > > index e87a0f19a0ee..911ad5ff0f89 100644
> > > --- a/mm/swap.h
> > > +++ b/mm/swap.h
> > > @@ -108,6 +108,25 @@ static inline int swap_zeromap_batch(swp_entry_t=
 entry, int max_nr,
> > >                 return find_next_bit(sis->zeromap, end, start) - star=
t;
> > >  }
> > >
> > > +static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> > > +{
> > > +       struct swap_info_struct *si =3D swp_swap_info(entry);
> > > +       pgoff_t offset =3D swp_offset(entry);
> > > +       int i;
> > > +
> > > +       /*
> > > +        * While allocating a large folio and doing mTHP swapin, we n=
eed to
> > > +        * ensure all entries are not cached, otherwise, the mTHP fol=
io will
> > > +        * be in conflict with the folio in swap cache.
> > > +        */
> > > +       for (i =3D 0; i < max_nr; i++) {
> > > +               if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
> > > +                       return i;
> > > +       }
> > > +
> > > +       return i;
> > > +}
>
> Nit:
> This was previously under CONFIG_TRANSPARENT_HUGEPAGE, but is now
> guarded by CONFIG_SWAP. I assume there's no performance impact, since
> if (order > 0) would never be true on platforms where THP is
> disabled, meaning non_swapcache_batch() would never be called?

Yes, there is no performance overhead, order is always 0. But some
clean up can be done later.

The whole `order =3D xa_get_order` and related checks are not needed at
all for !CONFIG_TRANSPARENT_HUGEPAGE. It's hard to optimize it out
without shuffle too many code here, simply wrap non_swapcache_batch
with CONFIG_TRANSPARENT_HUGEPAGE may cause more trouble for
understanding the code and doesn't help much here, it's really the
caller that should avoid the whole thing. That's not in the scope of a
bugfix.

I have a shmem xarray lookup optimization patch in the swap table
series, now looking at it I found it might be useful for the clean up
here. I'll check if I can send a clean up & optimize series first.

