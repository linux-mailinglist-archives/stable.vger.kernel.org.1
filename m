Return-Path: <stable+bounces-118674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAFEA40BC1
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 22:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8E43B8BD7
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5C1FF7B0;
	Sat, 22 Feb 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgUFUwKY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43768828;
	Sat, 22 Feb 2025 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740259911; cv=none; b=VAgfaHjwbwWoUPlku0ADc23rjozEodKtT5x8jSBHJUO5kBiF1srxw2y1citUr7QYXXG0z871zone2VE2d/LxAO0MexKiF5TW3plsPQcm17hhFPUGiaFXb9d3PNECCEcqFDhGnfrw1BNXkjX3gay+XSbKA/I4Tt9oNXZXl1kO30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740259911; c=relaxed/simple;
	bh=2dCxHSAWl+CcfaKV37MRjFIhjVKyunjoPYxzCkxTIrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4Rwl4iauvxvnZQlDFOFVoyCWxebpRrvvv5qFhYpYWJxlXGM4manFa7Rz1yceQI52e8p/AIyQ4UszP2fUVbreyu4oJt9jzogOqHxj5fIzAvS89gXdIuE9616MJ6Frt8Ly4JueMPVi/q4CQUF4A20dh8KSVWyNISese3//QzhCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgUFUwKY; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so934618241.2;
        Sat, 22 Feb 2025 13:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740259908; x=1740864708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFl0XQfY5EgWWOaf98TRRQVcDwnlYMlHf963+xnJa3Q=;
        b=DgUFUwKYuf2AyMgH6unkOZd73qQCNtd83cW9oxLjeJqZuSBamFz4+alu6JiMAhWq1U
         fHLEGj2SMPkNWZ89x9/jIh18N9hbAEpV+uS5rkXXzibwUOxdUWe/nOvPO2bB2ZWgBat3
         MB3WhYABb51UqGKxoeqr5G6NiYLJd3dmgmNW8ROIbTVKwwaPTjcZJgJ2mSRxedtriMzU
         wkhUOB7mT1ISYJtiYM1K/yym7ks0szSvoDbg/pwIXRd5iBQ4ip8t8cV/JxXxnCQCW5HF
         ju52b5NUHPPLMbdIBC4hounSvYXThzNzKk6R08UKGzpvD4FderVpAk8JpeCQs2MkkzK7
         TPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740259908; x=1740864708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFl0XQfY5EgWWOaf98TRRQVcDwnlYMlHf963+xnJa3Q=;
        b=GGm3UU6UvsBq+neWv7rkxBVwD6qzbENgPe1c+iAujBS4ivnIwCgjVSOICCztJLqG8S
         SHX/qMXufUdwAmS//EDuFdyBVUrgq0EXrJfgec4Vi2PB6A+gAgN/gLmZqdD2ZAuN6Gvt
         YKdxlSGsHyI4j9Jba9ROwsO8UdRObCOPRQYIfx32CTYdXdV/NP6yob+VZMjqN7QPg5f0
         aSgUzgc1x48UTM6V2cezrFX3IQHlXZU56aKUJLnLUtKddLqtSuwoPBJb/Pc6gqmwahoW
         5apIqh0aQm/L1WnhyQsm1NpVHlAA1IZLX861WE0j6XdqbPbFts44JMUDJltHfHgbMm2G
         wABg==
X-Forwarded-Encrypted: i=1; AJvYcCUM0ovHkNno3TuIq0TtM/Rs6twzMAoOQKNtvQJ3v9T3aqJUQxNLOjWxTMNK3llBTSPbG9a7lE4NYgAvCmw=@vger.kernel.org, AJvYcCX7RDZ7nPOK+YEhjLc+3esbrknRjMVCGZxsh4kpsThOi3vUhZaKuh4IhmRE+aglt1bXHybDMyMM@vger.kernel.org
X-Gm-Message-State: AOJu0YzGmF0OGibSg3Lm7/USvYxMyane838wu52n/VlJUP2Emc2sc75b
	KnEp6muiwqib1nwt8MoJ83QJF9snGurZMSC2CGOBRz4WCyBlF7HVUdhVZBgU+Lql27LW6B37wZ0
	MhmpFyv/3Qz6tPbIaKr16BqkVt4k=
