Return-Path: <stable+bounces-118398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30FA3D483
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B346189BEE0
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC91EEA42;
	Thu, 20 Feb 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdM2zNSR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50111EEA37;
	Thu, 20 Feb 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043281; cv=none; b=A0Gcrrpft4jDWClDTloSci/2gcuL+X5whNBcgrLm3dDLC564z3lZkGzPf/r/EpkZAdmEntI2GQD4VvWm38dE7ZyTIUtTjUFk0tBmMxe3omiPribP1r9GcPuUFJI0O8vahhag/nyXgN6IwA7MCl+d6s6s5HAbC1esWnUqpXmz/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043281; c=relaxed/simple;
	bh=/CnayuElWydL64LDvp0I4+aGDAfTeGnZH2zSPTilrNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAJ8HCD+z6qg9wOJ/Hn/BsOwDgXu5hVLG/x1jvY2l8cW1chusOb5bKy5GCGpPVEWYXYFnLlid80HP6OX7MpG2IU9e8FUUHmKydAlgJVDKhG6njoWbW82GgPLfN+7QIE2xBFydHHQLb6lArYyzjFZRwJ6iMkF0e2B7HVho+CKY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdM2zNSR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220e6028214so13188085ad.0;
        Thu, 20 Feb 2025 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740043277; x=1740648077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXKQs0HS0Ab03s7Br1OjuSWjhLULAq0fHhkaSj44tjc=;
        b=OdM2zNSR6Tr7CXbE5XeSEWrB8yppPxyQnKKEWh5JfiPpHHurDmnqSHqipkBelz/IQq
         iFKnDxrpR2fOQ3tY0LyfI4R7P25IB5JwS/WNLmUCaFQ8xzo5enTBgo59BjugTnFGHcBv
         dyg7LhhLoeu7+PM3rjj5sTkDEMDa6b9z6IMcg6UanNDx7hFuNetRlXRNuGbfze0XUlEz
         PZ+aN6GoikPAaV6wjrmtOXyOU56Gpxj9+5RNoDBPQ0qmeUFMCHO7M0kKcdwv5rrlqimL
         MPmnblDa04H4pd/WiYIczfeCxkMXwlN7Mm7O/0RGysuKrIUl2J8f6FQQD255lfetMKrq
         k45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740043277; x=1740648077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXKQs0HS0Ab03s7Br1OjuSWjhLULAq0fHhkaSj44tjc=;
        b=sbMnbaB3Dk1P8di6ZcLVmNct8dIvdSqZo+flxWD3MVQQFVwP5VaVHsQv7WWDqk0XgY
         /gLyGbxj/Oc/F6uUEHP+oUElK8169whMBhxUDpgMls6JC4pveBSNcta3o3aGUTl5kR6F
         FrUFRTZA3+NglpmwcI8mLAxhwYO7CUY+crHuP23I1jbO7rn1jq3caxFjSnqd1qU6u6kx
         7isn2TzNYhG71Ka3yIp55IregbC8jeglcRkJmQbbklH5fZ8GBf3nyZUqJDSpmHZuurFH
         TKO5Lh/MS0XW9GaQ5OmqP6X3mT6PJoNUePSjBu4M3byAm4aERj3rw+P0YwFWB4S1A7nF
         mHmA==
X-Forwarded-Encrypted: i=1; AJvYcCWeGY9MDpiGSXSDuEMmlFl9LiHUozVaN8fD+OO31i3O8TTNaPtBWqNzJ/X8pP4ZWKlRaSYHvUoe@vger.kernel.org, AJvYcCXuD4oVgIdaEydxXn5wzg1Gn1rUORsIpY88oyw6vSMa9RTzF0muMRIe8spVa0JfovfPMtZXrE+SW9r0Zys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+40psgb0AceUGNjH2WMT9ZP4b5uxTznjQTh+Z60d+/mf+r/5
	x5o4lmu7NOJmw6jbAdse101el3Myo82PhfGSsJc97/zurz0KcJfx
