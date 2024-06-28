Return-Path: <stable+bounces-56105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7EE91C805
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 23:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933E01F22DFB
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17427D09D;
	Fri, 28 Jun 2024 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXsSrqgZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17711C6A4;
	Fri, 28 Jun 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609581; cv=none; b=IIeEfLG2uQ0vNJi01+GU9cI9Leo60/Wwz3fePlw7VVlyFVulffGbeM455iilx7yjUDzrMoBebhoWuTvdpomMZ1+evpWwiC5jfE+pXS0c/6vGYrEQuiTVHRd5AtvT/zAwYrd7QFgHTrGBfJGUNyo12uhn31M3Ti+uRbwf4EteY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609581; c=relaxed/simple;
	bh=dWOL/fUmBGA03x/sE0zJ2D4eMQqdgZxip1wKdy36EWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDMhVxhBx3pzLED8HTMpFcqYlOwGp/lBVVgy6g5a2gDfzFN8FZCTSWied9M7rPqqvKDqsTAO4jnPrZv5UAk63ocZnW2ha/IYLO/cNL0sSC/iXs6u4oHzxA2H9suWp93z6wyoC3ELgMzCGdg+zN0CMqHofiApafRckJvSP/TBo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXsSrqgZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d26a4ee65so1307324a12.2;
        Fri, 28 Jun 2024 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719609578; x=1720214378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lkns5Z1/d3gxpOrvGYjA3SyIaI/uRmg5Eshm3X9NN5s=;
        b=WXsSrqgZ+MLudxvxm+j7+2KciADMO3ngZgGR80ieyfBq3+OpWqiOnNwSmYBTiXhciO
         IdLGAYm2nCpTXI+pZ0gjlGm6KxpBJYpFbX/vsi6iGmxuyGiUJ4DRymS9PvrAFNh1bA6O
         dWzDeE+6xGuxO6pl5MWvaDWBWtCpiMv3LadI6NpTw/SGlt5UKnifpuJ4DR+MuDHnZ5BP
         InsV8pMo+ZAeNm71/HyzPToFazQyOcNLD3aKCtfZCXwLt1WROmcukz9boop/LjH8npmv
         UcGiGU+WSN0H8Tg2UEFV7j/OFP5bjf3suzdvQ5rHSnbeKegiR9j1XDUqzmWC3oX+QseI
         sIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719609578; x=1720214378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lkns5Z1/d3gxpOrvGYjA3SyIaI/uRmg5Eshm3X9NN5s=;
        b=JcUyfTAPToStVunrWuIhETX5srCALhsJ+FLY7x+nUyFbEVNwgcDZIuPs93fqKoIjwo
         VSn2J/ywtQFv3MU0d8EuUov322M+nJwb7PPFOEbbCMJ2hpR6UxNztjrL0iGmC1V3a5z+
         dGKDt1hYVvEearBlo00iOhaIuDdmABCdDdZZiwG3Fk9N31nQr/e0xpbvTCg/IJw5fxc4
         UoPGbQcDfNt+KkEIsYA/px2JQa2Qsr1gm5MYBRVK9LwwX5AMo5ilZViYQXWvp6GkP3Ed
         kL/bCtT1t2P/uqBru2ctfUGOsA9GAmwYMRkaq1kbKtJ9ZftEtqrxZEm8FWN15q7Pqfgd
         TIeA==
X-Forwarded-Encrypted: i=1; AJvYcCX2raqTa2jpyo1asaeqjUbvyuOkmBrXUz/368MJs3zJOtaiujwiXSxixBZAtj9qsw1EP3n7r//OuQKndaMFvvBVGoKzRXM0mcIPr6hVMA+u2onM8kjgNlLVHqJ7zWIBGUIrMUTn
X-Gm-Message-State: AOJu0YxnDg8CSpiMaXaFL1GS6ZvpXLomhESUMQaVv7WpmHRJPvBmfBSX
	NxxPGFnffxlrN0XR3WvWFuGa17bc9oqgyNN62IMR9u9y+3qzw188Ji3tvNb94pkxCSV9SijliFG
	3C9IANy5yv5VNB5E4t10uNjzwae8=
