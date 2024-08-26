Return-Path: <stable+bounces-70276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AC395F96C
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 21:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C8B1F22D7C
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668171991D8;
	Mon, 26 Aug 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3MhC03I"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F601991C6
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699264; cv=none; b=BchYVZvIm8oBvjmLQ7kMszttu8VNXFYAzbb3SeE0xLWu2K1gBC+CN9bxgEcSC8AU98mfr2Y4Rav5zA9x1+Wv81SD/vmWao7g3PEVFw5FZ8YcaFZaVTegtgga8jczjCJC6PQOp0/Iq5W8VJr9viA3uVT8Il+cQmYwwBu2ftpLJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699264; c=relaxed/simple;
	bh=38ksbkqPg4F5t2Xby7SXcmkHpHbZz5yoHQt/ZBK2iEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZO91DLuA2B8sFwG0MCHvRye0TnOHwpBoTis6GHpwZbgBpj2Xl98UiFzV8qzF1voZkLzPF6+NLrTvhzE8kUfF+BRxk4J7iGvAg0E3UuIARG/apsHqlfxR6JNTu3NPGg5ZJ1KXtQpbFGZy0D5ljXRQvApDNpgAre2PQbToq1BKVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3MhC03I; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fee2bfd28so56711cf.1
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724699261; x=1725304061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rPuT+GJsYPFao+5rq3DRvTvjZuIBMa12VKy3PtmhCY=;
        b=L3MhC03IqGDeftsTTP/6tRP7ud+Ntsyoo01Lx2htWf46xHRIxYainDX9RPbpR4HLev
         PSKYUOVgzzwQBwFKR84t0aw0MVc0MOq9LpVGGwqr/D9wAL3QYj8GaXmI0wsTvgJICbXl
         67mXi33EjELAE2Oq+MJ+X2Kx9P1pL3VulUt3OFrOT67eTnZbiiKBW0Fq/C3j9+OXVPNu
         vGVE1785TMPLNU8XlJL69Vxuzvsj98M7FAi70Ke0TPnRMO9SnNEqwDU7bYpO/ieomPv9
         BqocU7dusihMn2b88hm1Y7qDB9RkEtICMKgeTflaG/wtYT66VjVmM5+4xSRunysYu5Lc
         6SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724699261; x=1725304061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rPuT+GJsYPFao+5rq3DRvTvjZuIBMa12VKy3PtmhCY=;
        b=oTStnIzqZgyhSm95YrhdCDDxwmMjJO0HbrteHF6anuJriX0J+YgsEmUxXbEKxdqGSY
         h7R/ly5+Tw6xB4QJNHQWbQ5CytYqSjfxh/47iTuKOMxSVxRr786g4oGxn51w+I/qWuAK
         qJY/A0tjYzSqYF0++TmKoPhCPHsxJ12mPuWRYAqA7W6Fllxu1O8qjaYXyd5/7ydDT7Pi
         8Hou6CFTHRVGw44+d6kZA3+B+TM9O5Em7awY72dFkwu/Z5YkaqqCTmkKUr5u3l4pgie3
         gf6nFyOEmA1obcV3fjB+YFqCHES9RlPxHa+SP4Pa23uKMZqymZILWWv+iqpM9PP44/Om
         iygA==
X-Forwarded-Encrypted: i=1; AJvYcCV5xyOFTIeX+9D6XXmXgm9HsDmwIGrgrRO5NcHhD6qIHYB2FDxrUx14/ZrvquvdLFbxwZ7FUUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvYwCtez1Z81Fy4XovBj9iGlZYg1BFpImuQ8zSeel22TZcC225
	O7zNwMh7JV2m109W5vkLow0rXSjwlKpRvRzp6EOak/ui/ZzVoWl5CoeIzHXD6hUx+EuPyqRoNdt
	iQT+QEpbbjQ+wrXWgQ4iauQvqP5gM+wVNgGEd
X-Google-Smtp-Source: AGHT+IFw0j5SlfzJrOxUT+ehixWHMOE6ne2a3tGOBDku0BVzObIQKN02nnM2qnlMirn/Y4UEd44sY83CtZa0FIYA7k4=
X-Received: by 2002:a05:622a:30f:b0:447:e0e1:2a7b with SMTP id
 d75a77b69052e-45661e33c0dmr320571cf.23.1724699260988; Mon, 26 Aug 2024
 12:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa6bde95-68e5-4d94-0ce4-c9a1d90fdcdc@linux.dev>
 <20240825163649.33294-1-hao.ge@linux.dev> <8e052e52-4c8e-279c-bcd4-3c4cd1325bdf@huawei.com>
In-Reply-To: <8e052e52-4c8e-279c-bcd4-3c4cd1325bdf@huawei.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Aug 2024 12:07:27 -0700
Message-ID: <CAJuCfpHbgcygtc3j0bstuZbo1QjMkeZJoPBshvrv=6rQkK1WRg@mail.gmail.com>
Subject: Re: [PATCH v2] codetag: debug: mark codetags for poisoned page as empty
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Hao Ge <hao.ge@linux.dev>, akpm@linux-foundation.org, david@redhat.com, 
	kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nao.horiguchi@gmail.com, pasha.tatashin@soleen.com, Hao Ge <gehao@kylinos.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 11:32=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> =
