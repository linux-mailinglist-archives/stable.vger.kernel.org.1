Return-Path: <stable+bounces-83125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB4B995D63
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 03:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38341F245F0
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907592C190;
	Wed,  9 Oct 2024 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gv+rNex6"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A73D9E
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438433; cv=none; b=PboJKVrK1QhwrUteJdurht/HncldXdKen0H7TL89xoTJ0yWzoiQPsk/2p+bzxOA7IaYfONZqjoDflKK4WCuwmQ4w/1pmRy6t29gVbP93Q5UKea2iA2ITMBKrF8xPzEuCCwbLDpoivcnQar/inWQiuLsPnLpH5hko8LDyw6YVBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438433; c=relaxed/simple;
	bh=VBm0hfq2DcbVBzfR35/h5cOzEtSAYZKed8pK56bnJXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+NXe7jjrj8HljB/GH8vfb59oyi5NFXJMg43mVLSOqnIXoK2s8AllN/oUcXXopDpKx6eeMP13lKI1Osf4FGsZ69Jk/B759BT/BMTPxLYPfbFYQBBXh/4v0m6q+zmtfFdTwZLGeD0Mpk6W12FEFunj9aqiJ9/k2H/0Vkm7s29uyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=gv+rNex6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2fef23839so21977077b3.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1728438430; x=1729043230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBm0hfq2DcbVBzfR35/h5cOzEtSAYZKed8pK56bnJXg=;
        b=gv+rNex6TPTa/CWnYUNJH32Yi7FjIQgIJd6oEYrKf/6+Aa62FVEhBsNxTzaES+BtD2
         cviJFixIqL5oe/TcCYR2NQ7NAv4Ud/PjzhICE54nc/RAcU9jXdRxI8H9A8lQPNX4YLkd
         clJyh7rAyX+qG0E31wfWXqckwCtkX71HgjIx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728438430; x=1729043230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBm0hfq2DcbVBzfR35/h5cOzEtSAYZKed8pK56bnJXg=;
        b=ejaUeyhAVVqpenyJuhynVkmRE+hmQIl544U7xisH9B9ch0ThTqbKRyIUWjqlGv1D3N
         MTqw8XpAOJhCpKWL8zs9xrxXQZQQhyINzd+PBs7c3nQq8V3881KBABvz/vx0B3tmL2XU
         sYgcmWrNquWUoft8BMyjyF0yQMEUiinzk/D2LJIJnJgMCt1MfFI7f9N3OfipfCrO0Lw5
         GBcrtxahxREyLlUoWccsXiJ9OhNuLIo359IDS6i2WtSaSCOtZpHrnUdiMLdisq8K4hJy
         rHI7Ha14dM533WHT3LpBOkvCICzdjipWX5haAiE7RN9Od9mjzqyo/xtgj+FRdKWmpJ0S
         hC2g==
X-Forwarded-Encrypted: i=1; AJvYcCX8fmfYCTzCHMZ+JEhJ4VTfJxCE3BaA5+IiRPzhl0eDMZHHNXajtv2u5aoZ6ie9Gs7vhxdahfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywse6Q3aQgcnSEEMC2SPbtBbr+K2+SbWQKkCrz0oH/pu9sqAjKo
	8+uTsgsmF20KpmMlkgD9gYPp3qZCOm2udOfNEMZG9VuUoQH6Faykj3urvRBKEExlaSmU2Z550if
	/8UjUVBLwlEPuAPqn8aO1nen6iboigdP4ArOa3LIkTSZR8aT0
X-Google-Smtp-Source: AGHT+IGpuyjOSuBdipJ6DMe3pkHIUBlBJLYPgayvZ5t0w/YPLCdD9uwweKmbCeluhi/jTwGh9EfTkRJrLji4HOdLVAo=
X-Received: by 2002:a05:690c:e0d:b0:699:7b60:d349 with SMTP id
 00721157ae682-6e32212b7e6mr10584667b3.11.1728438430556; Tue, 08 Oct 2024
 18:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
 <CAEXW_YSxcPJG8SrsrgXGQVOYOMwHRHMrEcB7Rp2ya0Zsn9ED1g@mail.gmail.com> <CAG48ez1ZMo0K0JU321vs0ovXXF2giMvVo14AxNDPzgpGMGZpDA@mail.gmail.com>
In-Reply-To: <CAG48ez1ZMo0K0JU321vs0ovXXF2giMvVo14AxNDPzgpGMGZpDA@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 8 Oct 2024 21:46:59 -0400
Message-ID: <CAEXW_YTC0zJwxrweOLxm-k6gL+AcxZfopHPrJgGOihNrOKFJ3g@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	willy@infradead.org, hughd@google.com, lorenzo.stoakes@oracle.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:50=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Oct 9, 2024 at 1:58=E2=80=AFAM Joel Fernandes <joel@joelfernandes=
.org> wrote:
> > On Mon, Oct 7, 2024 at 5:42=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > Not to overthink it, but do you have any insight into why copy_vma()
> > only requires the rmap lock under this condition?
> >
> > *need_rmap_locks =3D (new_vma->vm_pgoff <=3D vma->vm_pgoff);
> >
> > Could a collapse still occur when need_rmap_locks is false,
> > potentially triggering the bug you described? My assumption is no, but
> > I wanted to double-check.
>
> Ah, that code is a bit confusing. There are actually two circumstances
> under which we take rmap locks, and that condition only captures (part
> of) the first one:
>
> 1. when we might move PTEs against rmap traversal order (we need the
> lock so that concurrent rmap traversal can't miss the PTEs).

Ah ok, I see this mentioned in move_ptes(). Thanks for clarifying.

> 2. when we move page tables (otherwise concurrent rmap traversal could
> race with page table changes)

Ah ok, and these are the 4 call sites you mention below. Makes sense.

> If you look at the four callsites of move_pgt_entry(), you can see
> that its parameter "need_rmap_locks" sometimes comes from the caller's
> "need_rmap_locks" variable (in the HPAGE_PUD and HPAGE_PMD cases), but
> other times it is just hardcoded to true (in the NORMAL_PUD and
> NORMAL_PMD cases).
> So move_normal_pmd() always holds rmap locks.
> (This code would probably be a bit clearer if we moved the rmap
> locking into the helpers move_{normal,huge}_{pmd,pud} and got rid of
> the helper move_pgt_entry()...)

Thanks for clarifying, this makes a lot of sense now. So the
optimization is when we move ptes forward, we don't need the rmap lock
because the rmap code is cool with that due to traversal order. Ok.
And that definitely doesn't apply to move_normal_pmd() as you
mentioned I guess :).

> (Also, note that when undoing the PTE moves with the second
> move_page_tables() call, the "need_rmap_locks" parameter to
> move_page_tables() is hardcoded to true.)

Sure.

> > The patch looks good to me overall. I was also curious if
> > move_normal_pud() would require a similar change, though I=E2=80=99m in=
clined
> > to think that path doesn't lead to a bug.
>
> Yeah, there is no path that would remove PUD entries pointing to page
> tables through the rmap, that's a special PMD entry thing. (Well, at
> least not in non-hugetlb code, I haven't looked at hugetlb in a long
> time - but hugetlb has an entirely separate codepath for moving page
> tables, move_hugetlb_page_tables().)

Makes sense. TIL ;-)

thanks!

 - Joel