X-Gm-Gg: ASbGncsu604RFE/Pzp+umaYPxrzsLoI+P/SKJv9x3k43v8FN4PYzq1NcrTAWHKV7i08
	h8HZgVnPr77rEM4iK1cdvCaRpdaOp2bHIrVPqPIw8Zq6T/RucpcBfTFQ91DyjsqMsqzLwKmZlPM
	79QwDmrWc=
X-Google-Smtp-Source: AGHT+IHoyujMRhEdPKxeKf2mWlugvpAIglgbKM2uZWU15AhMHrumLw69+SgSol8v/MwdrCrAt4+D0bU4BZUUTD2wt7o=
X-Received: by 2002:a05:6122:2529:b0:51b:b750:8303 with SMTP id
 71dfb90a1353d-521ee49c7fbmr3952395e0c.11.1740259908445; Sat, 22 Feb 2025
 13:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com> <Z7e7iYNvGweeGsRU@x1.local>
 <CAGsJ_4zXMj3hxazV1R-e9kCi_q-UDyYDhU6onWQRtRNgEEV3rw@mail.gmail.com> <Z7fbom4rxRu-NX81@x1.local>
In-Reply-To: <Z7fbom4rxRu-NX81@x1.local>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 23 Feb 2025 10:31:37 +1300
X-Gm-Features: AWEUYZno13prQTj8vWDPxZEpQGT6slHD7oIiAxSZ34dWeJnuJMR5z9qAQPqbza0
Message-ID: <CAGsJ_4xb_FoH+3DgRvV7OkkbZqZKiubntPtR25mqiHQ7PLVaNQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Peter Xu <peterx@redhat.com>
Cc: david@redhat.com, Liam.Howlett@oracle.com, aarcange@redhat.com, 
	akpm@linux-foundation.org, axelrasmussen@google.com, bgeffon@google.com, 
	brauner@kernel.org, hughd@google.com, jannh@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com, 
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, 
	v-songbaohua@oppo.com, viro@zeniv.linux.org.uk, willy@infradead.org, 
	zhangpeng362@huawei.com, zhengtangquan@oppo.com, yuzhao@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:49=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Feb 21, 2025 at 01:07:24PM +1300, Barry Song wrote:
> > On Fri, Feb 21, 2025 at 12:32=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote:
> > >
> > > On Thu, Feb 20, 2025 at 10:21:01PM +1300, Barry Song wrote:
> > > > 2. src_anon_vma and its lock =E2=80=93 swapcache doesn=E2=80=99t re=
quire it=EF=BC=88folio is not mapped=EF=BC=89
> > >
> > > Could you help explain what guarantees the rmap walk not happen on a
> > > swapcache page?
> > >
> > > I'm not familiar with this path, though at least I see damon can star=
t a
> > > rmap walk on PageAnon almost with no locking..  some explanations wou=
ld be
> > > appreciated.
> >
> > I am observing the following in folio_referenced(), which the anon_vma =
lock
> > was originally intended to protect.
> >
> >         if (!pra.mapcount)
> >                 return 0;
> >
> > I assume all other rmap walks should do the same?
>
> Yes normally there'll be a folio_mapcount() check, however..
>
> >
> > int folio_referenced(struct folio *folio, int is_locked,
> >                      struct mem_cgroup *memcg, unsigned long *vm_flags)
> > {
> >
> >         bool we_locked =3D false;
> >         struct folio_referenced_arg pra =3D {
> >                 .mapcount =3D folio_mapcount(folio),
> >                 .memcg =3D memcg,
> >         };
> >
> >         struct rmap_walk_control rwc =3D {
> >                 .rmap_one =3D folio_referenced_one,
> >                 .arg =3D (void *)&pra,
> >                 .anon_lock =3D folio_lock_anon_vma_read,
> >                 .try_lock =3D true,
> >                 .invalid_vma =3D invalid_folio_referenced_vma,
> >         };
> >
> >         *vm_flags =3D 0;
> >         if (!pra.mapcount)
> >                 return 0;
> >         ...
> > }
> >
> > By the way, since the folio has been under reclamation in this case and
> > isn't in the lru, this should also prevent the rmap walk, right?
>
> .. I'm not sure whether it's always working.
>
> The thing is anon doesn't even require folio lock held during (1) checkin=
g
> mapcount and (2) doing the rmap walk, in all similar cases as above.  I s=
ee
> nothing blocks it from a concurrent thread zapping that last mapcount:
>
>                thread 1                         thread 2
>                --------                         --------
>         [whatever scanner]
>            check folio_mapcount(), non-zero
>                                                 zap the last map.. then m=
apcount=3D=3D0
>            rmap_walk()
>
> Not sure if I missed something.
>
> The other thing is IIUC swapcache page can also have chance to be faulted
> in but only if a read not write.  I actually had a feeling that your
> reproducer triggered that exact path, causing a read swap in, reusing the
> swapcache page, and hit the sanity check there somehow (even as mentioned
> in the other reply, I don't yet know why the 1st check didn't seem to
> work.. as we do check folio->index twice..).
>
> Said that, I'm not sure if above concern will happen in this specific cas=
e,
> as UIFFDIO_MOVE is pretty special, that we check exclusive bit first in s=
wp
> entry so we know it's definitely not mapped elsewhere, meanwhile if we ho=
ld
> pgtable lock so maybe it can't get mapped back.. it is just still tricky,
> at least we do some dances all over releasing and retaking locks.
>
> We could either justify that's safe, or maybe still ok and simpler if we
> could take anon_vma write lock, making sure nobody will be able to read t=
he
> folio->index when it's prone to an update.