X-Gm-Gg: ASbGncvlBYx9OdVgFJMn51PSVs3QLBFwSCwMQ2tsG/EeBgUPY7OBj01+IDnJMsD4ZPd
	g3dELVoTclMGX3sXPozAlNBpO99EQF8mgyckAEjzXlPfhEfITkjLQbk3wGGgPbP0d5ZZdUsFL/q
	qtCc/WjXBggP6rGoITYQg4c3QAQU2+fUFf0MKyAKxSxwTWBkoEAW6ByOeeb2GR5tNMhWiDH7Ake
	dw3Elq0gEn0HfU1SoTudnUcbda0WXaPccvSJBOoOSQc28yqilAcxqCs02yB9wn+ShbT3DJl64R8
	QNfvPwxtD++mtyKbYHD8QNxgHTS1y1pC
X-Google-Smtp-Source: AGHT+IH1386EnW196MK2ktkUJvTHr/mgWmdE0+4dFSk9ZQxxfmnpDaqHODsj5EAn23kFY8N1gXApYg==
X-Received: by 2002:a05:6a21:394c:b0:1ee:c390:58a4 with SMTP id adf61e73a8af0-1eee5c26645mr3433445637.2.1740043276747;
        Thu, 20 Feb 2025 01:21:16 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265678abasm9549232b3a.27.2025.02.20.01.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Feb 2025 01:21:16 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com
Cc: 21cnbao@gmail.com,
	Liam.Howlett@oracle.com,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	bgeffon@google.com,
	brauner@kernel.org,
	hughd@google.com,
	jannh@google.com,
	kaleshsingh@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lokeshgidra@google.com,
	mhocko@suse.com,
	ngeoffray@google.com,
	peterx@redhat.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	surenb@google.com,
	v-songbaohua@oppo.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	zhangpeng362@huawei.com,
	zhengtangquan@oppo.com,
	yuzhao@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
Date: Thu, 20 Feb 2025 22:21:01 +1300
Message-Id: <20250220092101.71966-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Feb 20, 2025 at 9:40 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.02.25 19:58, Suren Baghdasaryan wrote:
> > On Wed, Feb 19, 2025 at 10:30 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 19.02.25 19:26, Suren Baghdasaryan wrote:
> >>> On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
> >>>>
> >>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> userfaultfd_move() checks whether the PTE entry is present or a
> >>>> swap entry.
> >>>>
> >>>> - If the PTE entry is present, move_present_pte() handles folio
> >>>>     migration by setting:
> >>>>
> >>>>     src_folio->index = linear_page_index(dst_vma, dst_addr);
> >>>>
> >>>> - If the PTE entry is a swap entry, move_swap_pte() simply copies
> >>>>     the PTE to the new dst_addr.
> >>>>
> >>>> This approach is incorrect because even if the PTE is a swap
> >>>> entry, it can still reference a folio that remains in the swap
> >>>> cache.
> >>>>
> >>>> If do_swap_page() is triggered, it may locate the folio in the
> >>>> swap cache. However, during add_rmap operations, a kernel panic
> >>>> can occur due to:
> >>>>    page_pgoff(folio, page) != linear_page_index(vma, address)
> >>>
> >>> Thanks for the report and reproducer!
> >>>
> >>>>
> >>>> $./a.out > /dev/null
> >>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
> >>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
> >>>> [   13.337716] memcg:ffff00000405f000
> >>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
> >>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> >>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> >>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> >>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> >>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
> >>>> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> >>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
> >>>> [   13.340190] ------------[ cut here ]------------
> >>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
> >>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> >>>> [   13.340969] Modules linked in:
> >>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
> >>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
> >>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> >>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> >>>> [   13.342018] sp : ffff80008752bb20
> >>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
> >>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
> >>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
> >>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
> >>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
> >>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
> >>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
> >>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
> >>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
> >>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
> >>>> [   13.343876] Call trace:
> >>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> >>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> >>>> [   13.344333]  do_swap_page+0x1060/0x1400
> >>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> >>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
> >>>> [   13.344586]  do_page_fault+0x20c/0x770
> >>>> [   13.344673]  do_translation_fault+0xb4/0xf0
> >>>> [   13.344759]  do_mem_abort+0x48/0xa0
> >>>> [   13.344842]  el0_da+0x58/0x130
> >>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> >>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> >>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> >>>> [   13.345504] ---[ end trace 0000000000000000 ]---
> >>>> [   13.345715] note: a.out[107] exited with irqs disabled
> >>>> [   13.345954] note: a.out[107] exited with preempt_count 2
> >>>>
> >>>> Fully fixing it would be quite complex, requiring similar handling
> >>>> of folios as done in move_present_pte.
> >>>
> >>> How complex would that be? Is it a matter of adding
> >>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> >>> folio->index = linear_page_index like in move_present_pte() or
> >>> something more?
> >>
> >> If the entry is pte_swp_exclusive(), and the folio is order-0, it cannot
> >> be pinned and we may be able to move it I think.
> >>
> >> So all that's required is to check pte_swp_exclusive() and the folio size.
> >>
> >> ... in theory :) Not sure about the swap details.
> >
> > Looking some more into it, I think we would have to perform all the
> > folio and anon_vma locking and pinning that we do for present pages in
> > move_pages_pte(). If that's correct then maybe treating swapcache
> > pages like a present page inside move_pages_pte() would be simpler?
>
> I'd be more in favor of not doing that. Maybe there are parts we can
> move out into helper functions instead, so we can reuse them?

