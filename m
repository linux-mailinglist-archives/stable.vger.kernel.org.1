Return-Path: <stable+bounces-119398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D086A42A51
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9116C3A7D15
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1F263F3A;
	Mon, 24 Feb 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUV80sJW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F82561D8
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419436; cv=none; b=DbF78ZfzkmnI6NISx9CvAgZeUiST+HllHungKcrp0LdGirgwWLyuYhQPaNp27tGSSlpUemlaFCLHtr3P2cwMX3HnTJ8RTgPR2M6Dzl1kfDxcLN/Vg8Ln1Kk/fDHRVs/gVLelcQyCbo6Gq2uW4dkCPq95y/bN2/+N8bS2CeZvmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419436; c=relaxed/simple;
	bh=0iNOKWVOBUDsEBvVYzuviMG4d7wS1hRNYwHdQNs02AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPOctZVzgf5I7I1TrKImkCCcYZaDHyu8cTb63GuJzW4rKPuXkJ+n8LjE0/wtwAPNYzuCL1G3kPjVoQYUk5ctwVDLfFyW7TOgsegkyuV3gFUrwukAVgtY69pU91fNC4E3F5s1SOdpqNrWJNgBrtbd1qH3FBIC449LbZFtijoK1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUV80sJW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740419434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h33/ibReAMPF5jXPXEdEGWkt5jot1xq8doKW9lgfJGw=;
	b=dUV80sJW6ApntcupaMgR6WLnA7UFbWg45L+PkE+5NWUSX18d1p7O3c8DT+ep0bk7aczJr1
	bzcTXPDUnCsl6zhVhQdvVr+tMjqFXGvN5D2MjbhFFzrl8HUzeYMKqpcDIzSFdOgsj6Y5YF
	JiozKtzpzbnm9tcQZOdCf4/HpjQ6Ibo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-CKSHqaHZOy6apzWyRBiZGQ-1; Mon, 24 Feb 2025 12:50:32 -0500
X-MC-Unique: CKSHqaHZOy6apzWyRBiZGQ-1
X-Mimecast-MFC-AGG-ID: CKSHqaHZOy6apzWyRBiZGQ_1740419432
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0b22036e1so945408585a.1
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 09:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419432; x=1741024232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h33/ibReAMPF5jXPXEdEGWkt5jot1xq8doKW9lgfJGw=;
        b=O4N1H+SZIrAd5gtJ9zvYqUq/pT/mYO5Eotq6RjyKqGxdyzcwNH6MGw9Ql0q3gNdVAt
         tmePOCHwlwa1cXWuNH0av+H1UZBT/t6QEiQ6+AI9GmVSlQe6cIh1fnGhPBNgkaQGB9Ti
         FNlQXFpNHDaFzdPdaM0MUyr8Voy9KpvN1MYoIsLStbEHUlKUQ/LOM7b/sF7AHhq0y4dT
         7m+nakJQ/vv+8zEiBOpJkV83aNBdbe1S6axxXt05uVRzwSy+SC4PftLczp5QBCOWuX7k
         rtEerD+R2zAsOgxEF+bh2mLhrEjAXTA86OcWk98Xez5/nUWT6Cq72Ssz900qepUm0svy
         B6xg==
X-Forwarded-Encrypted: i=1; AJvYcCVuLjaFFoQSALQaUemQJPV6uWmk9FJ/x9XOuzCq4NA5VkZ9be6iQFpd96asaFnlU1JgSpuFTng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCFSOPNokEm6QsKEeW1C5wF1n16XWSCZIhSwFxLQylRYPPRIf
	W+Ev6kP4PmYNXnQYvFkuoKdBpvuQnxpFhJBGKA9CMrCfX6fvHCA+xGR7GMBAPpiUJ+HUNroOIHP
	jzPTer6ljKpj1Skfu/WS9nss5nG+Q/rrc6upg3eEF2tRmEQcopuGgyg==
X-Gm-Gg: ASbGnctrIXwPEuHzyVfVN5a3AcodANZPn+BFPOZVZ4r+HlNBP2l6C2KB9Lj3p1Eh036
	jz4Bs8t2CaMkVjU8kaRkCL8mOOGNtHVb20gKRQK2sET+JlfIfTlgDtVNPTug8bjmqd2UiWoMNb+
	gfQJVCpA2bUCTNOHVaw4P1fp7HtIUpCqJh1MYFYFfc1wPUu7+Yf7R/JstjtSjVRYYT/T/yAXCj1
	bEL2rrz2UJi7SpcxzFmSnFg6YjstkWVEtZ4ufF83sYJtHx1XYsH1RyxMwQUe0mTE5ThDw==
X-Received: by 2002:a05:620a:294f:b0:7c0:a264:4de1 with SMTP id af79cd13be357-7c0c229b9b1mr2240431585a.24.1740419432081;
        Mon, 24 Feb 2025 09:50:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtId71DUG4ZeM+nkY5pFfCprYMqXckLHG+4ltK2GU+vnkqGTA3w6mxJ4urvsp12Zr3dVEFbA==
