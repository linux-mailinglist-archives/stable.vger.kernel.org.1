Return-Path: <stable+bounces-147981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C135CAC6DA7
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498581C0093D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480DC2AD22;
	Wed, 28 May 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaW5KfKM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449B28CF77
	for <stable@vger.kernel.org>; Wed, 28 May 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448907; cv=none; b=GrZzuzz4GtJVJcoR19JqIWfqPXB7n4ExPJiuKjV0RDy/UEKXtkKG35AQ/4CToyYQuFmYAwCzMFYl1fDadpwFpyc3bP+29Usqo1R6EJuIzzyrnpQLu+zdjNm/XJEzXlr8OhxpKoTC/R0RvNPHWkmIueU+e8ZYuM9BPAlQ71MHc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448907; c=relaxed/simple;
	bh=oftCGjGpACLgWjDfLsAyXAfYxlJ+xGu9uinKdgFYgsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vf8r9dhYTrCeu4F8jtHsohq+7C1wPYjAxkMKJi//7Cnb61TF+0583fiPEgBotePwCdpm0/mXdhW6zqOUFOFt6MeTTJ1faJNGgLz6HUH0QTienRtptms1X2nc9N7hB+fGzO6nbO+KQir3CxHuoOXmSWhlRHlc3O74+rkeHyczYqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SaW5KfKM; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso3678068276.0
        for <stable@vger.kernel.org>; Wed, 28 May 2025 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748448904; x=1749053704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oftCGjGpACLgWjDfLsAyXAfYxlJ+xGu9uinKdgFYgsQ=;
        b=SaW5KfKMU5iqNDyf1Ck5tVJ6aA4C2qc8B6kDtVSqWhRfO0yrI30RlNaU7XxBH6ImVH
         ocqLYMS3DEHv0Uv8ewSNkaN8X5zCRtxe8yxHIrtwPNIlrRHWJsvHutujKcjXdYTHur6b
         HeZhdwqF71RlsixpiKycpzY/7vaQpZ2rwW0Fp4KPSLAT96sJ8Au/IaQoTALo3SFbbDmh
         tWvyCKXVCPBfWU6r+SPVpYdf7udeglG5hK4y8bhMTp5/ecyFDmJ+JtSDM8S6dplBuYSZ
         B//JB5TJLZxRIIY7a6BjTfoj2xc0/BW/KpRoYyLfsQBiZsYhY/wemUY14wdhrGGTd/cj
         R+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748448904; x=1749053704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oftCGjGpACLgWjDfLsAyXAfYxlJ+xGu9uinKdgFYgsQ=;
        b=vy9yUasJRbeDaGcn1Zb+MoTHG3OrOkBFfbgWgRgBYrJOsCTSbXNCBTmvc6gtzLxZwS
         SO5uByPbSrIlwyMfgXh0rYqYBTCi3JNqUUVAInazgS/ROGZR9HAjc9bW9h3rRZKgED+F
         bOP+i0+ozYoPUULDlDL+pyiA9NQY7l+BNj4vvP8U1do5evWDM+HeL6Z9fFz7mOLPkItK
         dB1C9wXydmvEnD6ZPs35qc8xoCLWAcSHipFT+budb/0m0g2CJ9CQY7NX0U7sw+6JWUyz
         R77YQOzQwvB8W8rYqHXOY7w3BoukuinZwB/a+4jXRPhIXx7toUpZQGmyRqWttfdIWcY5
         2zKw==
X-Forwarded-Encrypted: i=1; AJvYcCX2DU+65QTnlF0kApC685q/p+V1aptRJ5rE3l6wIjcfItfxiWNY47XIRUTKFaC/empGkhDtk/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9s7N90yh1V5LtpimtEl+ixG9O6D7PWoIwSn4TFr36cF/95L3I
	r0A6WKqlkQdPgSmL4yX97iG1Fo5g5Ij1cCFVXVgExamxkKAKn4viotf9muGXjMvQrkYPg2JcMVQ
	w1jashK7N8TQP7dpyFs9os/RJAjCkly5O5LxluV0L