wrote:
>
> On 2024/8/26 0:36, Hao Ge wrote:
> > From: Hao Ge <gehao@kylinos.cn>
> >
> > When PG_hwpoison pages are freed,they are treated differently in
> > free_pages_prepare() and instead of being released they are isolated.
> >
> > Page allocation tag counters are decremented at this point since the
> > page is considered not in use. Later on when such pages are released
> > by unpoison_memory(), the allocation tag counters will be decremented
> > again and the following warning gets reported:
> >
> > [  113.930443][ T3282] ------------[ cut here ]------------
> > [  113.931105][ T3282] alloc_tag was not set
> > [  113.931576][ T3282] WARNING: CPU: 2 PID: 3282 at ./include/linux/all=
oc_tag.h:130 pgalloc_tag_sub.part.66+0x154/0x164
> > [  113.932866][ T3282] Modules linked in: hwpoison_inject fuse ip6t_rpf=
ilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebt=
able_nat ebtable_broute ip6table_nat ip6table_man4
> > [  113.941638][ T3282] CPU: 2 UID: 0 PID: 3282 Comm: madvise11 Kdump: l=
oaded Tainted: G        W          6.11.0-rc4-dirty #18
> > [  113.943003][ T3282] Tainted: [W]=3DWARN
> > [  113.943453][ T3282] Hardware name: QEMU KVM Virtual Machine, BIOS un=
known 2/2/2022
> > [  113.944378][ T3282] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT =
-SSBS BTYPE=3D--)
> > [  113.945319][ T3282] pc : pgalloc_tag_sub.part.66+0x154/0x164
> > [  113.946016][ T3282] lr : pgalloc_tag_sub.part.66+0x154/0x164
> > [  113.946706][ T3282] sp : ffff800087093a10
> > [  113.947197][ T3282] x29: ffff800087093a10 x28: ffff0000d7a9d400 x27:=
 ffff80008249f0a0
> > [  113.948165][ T3282] x26: 0000000000000000 x25: ffff80008249f2b0 x24:=
 0000000000000000
> > [  113.949134][ T3282] x23: 0000000000000001 x22: 0000000000000001 x21:=
 0000000000000000
> > [  113.950597][ T3282] x20: ffff0000c08fcad8 x19: ffff80008251e000 x18:=
 ffffffffffffffff
> > [  113.952207][ T3282] x17: 0000000000000000 x16: 0000000000000000 x15:=
 ffff800081746210
> > [  113.953161][ T3282] x14: 0000000000000000 x13: 205d323832335420 x12:=
 5b5d353031313339
> > [  113.954120][ T3282] x11: ffff800087093500 x10: 000000000000005d x9 :=
 00000000ffffffd0
> > [  113.955078][ T3282] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008236ba90 x6 :=
 c0000000ffff7fff
> > [  113.956036][ T3282] x5 : ffff000b34bf4dc8 x4 : ffff8000820aba90 x3 :=
 0000000000000001
> > [  113.956994][ T3282] x2 : ffff800ab320f000 x1 : 841d1e35ac932e00 x0 :=
 0000000000000000
> > [  113.957962][ T3282] Call trace:
> > [  113.958350][ T3282]  pgalloc_tag_sub.part.66+0x154/0x164
> > [  113.959000][ T3282]  pgalloc_tag_sub+0x14/0x1c
> > [  113.959539][ T3282]  free_unref_page+0xf4/0x4b8
> > [  113.960096][ T3282]  __folio_put+0xd4/0x120
> > [  113.960614][ T3282]  folio_put+0x24/0x50
> > [  113.961103][ T3282]  unpoison_memory+0x4f0/0x5b0
> > [  113.961678][ T3282]  hwpoison_unpoison+0x30/0x48 [hwpoison_inject]
> > [  113.962436][ T3282]  simple_attr_write_xsigned.isra.34+0xec/0x1cc
> > [  113.963183][ T3282]  simple_attr_write+0x38/0x48
> > [  113.963750][ T3282]  debugfs_attr_write+0x54/0x80
> > [  113.964330][ T3282]  full_proxy_write+0x68/0x98
> > [  113.964880][ T3282]  vfs_write+0xdc/0x4d0
> > [  113.965372][ T3282]  ksys_write+0x78/0x100
> > [  113.965875][ T3282]  __arm64_sys_write+0x24/0x30
> > [  113.966440][ T3282]  invoke_syscall+0x7c/0x104
> > [  113.966984][ T3282]  el0_svc_common.constprop.1+0x88/0x104
> > [  113.967652][ T3282]  do_el0_svc+0x2c/0x38
> > [  113.968893][ T3282]  el0_svc+0x3c/0x1b8
> > [  113.969379][ T3282]  el0t_64_sync_handler+0x98/0xbc
> > [  113.969980][ T3282]  el0t_64_sync+0x19c/0x1a0
> > [  113.970511][ T3282] ---[ end trace 0000000000000000 ]---
> >
> > To fix this, clear the page tag reference after the page got isolated
> > and accounted for.
> >
> > Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages =
as empty")
> > Cc: stable@vger.kernel.org # v6.10
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks.
> .

