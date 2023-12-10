Return-Path: <stable+bounces-5187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DDE80B8F6
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 06:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01590280EEE
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 05:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C48B1842;
	Sun, 10 Dec 2023 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCQ8a/yn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B69A114
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 21:18:55 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5c08c47c055so32561357b3.1
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 21:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702185533; x=1702790333; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ken9FFd/gnCbG/lfDhbbx0JIuU8MFDO8geOYaZeVghc=;
        b=aCQ8a/yntIiGCdYG6oDldrBmmdI9hK/CbCcMd3sVy2UXsNOEApdzGzidc6F9KKb0x1
         qZxV5SgFzUFIyzP/i68MJ5QhD91FCe2DFCYmhHyVQF7f54j+Efl9Fwzhy8A35szWEMrw
         i5tgCuz/0bSiQ2bVwmF0MRXXr0R4r/BAFIIgVzyfhd0cjWNjDIJSq4LkW6UgQTupqIaW
         MvM6CBROKhrIT/SSvSakbN+WMCysMeT1AAVra4UjPuCEj3oWTbKNfgICkUTJW5+P1oH1
         4XzNs5GKwRoJpl1Gi+N0c4VgATposVw3+IHH2QkfX/GWM/cEcIJhhFYo+DPXFJhVLqLV
         +ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702185533; x=1702790333;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ken9FFd/gnCbG/lfDhbbx0JIuU8MFDO8geOYaZeVghc=;
        b=BIJvU7m3FMCaC+1JwzQ+1Fn7uWJN8HuINT8DXtEjpoP/BxgZ55r/JLib/4KFMIsEx5
         xxexfOxjL5JBqcDBRLM0T+VObpRD4w4Nm4vGv/S+5lMhlIWXyNH5yom0L1MNOBWj2Qtr
         RGzR1Dy7ykwHZL2x8VQJxkxgqbx9ZXeTN/iPGdeTx9B6yMH4Gx24veZie2mf1AyDfEMR
         lSJOHDXnxynyKlq9Wh9wdTYIC/xTnqDHmwMO+M0AVM0FT8VrZY33IUkjCuSrzfRLP9uv
         dpy+VB5fgaFwDjrX668kY4TEa2CPjxSjr1vTbEowBq+6wDavmBYmtFkDdOhBgegTRh2b
         cjfA==
X-Gm-Message-State: AOJu0YzZq0vC/0WL5ntQ9O5YJWFAuaT7zIZJaRyQlxHy5rIaBZaDHkOw
	nPDxuriUgZRyC9ZxuzO+YEU5VvBZco0QjGVVyUBZsg==
X-Google-Smtp-Source: AGHT+IE2waPkDKJeaXl9DPFDjZO4AzHgFDJePCFzHVoNd5VjVM/ds8ltnKpFpCTR+7ChrmZirQtfuw==
X-Received: by 2002:a81:4a85:0:b0:5d7:a00d:62e7 with SMTP id x127-20020a814a85000000b005d7a00d62e7mr1669454ywa.50.1702185533189;
        Sat, 09 Dec 2023 21:18:53 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d201-20020a814fd2000000b005cc5f5aa533sm1988886ywb.43.2023.12.09.21.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 21:18:52 -0800 (PST)
Date: Sat, 9 Dec 2023 21:18:42 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: stable@vger.kernel.org
cc: gregkh@linuxfoundation.org, willy@infradead.org, akpm@linux-foundation.org, 
    david@redhat.com, jannh@google.com, 
    =?ISO-8859-15?Q?Jos=E9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>, 
    kirill.shutemov@linux.intel.com, hughd@google.com
Subject: [PATCH 5.15.y] mm: fix oops when filemap_map_pmd) without
 prealloc_pte
Message-ID: <b7fc5151-3d73-b6ca-ce28-f4a4556294bb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463753983-1514366849-1702185532=:4856"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463753983-1514366849-1702185532=:4856
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

syzbot reports oops in lockdep's __lock_acquire(), called from
__pte_offset_map_lock() called from filemap_map_pages(); or when I run the
repro, the oops comes in pmd_install(), called from filemap_map_pmd()
called from filemap_map_pages(), just before the __pte_offset_map_lock().

The problem is that filemap_map_pmd() has been assuming that when it finds
pmd_none(), a page table has already been prepared in prealloc_pte; and
indeed do_fault_around() has been careful to preallocate one there, when
it finds pmd_none(): but what if *pmd became none in between?

My 6.6 mods in mm/khugepaged.c, avoiding mmap_lock for write, have made it
easy for *pmd to be cleared while servicing a page fault; but even before
those, a huge *pmd might be zapped while a fault is serviced.

The difference in symptomatic stack traces comes from the "memory model"
in use: pmd_install() uses pmd_populate() uses page_to_pfn(): in some
models that is strict, and will oops on the NULL prealloc_pte; in other
models, it will construct a bogus value to be populated into *pmd, then
__pte_offset_map_lock() oops when trying to access split ptlock pointer
(or some other symptom in normal case of ptlock embedded not pointer).

Link: https://lore.kernel.org/linux-mm/20231115065506.19780-1-jose.pekkarin=
en@foxhound.fi/
Link: https://lkml.kernel.org/r/6ed0c50c-78ef-0719-b3c5-60c0c010431c@google=
=2Ecom
Fixes: f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths"=
)
Signed-off-by: Hugh Dickins <hughd@google.com>
Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.c=
om
Closes: https://lore.kernel.org/linux-mm/0000000000005e44550608a0806c@googl=
e.com/
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>,
Cc: Jos=E9 Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>    [5.12+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 9aa1345d66b8132745ffb99b348b1492088da9e2)
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 81e28722edfa..84a5b0213e0e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3209,7 +3209,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, str=
uct page *page)
 =09    }
 =09}
=20
-=09if (pmd_none(*vmf->pmd)) {
+=09if (pmd_none(*vmf->pmd) && vmf->prealloc_pte) {
 =09=09vmf->ptl =3D pmd_lock(mm, vmf->pmd);
 =09=09if (likely(pmd_none(*vmf->pmd))) {
 =09=09=09mm_inc_nr_ptes(mm);
--=20
2.35.3
---1463753983-1514366849-1702185532=:4856--

