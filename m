Return-Path: <stable+bounces-214763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dlVKCWxLh2nVVwQAu9opvQ
	(envelope-from <stable+bounces-214763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:25:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295610627B
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C02763016926
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0FD335096;
	Sat,  7 Feb 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkIc+mtm"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAE2367D1
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770474344; cv=pass; b=WuZMrqsU6DrG86IYp4D8n8w1WBiXaSIGgT4Z8fatf6xwNPFNEgWup26D8w4oKYiaUWi2RRSDQylH6bT5fgucigvkKUXkXeVZclnsarrZr5dzvKPbwt14ZlB8lHT9OZBWdUBw6MbezkPFW+Exwes58NJQd6CsyAo3EFVfgs+ORIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770474344; c=relaxed/simple;
	bh=3WP7fZ78K34Ts8WY1eRHR16vmDphEyvzbs9Q5HugKEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+keWhF5317nUwHVqjFZYAszgg1C8MOJ5aI519XcCU0WxbMC5hx+qg3ZxxmlseP/FMBchm2eqaSthhxi6z4IwHWuBAo/B0gHPQ1UzaZDetY+JcQ2ozfG64qkgqi7a17x04d390xlA35Hhaok1zAXrjaOtiM2ZSkWWe2qv6StdBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkIc+mtm; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c838069e5so2178820b6e.0
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 06:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770474343; cv=none;
        d=google.com; s=arc-20240605;
        b=BRgjx6ouLW+gUsqn8uBa3EZD0lwKTGV2F/spcQjcefJcmmUVm+d0WKctIRLcAXPi5G
         J8fxYap6MHtwA1pXWt1qppnMSpT+VTySMHZUxsF/nch7a/m3mWdlVD3oaXcC5LCTe9FP
         GEZ2l0zIyw5M4uJdKcTC/LiTcln3fiQ8w5IXqxMtnqH/M4MmIOYJncTMAT+ClacD+m9C
         2BIbY1HobnxIs54kYQWuuQ75X1paFQl72BuFRb6wLIK/GdFGJwbBAGYJfPHNNKVyO8I6
         AuKvVs9OGF2pe1N6eTDvtlL+qe+1EaHo1ff54V4dbpYMDF/ah6y2Ss4RpjMPS0Xd0p8R
         /fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MUnteIOcWItO7a2hy82VgioQwRsbF0EGBjUphfa4ibE=;
        fh=4yuGohUyI0RTkt/d0h3LcjtFYJ5JLw/BV0t+96nPFCA=;
        b=lZwpbOhbFjLs+IxZ9UQF1daHrJ4hPSO2rE4/X5O2qHujWN8o2r5RjtxQEnLBIIkr06
         XyJs6IN79epguyhwLV/IjZeyQLzVUCW4DPW1Hn8F+v+r89tdzgoy5wS606XvompAB5KW
         xAMkZlwGisfHOHnEvAzagCjwD5wah2xggoqyk/mQKJKzq3PkCBV1WDON7vYvf21Gb3/5
         oYv7N4HuecpNvIMwzt93+b8SJo+qSlpyz3UBtO4Tw5AbmGL1Rovu7nQfcd+JDS9O5ygq
         s8oKAvDJ6Eqx3HWpNfo6kl6zJ0TugRRLes2nLuMTocVE+naqeBx4wThGYxBBTSZiZtGy
         BzRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770474343; x=1771079143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUnteIOcWItO7a2hy82VgioQwRsbF0EGBjUphfa4ibE=;
        b=WkIc+mtm4Fig8+lUgaMnQWBjBgvhHoPb4BpYleAb0J3HUwLFBKvqjZR7b06tH7Woxk
         MtxYEX0vHyY3vLJBNM5iRYI0YpFOuJbZjzL2KKqZMePoydyqTuO/JWoA8Ri9c03sfO9H
         5jSvs3JZ5aVy99RcblKEverHlIOdVMhSauCi0Aho0SS62B3iztiYXC6J8D96Bf5GcOGh
         rhv0iN/VVQVGehQrtH6pA1ILza0Tpv+HPF6vS9gIMnnsiNu+GlkHDf2Sd0gbavCIWYtm
         dbqofS+V7M+GFPv+lzEa7tVayHf/MTfOT8QIdekMHMji8wRlqRvjC9yv0nqlCMlmdMsa
         maSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770474343; x=1771079143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUnteIOcWItO7a2hy82VgioQwRsbF0EGBjUphfa4ibE=;
        b=rhXdSoiLFk5rW6Z3oMCYk+2nLiimLT/KmCmACmwfSZMTH8FWDAGtKDuk/0B6g7yzgF
         38lMJrti8WYhlW+IWJHj3bjSEzkfY3bTU4DhyyANkRDN0eH0yfHNA8eIn5Yx3OApY7Lx
         qr1ciTxNh4yxjEqi/aTx8endamlZgb+I+vy4VNe4xwipbzPSLbUH3p1QOKfJQ97nQ+gY
         HrrpvJ4ORwu/zzVMlwRqXIihDPcOfMV7s5QR7gfwvV2xWgqMckEunLcM3y17bmHZbXuh
         /PBJ3soZQ2kQ/MWExmgnZCE33wqTlPMg9b+0UzNx/odiv2yUcYcJ6TS5kusBpCr0PpUJ
         DNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0IlnWHJi2ABwju9cVEdnctW3IZe4Cz8tNgVi7/rcCNTsbtoPoMeAYdIvk+JBWdl4ooEjfY7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyecLIFMrzAbfkJdN2K8XPGLt9grnRGWQzat8dWOG2OeRR0CVA3
	Jk5578MuRGJcKlDubeZV8/u7+iK6PeyzAfKm9Hid4pIKn5S/xRfQ+s2NhasMNekDx6sxjcyYIKu
	xjs3Eg5Oi1kIOlDh/XJ+HAzH969NIcLU=
X-Gm-Gg: AZuq6aIuklyYvOSwsKJwFNOl7kK4IPY1CQdlhVTkCQUSroDTsB44v+hqveIYTYaLXh7
	vY6t5OGVWW71jAQGLBs9wvgWV5POzkkcn2YOLG5n/+MOsV0UyWo+ahsMfXvD/EEQzYxj2jlo+5J
	BVfnBbqErtneZrywCIE779yrPciIE3krAkx0d9V+0IS70dhsV+loBcqhPtQaFJX9Bcmh8v4YMIF
	6MxU1pc2Hgpmxt8+Np0UozeP5rDeIWADKqXRXBULky/QP3LuusYy+uZK4OnDjf/d3mweG6+vQ==
X-Received: by 2002:a05:6808:6410:b0:45e:bb61:b981 with SMTP id
 5614622812f47-462fd0a239dmr3360221b6e.46.1770474343174; Sat, 07 Feb 2026
 06:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com> <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com> <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
 <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com> <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
 <CABXGCsP2z6sbf_FYZjdxyLhfJZEaxz0_WrEeteS50GLyU=KQGA@mail.gmail.com>
 <CABXGCsNM8Oex-V3vFSUy3ftMw1fAweHZHQYzRHWU9M6gm7r-rw@mail.gmail.com>
 <FF3C3042-8265-40E8-8786-333A6F627405@nvidia.com> <AB3C1175-FF03-484E-AEB6-07BC93E49683@nvidia.com>
In-Reply-To: <AB3C1175-FF03-484E-AEB6-07BC93E49683@nvidia.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 7 Feb 2026 19:25:31 +0500
X-Gm-Features: AZwV_QiQ7swe7v8rQU1SeopcrGZfNe5EXkz7JL0I3ywv5FfgC0PaaUjyFc-0yn4
Message-ID: <CABXGCsNyt6DB=SX9JWD=-WK_BiHhbXaCPNV-GOM8GskKJVAn_A@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, hughd@google.com, stable@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, surenb@google.com, Matthew Wilcox <willy@infradead.org>, 
	mhocko@suse.com, hannes@cmpxchg.org, jackmanb@google.com, vbabka@suse.cz, 
	Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214763-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,tencent.com,google.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org,suse.cz,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6295610627B
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 8:28=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> OK, it seems that both slub and shmem do not reset ->private when freeing
> pages/folios. And tail page's private is not zero, because when a page
> with non zero private is freed and gets merged with a lower buddy, its
> private is not set to 0 in the code path.
>
> The patch below seems to fix the issue, since I am at Iteration 104 and c=
ounting.
> I also put a VM_BUG_ON(page->private) in free_pages_prepare() and it is n=
ot
> triggered either.
>
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ec6c01378e9d..546e193ef993 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2437,8 +2437,10 @@ static int shmem_swapin_folio(struct inode *inode,=
 pgoff_t index,
>  failed_nolock:
>         if (skip_swapcache)
>                 swapcache_clear(si, folio->swap, folio_nr_pages(folio));
> -       if (folio)
> +       if (folio) {
> +               folio->swap.val =3D 0;
>                 folio_put(folio);
> +       }
>         put_swap_device(si);
>
>         return error;
> diff --git a/mm/slub.c b/mm/slub.c
> index f77b7407c51b..2cdab6d66e1a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3311,6 +3311,7 @@ static void __free_slab(struct kmem_cache *s, struc=
t slab *slab)
>
>         __slab_clear_pfmemalloc(slab);
>         page->mapping =3D NULL;
> +       page->private =3D 0;
>         __ClearPageSlab(page);
>         mm_account_reclaimed_pages(pages);
>         unaccount_slab(slab, order, s);
>
>
>
> But I am not sure if that is all. Maybe the patch below on top is needed =
to find all violators
> and still keep the system running. I also would like to hear from others =
on whether page->private
> should be reset or not before free_pages_prepare().
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cbf758e27aa2..9058f94b0667 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1430,6 +1430,8 @@ __always_inline bool free_pages_prepare(struct page=
 *page,
>
>         page_cpupid_reset_last(page);
>         page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
> +       VM_WARN_ON_ONCE(page->private);
> +       page->private =3D 0;
>         reset_page_owner(page, order);
>         page_table_check_free(page, order);
>         pgalloc_tag_sub(page, 1 << order);
>
>
> --
> Best Regards,
> Yan, Zi

I tested your patch. The VM_WARN_ON_ONCE caught another violator - TTM
(GPU memory manager):
 ------------[ cut here ]------------
 WARNING: mm/page_alloc.c:1433 at __free_pages_ok+0xe1e/0x12c0,
CPU#16: gnome-shell/5841
 Modules linked in: overlay uinput rfcomm snd_seq_dummy snd_hrtimer
xt_mark xt_cgroup xt_MASQUERADE ip6t_REJECT ipt_REJECT nft_compat
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr uhid bnep sunrpc amd_atl
intel_rapl_msr intel_rapl_common mt7921e mt7921_common mt792x_lib
mt76_connac_lib btusb mt76 btmtk btrtl btbcm btintel vfat edac_mce_amd
spd5118 bluetooth fat snd_hda_codec_atihdmi asus_ec_sensors mac80211
snd_hda_codec_hdmi kvm_amd snd_hda_intel uvcvideo snd_usb_audio
snd_hda_codec uvc videobuf2_vmalloc kvm videobuf2_memops snd_hda_core
joydev videobuf2_v4l2 snd_intel_dspcfg videobuf2_common
snd_usbmidi_lib videodev snd_intel_sdw_acpi snd_ump irqbypass
snd_hwdep asus_nb_wmi mc snd_rawmidi rapl snd_seq asus_wmi cfg80211
sparse_keymap snd_seq_device platform_profile wmi_bmof pcspkr snd_pcm
snd_timer rfkill igc snd
  libarc4 i2c_piix4 soundcore k10temp i2c_smbus gpio_amdpt
gpio_generic nfnetlink zram lz4hc_compress lz4_compress amdgpu amdxcp
i2c_algo_bit drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks
gpu_sched drm_suballoc_helper nvme video nvme_core drm_buddy
ghash_clmulni_intel drm_display_helper nvme_keyring nvme_auth cec
sp5100_tco hkdf wmi uas usb_storage fuse ntsync i2c_dev
 CPU: 16 UID: 1000 PID: 5841 Comm: gnome-shell Tainted: G        W
      6.19.0-rc8-f14faaf3a1fb-with-fix-reset-private-when-freeing+ #82
PREEMPT(lazy)
 Tainted: [W]=3DWARN
 Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING
WIFI, BIOS 3602 11/13/2025
 RIP: 0010:__free_pages_ok+0xe1e/0x12c0
 Code: ef 48 89 c6 e8 f3 59 ff ff 83 44 24 20 01 49 ba 00 00 00 00 00
fc ff df e9 71 fe ff ff 41 c7 45 30 ff ff ff ff e9 f5 f4 ff ff <0f> 0b
e9 73 f5 ff ff e8 86 4c 0e 00 e9 02 fb ff ff 48 c7 44 24 30
 RSP: 0018:ffffc9000e0cf878 EFLAGS: 00010206
 RAX: dffffc0000000000 RBX: 0000000000000f80 RCX: 1ffffd40028c6000
 RDX: 1ffffd40028c6005 RSI: 0000000000000004 RDI: ffffea0014630038
 RBP: ffffea0014630028 R08: ffffffff9e58e2de R09: 1ffffd40028c6006
 R10: fffff940028c6007 R11: fffff940028c6007 R12: ffffffffa27376d8
 R13: ffffea0014630000 R14: ffff889054e559c0 R15: 0000000000000000
 FS:  00007f510f914000(0000) GS:ffff8890317a8000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00005607eaf70168 CR3: 00000001dfd6a000 CR4: 0000000000f50ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ttm_pool_unmap_and_free+0x30c/0x520 [ttm]
  ? dma_resv_iter_first_unlocked+0x2f9/0x470
  ttm_pool_free_range+0xef/0x160 [ttm]
  ? __pfx_drm_gem_close_ioctl+0x10/0x10
  ttm_pool_free+0x70/0xe0 [ttm]
  ? rcu_is_watching+0x15/0xe0
  ttm_tt_unpopulate+0xa2/0x2d0 [ttm]
  ttm_bo_cleanup_memtype_use+0xec/0x200 [ttm]
  ttm_bo_release+0x371/0xb00 [ttm]
  ? __pfx_ttm_bo_release+0x10/0x10 [ttm]
  ? drm_vma_node_revoke+0x1a/0x1e0
  ? local_clock+0x15/0x30
  ? __pfx_drm_gem_close_ioctl+0x10/0x10
  drm_gem_object_release_handle+0xcd/0x1f0
  drm_gem_handle_delete+0x6a/0xc0
  ? drm_dev_exit+0x35/0x50
  drm_ioctl_kernel+0x172/0x2e0
  ? __lock_release.isra.0+0x1a2/0x370
  ? __pfx_drm_ioctl_kernel+0x10/0x10
  drm_ioctl+0x571/0xb50
  ? __pfx_drm_gem_close_ioctl+0x10/0x10
  ? __pfx_drm_ioctl+0x10/0x10
  ? rcu_is_watching+0x15/0xe0
  ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
  ? trace_hardirqs_on+0x18/0x140
  ? lockdep_hardirqs_on+0x90/0x130
  ? __raw_spin_unlock_irqrestore+0x5d/0x80
  ? __raw_spin_unlock_irqrestore+0x46/0x80
  amdgpu_drm_ioctl+0xd3/0x190 [amdgpu]
  __x64_sys_ioctl+0x13c/0x1d0
  ? syscall_trace_enter+0x15c/0x2a0
  do_syscall_64+0x9c/0x4e0
  ? __lock_release.isra.0+0x1a2/0x370
  ? do_user_addr_fault+0x87a/0xf60
  ? fpregs_assert_state_consistent+0x8f/0x100
  ? trace_hardirqs_on_prepare+0x101/0x140
  ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
  ? irqentry_exit+0x99/0x600
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f5113af889d
 Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00
00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2
3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
 RSP: 002b:00007fff83c100c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00005607ed127c50 RCX: 00007f5113af889d
 RDX: 00007fff83c10150 RSI: 0000000040086409 RDI: 000000000000000e
 RBP: 00007fff83c10110 R08: 00005607ead46d50 R09: 0000000000000000
 R10: 0000000000000031 R11: 0000000000000246 R12: 00007fff83c10150
 R13: 0000000040086409 R14: 000000000000000e R15: 00005607ead46d50
  </TASK>
 irq event stamp: 5186663
 hardirqs last  enabled at (5186669): [<ffffffff9dc9ce6e>]
__up_console_sem+0x7e/0x90
 hardirqs last disabled at (5186674): [<ffffffff9dc9ce53>]
__up_console_sem+0x63/0x90
 softirqs last  enabled at (5186538): [<ffffffff9da5325b>]
handle_softirqs+0x54b/0x810
 softirqs last disabled at (5186531): [<ffffffff9da53654>]
__irq_exit_rcu+0x124/0x240
 ---[ end trace 0000000000000000 ]---

So there are more violators than just slub and shmem.
I also tested the post_alloc_hook() fix (clearing page->private for
all pages at allocation) - 1600+ iterations without crash.
Given multiple violators, maybe a defensive fix (either in
split_page() which is already in mm-unstable, or in post_alloc_hook())
is the right approach, rather than hunting down each violator?

--
Best Regards,
Mike Gavrilov.

