Return-Path: <stable+bounces-70066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E636D95D3A7
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5385AB22BB5
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8018BC02;
	Fri, 23 Aug 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u79x3eCk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B718A6C7
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431185; cv=none; b=eLD3YN9pOpMPDGYvtUqKd9BiStpTCmufseI5JpwfO9Xs3Js9PNvJVg5XdmFZW18EQyz6Ln9BV93q7VDXjKKsdvndOSh6qNptabcKCo0VPdb9yByy9H9wBfJ17thnzmKbA6MYUbV0pIymI6fF8hlHoWs2VLblGbzEkbOhyYI7Ei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431185; c=relaxed/simple;
	bh=KaCmjrABe49GNzvbAm6OT6hfcDxVLHDDU0KNQEzpicA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Myn4FmtMFbg4VNsrwSClaOX3GgtO+KNY8peD/0UqlocVN6oA4FwHl7X3C886vXnVjh0CWZUVzsZARqIZvcx2JwIUY1qB4/FVPNo00giy94y6ru6T1n9A2AEjhuie9kQiA2EhqHBiYEmyj1WI/l6XSbBBofM2Fo89qVzki3LUGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u79x3eCk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fee2bfd28so61cf.1
        for <stable@vger.kernel.org>; Fri, 23 Aug 2024 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724431182; x=1725035982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWCZVGAlZgiRQ76TnTfciwWkaeUiO7Q9jJrOr7a++YM=;
        b=u79x3eCkyXKVdsaq0hmfcH0OSrNOOoZTgqkgJvsIDp8ph/gw7eALwHaGrpBNKBAh4/
         WKoVEZ7wuWt9L5yyms44SVPrK96/fxCYlw2qBQ3OKNKHUhOzjEL6+tLTYN9XK+u0NwuI
         i4wu5XMVc5c+Dmp6KEhMrSDGx8hZz8ag11JiEYC7+ZczNPOpCa7QFVvTtTCpGkeA34DE
         88kB60+2qHHH/qaMOLmO+ZrjQkgsWlmxHJzU0zCJusLI+b58eSzHDjFG8+z7qjefVs+n
         uNrMNNb19Tmg9RifouIzylqHgKkW6xDWZFJmqaa4/zMqZ6/cu68Cqe45TvHPW6G4a2vp
         eMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724431182; x=1725035982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWCZVGAlZgiRQ76TnTfciwWkaeUiO7Q9jJrOr7a++YM=;
        b=p71KuhbDNicQigXM7TunROZ2FViH9B753bW1e4l4IR8kYJnq6t7xVIVOjwV+3d6i/k
         UK/S+Gmh97E2I676eC5pcC0HizPwS/1REv5uLGLcnfS7lRVfZ/+48Nto3M5OZxydPAA/
         7KXM7Gb2leHaelQtgcSsQpn+P2jPjXa6wyEglKLkWEqqo2W7JTMoHMYuT4exaicg+QKV
         Cch1nAsc4cZ5UuyS6GXpumkhxp04g803xAlCv0WO+XjhiBHtZFuB2cc7tUq6zoifWAGu
         X7sbzU6BInOjXjW0hh9ZlK9VqIKNqDld/NBKcdjp5HcFyDy8cT6RC8+ABwZMPxB0Ovo1
         JbIA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ghynMX/dvt3O9kpb1TckfnS+6zMMGnlx388ioWpEvqbwl6lkqa/bACbfiFPn99aVQMpt2ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAju45RfTLPj2D+pNe3UxhJ+ZFEGFXcFtf/nQpn0jue7Z64cjA
	QeBFR+OYCu0KSbxp4QfFbJ82+T9PYxerN1zuyrefx7kwE7Arbzhjc7h7vwLJPfOiDJmkukz8s+N
	A0HNBJGyEPhdMTX459I7m1TJlcoQDOp8B+UMz
X-Google-Smtp-Source: AGHT+IFoUZAQeCvqN+NjxXRErz71IIQZhTN00AkX1g1s0tHX14bey0qIKs+NzKWVaf59WcugpqvHyCzlUGndZY5N0uE=
X-Received: by 2002:ac8:5a8a:0:b0:44f:e12e:3015 with SMTP id
 d75a77b69052e-45509ebc0demr3093081cf.25.1724431181755; Fri, 23 Aug 2024
 09:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d6f46ea8-0f09-4942-6818-a58005c8a0c1@linux.dev> <20240823062002.21165-1-hao.ge@linux.dev>
In-Reply-To: <20240823062002.21165-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Aug 2024 09:39:30 -0700
Message-ID: <CAJuCfpH9BB0axRGphPWUdhamyhnhiK8MOQYLa55W7RmnBPASjA@mail.gmail.com>
Subject: Re: [PATCH] codetag: debug: mark codetags for poisoned page as empty
To: Hao Ge <hao.ge@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, kent.overstreet@linux.dev, 
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, pasha.tatashin@soleen.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Hao Ge <gehao@kylinos.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:21=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> The PG_hwpoison page will be caught and isolated on the entrance to
> the free buddy page pool.
>
> But for poisoned pages which software injected errors,
> we can reclaim it through unpoison_memory.
>
> So mark codetags for it as empty,just like when a page
> is first added to the buddy system.
>
> It was detected by [1] and the following WARN occurred:

Hi Hao,
Thanks for fixing this. I find this description a bit unclear. How
about something like this:

When PG_hwpoison pages are freed, they are treated differently in
free_pages_prepare() and instead of being released they are isolated.
Page allocation tag counters are decremented at this point since the
page is considered not in use. Later on when such pages are released
by unpoison_memory(), the allocation tag counters will be decremented
again and the following warning gets reported:

