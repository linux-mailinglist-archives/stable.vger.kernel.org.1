Return-Path: <stable+bounces-165745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E3B18382
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 16:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB6C1C8202E
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E52264D2;
	Fri,  1 Aug 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcZOvuzX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC24A1D
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057783; cv=none; b=bTzDY3W5md9YWf+uBhMTlAexeq8yoW6KNRISI0CkwY40ZgwKfwEhnaWL9STkDw8yaX+a0h7MJ4qhjyHBt9N20DwjcoWnJIiZ/UI0t7AUrEwTPGy/OFUZvn3dVoFEKVkLk24NuwXR1fXkyr7ktP+RZuYi24VzMCseCvezJ8B8Swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057783; c=relaxed/simple;
	bh=fkicVuLv0/RUgxzAMew1rsJVx1staOCi9qLzOdfW1T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVn/N4CWnhJULMbrh10wUEfNS99JrAZGsYfcply0u9P67h9Qh/2SEX8G9/40Xpd+4c/5c4FZq+AktTstEZOZa5DIxzOu7PAw8y07AI3X2lLPOxrbf80Z8/FWobqUQaOPqpUmb57ReKpKjkdxOg0t2J01w/3phIXPaq3caxQALGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcZOvuzX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754057780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxZ9pu4hPNnD/ub+/DxG4Ghav/BT/6VOf4b/nhk7vKQ=;
	b=GcZOvuzXi/tEtZXN43dvx2wjCeCidnrCZjwiXWICEgEMjNG58tIib4lWR7I5HK5LW081YZ
	kyTUrmgLPhLvmn48LM3YA0U16Za+2nDZBXtduk8dfe6tsGjzueHo6gnvlMxcZik4Pjqnxi
	JDZjHKYOmBDR8pHX3bEDDp8Vt5N5NUc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-sEs7DXUUMU-y4oWJ-Ychhw-1; Fri, 01 Aug 2025 10:16:19 -0400
X-MC-Unique: sEs7DXUUMU-y4oWJ-Ychhw-1
X-Mimecast-MFC-AGG-ID: sEs7DXUUMU-y4oWJ-Ychhw_1754057779
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71b6c56ca46so12999677b3.0
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 07:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057778; x=1754662578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxZ9pu4hPNnD/ub+/DxG4Ghav/BT/6VOf4b/nhk7vKQ=;
        b=wzKW2t/WK9exmzigiDCwau/j7kGGhtKOr/mnYonV3mzSWQZoKXQp0UAIMoiEPYZP3v
         oWhLznH2BcwaGKfjCaZxneI2mO1fa+FwOSzP8gTDZMHGX9B/dfKUafBhktIH4J65AJ9t
         Zq9ugC2dZdZSSwhgaW8WVfR1tDEC/jNynRsnhagRvpcmKLJgBb/+1oY4AGmQBsEoDScH
         pjD+qTc2o9HnBC70BWudx3r9I3e4UEaqXpA5itoKlB2K+xFefrYGEfAF+LkmGNXkfeAI
         G4odoIUE8lRA6lUcEGYW8RKdnXvHc2ZLI25Z9sJq4JeYKLmlzV/8BlflGPr4+0ocMW5G
         d19w==
X-Forwarded-Encrypted: i=1; AJvYcCXVe2mO1+TaZrmmAyQGa12T7/lx4P3opzK0M0rDkVSFrIWuLR8EO+j9G9Ank42QuDc6BGER9ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHnVnZYmNSqlDSfkrBmPwyZwgQwW5EgkIbcrngCp65TjRiqAv
	FQxS5M2ZN0rN2pcjVEio+CeDE+vlcsEIT/W1oTa2qNASZeIV0jSbn3P02nL8ODCGxpqx0hZUXz0
	Rs+9KMVbTseaQ2o761uudx4Uwpw/WccSEVBn/yi8i3eAMVP+4w2v96M/cGqlx709sOQ==
X-Gm-Gg: ASbGncuuAR73xtuuaiJgM0/fUd5hjegPFEGoEbveBJNz3/e6oU+/STNgVC4GyBgq/xf
	jNnFjZm9eEBmH1VONlYkxc7apdQEv4AIE31rctD7mBL5TZhUyDWBw/WgN1+Rich27gKPfqIfxyn
	3FhK/PP6f4WcHZPNwMIoGqE4pJH5fMP5giKalUu8NHSOc8ys7XUvTG6AVXoq1Z+1EAE2bEtDZbn
	9jyWLvdsbbCGBNdFFEcbIsWxYHlP/gBx0UhKI4fSYxoW5ntfR3oIVyufzvsYViGhRQ4xI+Ye2Tf
	LkaixYRaD+hyGCTvHo/BmOCvgLoLjCzg
X-Received: by 2002:a05:6902:72b:b0:e8f:c8ae:186c with SMTP id 3f1490d57ef6-e8fc8ae1efbmr11402546276.45.1754057778379;
        Fri, 01 Aug 2025 07:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0HREDaQfPbkGMZZI9Cdn9rppctb576Z8m/N9WTc3IgN7JerdXDwBFB53QUPtyMVn+vGbl1g==
X-Received: by 2002:a05:6214:494:b0:709:355d:6bbb with SMTP id 6a1803df08f44-709355d6d79mr522926d6.19.1754057766004;
        Fri, 01 Aug 2025 07:16:06 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca3621asm21820476d6.33.2025.08.01.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:16:05 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:15:54 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aIzMGlrR1SL5Y_Gp@x1.local>
References: <20250731154442.319568-1-surenb@google.com>
 <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>

On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> On 31.07.25 17:44, Suren Baghdasaryan wrote:
> 
> Hi!
> 
> Did you mean in you patch description:
> 
> "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> 
> Talking about THP holes is very very confusing.
> 
> > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > encounters a non-present THP, it fails to properly recognize an unmapped
> 
> You mean a "non-present PMD that is not a migration entry".
> 
> > hole and tries to access a non-existent folio, resulting in
> > a crash. Add a check to skip non-present THPs.
> 
> That makes sense. The code we have after this patch is rather complicated
> and hard to read.
> 
> > 
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes since v1 [1]
> > - Fixed step size calculation, per Lokesh Gidra
> > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > 
> > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > 
> >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> >   1 file changed, 29 insertions(+), 16 deletions(-)
> > 
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..b5af31c22731 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> >   		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> >   		if (ptl) {
> > -			/* Check if we can move the pmd without splitting it. */
> > -			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > -			    !pmd_none(dst_pmdval)) {
> > -				struct folio *folio = pmd_folio(*src_pmd);
> > +			if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {

[1]

> > +				/* Check if we can move the pmd without splitting it. */
> > +				if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > +				    !pmd_none(dst_pmdval)) {
> > +					if (pmd_present(*src_pmd)) {
> > +						struct folio *folio = pmd_folio(*src_pmd);
> > +
> > +						if (!folio || (!is_huge_zero_folio(folio) &&
> > +							       !PageAnonExclusive(&folio->page))) {
> > +							spin_unlock(ptl);
> > +							err = -EBUSY;
> > +							break;
> > +						}
> > +					}
> 
> ... in particular that. Is there some way to make this code simpler / easier
> to read? Like moving that whole last folio-check thingy into a helper?

One question might be relevant is, whether the check above [1] can be
dropped.

The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
before returning the ptl.  I didn't follow closely on the recent changes on
mm side on possible new pmd swap entries, if migration is the only possible
one then it looks like [1] can be avoided.

And it also looks applicable to also drop the "else" later, because in "if
(ptl)" it cannot hit pmd_none().

Thanks,

-- 
Peter Xu


