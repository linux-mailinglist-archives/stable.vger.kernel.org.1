Return-Path: <stable+bounces-132897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B4A91282
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28B11901B60
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B501CDFC1;
	Thu, 17 Apr 2025 05:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTDn7W0Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ACB18C034
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744866218; cv=none; b=eOb079h/WELd9bctD49Racg5dYPDOZ09xyspBJjwfbN3yyOTQPXbTUHuIvebG1lIwsmEiMSZgvb9qP/y1bR0Nqoqijo1izKzAKK92LXGbNewhAdM9GaXzP0sEwuDYwSRVENBD+AWWH8stcCwxcao2SHVw3Zx0Fi4kvkHouyeVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744866218; c=relaxed/simple;
	bh=I7wIEYnpxcz/BApB48jy+atPoGsInFFcNendN5f2mEc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O41Z/AWbf/2tMh6mc3NWN7rB02hohkIcgM1ie/DEHQmVxL6PN44NQMxxzWPA6DCSm4vraoDK/RCN2ehg52SwVUxvmlet7gM0MEMIM8oDw+OTtd9zAiWUPE3ysknFh6RCqfqnBx7p8GNGwjLZaHb6IxUHb/N3x4cTsRM40K7aMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTDn7W0Z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fd89d036so4542635ad.1
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 22:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744866216; x=1745471016; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz/XOU6GJUjnIHziBMa/ejaxLXDiuXn3yPYLfVwKjWo=;
        b=GTDn7W0Z1Vv5x69Cv9GF14wZ7i+KDOwD6kdf7sE+21DVl5wMvWuvMUEMjBjMy8YoUg
         lQBbSMXEVfGiVvM1r7KJSmY+bLU5orx/a7+Rgm1als9hDISlnThCaqkMwjxpJqs7rDWY
         jlQbXjMNkusC5vvip4cABskBUNZx66b3e15Uq73+ntis68gXDiRwmJDC9hQWcul6BKLt
         j9+GHvEp3rQ9XUOt4TU5MGdd5GK9FP6Gntu146qhAR1/kMZGTZpuxZWCVgaFaYQ/e+nq
         8NODKpMsP+lfDenxq1zCcWcecORTfACclfbbG8l8XAjUozUmviKrYQMbhKVU15bfTesI
         sytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744866216; x=1745471016;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz/XOU6GJUjnIHziBMa/ejaxLXDiuXn3yPYLfVwKjWo=;
        b=tIU1jOCzjBbmCc5BwPfC3C6RJPp9HyrlRHWL04xgHu0olRB1FNxw15WHsxAFCtzT5L
         JXnGB7iOWhVVX9d/oBhiqxG0aZ0z5zQnHgbHhopjI/NR5fKBZasc/LjrnUVHyZSrJ78W
         qX0F5TfvHwG0smN79tQkkG4gKZyakEeUaQNkITcMlJUr6ox2DTW6QCLpvVsLiA0g+H28
         0zpZIZopj5SKEzRIcNzoFTHj2RmBUx4HlDLIst+KOfW6KLAFGPFb4rFqkO+jnfjNenJt
         aIpnYxq+cAkxLTdhtPecHeg87tbKACqZYXPgeEzxHLJA6QlYfUp1JPUPQoFy+BfOdtzc
         JM1A==
X-Forwarded-Encrypted: i=1; AJvYcCV1K8cQBZbtVll/q+hkOPuhSHz13jb3PwcFnLTD/srNKNme/+CZTBuzt3Ydq06Zv6IDTKNhs8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/wiBGKTG28950o6uP67RKDHhOoxHBhic2xsQzpGsB7imLdSA
	fjD0ScYYXLNDvz0LcjkMZRgJJSvKes552qMnmwW48m3OX3C/kjaUFPbh7Lp3lg==
X-Gm-Gg: ASbGnctj8yAnaUu0UhP1cp85LMA7A9xSelGnNEv0v4nWMDkq0SocVlwbNr+aMwGTrW9
	+MJAhZRZ6G8P75lEoUY0xpP58kyZXO76ozJF9sNOjw9eC8J18HTeXHprblccpYBVssb5ydydZs5
	u7sxETLFovZ8q9D/ZVMyGOWkTmH94gxfoFyV3KWP3bnCyT3jRnC8X1Ja5LF3gP5vp+/2xxXgJfU
	KG3zN+6D6t+fsQeW7aJyKM6c49zUw7o+UJ98naMNS4x4cfSe3wTJu8JR97JB8XsYGLTIfTEV9aq
	sV/unOXPstV05CIiQYXc+A2wS609cTXgGqV+kKKBkXoeO4MhJfIrd3hUoGd473nbqp3rvCw7+p2
	wGyDQXjbjHVfG1d5whu4IhBNP
X-Google-Smtp-Source: AGHT+IERG0jv4hzWyJchJgTRcqJ4HywpEjypOZy8IrUAQQsiFDrXebt5WGosFtJLR6VQALxZ6cQziw==
X-Received: by 2002:a17:902:c405:b0:224:2384:5b40 with SMTP id d9443c01a7336-22c35916c90mr72088015ad.24.1744866216101;
        Wed, 16 Apr 2025 22:03:36 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fa5f59sm24056305ad.129.2025.04.16.22.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:03:35 -0700 (PDT)
