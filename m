Return-Path: <stable+bounces-165580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89CB1656E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B69170645
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD42DECD4;
	Wed, 30 Jul 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0TmPxl4P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB71DED42
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896243; cv=none; b=Y8iO5w0Al9GxKVIcgJEu03vdG1RqLRnwGxu8AtHctu7U/TsVCxMjOTsT5JCYjJSQmTO3agWOPwrmRXS81sdGg2b68hvqlIZ9MtCCfHhdoEl9RfeAraoCldZumrgN4L+7PsKcYyLwyPAAogBflKexKiWwpvYrg9C9CqmQzCVNe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896243; c=relaxed/simple;
	bh=ud9NI4UP1XUUxwZIxKxyCKzyc+dghyomDaE1P/Rbr10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMvyiZFPKVVKT164WbxNibFFRI4xXkZVGSSH1Ly5xUkU+xCYbUB9IOzsxEQnT3flPDBnAuDLuhPr1VuyP7uzz4NCxJ+iCO/EZ7Ltokdg/+I0ryJETxaTU5Y6SyBufr9kEbJdlHJKn7A+l950b3v1vSo1OwMzJcaNF6xITZKUDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0TmPxl4P; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24070ef9e2eso11255ad.0
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753896241; x=1754501041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABuL6sm2VhvfVKiWwwjxq9f1HfKCyucRnavU2SWMlvA=;
        b=0TmPxl4P+U0wD1kju8e8/xkz88mGbwwNLkz8r8r9KMU4lv9aUc8Jz6ocL7HFFxwrzl
         QHdZ8Rkw0ilWJOLeWuWTA116xaE2OsKcvajG+TIywBpK4l0P33oLtk775hFPu4XtGRpD
         rUCAuGXJW+pog9OoawMDv2ZlKK5dGj9VLEWDhQgTgTkQtG7NYtPLbavavjnyk0gzXE2W
         u5m7l2gJC2bLcK79hXaHwo4fmXQrcJxAc7zyHkXiGVc2trnHwpelb5QP3VS0wgPz7HfG
         s2KVdPSehOKfnO3f5urqGcReGQEIRIBAWYe3oaPTfs9ENQ9t8qw9v0qNfYoYJR1OTPPK
         ha7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896241; x=1754501041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABuL6sm2VhvfVKiWwwjxq9f1HfKCyucRnavU2SWMlvA=;
        b=tOVkqwIMX6pS9GrEtk3dfNUVh+B0S0pH2/TVYzK79c4ngi3OFzMJDkB1QxwtpGvA3z
         Apf/SjlfiDXrg7hxQ1bmuWez2kWKiBhAuCD80RViyw73AhMZoLe7UBoKnta/Oxg0cf4U
         d7FqXIx83z7b4nwLwK+LKXxo8Xgx8K9aEGWf9KdRIAG8CV5fQ5W0TUpTKecUqYBRiouo
         Zrww6aANnFoGStgYZ7k8csOY+C7vOfPgyok9UlmwgH2CTrEvw+UMdR+XrsZTQ6XFBQmg
         DOmoA0I/YJpAIZGt7wliQUaJxhEEa5ebq80Fc/UaKDhVE2EXmPqGsEL0uvt2c024wsNY
         iGRA==
X-Forwarded-Encrypted: i=1; AJvYcCXPIiAjJegkYtW19/St5sg3VWbc62sLqiLOXOlTaM+q1OTJlig8Nhl0qXj+TcuebvBmrMbBda8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzplFhffo+PVQLCVY2RJbeDrty6WP36IBmZQqprTipGiMuE3S
	f7GqJGQWCiqPZKMDpK9LkPqQii6E7InPXpuGI/W+vvf8B7C5pum/gWkRIXtNQHgmmIC4HBGx0Bz
	MZHNnvGH/ap4=
X-Gm-Gg: ASbGncsnyHVFuJ6VWrMsHuVR5LwKp/i/7Yl6aUg45EzkvbjJSo6UxmZBvmUX0lenWjt
	CXo6/UTezv7bDmJHAV0W9iwXlumhL0Zv97MspmiRC1nMOY65jSRA1bA0mIW66RQhjBO23HFTgG6
	LOS8rcoN1NGyc+bzwU8Vqe5eHAQirXx+n5Ww9cDAA644beDV95XdA+3YfJBhgeYOrKRNO/+oKyM
	8DV7Z1OWlo9r+sRKy9NEF9EUpaUG8sCYiSOIySzn53bSz7pGb2R5riECtjNL5p4+MeCUWZodqUV
	6sLlLAETEBD39nCh01Dnj4UGFNWz0q2hh6pm/NHfPjxBhOcE+25PlDmrEWXXuMTa6600gc9C+fI
	iASPMthC+NPvc48fTamYzx2P+xZvqkevnIAxZnC7ujHBy2I2UqKt55grXRhsmm4E=
