Return-Path: <stable+bounces-76941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1576983A96
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 02:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3E5283D99
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 00:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6415184E;
	Tue, 24 Sep 2024 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWL8bNIP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B144C83;
	Tue, 24 Sep 2024 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727137739; cv=none; b=gOpNK4/F8rUEQGzvASNMGt6CSqn8BlzfgiSFhoB1qbZvcuW/BoU+MtwUiFK3+z1Wx8SQHCueUniSNSDWMZrjx3lkwxTw6/EuaIBa0CT2EFJA3wXdIdSBMcLzGohomkdY8Dy+CsuK0KiJdWNAd3IxCp9NM1wpwyuXFe4YHSGdP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727137739; c=relaxed/simple;
	bh=6yylBs8UzChMH0lJRYPMXf66FZQvU7rV330MIqe+xkA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=XVrmWcFB4gueVPy45QxVMe7/jlCOkiwXhYyzagp1XXFxdZCxPo5Mef9oa78A0URbk7SZnamOVZk21+EJD/gAd8zOoIQPLPboGRYTVfW3WCSdsyY3faaWoAGymF79MnaTN+H5SD9EgS9yPLHEJYFn5DECkxsLfU1FKS+L/3A5ucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWL8bNIP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d87a1f0791so3338180a91.2;
        Mon, 23 Sep 2024 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727137737; x=1727742537; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfGFG2zuOgkqW7Ma7oy1+jUoyJHiJGowMQv0QfB8uTQ=;
        b=BWL8bNIPCVlKmTBLFk0UMIA4wmzKLwGaTuUTtaDpFPsFWpbd9wez8F7QaEqJbM3SU3
         dxj9mGLHU4eVyPjWaBakGxuX56oEYFOu9S+lrNWvO7H9bbBvbOSSeKqDFpGtTnMZNiJE
         nJLjXr3ASe3Pj288D8rf+YgViu8cmXAePqfhuvZ84bJk0pU2Trco6Usu9+earrtevP/V
         E0Sw6NN4wca9Zf2J76IkrmAZUSMLOLM5PSRG8OYk4e9cOeWpPVjoW42xAzDmjoKPWDoD
         oIRPu80UvE+YSSIHy3qvSgllvZVMT5ytiiW2ovtaobiGZPBZkZ4gSSeFasSkE7Ut7EgQ
         rqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727137737; x=1727742537;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfGFG2zuOgkqW7Ma7oy1+jUoyJHiJGowMQv0QfB8uTQ=;
        b=ry4kYED/TjEbQ4wdsNaFfjZ1dpmYK/crYtOsfTudHjsG3ybKbQ0DkRudvqmBxQtmCq
         OjpJJonO7mR9rPbJYIiHFNGGuI6YhKWXVjM7p8/b9z58udt5KSO0uTc8BQc7Q/BaHwLa
         gG9BlifshoJpAxWOi5qIlrsYm59hPt5BLvLomWWzKA4ewjvwY7gyB3HfsO1w6BkTmzJH
         gCjy0HC48I9dDQkAZHwsisAdnhJ3M7pBdHCuLVBwuQvPkwKQLsIWJJvGfAGG7YFnaD6k
         IijitMC8JBDxlti41sh4vEwfIZkU83rA+zll4Rw4VWO09cADv9QXp9Xx2d1mr11/RdT9
         U2wg==
X-Forwarded-Encrypted: i=1; AJvYcCVzejpjMQp5eJuyGHcWqNDWSb3Cck9ehlfhRlkLWuLPfRNewr05Aq6JXTJ82M+ccl2dKJo9TruXlyQSFhE=@vger.kernel.org, AJvYcCXK1UhNlSlUWVitF+4XVxBCler/PJAiQjR6FdseBfABbne8bq2b3GBA7jGEVYwwqKFtRFFHuQ06@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27APWGHA6nKMFn9YggGbLPl3fg7sFqVfFmebLhCqR/Dj1pPx8
	j1Y+Ub3xjSrzxyjm/WQd/gCP4u23lJQBqLx5r5toGbe0Sx4mzwCl0z/qQuDp
X-Google-Smtp-Source: AGHT+IHJ6bVoox5RfjPf3s1wHpqUJQTN6W5GRb1G3pAD6Ot3DCAoF1mAlcp62pFQM9xGobdcvbcrtw==
X-Received: by 2002:a17:90b:4a8d:b0:2d8:8818:4d51 with SMTP id 98e67ed59e1d1-2dd7f36cb57mr17423004a91.7.1727137736945;
        Mon, 23 Sep 2024 17:28:56 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a02a:7af0:89b:3903:a61c:1a89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef3ede0sm10010465a91.46.2024.09.23.17.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 17:28:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: migrate: fix data-race in migrate_folio_unmap()
Date: Tue, 24 Sep 2024 09:28:44 +0900
Message-Id: <B1FCFC88-1242-4472-BCED-71BA9530B639@gmail.com>
References: <ZvHIK80Hxd6DK2jw@casper.infradead.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot <syzkaller@googlegroups.com>
In-Reply-To: <ZvHIK80Hxd6DK2jw@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: iPhone Mail (21G93)



