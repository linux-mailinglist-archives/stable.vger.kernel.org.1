Return-Path: <stable+bounces-222571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLC5H3FppWntAAYAu9opvQ
	(envelope-from <stable+bounces-222571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:41:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF921D6B77
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEFDC305DBB7
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533D39E6CB;
	Mon,  2 Mar 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Odbtyi7r"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96391FC0EA
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447380; cv=pass; b=QhlLO0/pmyxnTw3nCEdK5DBEtktG3lbbfr5mi92OdI8te+dqWci2Dz6Rq7koUybl6EBScVGfBliru+RxZKlXHTFUQeZfUX9BvPUXrdyF9Rtf7JfZAgW0F+IbkZZ16Nt/CfevKOPfutTgMWCh+M6gcY6ggo3K3iCNlU7rjGQWTsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447380; c=relaxed/simple;
	bh=RvnCJRoCRweP0jEmavxA07TcKBcM1pOUhMY6Qovsu2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II4u8hGJ5FPsOMauXe7dzdig7fwztJvja9c8DjVI3c4epfHc1Q2aqSdkPTtJ6sad+SWWq2sZc5/2wsvK+N9qhJw0nuL1qah73FrtgUy4nXMQIa88s6Ng412yUKhmoXdgiHSKIP21bZlstQmg+DijJordB+Fd4x1Y8nyLOgbVjH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Odbtyi7r; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb40149037so449180785a.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 02:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772447378; cv=none;
        d=google.com; s=arc-20240605;
        b=iio3d9EStkYfLHLesA5RAf08FXd4aydN/OtG5HNSbHmsjI760gavbvE7J8ak+eDDxV
         LPKkVLbN3q63+tQxT+h5/iYmaYjnuGec9vqU/q5hBJXFAEk5sXVMd6zXUFlHvH9+hH89
         Kx4PKN712+7GpTB637IeRN0nvzdMXviObeHCF/Oa8/x2PuB6XYmvWR0nD7mz4MLSHCRm
         TKgXD8TQML31yfNjRnTtMV+wpvy9x0e84VYlRUjKdErlWqiNZywDCgmhd6AEK+Mdtrmx
         SWTurABW8o9mwqf4Hc2fNTvTd6gPrJtjuye6JXQyBuZabvRcgD4lQpAJnvV0GqLRygcP
         6XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h/njpkbtZVt3Kl+KjZ5piSQhFiqZBY8slUODGXpsT5Y=;
        fh=XkGBu49NJEnDC2ccnN3xbWDu19Ev/ZrnoSTZFwdDZpY=;
        b=i2QOCnoW4LVLFFur5ykK2ioFpDTvhzaTkpvtgQDBh9YAXlvDfghZ7Ac65pODzZhBiJ
         IzSPzRHtYvQPbwN8lu1+T0ubzyOWszTTvWEthbBNcI9AnouNw4cWpTFckbeRc+KO3Wkb
         9XC9qeEusW8xpNAdUMkWyRcmwQXmKdtft37nmNEJOkaujTR/Kqj4TFxroDrZ2JoE7nDj
         is4oJR40fixnGVeVuXTC+3JZFTCFlv8spoNjLvHC6j46hpwli8UzQbzk8O0Rc0dicCeE
         7FO2XKddsJov4oqRkHrZytkczuihpIpS7B3W2PozfGdmhE0H8zsK/nakGZtkYutP76BW
         GsRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772447378; x=1773052178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/njpkbtZVt3Kl+KjZ5piSQhFiqZBY8slUODGXpsT5Y=;
        b=Odbtyi7r9oBHlg8YyNxuBDa3Hva1zvjVxOX6/RI9JMLvJG2hNf450kDkZL0FzWBzmZ
         V7wuvWcXYHWWm/u7f1r9E9o+myVrUn/bDmTWAIabVUjUhALUi5bLWN7/zda/NNtl8DLG
         GMlS9vYTEnAPbhAS9bnVOGzPLPeqqNb6YUkSDqCG+FEQJe5yyKjiI6Xufi8TzUtL5yjZ
         OI3W6E3KE6TFtUINEHY2zLOJx4y9GdGWwQ+E8EDm4RLUq5oms03IHzPK8DtDrbA0e3+/
         7sdvcWD9HbUrSWqj3A1uuLnPzaTbJo1bRa6u6lyGYjbt4yNncEj5gpXrov/Okb24RxBl
         nk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447378; x=1773052178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/njpkbtZVt3Kl+KjZ5piSQhFiqZBY8slUODGXpsT5Y=;
        b=LnI1fNj1icUFhhFCjxOuGVh02MX08hBGehvIVu/lQlM1W3BOgq7q75Fap2gn1t6g1x
         us1Tq/7TsSaRYKTRdqz0GeL5bXvNiAgbLDdL9OlyGMqytjpSZimliXlP3qrnPMZXuXRZ
         OHbSs+zfUiPB/u49bAfMcGkdzn89pNfZfGRyDHAalDtN7QM12yXKp7q+xs1TLhyWJfZ4
         cT9XdZ09o2jEDxWx8/rGcOjQiiNiHnzWIFwFvvy2Kxmvq9FCyX3agM2aOvmBGt+EaY2d
         nO6Kkqxif87bfCBnZB/BAQZ50OfTtZWvoKw8jOjZNlnqpcBwMSpDkkxdDGdgY2ibmTxq
         YCKw==
X-Forwarded-Encrypted: i=1; AJvYcCUuajg12LDxgY1WwzRqYU1fa+xqbzfQDrV1mMItGj7vNeo9wIMEqiFBwqcZYNlTMvhjHaNVK3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjyKMiMy+0uknqP8fp9OLck59/7YhgZQ9RbdfNGVKwbFzyydhG
	R2lLbeN9NT830oGVkmW635IMB+RCgWT7qDQbIQ13Iq/PU6oXcdCwg9/1vu2J9MpLWsc3hLbkqDk
	KVasN+dznO9TLYci9poRYWisg+qsAETjId5Sk0c8d
X-Gm-Gg: ATEYQzxiLeGcugomcdcNV82wMXBFzKFZ9Jgh1l7Emada2QUZLbM6ZpOUgNMsoVCzk6y
	LrTywiW+Orq7s6W1riYebeyUXHPgHmmtD2x/n9Lfkguu1Ur4YeNjLjaqpWM7MOBgx4AX+ldHFVj
	4tTRi5muhuBkDw2H3BJ3wnuVu0ZMCEesyOs5THC6jwV+0mZZRpgYoUwmkBQxUK38IJCJUJkTKzz
	Vf+Xgu6gzma48QdHBbxL30bVP/aUv2r/aWLIhp9Qp79IL62av6Hj36/yS9D5XjzDs6yaiwQXbZP
	gL6v+GeWgHqzSUPXasTevlctzUUbk7Qn0qoQWg==
X-Received: by 2002:a05:620a:450e:b0:8c6:b14e:6569 with SMTP id
 af79cd13be357-8cbc8e3099bmr1545558085a.79.1772447377161; Mon, 02 Mar 2026
 02:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f9135c7866c6e0d06e960993b8a5674a9ebc7ec.1771938394.git.ritesh.list@gmail.com>
In-Reply-To: <2f9135c7866c6e0d06e960993b8a5674a9ebc7ec.1771938394.git.ritesh.list@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 2 Mar 2026 11:29:00 +0100
X-Gm-Features: AaiRm53DRbj7sPLIop0CBXc5s2h5N9WBGDepItjpg99dPeJvb65reF4OaqPzMX8
Message-ID: <CAG_fn=U5weotUtW+TKmX_WRvRSaH+UiqdeDx-4foxVKK_kLNYw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kasan: Fix double free for kasan pXds
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222571-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[googlegroups.com,kvack.org,gmail.com,google.com,arm.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glider@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EBF921D6B77
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 2:23=E2=80=AFPM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
>
> kasan_free_pxd() assumes the page table is always struct page aligned.
> But that's not always the case for all architectures. E.g. In case of
> powerpc with 64K pagesize, PUD table (of size 4096) comes from slab
> cache named pgtable-2^9. Hence instead of page_to_virt(pxd_page()) let's
> just directly pass the start of the pxd table which is passed as the 1st
> argument.
>
> This fixes the below double free kasan issue seen with PMEM:
>
> radix-mmu: Mapped 0x0000047d10000000-0x0000047f90000000 with 2.00 MiB pag=
es
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: double-free in kasan_remove_zero_shadow+0x9c4/0xa20
> Free of addr c0000003c38e0000 by task ndctl/2164
>
> CPU: 34 UID: 0 PID: 2164 Comm: ndctl Not tainted 6.19.0-rc1-00048-gea1013=
c15392 #157 VOLUNTARY
> Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:I=
BM,FW1060.00 (NH1060_012) hv:phyp pSeries
> Call Trace:
>  dump_stack_lvl+0x88/0xc4 (unreliable)
>  print_report+0x214/0x63c
>  kasan_report_invalid_free+0xe4/0x110
>  check_slab_allocation+0x100/0x150
>  kmem_cache_free+0x128/0x6e0
>  kasan_remove_zero_shadow+0x9c4/0xa20
>  memunmap_pages+0x2b8/0x5c0
>  devm_action_release+0x54/0x70
>  release_nodes+0xc8/0x1a0
>  devres_release_all+0xe0/0x140
>  device_unbind_cleanup+0x30/0x120
>  device_release_driver_internal+0x3e4/0x450
>  unbind_store+0xfc/0x110
>  drv_attr_store+0x78/0xb0
>  sysfs_kf_write+0x114/0x140
>  kernfs_fop_write_iter+0x264/0x3f0
>  vfs_write+0x3bc/0x7d0
>  ksys_write+0xa4/0x190
>  system_call_exception+0x190/0x480
>  system_call_vectored_common+0x15c/0x2ec
> ---- interrupt: 3000 at 0x7fff93b3d3f4
> NIP:  00007fff93b3d3f4 LR: 00007fff93b3d3f4 CTR: 0000000000000000
> REGS: c0000003f1b07e80 TRAP: 3000   Not tainted  (6.19.0-rc1-00048-gea101=
3c15392)
> MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48888208=
  XER: 00000000
> <...>
> NIP [00007fff93b3d3f4] 0x7fff93b3d3f4
> LR [00007fff93b3d3f4] 0x7fff93b3d3f4
> ---- interrupt: 3000
>
>  The buggy address belongs to the object at c0000003c38e0000
>   which belongs to the cache pgtable-2^9 of size 4096
>  The buggy address is located 0 bytes inside of
>   4096-byte region [c0000003c38e0000, c0000003c38e1000)
>
>  The buggy address belongs to the physical page:
>  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3c3=
8c
>  head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>  memcg:c0000003bfd63e01
>  flags: 0x63ffff800000040(head|node=3D6|zone=3D0|lastcpupid=3D0x7ffff)
>  page_type: f5(slab)
>  raw: 063ffff800000040 c000000140058980 5deadbeef0000122 0000000000000000
>  raw: 0000000000000000 0000000080200020 00000000f5000000 c0000003bfd63e01
>  head: 063ffff800000040 c000000140058980 5deadbeef0000122 000000000000000=
0
>  head: 0000000000000000 0000000080200020 00000000f5000000 c0000003bfd63e0=
1
>  head: 063ffff800000002 c00c000000f0e301 00000000ffffffff 00000000fffffff=
f
>  head: ffffffffffffffff 0000000000000000 00000000ffffffff 000000000000000=
4
>  page dumped because: kasan: bad access detected
>
> [  138.953636] [   T2164] Memory state around the buggy address:
> [  138.953643] [   T2164]  c0000003c38dff00: fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc fc
> [  138.953652] [   T2164]  c0000003c38dff80: fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc fc
> [  138.953661] [   T2164] >c0000003c38e0000: fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc fc
> [  138.953669] [   T2164]                    ^
> [  138.953675] [   T2164]  c0000003c38e0080: fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc fc
> [  138.953684] [   T2164]  c0000003c38e0100: fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc fc
> [  138.953692] [   T2164] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> [  138.953701] [   T2164] Disabling lock debugging due to kernel taint
>
> Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work =
with KASAN")
> Cc: stable@vger.kernel.org
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