X-Google-Smtp-Source: AGHT+IE0NCe9pOqFnrtuUQFzjr4ZUIiJ/4BybCGyi87RK6w/jlF/FLUocygkQGDkZEYhNJPoZYcHhg==
X-Received: by 2002:a17:902:e747:b0:235:f18f:291f with SMTP id d9443c01a7336-240ce62a3f4mr38425ad.23.1753896240640;
        Wed, 30 Jul 2025 10:24:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9606:2f93:add0:9255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24025f4a855sm75640695ad.127.2025.07.30.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:23:59 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:23:54 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: gregkh@linuxfoundation.org, aliceryhl@google.com, surenb@google.com,
	stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <aIpVKpqXmfuITxf-@google.com>
References: <20250730015406.32569-1-isaacmanjarres@google.com>
 <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>

On Wed, Jul 30, 2025 at 03:21:48PM +0100, Lorenzo Stoakes wrote:
> Hi Isaac,
> 
> Thanks very much for all your hard work on this!
> 
> I'll respond to this one, but this is a general comment for all the
> backports.
> 
> I just wonder if this is what backporting is for - really this is a new
> feature, yes the documentation is incorrect, which is why I made the
> change, but it's sort of debatable if that's a bug or a new feature.

Hi Lorenzo,

Thanks for your feedback on this. That's a good question. The rationale
that I had when backporting these fixes was: The original intent of
F_SEAL_WRITE was to just prevent any writes to region after it had
been write-sealed, and that the existing behavior on older kernels
may have been a result of oversight or just an accident, making it a
bug. So fixing it would be fixing a bug that has been around for a
while. I hadn't really thought of it as a new feature.

I also learned recently that, at least for Android, there were attempts
in the past to map write-sealed memfds as read-only and shared, which
failed. This was surprising to developers, and they ended up working
around it. I'm not sure why it wasn't reported then, but this being
a surprise to multiple developers makes it feel like more of a bug
to me on older kernels.

>
> Having said that, I'm not against you doing this, just wondering about
> that.
> 
> Also - what kind of testing have you do on these series?
I did the following tests:

1. I have a unit test that tries to map write-sealed memfds as
read-only and shared. I verified that this works for each kernel version
that this series is being applied to.

2. Android devices do use memfds as well, so I did try these patches out
on a device running each kernel version, and tried boot testing, using
several apps/games. I was looking for functional failures in these
scenarios but didn't encounter any.

Do you have any other recommendations of what I should test?

Thanks,
Isaac

> Cheers, Lorenzo
> 
> On Tue, Jul 29, 2025 at 06:53:58PM -0700, Isaac J. Manjarres wrote:
> > Hello,
> >
> > Until kernel version 6.7, a write-sealed memfd could not be mapped as
> > shared and read-only. This was clearly a bug, and was not inline with
> > the description of F_SEAL_WRITE in the man page for fcntl()[1].
> >
> > Lorenzo's series [2] fixed that issue and was merged in kernel version
> > 6.7, but was not backported to older kernels. So, this issue is still
> > present on kernels 5.4, 5.10, 5.15, 6.1, and 6.6.
> >
> > This series consists of backports of two of Lorenzo's series [2] and
> > [3].
> >
> > Note: for [2], I dropped the last patch in that series, since it
> > wouldn't make sense to apply it due to [4] being part of this tree. In
> > lieu of that, I backported [3] to ultimately allow write-sealed memfds
> > to be mapped as read-only.
> >
> > [1] https://man7.org/linux/man-pages/man2/fcntl.2.html
> > [2] https://lore.kernel.org/all/913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com/T/#m28fbfb0d5727e5693e54a7fb2e0c9ac30e95eca5
> > [3] https://lkml.kernel.org/r/99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com
> > [4] https://lore.kernel.org/all/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com/T/#u
> >
> > Lorenzo Stoakes (4):
> >   mm: drop the assumption that VM_SHARED always implies writable
> >   mm: update memfd seal write check to include F_SEAL_WRITE
> >   mm: reinstate ability to map write-sealed memfd mappings read-only
> >   selftests/memfd: add test for mapping write-sealed memfd read-only
> >
> >  fs/hugetlbfs/inode.c                       |  2 +-
> >  include/linux/fs.h                         |  4 +-
> >  include/linux/memfd.h                      | 14 ++++
> >  include/linux/mm.h                         | 80 +++++++++++++++-------
> >  kernel/fork.c                              |  2 +-
> >  mm/filemap.c                               |  2 +-
> >  mm/madvise.c                               |  2 +-
> >  mm/memfd.c                                 |  2 +-
> >  mm/mmap.c                                  | 10 ++-
> >  mm/shmem.c                                 |  2 +-
> >  tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++
> >  11 files changed, 129 insertions(+), 34 deletions(-)
> >
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