What prompted me to do the former is that folio_get_anon_vma() returns
NULL for an unmapped folio. As for the latter, we need to carefully evaluat=
e
whether the change below is safe.

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -505,7 +505,7 @@ struct anon_vma *folio_get_anon_vma(const struct
folio *folio)
        anon_mapping =3D (unsigned long)READ_ONCE(folio->mapping);
        if ((anon_mapping & PAGE_MAPPING_FLAGS) !=3D PAGE_MAPPING_ANON)
                goto out;

-       if (!folio_mapped(folio))
+       if (!folio_mapped(folio) && !folio_test_swapcache(folio))
                goto out;

        anon_vma =3D (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON)=
;
@@ -521,7 +521,7 @@ struct anon_vma *folio_get_anon_vma(const struct
folio *folio)
         * SLAB_TYPESAFE_BY_RCU guarantees that - so the atomic_inc_not_zer=
o()
         * above cannot corrupt).
         */

-       if (!folio_mapped(folio)) {
+       if (!folio_mapped(folio) && !folio_test_swapcache(folio)) {
                rcu_read_unlock();
                put_anon_vma(anon_vma);
                return NULL;


The above change, combined with the change below, has also resolved the mTH=
P
-EBUSY issue.

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e5718835a964..1ef991b5c225 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1333,6 +1333,7 @@ static int move_pages_pte(struct mm_struct *mm,
pmd_t *dst_pmd, pmd_t *src_pmd,
                pte_unmap(&orig_src_pte);
                pte_unmap(&orig_dst_pte);
                src_pte =3D dst_pte =3D NULL;
+               folio_wait_writeback(src_folio);
                err =3D split_folio(src_folio);

                if (err)
                        goto out;
@@ -1343,7 +1344,7 @@ static int move_pages_pte(struct mm_struct *mm,
pmd_t *dst_pmd, pmd_t *src_pmd,
                goto retry;
        }

-       if (!src_anon_vma && pte_present(orig_src_pte)) {
+       if (!src_anon_vma) {
                /*
                 * folio_referenced walks the anon_vma chain
                 * without the folio lock. Serialize against it with


split_folio() returns -EBUSY if the folio is under writeback or if
folio_get_anon_vma() returns NULL.

I have no issues with the latter, provided the change in folio_get_anon_vma=
()
is safe, as it also resolves the mTHP -EBUSY issue.

We need to carefully consider the five places where folio_get_anon_vma() is
called, as this patch will also be backported to stable.

  1   2618  mm/huge_memory.c <<move_pages_huge_pmd>>
             src_anon_vma =3D folio_get_anon_vma(src_folio);

   2   3765  mm/huge_memory.c <<__folio_split>>
             anon_vma =3D folio_get_anon_vma(folio);

   3   1280  mm/migrate.c <<migrate_folio_unmap>>
             anon_vma =3D folio_get_anon_vma(src);

   4   1485  mm/migrate.c <<unmap_and_move_huge_page>>
             anon_vma =3D folio_get_anon_vma(src);

   5   1354  mm/userfaultfd.c <<move_pages_pte>>
             src_anon_vma =3D folio_get_anon_vma(src_folio);

>
> Thanks,
>
> --
> Peter Xu
>

Thanks
barry