X-Received: by 2002:a05:620a:294f:b0:7c0:a264:4de1 with SMTP id af79cd13be357-7c0c229b9b1mr2240426285a.24.1740419431656;
        Mon, 24 Feb 2025 09:50:31 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a3dcda55sm967097385a.58.2025.02.24.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:50:30 -0800 (PST)
Date: Mon, 24 Feb 2025 12:50:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: david@redhat.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	bgeffon@google.com, brauner@kernel.org, hughd@google.com,
	jannh@google.com, kaleshsingh@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com,
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org,
	surenb@google.com, v-songbaohua@oppo.com, viro@zeniv.linux.org.uk,
	willy@infradead.org, zhangpeng362@huawei.com,
	zhengtangquan@oppo.com, yuzhao@google.com, stable@vger.kernel.org
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z7yxY3wkcjg_m-x4@x1.local>
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com>
 <Z7e7iYNvGweeGsRU@x1.local>
 <CAGsJ_4zXMj3hxazV1R-e9kCi_q-UDyYDhU6onWQRtRNgEEV3rw@mail.gmail.com>
 <Z7fbom4rxRu-NX81@x1.local>
 <CAGsJ_4xb_FoH+3DgRvV7OkkbZqZKiubntPtR25mqiHQ7PLVaNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xb_FoH+3DgRvV7OkkbZqZKiubntPtR25mqiHQ7PLVaNQ@mail.gmail.com>

On Sun, Feb 23, 2025 at 10:31:37AM +1300, Barry Song wrote:
> On Fri, Feb 21, 2025 at 2:49 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 01:07:24PM +1300, Barry Song wrote:
> > > On Fri, Feb 21, 2025 at 12:32 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 10:21:01PM +1300, Barry Song wrote:
> > > > > 2. src_anon_vma and its lock – swapcache doesn’t require it（folio is not mapped）
> > > >
> > > > Could you help explain what guarantees the rmap walk not happen on a
> > > > swapcache page?
> > > >
> > > > I'm not familiar with this path, though at least I see damon can start a
> > > > rmap walk on PageAnon almost with no locking..  some explanations would be
> > > > appreciated.
> > >
> > > I am observing the following in folio_referenced(), which the anon_vma lock
> > > was originally intended to protect.
> > >
> > >         if (!pra.mapcount)
> > >                 return 0;
> > >
> > > I assume all other rmap walks should do the same?
> >
> > Yes normally there'll be a folio_mapcount() check, however..
> >
> > >
> > > int folio_referenced(struct folio *folio, int is_locked,
> > >                      struct mem_cgroup *memcg, unsigned long *vm_flags)
> > > {
> > >
> > >         bool we_locked = false;
> > >         struct folio_referenced_arg pra = {
> > >                 .mapcount = folio_mapcount(folio),
> > >                 .memcg = memcg,
> > >         };
> > >
> > >         struct rmap_walk_control rwc = {
> > >                 .rmap_one = folio_referenced_one,
> > >                 .arg = (void *)&pra,
> > >                 .anon_lock = folio_lock_anon_vma_read,
> > >                 .try_lock = true,
> > >                 .invalid_vma = invalid_folio_referenced_vma,
> > >         };
> > >
> > >         *vm_flags = 0;
> > >         if (!pra.mapcount)
> > >                 return 0;
> > >         ...
> > > }
> > >
> > > By the way, since the folio has been under reclamation in this case and
> > > isn't in the lru, this should also prevent the rmap walk, right?
> >
> > .. I'm not sure whether it's always working.
> >
> > The thing is anon doesn't even require folio lock held during (1) checking
> > mapcount and (2) doing the rmap walk, in all similar cases as above.  I see
> > nothing blocks it from a concurrent thread zapping that last mapcount:
> >
> >                thread 1                         thread 2
> >                --------                         --------
> >         [whatever scanner]
> >            check folio_mapcount(), non-zero
> >                                                 zap the last map.. then mapcount==0
> >            rmap_walk()
> >
> > Not sure if I missed something.
> >
> > The other thing is IIUC swapcache page can also have chance to be faulted
> > in but only if a read not write.  I actually had a feeling that your
> > reproducer triggered that exact path, causing a read swap in, reusing the
> > swapcache page, and hit the sanity check there somehow (even as mentioned
> > in the other reply, I don't yet know why the 1st check didn't seem to
> > work.. as we do check folio->index twice..).
> >
> > Said that, I'm not sure if above concern will happen in this specific case,
> > as UIFFDIO_MOVE is pretty special, that we check exclusive bit first in swp
> > entry so we know it's definitely not mapped elsewhere, meanwhile if we hold
> > pgtable lock so maybe it can't get mapped back.. it is just still tricky,
> > at least we do some dances all over releasing and retaking locks.
> >
> > We could either justify that's safe, or maybe still ok and simpler if we
> > could take anon_vma write lock, making sure nobody will be able to read the
> > folio->index when it's prone to an update.
> 
> What prompted me to do the former is that folio_get_anon_vma() returns
> NULL for an unmapped folio. As for the latter, we need to carefully evaluate
> whether the change below is safe.
> 
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -505,7 +505,7 @@ struct anon_vma *folio_get_anon_vma(const struct
> folio *folio)
>         anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
>         if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
>                 goto out;
> 
> -       if (!folio_mapped(folio))
> +       if (!folio_mapped(folio) && !folio_test_swapcache(folio))
>                 goto out;
> 
>         anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
> @@ -521,7 +521,7 @@ struct anon_vma *folio_get_anon_vma(const struct
> folio *folio)
>          * SLAB_TYPESAFE_BY_RCU guarantees that - so the atomic_inc_not_zero()
>          * above cannot corrupt).
>          */