I actually have a v2 ready. Maybe we can discuss if some of the code can be
extracted as a helper based on the below before I send it formally?

I’d say there are many parts that can be shared with present PTE, but there
are two major differences:

1. Page exclusivity – swapcache doesn’t require it (try_to_unmap_one has remove
Exclusive flag;)
2. src_anon_vma and its lock – swapcache doesn’t require it（folio is not mapped）


Subject: [PATCH v2 Discussing with David] mm: Fix kernel crash when userfaultfd_move encounters
 swapcache

userfaultfd_move() checks whether the PTE entry is present or a
swap entry.

- If the PTE entry is present, move_present_pte() handles folio
  migration by setting:

  src_folio->index = linear_page_index(dst_vma, dst_addr);

- If the PTE entry is a swap entry, move_swap_pte() simply copies
  the PTE to the new dst_addr.

This approach is incorrect because, even if the PTE is a swap entry,
it can still reference a folio that remains in the swap cache.

This exposes a race condition between steps 2 and 4:
 1. add_to_swap: The folio is added to the swapcache.
 2. try_to_unmap: PTEs are converted to swap entries.
 3. pageout: The folio is written back.
 4. Swapcache is cleared.
If userfaultfd_move() happens in the window between step 2 and step 4,
after the swap PTE is moved to the destination, accessing the destination
triggers do_swap_page(), which may locate the folio in the swap cache.
However, during add_rmap operations, a kernel panic can occur due to:

page_pgoff(folio, page) != linear_page_index(vma, address)

This happens because move_swap_pte() has never updated the index to
match dst_vma and dst_addr.