> Matthew Wilcox <willy@infradead.org> wrote:
>=20
> =EF=BB=BFOn Mon, Sep 23, 2024 at 05:56:40PM +0200, David Hildenbrand wrote=
:
>>> On 22.09.24 17:17, Jeongjun Park wrote:
>>> I found a report from syzbot [1]
>>>=20
>>> When __folio_test_movable() is called in migrate_folio_unmap() to read
>>> folio->mapping, a data race occurs because the folio is read without
>>> protecting it with folio_lock.
>>>=20
>>> This can cause unintended behavior because folio->mapping is initialized=

>>> to a NULL value. Therefore, I think it is appropriate to call
>>> __folio_test_movable() under the protection of folio_lock to prevent
>>> data-race.
>>=20
>> We hold a folio reference, would we really see PAGE_MAPPING_MOVABLE flip?=

>> Hmm
>=20
> No; this shows a page cache folio getting truncated.  It's fine; really
> a false alarm from the tool.  I don't think the proposed patch
> introduces any problems, but it's all a bit meh.
>=20

Well, I still don't understand why it's okay to read folio->mapping=20
without folio_lock . Since migrate_folio_unmap() is already protected=20
by folio_lock , I think it's definitely necessary to fix it to read=20
folio->mapping under folio_lock protection. If it were still okay to=20
call __folio_test_movable() without folio_lock , then we could=20
annotate data-race, but I'm still not sure if this is a good way=20
to do it.

Regards,
Jeongjun Park

>> Even a racing __ClearPageMovable() would still leave PAGE_MAPPING_MOVABLE=

>> set.
>>=20
>>> [1]
>>>=20
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> BUG: KCSAN: data-race in __filemap_remove_folio / migrate_pages_batch
>>>=20
>>> write to 0xffffea0004b81dd8 of 8 bytes by task 6348 on cpu 0:
>>>  page_cache_delete mm/filemap.c:153 [inline]
>>>  __filemap_remove_folio+0x1ac/0x2c0 mm/filemap.c:233
>>>  filemap_remove_folio+0x6b/0x1f0 mm/filemap.c:265
>>>  truncate_inode_folio+0x42/0x50 mm/truncate.c:178
>>>  shmem_undo_range+0x25b/0xa70 mm/shmem.c:1028
>>>  shmem_truncate_range mm/shmem.c:1144 [inline]
>>>  shmem_evict_inode+0x14d/0x530 mm/shmem.c:1272
>>>  evict+0x2f0/0x580 fs/inode.c:731
>>>  iput_final fs/inode.c:1883 [inline]
>>>  iput+0x42a/0x5b0 fs/inode.c:1909
>>>  dentry_unlink_inode+0x24f/0x260 fs/dcache.c:412
>>>  __dentry_kill+0x18b/0x4c0 fs/dcache.c:615
>>>  dput+0x5c/0xd0 fs/dcache.c:857
>>>  __fput+0x3fb/0x6d0 fs/file_table.c:439
>>>  ____fput+0x1c/0x30 fs/file_table.c:459
>>>  task_work_run+0x13a/0x1a0 kernel/task_work.c:228
>>>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>>>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>>>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>>>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>>>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>=20
>>> read to 0xffffea0004b81dd8 of 8 bytes by task 6342 on cpu 1:
>>>  __folio_test_movable include/linux/page-flags.h:699 [inline]
>>>  migrate_folio_unmap mm/migrate.c:1199 [inline]
>>>  migrate_pages_batch+0x24c/0x1940 mm/migrate.c:1797
>>>  migrate_pages_sync mm/migrate.c:1963 [inline]
>>>  migrate_pages+0xff1/0x1820 mm/migrate.c:2072
>>>  do_mbind mm/mempolicy.c:1390 [inline]
>>>  kernel_mbind mm/mempolicy.c:1533 [inline]
>>>  __do_sys_mbind mm/mempolicy.c:1607 [inline]
>>>  __se_sys_mbind+0xf76/0x1160 mm/mempolicy.c:1603
>>>  __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1603
>>>  x64_sys_call+0x2b4d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h=
:238
>>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>=20
>>> value changed: 0xffff888127601078 -> 0x0000000000000000
>>=20
>> Note that this doesn't flip PAGE_MAPPING_MOVABLE, just some unrelated bit=
s.
>>=20
>>>=20
>>> Reported-by: syzbot <syzkaller@googlegroups.com>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 7e2a5e5ab217 ("mm: migrate: use __folio_test_movable()")
>>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>>> ---
>>>  mm/migrate.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 923ea80ba744..e62dac12406b 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1118,7 +1118,7 @@ static int migrate_folio_unmap(new_folio_t get_new=
_folio,
>>>      int rc =3D -EAGAIN;
>>>      int old_page_state =3D 0;
>>>      struct anon_vma *anon_vma =3D NULL;
>>> -    bool is_lru =3D !__folio_test_movable(src);
>>> +    bool is_lru;
>>>      bool locked =3D false;
>>>      bool dst_locked =3D false;
>>> @@ -1172,6 +1172,7 @@ static int migrate_folio_unmap(new_folio_t get_new=
_folio,
>>>      locked =3D true;
>>>      if (folio_test_mlocked(src))
>>>          old_page_state |=3D PAGE_WAS_MLOCKED;
>>> +    is_lru =3D !__folio_test_movable(src);
>>=20
>>=20
>> Looks straight forward, though
>>=20
>> Acked-by: David Hildenbrand <david@redhat.com>
>>=20
>>=20
>> --
>> Cheers,
>>=20
>> David / dhildenb
>>=20

