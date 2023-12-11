Return-Path: <stable+bounces-5516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2080D386
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C7A281ADF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF54D582;
	Mon, 11 Dec 2023 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQMaXGj8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B09B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:18:21 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db537948ea0so4548556276.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702315100; x=1702919900; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d8r3lyrzD5bS7Rw+HcuPdF3gJgvsKK1V3GgffIf9p6M=;
        b=SQMaXGj8AAAtmRmS/Jqi702O14B0ghlAOzT2CVc7bicPJBhxOLptjBcfvYSr6HZzMq
         URzwVlYr8tiNfReLnyz1YegHWsMX9KGEnOb9i/kFLRO2TkZTTMj9DohUF3CxmwgBAwUB
         ZYkRS/DQCcjv770haOobBOv6MNRo55H4JIsTgONUHIEqIpPiiV09wy5YYfKquOSxE1h6
         DKyKmaiYgfzOd2pBIeLAXkTR+O4dKiZXz7jKFCIxLMPwreuMQo/KkJmzoARX7P7Sd62h
         v2e7icYglyx956wwSRwmr4La/TwXtjwthq+JtIwsfiRERLba0X9fFTBuVXCrUbui8uRK
         o7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315100; x=1702919900;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8r3lyrzD5bS7Rw+HcuPdF3gJgvsKK1V3GgffIf9p6M=;
        b=Ermbo9SOwjrv8RGrxnQ/RHcN7mniXbJyIEabR2VhBiO947onNSXxUdK0SlEL3969pX
         xgQc6EHkfNx5K3e8SPg013JkPGgjVupyj8n8KiHuuLpKmJ0uNjRjlcbQMcE90rjNqP9v
         GydPoHsP5GUg8OQoyxWy2dehhgPuNLBaI5hCBsnfxoxknMPtuhGIQ9SSxqh4QpnPGw+F
         6ndlr+9KaQDWqfGaotMukrQ2u2vkdbXZCN6N6pOwY1INTdJhnnKlNbxwbHoavc6XR0p9
         7K/8dI9oPg2akTozH/jVs+0mbSR5npEroM4J2SvE9qyj/HqMhwijxRHGdkSm4gNdJesE
         RTUA==
X-Gm-Message-State: AOJu0YwkTx1JQIaMrsDQa0zp3JDr7ZiZEQQ4Sb7baiie/rLQOerOEwZG
	CEhvZCI7R316A6KGRYe7rBqsQNlKSxakzxPrAh01/Q==
X-Google-Smtp-Source: AGHT+IFsQ5Rm74LBc4iIQqRojyeGTFph1bXtjzhJtldiMwUNhzPbT5RtYu7wmShQyUKzM4CK1MLj2Q==
X-Received: by 2002:a5b:d45:0:b0:da0:3d0d:3a18 with SMTP id f5-20020a5b0d45000000b00da03d0d3a18mr3073570ybr.39.1702315100047;
        Mon, 11 Dec 2023 09:18:20 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v17-20020a259d91000000b00d974c72068fsm2630315ybp.4.2023.12.11.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:18:18 -0800 (PST)
Date: Mon, 11 Dec 2023 09:18:06 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Greg KH <gregkh@linuxfoundation.org>
cc: Sasha Levin <sashal@kernel.org>, Hugh Dickins <hughd@google.com>, 
    stable@vger.kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
    david@redhat.com, jannh@google.com, 
    =?ISO-8859-15?Q?Jos=E9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>, 
    kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 5.15.y] mm: fix oops when filemap_map_pmd) without
 prealloc_pte
In-Reply-To: <2023121120-degree-target-cd18@gregkh>
Message-ID: <ac3262ba-7398-eef1-1d80-8425e394dc6f@google.com>
References: <b7fc5151-3d73-b6ca-ce28-f4a4556294bb@google.com> <2023121120-degree-target-cd18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463753983-1426648966-1702315098=:3108"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463753983-1426648966-1702315098=:3108
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Dec 2023, Greg KH wrote:
> On Sat, Dec 09, 2023 at 09:18:42PM -0800, Hugh Dickins wrote:
> > syzbot reports oops in lockdep's __lock_acquire(), called from
> > __pte_offset_map_lock() called from filemap_map_pages(); or when I run =
the
> > repro, the oops comes in pmd_install(), called from filemap_map_pmd()
> > called from filemap_map_pages(), just before the __pte_offset_map_lock(=
).
> >=20
> > The problem is that filemap_map_pmd() has been assuming that when it fi=
nds
> > pmd_none(), a page table has already been prepared in prealloc_pte; and
> > indeed do_fault_around() has been careful to preallocate one there, whe=
n
> > it finds pmd_none(): but what if *pmd became none in between?
> >=20
> > My 6.6 mods in mm/khugepaged.c, avoiding mmap_lock for write, have made=
 it
> > easy for *pmd to be cleared while servicing a page fault; but even befo=
re
> > those, a huge *pmd might be zapped while a fault is serviced.
> >=20
> > The difference in symptomatic stack traces comes from the "memory model=
"
> > in use: pmd_install() uses pmd_populate() uses page_to_pfn(): in some
> > models that is strict, and will oops on the NULL prealloc_pte; in other
> > models, it will construct a bogus value to be populated into *pmd, then
> > __pte_offset_map_lock() oops when trying to access split ptlock pointer
> > (or some other symptom in normal case of ptlock embedded not pointer).
> >=20
> > Link: https://lore.kernel.org/linux-mm/20231115065506.19780-1-jose.pekk=
arinen@foxhound.fi/
> > Link: https://lkml.kernel.org/r/6ed0c50c-78ef-0719-b3c5-60c0c010431c@go=
ogle.com
> > Fixes: f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepa=
ths")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotma=
il.com
> > Closes: https://lore.kernel.org/linux-mm/0000000000005e44550608a0806c@g=
oogle.com/
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Cc: Jann Horn <jannh@google.com>,
> > Cc: Jos=E9 Pekkarinen <jose.pekkarinen@foxhound.fi>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: <stable@vger.kernel.org>    [5.12+]
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit 9aa1345d66b8132745ffb99b348b1492088da9e2)
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  mm/filemap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20
> Now queued up, thanks.
>=20
> greg k-h

Thanks Greg: but Sasha appears to have a competing queue, in which
he's cherry-picked in a dependency from 5.16 ahead of a clean
cherry-pick for this one.

He posted his the next day: I expect it's more to your taste (pull
in dependency rather than edit cherry-pick) and it looked fine to me.
Please sort out with Sasha which goes forward, either will do.

Hugh
---1463753983-1426648966-1702315098=:3108--