X-Google-Smtp-Source: AGHT+IFdEwhmzc8q8/7nPHfFlvJYTH2iFU7NzObsErmjGjm4GARuSggLZBbexnoILH9XnrCHqojmAnIyT2nviCcu+9Y=
X-Received: by 2002:a17:906:c40a:b0:a71:afc3:5c94 with SMTP id
 a640c23a62f3a-a7242e146b3mr1094639066b.74.1719609577981; Fri, 28 Jun 2024
 14:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719554518-11006-1-git-send-email-yangge1116@126.com> <20240628134241.53c5f68f936efe0aa8f0b789@linux-foundation.org>
In-Reply-To: <20240628134241.53c5f68f936efe0aa8f0b789@linux-foundation.org>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 28 Jun 2024 14:19:25 -0700
Message-ID: <CAHbLzkozpGYFFjV9hK_6hEcjCjXKCEpmUh2s-RsHLYqUu4gXMQ@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Fix longterm pin on slow gup regression
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yangge1116@126.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, 21cnbao@gmail.com, peterx@redhat.com, 
	yang@os.amperecomputing.com, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 1:42=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 28 Jun 2024 14:01:58 +0800 yangge1116@126.com wrote:
>
> > From: yangge <yangge1116@126.com>
> >
> > If a large number of CMA memory are configured in system (for
> > example, the CMA memory accounts for 50% of the system memory),
> > starting a SEV virtual machine will fail. During starting the SEV
> > virtual machine, it will call pin_user_pages_fast(..., FOLL_LONGTERM,
> > ...) to pin memory. Normally if a page is present and in CMA area,
> > pin_user_pages_fast() will first call __get_user_pages_locked() to
> > pin the page in CMA area, and then call
> > check_and_migrate_movable_pages() to migrate the page from CMA area
> > to non-CMA area. But the current code calling __get_user_pages_locked()
> > will fail, because it call try_grab_folio() to pin page in gup slow
> > path.
> >
> > The commit 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages
> > !=3D NULL"") uses try_grab_folio() in gup slow path, which seems to be
> > problematic because try_grap_folio() will check if the page can be
> > longterm pinned. This check may fail and cause __get_user_pages_lock()
> > to fail. However, these checks are not required in gup slow path,
> > seems we can use try_grab_page() instead of try_grab_folio(). In
> > addition, in the current code, try_grab_page() can only add 1 to the
> > page's refcount. We extend this function so that the page's refcount
> > can be increased according to the parameters passed in.
> >
> > The following log reveals it:
> >
> > [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_p=
ages+0x423/0x520
> > [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not taint=
ed 6.6.33+ #6
> > [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> > [  464.325515] Call Trace:
> > [  464.325520]  <TASK>
> > [  464.325523]  ? __get_user_pages+0x423/0x520
> > [  464.325528]  ? __warn+0x81/0x130
> > [  464.325536]  ? __get_user_pages+0x423/0x520
> > [  464.325541]  ? report_bug+0x171/0x1a0
> > [  464.325549]  ? handle_bug+0x3c/0x70
> > [  464.325554]  ? exc_invalid_op+0x17/0x70
> > [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> > [  464.325567]  ? __get_user_pages+0x423/0x520
> > [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> > [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> > [  464.325590]  pin_user_pages_fast+0x47/0x60
> > [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> > [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> >
>
> Well, we also have Yang Shi's patch
> (https://lkml.kernel.org/r/20240627231601.1713119-1-yang@os.amperecomputi=
ng.com)
> which takes a significantly different approach.  Which way should we
> go?

IMO, my patch is more complete, it should be sent to the mainline.
This patch can be considered if it is hard to backport my patch to the
stable tree.

>