>
> [  113.930443][ T3282] ------------[ cut here ]------------
> [  113.931105][ T3282] alloc_tag was not set
> [  113.931576][ T3282] WARNING: CPU: 2 PID: 3282 at ./include/linux/alloc=
_tag.h:130 pgalloc_tag_sub.part.66+0x154/0x164
> [  113.932866][ T3282] Modules linked in: hwpoison_inject fuse ip6t_rpfil=
ter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtab=
le_nat ebtable_broute ip6table_nat ip6table_man4
> [  113.941638][ T3282] CPU: 2 UID: 0 PID: 3282 Comm: madvise11 Kdump: loa=
ded Tainted: G        W          6.11.0-rc4-dirty #18
> [  113.943003][ T3282] Tainted: [W]=3DWARN
> [  113.943453][ T3282] Hardware name: QEMU KVM Virtual Machine, BIOS unkn=
own 2/2/2022
> [  113.944378][ T3282] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -S=
SBS BTYPE=3D--)
> [  113.945319][ T3282] pc : pgalloc_tag_sub.part.66+0x154/0x164
> [  113.946016][ T3282] lr : pgalloc_tag_sub.part.66+0x154/0x164
> [  113.946706][ T3282] sp : ffff800087093a10
> [  113.947197][ T3282] x29: ffff800087093a10 x28: ffff0000d7a9d400 x27: f=
fff80008249f0a0
> [  113.948165][ T3282] x26: 0000000000000000 x25: ffff80008249f2b0 x24: 0=
000000000000000
> [  113.949134][ T3282] x23: 0000000000000001 x22: 0000000000000001 x21: 0=
000000000000000
> [  113.950597][ T3282] x20: ffff0000c08fcad8 x19: ffff80008251e000 x18: f=
fffffffffffffff
> [  113.952207][ T3282] x17: 0000000000000000 x16: 0000000000000000 x15: f=
fff800081746210
> [  113.953161][ T3282] x14: 0000000000000000 x13: 205d323832335420 x12: 5=
b5d353031313339
> [  113.954120][ T3282] x11: ffff800087093500 x10: 000000000000005d x9 : 0=
0000000ffffffd0
> [  113.955078][ T3282] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008236ba90 x6 : c=
0000000ffff7fff
> [  113.956036][ T3282] x5 : ffff000b34bf4dc8 x4 : ffff8000820aba90 x3 : 0=
000000000000001
> [  113.956994][ T3282] x2 : ffff800ab320f000 x1 : 841d1e35ac932e00 x0 : 0=
000000000000000
> [  113.957962][ T3282] Call trace:
> [  113.958350][ T3282]  pgalloc_tag_sub.part.66+0x154/0x164
> [  113.959000][ T3282]  pgalloc_tag_sub+0x14/0x1c
> [  113.959539][ T3282]  free_unref_page+0xf4/0x4b8
> [  113.960096][ T3282]  __folio_put+0xd4/0x120
> [  113.960614][ T3282]  folio_put+0x24/0x50
> [  113.961103][ T3282]  unpoison_memory+0x4f0/0x5b0
> [  113.961678][ T3282]  hwpoison_unpoison+0x30/0x48 [hwpoison_inject]
> [  113.962436][ T3282]  simple_attr_write_xsigned.isra.34+0xec/0x1cc
> [  113.963183][ T3282]  simple_attr_write+0x38/0x48
> [  113.963750][ T3282]  debugfs_attr_write+0x54/0x80
> [  113.964330][ T3282]  full_proxy_write+0x68/0x98
> [  113.964880][ T3282]  vfs_write+0xdc/0x4d0
> [  113.965372][ T3282]  ksys_write+0x78/0x100
> [  113.965875][ T3282]  __arm64_sys_write+0x24/0x30
> [  113.966440][ T3282]  invoke_syscall+0x7c/0x104
> [  113.966984][ T3282]  el0_svc_common.constprop.1+0x88/0x104
> [  113.967652][ T3282]  do_el0_svc+0x2c/0x38
> [  113.968893][ T3282]  el0_svc+0x3c/0x1b8
> [  113.969379][ T3282]  el0t_64_sync_handler+0x98/0xbc
> [  113.969980][ T3282]  el0t_64_sync+0x19c/0x1a0
> [  113.970511][ T3282] ---[ end trace 0000000000000000 ]---
>
> Link [1]: https://github.com/linux-test-project/ltp/blob/master/testcases=
/kernel/syscalls/madvise/madvise11.c

To fix this, clear the page tag reference after the page got isolated
and accounted for.

>
> Fixes: a8fc28dad6d5 ("alloc_tag: introduce clear_page_tag_ref() helper fu=
nction")

This would be more appropriate:
Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages
as empty")

> Cc: stable@vger.kernel.org # v6.10
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  mm/page_alloc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c565de8f48e9..7ccd2157d092 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1054,6 +1054,14 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>                 reset_page_owner(page, order);
>                 page_table_check_free(page, order);
>                 pgalloc_tag_sub(page, 1 << order);
> +
> +               /*
> +                * For poisoned pages which software injected errors,

Not sure what you mean by "which software injected errors". Maybe it's
a typo and should be "with software injected errors"?

> +                * we can reclaim it through unpoison_memory.
> +                * so mark codetags for it as empty,
> +                * just like when a page is first added to the buddy syst=
em.
> +                */

I think you can simply say here that:
/*
 * The page is isolated and accounted for. Mark the codetag as empty to avo=
id
 * accounting error when the page is freed by unpoison_memory().
 */

> +               clear_page_tag_ref(page);
>                 return false;
>         }
>
> --
> 2.25.1
>