X-Gm-Gg: ASbGncsHe8d3MIBUMF/Q+wul92DjCV6Gdr06tiSGxIyZgke82d3d9PwYIixR0eTFPD2
	JlXZNdLeiHWU6r5xfmMqITHYzzmQYNsX3+4EcqNJ3SyGhbAvlmC1Mqgmpq4zvdRz18rIyuhkSQ8
	b/o52Mz5/M/z+/B0Zzl8g1ORxavHk3OOJ9VBuGORHtinxApj0qEMnmT1tEioAhJYa7Y8eodponr
	yCCGg==
X-Google-Smtp-Source: AGHT+IFwW0/MrySaPT+ucgIg1dChgPDCXdJtXWgrMY95UPokdViJg0CdZ9UXjyC8CVjk5twtVkLrVgdpew1P2vJKaig=
X-Received: by 2002:a05:6902:1b8a:b0:e7d:c87a:6249 with SMTP id
 3f1490d57ef6-e7dc87a6957mr7030815276.36.1748448903884; Wed, 28 May 2025
 09:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528023326.3499204-1-gavinguo@igalia.com> <aDbXEnqnpDnAx4Mw@localhost.localdomain>
 <aDcl2YM5wX-MwzbM@x1.local> <629bb87e-c493-4069-866c-20e02c14ddcc@redhat.com> <aDcvplLNH0nGsLD1@localhost.localdomain>
In-Reply-To: <aDcvplLNH0nGsLD1@localhost.localdomain>
From: James Houghton <jthoughton@google.com>
Date: Wed, 28 May 2025 12:14:28 -0400
X-Gm-Features: AX0GCFtQ3Y_TJAz9gxU-mydw8Rp4n4FQFwD-d7vMDgv4nmmNrG0P_Nb3Fcuv7Sk
Message-ID: <CADrL8HXD0hX+5WvtZWKXAr0NvfvOJZhqL9PVBawYQuAyzhGgYg@mail.gmail.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and hugetlb_fault_mutex_table
To: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, Gavin Guo <gavinguo@igalia.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, kernel-dev@igalia.com, 
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:45=E2=80=AFAM Oscar Salvador <osalvador@suse.de>=
 wrote:
>
> On Wed, May 28, 2025 at 05:09:26PM +0200, David Hildenbrand wrote:
> > On 28.05.25 17:03, Peter Xu wrote:
> > > So I'm not 100% sure we need the folio lock even for copy; IIUC a ref=
count
> > > would be enough?
> >
> > The introducing patches seem to talk about blocking concurrent migratio=
n /
> > rmap walks.
>
> I thought the main reason was because PageLock protects us against writes=
,
> so when copying (in case of copying the underlying file), we want the
> file to be stable throughout the copy?
>
> > Maybe also concurrent fallocate(PUNCH_HOLE) is a problem regarding
> > reservations? Not sure ...
>
> fallocate()->hugetlb_vmdelete_list() tries to grab the vma in write-mode,
> and hugetlb_wp() grabs the lock in read-mode, so we should be covered?
>
> Also, hugetlbfs_punch_hole()->remove_inode_hugepages() will try to grab t=
he mutex.
>
> The only fishy thing I see is hugetlbfs_zero_partial_page().
>
> But that is for old_page, and as I said, I thought main reason was to
> protect us against writes during the copy.
>
> > For 2) I am also not sure if we need need the pagecache folio locked; I
> > doubt it ... but this code is not the easiest to follow.
>
> I have been staring at that code and thinking about potential scenarios
> for a few days now, and I cannot convice myself that we need
> pagecache_folio's lock when pagecache_folio !=3D old_folio because as a
> matter of fact I cannot think of anything it protects us against.

Hi Oscar,

Have you thought about the UFFDIO_CONTINUE case (hugetlb_mfill_atomic_pte()=
)?

I'm slightly concerned that, if you aren't holding pagecache_folio's
lock, there might be issues where hugetlb_mfill_atomic_pte() proceeds
to map a hugetlb page that it is not supposed to. (For example, if the
fault handler does not generally hold pagecache_folio's lock,
hugetlb_mfill_atomic_pte() will see a page in the pagecache and map
it, even though it may not have been zeroed yet.)

I haven't had enough time to fully think through this case, but just
want to make sure it has been considered.

Thanks!

> I plan to rework this in a more sane way, or at least less offusctaed, an=
d then
> Galvin can fire his syzkaller to check whether we are good.
>
> --
> Oscar Salvador
> SUSE Labs
>

