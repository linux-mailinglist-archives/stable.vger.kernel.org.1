Return-Path: <stable+bounces-55984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1685F91AF68
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 21:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6481C22710
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 19:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0419B3D0;
	Thu, 27 Jun 2024 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4StD3Uw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AD19A2BA;
	Thu, 27 Jun 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515034; cv=none; b=oeReB0U5Gx00bY8afU36ucDLBzLrxZfoLk3TWMD+ohOs39S/2z35ueUQvWKVOIRdqp9Bym4PKN43jmq+P+sODqd68nomCPPOLy+/EcG8TxOvRavpmRNq1NN4lvKn4VUQ6JwkFb0K9B0n9PRO6Jne58YyeOVKlX59WU0jpN6SJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515034; c=relaxed/simple;
	bh=0FeWUqgmRQBEgkRV40TveFBTzvhp+lE/Fddz+6fzvyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOBz1PsPC89nYIGxs24jeRRzz9tswhcg/liDW5sVYAycrWT8GvO6CxvW6Lzi4Is9JPWw4C+DeybX7NctY9qmizGoPxtH5nr3sW0ymmp5Xp0bbXCoACp69IV78RqROCZJzKWTzYThBIWiFVBifEs/w/9uvBb3lS4Ob+AyXbMGoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4StD3Uw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so2260134a12.3;
        Thu, 27 Jun 2024 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719515031; x=1720119831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cNQaKFEgW5yQvTALHrvOQ9l/UgLJ4FF7ZCby1Wnszo=;
        b=c4StD3UwBHLLWqjdJIgxZVx5YRuGcjTUgm4TXu2s2wPqwGECippzEYk5kVrLQLDEz6
         jEt9jmndD3kDsQnpOcs5YSp15YXpMCWTYVFwVwD1UyZETkEI3eRmdVlNH/i3cwQumTeK
         gMfsL8J7Abk6FgX7q4zCK3W7kcJAzupFm4NEuasqL8l3sID6/sesRKLm8qMRcdh1R1bv
         I1SJ4pII4lezHWKZx1QKYszKoUA2c5UMoKtGj0n+tfBwqmq8kztPqQGpVgWGS4LHiHc8
         k+lIBsGlcQpRQhPyFeCpSHnFP6D+Mk7hF09/nOhSsO3WRyL9gfxmdvlEAxqiEsNZwA8T
         Vdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719515031; x=1720119831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cNQaKFEgW5yQvTALHrvOQ9l/UgLJ4FF7ZCby1Wnszo=;
        b=r1/K7A2PsAhpVaxuvBvCc4Wh3quY8vlKVilVeh+Bh8VAxx3rl8hnB1sihOLJh9L4ao
         ododdtO+GDSvArPv+Xu3wnexXv4mJh1wpGZDGrw/xTbRS3ZIrn0H82Z0hCYr2Ol4SXGv
         nT/8xALviu4280hfU04d+tAUqEL+bOk65TgFxCL6UGc7rKq6Sglo3OvELCkR+8FHLtIA
         eApDu1h5fckAsRW9tUvlozkByxr/yvfAUq6AQqgoskPODlTMF4QccZiNwytd+mmrwi/w
         hJnIKbE2OT0ZbQtLT76oGj8KRYxWw3kc6qAv2wBD+pmEkcf6QDmtmHdsprZB/eAbUwyh
         HgKg==
X-Forwarded-Encrypted: i=1; AJvYcCV+uTWO+G20t5tEyHf/594SUXJTxouifFV29t2Jtk2/EmGYAi2hlljlQnVXhHpHZt1jwF2+KNXx8KrSdqg33+MJRisrddiiXLu5dCM9fBz1PgzrKxl+Bc0k4+1OnMvJ//g+kbrG
X-Gm-Message-State: AOJu0Yz3n12BsCAwl2JO5JQ7ZYqJZIw2vssPdZLgfoZufeV3eGwqXUVu
	pdBcTFK5w+5T2vH1ODiyV0kn1vgThZZ+W5Ks1vl2oakERM1lFRWhvHxwmIQlxa+OSq7TAaXgbLy
	nQbZ9QvlKh8HKm3YR1KhG5qTBiLA=
X-Google-Smtp-Source: AGHT+IFuUYrwKVK5ll2BgGlAUvAhY8Bipf/zQhfWva3sESfc+Kmwzi0MnW2uFrNgC6jM1EKbN4X5hzvkY3tsqbs06uI=
X-Received: by 2002:a17:907:8e8b:b0:a6f:6b6a:e8d0 with SMTP id
 a640c23a62f3a-a7242c4df6fmr976876366b.7.1719515030382; Thu, 27 Jun 2024
 12:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719478388-31917-1-git-send-email-yangge1116@126.com> <Zn21n5vg1Vz6whvs@x1n>
In-Reply-To: <Zn21n5vg1Vz6whvs@x1n>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 27 Jun 2024 12:03:38 -0700
Message-ID: <CAHbLzkpBxJT632ip22VmM6VSO7JEvk3NJ9Kpof0F=AQ69PSLyA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: Use try_grab_page() instead of try_grab_folio()
 in gup slow path
To: Peter Xu <peterx@redhat.com>
Cc: yangge1116@126.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 21cnbao@gmail.com, 
	baolin.wang@linux.alibaba.com, liuzixing@hygon.cn, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:55=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Jun 27, 2024 at 04:53:08PM +0800, yangge1116@126.com wrote:
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
> > Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages !=3D N=
ULL"")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: yangge <yangge1116@126.com>
>
> Thanks for the report and the fix proposed.  This is unfortunate..
>
> It's just that I worry this may not be enough, as thp slow gup isn't the
> only one using try_grab_folio().  There're also hugepd and memfd pinning
> (which just got queued, again).
>
> I suspect both of them can also hit a cma chunk here, and fail whenever
> they shouldn't have.
>
> The slight complexity resides in the hugepd path where it right now share=
s
> with fast-gup.  So we may potentially need something similiar to what Yan=
g
> used to introduce in this patch:
>
> https://lore.kernel.org/r/20240604234858.948986-2-yang@os.amperecomputing=
.com
>
> So as to identify whether the hugepd gup is slow or fast, and we should
> only let the fast gup fail on those.
>
> Let me also loop them in on the other relevant discussion.

Thanks, Peter. I was actually typing the same thing...

Yes, I agree my patch should be able to solve the problem. At the
beginning I thought it is just a pure clean up patch, but it seems
like it is more useful.

I'm going to port my patch to the latest mm-unstable, then post it.

>
> Thanks,
>
> --
> Peter Xu
>