Date: Wed, 16 Apr 2025 22:03:33 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org, 
    akpm@linux-foundation.org, willy@infradead.org, linmiaohe@huawei.com, 
    hughd@google.com, revest@google.com, kernel-dev@igalia.com, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm/huge_memory: fix dereferencing invalid pmd migration
 entry
In-Reply-To: <A049A15F-1287-4943-8EE4-833CEEC4F988@nvidia.com>
Message-ID: <eec1be5d-8b42-6dbb-432d-488650b79c40@google.com>
References: <20250414072737.1698513-1-gavinguo@igalia.com> <A049A15F-1287-4943-8EE4-833CEEC4F988@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-916831765-1744866215=:4537"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-916831765-1744866215=:4537
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Apr 2025, Zi Yan wrote:
> On 14 Apr 2025, at 3:27, Gavin Guo wrote:
>=20
> > When migrating a THP, concurrent access to the PMD migration entry
> > during a deferred split scan can lead to a page fault, as illustrated
>=20
> It is an access violation, right? Because pmd_folio(*pmd_migration_entry)
> does not return a folio address. Page fault made this sounded like not
> a big issue.
>=20
> > below. To prevent this page fault, it is necessary to check the PMD
> > migration entry and return early. In this context, there is no need to
> > use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the equality
> > of the target folio. Since the PMD migration entry is locked, it cannot
> > be served as the target.
>=20
> You mean split_huge_pmd_address() locks the PMD page table, so that
> page migration cannot proceed, or the THP is locked by migration,
> so that it cannot be split? The sentence is a little confusing to me.

No, split_huge_pmd_address() locks nothing. But its caller holds the
folio lock on this folio (as split_huge_pmd_locked() asserts with a=20
VM_WARN_ON_ONCE); and page migration holds folio lock on its folio
(as various swapops.h functions assert with BUG_ON).

So any PMD migration entry found here cannot be for the folio which
split_huge_pmd_address() is passing down.  (And even if the impossible
did occur, what woud we want to do?  Skip it as the patch does.)

>=20
> >
> > BUG: unable to handle page fault for address: ffffea60001db008
> > CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2 04/01/2014
> > RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
> > Call Trace:
> > <TASK>
> > try_to_migrate_one+0x28c/0x3730
> > rmap_walk_anon+0x4f6/0x770
> > unmap_folio+0x196/0x1f0
> > split_huge_page_to_list_to_order+0x9f6/0x1560
> > deferred_split_scan+0xac5/0x12a0
> > shrinker_debugfs_scan_write+0x376/0x470
> > full_proxy_write+0x15c/0x220
> > vfs_write+0x2fc/0xcb0
> > ksys_write+0x146/0x250
> > do_syscall_64+0x6a/0x120
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > The bug is found by syzkaller on an internal kernel, then confirmed on
> > upstream.
> >
> > Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> > ---
> >  mm/huge_memory.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 2a47682d1ab7..0cb9547dcff2 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_are=
a_struct *vma, pmd_t *pmd,
> >  void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
> >  =09=09=09   pmd_t *pmd, bool freeze, struct folio *folio)
> >  {
> > +=09bool pmd_migration =3D is_pmd_migration_entry(*pmd);
> > +
> >  =09VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
> >  =09VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
> >  =09VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> > @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struc=
t *vma, unsigned long address,
> >  =09 * require a folio to check the PMD against. Otherwise, there
> >  =09 * is a risk of replacing the wrong folio.
> >  =09 */
> > -=09if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> > -=09    is_pmd_migration_entry(*pmd)) {
> > -=09=09if (folio && folio !=3D pmd_folio(*pmd))
> > -=09=09=09return;
> > +=09if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
> > +=09=09if (folio) {
> > +=09=09=09/*
> > +=09=09=09 * Do not apply pmd_folio() to a migration entry; and
> > +=09=09=09 * folio lock guarantees that it must be of the wrong
> > +=09=09=09 * folio anyway.
>=20
> Why does the folio lock imply it is a wrong folio?

Because you cannot have two tasks holding folio lock on the same folio
at the same time.  So therefore it is a different ("wrong") folio.

>=20
> > +=09=09=09 */
> > +=09=09=09if (pmd_migration)
> > +=09=09=09=09return;
> > +=09=09=09if (folio !=3D pmd_folio(*pmd))
> > +=09=09=09=09return;
> > +=09=09}
>=20
> Why not just
>=20
> if (folio && pmd_migration)
> =09return;

That looks nicer, less indentation, I agree.  But Gavin's patch is
keeping the relevant check next to the "pmd_folio(*pmd)" to be avoided:
also good. I have no opinion which is the better.

Hugh

>=20
> if (pmd_trans_huge() =E2=80=A6) {
> =09=E2=80=A6
> }
> ?
>=20
> Thanks.
>=20
> Best Regards,
> Yan, Zi
>=20
---1463770367-916831765-1744866215=:4537--