$./a.out > /dev/null
[   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
[   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
[   13.337716] memcg:ffff00000405f000
[   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
[   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
[   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
[   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
[   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
[   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
[   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
[   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
[   13.340190] ------------[ cut here ]------------
[   13.340316] kernel BUG at mm/rmap.c:1380!
[   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[   13.340969] Modules linked in:
[   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
[   13.341470] Hardware name: linux,dummy-virt (DT)
[   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
[   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
[   13.342018] sp : ffff80008752bb20
[   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
[   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
[   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
[   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
[   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
[   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
[   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
[   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
[   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
[   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
[   13.343876] Call trace:
[   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
[   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
[   13.344333]  do_swap_page+0x1060/0x1400
[   13.344417]  __handle_mm_fault+0x61c/0xbc8
[   13.344504]  handle_mm_fault+0xd8/0x2e8
[   13.344586]  do_page_fault+0x20c/0x770
[   13.344673]  do_translation_fault+0xb4/0xf0
[   13.344759]  do_mem_abort+0x48/0xa0
[   13.344842]  el0_da+0x58/0x130
[   13.344914]  el0t_64_sync_handler+0xc4/0x138
[   13.345002]  el0t_64_sync+0x1ac/0x1b0
[   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
[   13.345504] ---[ end trace 0000000000000000 ]---
[   13.345715] note: a.out[107] exited with irqs disabled
[   13.345954] note: a.out[107] exited with preempt_count 2

This patch also checks the swapcache when handling swap entries. If a
match is found in the swapcache, it processes it similarly to a present
PTE.
However, there are some differences. For example, the folio is no longer
exclusive because folio_try_share_anon_rmap_pte() is performed during
unmapping.
Furthermore, in the case of swapcache, the folio has already been
unmapped, eliminating the risk of concurrent rmap walks and removing the
need to acquire src_folio's anon_vma or lock.

Note that for large folios, in the swapcache handling path, we still
frequently encounter -EBUSY returns because split_folio() returns
-EBUSY when the folio is under writeback.
That is not an urgent fix, so a following patch will address it.

Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Nicolas Geoffray <ngeoffray@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: ZhangPeng <zhangpeng362@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/userfaultfd.c | 228 +++++++++++++++++++++++++++--------------------
 1 file changed, 133 insertions(+), 95 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 867898c4e30b..e5718835a964 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -18,6 +18,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include "internal.h"
+#include "swap.h"
 
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
@@ -1025,7 +1026,7 @@ static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
 	       pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
 }
 
-static int move_present_pte(struct mm_struct *mm,
+static int move_pte_and_folio(struct mm_struct *mm,
 			    struct vm_area_struct *dst_vma,
 			    struct vm_area_struct *src_vma,
 			    unsigned long dst_addr, unsigned long src_addr,
@@ -1046,7 +1047,7 @@ static int move_present_pte(struct mm_struct *mm,
 	}
 	if (folio_test_large(src_folio) ||
 	    folio_maybe_dma_pinned(src_folio) ||
-	    !PageAnonExclusive(&src_folio->page)) {
+	    (pte_present(orig_src_pte) && !PageAnonExclusive(&src_folio->page))) {
 		err = -EBUSY;
 		goto out;
 	}
@@ -1062,10 +1063,13 @@ static int move_present_pte(struct mm_struct *mm,
 	folio_move_anon_rmap(src_folio, dst_vma);
 	src_folio->index = linear_page_index(dst_vma, dst_addr);
 
-	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
-	/* Follow mremap() behavior and treat the entry dirty after the move */
-	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
-
+	if (pte_present(orig_src_pte)) {
+		orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
+		/* Follow mremap() behavior and treat the entry dirty after the move */
+		orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
+	} else { /* swap entry */
+		orig_dst_pte = orig_src_pte;
+	}
 	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
 out:
 	double_pt_unlock(dst_ptl, src_ptl);
@@ -1079,9 +1083,6 @@ static int move_swap_pte(struct mm_struct *mm,
 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
 {
-	if (!pte_swp_exclusive(orig_src_pte))
-		return -EBUSY;
-
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1137,6 +1138,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			  __u64 mode)
 {
 	swp_entry_t entry;
+	struct swap_info_struct *si = NULL;
 	pte_t orig_src_pte, orig_dst_pte;
 	pte_t src_folio_pte;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -1220,122 +1222,156 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		goto out;
 	}
 
-	if (pte_present(orig_src_pte)) {
-		if (is_zero_pfn(pte_pfn(orig_src_pte))) {
-			err = move_zeropage_pte(mm, dst_vma, src_vma,
-					       dst_addr, src_addr, dst_pte, src_pte,
-					       orig_dst_pte, orig_src_pte,
-					       dst_pmd, dst_pmdval, dst_ptl, src_ptl);
+	if (!pte_present(orig_src_pte)) {
+		entry = pte_to_swp_entry(orig_src_pte);
+		if (is_migration_entry(entry)) {
+			pte_unmap(&orig_src_pte);
+			pte_unmap(&orig_dst_pte);
+			src_pte = dst_pte = NULL;
+			migration_entry_wait(mm, src_pmd, src_addr);
+			err = -EAGAIN;
+			goto out;
+		}
+
+		if (non_swap_entry(entry)) {
+			err = -EFAULT;
+			goto out;
+		}
+
+		if (!pte_swp_exclusive(orig_src_pte)) {
+			err = -EBUSY;
+			goto out;
+		}
+		/* Prevent swapoff from happening to us. */
+		if (!si)
+			si = get_swap_device(entry);
+		if (unlikely(!si)) {
+			err = -EAGAIN;
 			goto out;
 		}
+	}
+
+	if (pte_present(orig_src_pte) && is_zero_pfn(pte_pfn(orig_src_pte))) {
+		err = move_zeropage_pte(mm, dst_vma, src_vma,
+				dst_addr, src_addr, dst_pte, src_pte,
+				orig_dst_pte, orig_src_pte,
+				dst_pmd, dst_pmdval, dst_ptl, src_ptl);
+		goto out;
+	}
+
+	/*
+	 * Pin and lock both source folio and anon_vma. Since we are in
+	 * RCU read section, we can't block, so on contention have to
+	 * unmap the ptes, obtain the lock and retry.
+	 */
+	if (!src_folio) {
+		struct folio *folio;
 
 		/*
-		 * Pin and lock both source folio and anon_vma. Since we are in
-		 * RCU read section, we can't block, so on contention have to
-		 * unmap the ptes, obtain the lock and retry.
+		 * Pin the page while holding the lock to be sure the
+		 * page isn't freed under us
 		 */
-		if (!src_folio) {
-			struct folio *folio;
+		spin_lock(src_ptl);
+		if (!pte_same(orig_src_pte, ptep_get(src_pte))) {
+			spin_unlock(src_ptl);
+			err = -EAGAIN;
+			goto out;
+		}
 
-			/*
-			 * Pin the page while holding the lock to be sure the
-			 * page isn't freed under us
-			 */
-			spin_lock(src_ptl);
-			if (!pte_same(orig_src_pte, ptep_get(src_pte))) {
+		if (pte_present(orig_src_pte)) {
+			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
+			if (!folio) {
 				spin_unlock(src_ptl);
-				err = -EAGAIN;
+				err = -EBUSY;
 				goto out;
 			}
-
-			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
-			if (!folio || !PageAnonExclusive(&folio->page)) {
+			if (!PageAnonExclusive(&folio->page)) {
 				spin_unlock(src_ptl);
 				err = -EBUSY;
 				goto out;
 			}
-
 			folio_get(folio);
-			src_folio = folio;
-			src_folio_pte = orig_src_pte;
-			spin_unlock(src_ptl);
-
-			if (!folio_trylock(src_folio)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
-				src_pte = dst_pte = NULL;
-				/* now we can block and wait */
-				folio_lock(src_folio);
-				goto retry;
-			}
-
-			if (WARN_ON_ONCE(!folio_test_anon(src_folio))) {
-				err = -EBUSY;
+		} else {
+			/*
+			 * Check if swapcache exists.
+			 * If it does, we need to move the folio
+			 * even if the PTE is a swap entry.
+			 */
+			folio = filemap_get_folio(swap_address_space(entry),
+					swap_cache_index(entry));
+			if (IS_ERR(folio)) {
+				spin_unlock(src_ptl);
+				err = move_swap_pte(mm, dst_addr, src_addr, dst_pte, src_pte,
+						orig_dst_pte, orig_src_pte, dst_pmd,
+						dst_pmdval, dst_ptl, src_ptl);
 				goto out;
 			}
 		}
 
-		/* at this point we have src_folio locked */
-		if (folio_test_large(src_folio)) {
-			/* split_folio() can block */
+		src_folio = folio;
+		src_folio_pte = orig_src_pte;
+		spin_unlock(src_ptl);
+
+		if (!folio_trylock(src_folio)) {
 			pte_unmap(&orig_src_pte);
 			pte_unmap(&orig_dst_pte);
 			src_pte = dst_pte = NULL;
-			err = split_folio(src_folio);
-			if (err)
-				goto out;
-			/* have to reacquire the folio after it got split */
-			folio_unlock(src_folio);
-			folio_put(src_folio);
-			src_folio = NULL;
+			/* now we can block and wait */
+			folio_lock(src_folio);
 			goto retry;
 		}
 
-		if (!src_anon_vma) {
-			/*
-			 * folio_referenced walks the anon_vma chain
-			 * without the folio lock. Serialize against it with
-			 * the anon_vma lock, the folio lock is not enough.
-			 */
-			src_anon_vma = folio_get_anon_vma(src_folio);
-			if (!src_anon_vma) {
-				/* page was unmapped from under us */
-				err = -EAGAIN;
-				goto out;
-			}
-			if (!anon_vma_trylock_write(src_anon_vma)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
-				src_pte = dst_pte = NULL;
-				/* now we can block and wait */
-				anon_vma_lock_write(src_anon_vma);
-				goto retry;
-			}
+		if (WARN_ON_ONCE(!folio_test_anon(src_folio))) {
+			err = -EBUSY;
+			goto out;
 		}
+	}
 
-		err = move_present_pte(mm,  dst_vma, src_vma,
-				       dst_addr, src_addr, dst_pte, src_pte,
-				       orig_dst_pte, orig_src_pte, dst_pmd,
-				       dst_pmdval, dst_ptl, src_ptl, src_folio);
-	} else {
-		entry = pte_to_swp_entry(orig_src_pte);
-		if (non_swap_entry(entry)) {
-			if (is_migration_entry(entry)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
-				src_pte = dst_pte = NULL;
-				migration_entry_wait(mm, src_pmd, src_addr);
-				err = -EAGAIN;
-			} else
-				err = -EFAULT;
+	/* at this point we have src_folio locked */
+	if (folio_test_large(src_folio)) {
+		/* split_folio() can block */
+		pte_unmap(&orig_src_pte);
+		pte_unmap(&orig_dst_pte);
+		src_pte = dst_pte = NULL;
+		err = split_folio(src_folio);
+		if (err)
 			goto out;
-		}
+		/* have to reacquire the folio after it got split */
+		folio_unlock(src_folio);
+		folio_put(src_folio);
+		src_folio = NULL;
+		goto retry;
+	}
 
-		err = move_swap_pte(mm, dst_addr, src_addr, dst_pte, src_pte,
-				    orig_dst_pte, orig_src_pte, dst_pmd,
-				    dst_pmdval, dst_ptl, src_ptl);
+	if (!src_anon_vma && pte_present(orig_src_pte)) {
+		/*
+		 * folio_referenced walks the anon_vma chain
+		 * without the folio lock. Serialize against it with
+		 * the anon_vma lock, the folio lock is not enough.
+		 * In the swapcache case, the folio has been unmapped,
+		 * so there is no concurrent rmap walk.
+		 */
+		src_anon_vma = folio_get_anon_vma(src_folio);
+		if (!src_anon_vma) {
+			/* page was unmapped from under us */
+			err = -EAGAIN;
+			goto out;
+		}
+		if (!anon_vma_trylock_write(src_anon_vma)) {
+			pte_unmap(&orig_src_pte);
+			pte_unmap(&orig_dst_pte);
+			src_pte = dst_pte = NULL;
+			/* now we can block and wait */
+			anon_vma_lock_write(src_anon_vma);
+			goto retry;
+		}
 	}
 
+	err = move_pte_and_folio(mm,  dst_vma, src_vma,
+			dst_addr, src_addr, dst_pte, src_pte,
+			orig_dst_pte, orig_src_pte, dst_pmd,
+			dst_pmdval, dst_ptl, src_ptl, src_folio);
+
 out:
 	if (src_anon_vma) {
 		anon_vma_unlock_write(src_anon_vma);
@@ -1351,6 +1387,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		pte_unmap(src_pte);
 	mmu_notifier_invalidate_range_end(&range);
 
+	if (si)
+		put_swap_device(si);
 	return err;
 }
 
-- 
2.39.3 (Apple Git-146)


>
> --
> Cheers,
>
> David / dhildenb
>