[1]

> 
> -       if (!folio_mapped(folio)) {
> +       if (!folio_mapped(folio) && !folio_test_swapcache(folio)) {
>                 rcu_read_unlock();
>                 put_anon_vma(anon_vma);
>                 return NULL;

Hmm, this let me go back read again on how we manage anon_vma lifespan,
then I just noticed this may not work.

See the comment right above [1], here's a full version:

	/*
	 * If this folio is still mapped, then its anon_vma cannot have been
	 * freed.  But if it has been unmapped, we have no security against the
	 * anon_vma structure being freed and reused (for another anon_vma:
	 * SLAB_TYPESAFE_BY_RCU guarantees that - so the atomic_inc_not_zero()
	 * above cannot corrupt).
	 */

So afaiu that means we pretty much very rely upon folio_mapped() check to
make sure anon_vma being valid at all that we fetched from folio->mapping,
not to mention the rmap walk later afterwards.

Then above diff in folio_get_anon_vma() should be problematic, as when
"folio_mapped()==false && folio_test_swapcache()==true", above change will
start to return anon_vma pointer even if the anon_vma could have been freed
and reused by other VMAs.

> 
> 
> The above change, combined with the change below, has also resolved the mTHP
> -EBUSY issue.
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e5718835a964..1ef991b5c225 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1333,6 +1333,7 @@ static int move_pages_pte(struct mm_struct *mm,
> pmd_t *dst_pmd, pmd_t *src_pmd,
>                 pte_unmap(&orig_src_pte);
>                 pte_unmap(&orig_dst_pte);
>                 src_pte = dst_pte = NULL;
> +               folio_wait_writeback(src_folio);
>                 err = split_folio(src_folio);
> 
>                 if (err)
>                         goto out;
> @@ -1343,7 +1344,7 @@ static int move_pages_pte(struct mm_struct *mm,
> pmd_t *dst_pmd, pmd_t *src_pmd,
>                 goto retry;
>         }
> 
> -       if (!src_anon_vma && pte_present(orig_src_pte)) {
> +       if (!src_anon_vma) {
>                 /*
>                  * folio_referenced walks the anon_vma chain
>                  * without the folio lock. Serialize against it with
> 
> 
> split_folio() returns -EBUSY if the folio is under writeback or if
> folio_get_anon_vma() returns NULL.
> 
> I have no issues with the latter, provided the change in folio_get_anon_vma()
> is safe, as it also resolves the mTHP -EBUSY issue.
> 
> We need to carefully consider the five places where folio_get_anon_vma() is
> called, as this patch will also be backported to stable.
> 
>   1   2618  mm/huge_memory.c <<move_pages_huge_pmd>>
>              src_anon_vma = folio_get_anon_vma(src_folio);
> 
>    2   3765  mm/huge_memory.c <<__folio_split>>
>              anon_vma = folio_get_anon_vma(folio);
> 
>    3   1280  mm/migrate.c <<migrate_folio_unmap>>
>              anon_vma = folio_get_anon_vma(src);
> 
>    4   1485  mm/migrate.c <<unmap_and_move_huge_page>>
>              anon_vma = folio_get_anon_vma(src);
> 
>    5   1354  mm/userfaultfd.c <<move_pages_pte>>
>              src_anon_vma = folio_get_anon_vma(src_folio);

If my above understanding is correct, we may indeed need alternative plans.
Not sure whether others have thoughts, but two things I am thinking out
loud..

  - Justify rmap on the swap cache folio not possible: I think if
    folio_mapped() is required for any anon rmap walk (which I didn't
    notice previously..), and we know this is exclusive swap entry and
    keeps true (so nobody will be able to race and make the swapcache
    mapped during the whole process), maybe we are able to justify any rmap
    won't happen at all, because they should fail at folio_mapped() check.
    Then we update the folio->mapping & folio->index directly without
    anon_vma locking.  A rich comment would be helpful in this case..

  - I wonder if it's possible we free the swap cache if it's already
    writeback to backend storage and clean.  Then moving the swp entry
    alone looks safe when without the swapcache present.

Thanks,

-- 
Peter Xu


