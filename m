Return-Path: <stable+bounces-165152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D203B156CA
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 02:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118343B8457
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C21885A5;
	Wed, 30 Jul 2025 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVc1Ye7L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825C26AFB
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753837110; cv=none; b=GAXk3U+09HWjAsnI7AXRs6lIttO7OIZ/W0q4DjD40x/Z17aPB8JhH1JgwHw02ZDORCpdsAg+oYzxNjGSJ9j9DCZXwNdjEOrUGtXk0daKIW1v1G6mQdRoPgSIPacjfPsBvRmlWLbQ+eJeqQ/edDiOrKbiaeeCAAapoHydEd7GEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753837110; c=relaxed/simple;
	bh=8krCprYrUMdOZ3h034xFumycFTtvtQ8rNBxl0XROG6M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zx/EYp6yhhOGylEbcTJh/XLYiVf1tXlgSyMI/+7x12EbCtiIbS9gvv5BZZX3FIsxMK8SOR1D0teXGFF7/5KmhnCTsLpWhqkCJKhIZnnsu/8N7JZITg9fT2v2tyfQVXiB3OvmmvbP5535y0SqOOL16hbL2pY0G9t1VAFZWJVQpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVc1Ye7L; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24086faa5bcso3582185ad.0
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 17:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753837108; x=1754441908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BvzOHnKibLB3ltRouRfCtD2c5Lgi+zp48cQKPXu7/xE=;
        b=aVc1Ye7LBjhQvOM4uerN+DgUwFaQw9DTwyqp9kBgDkeAsaMv7K0b4Sksh8DWPPJJxz
         zVQuIsjWSiYsqlGXObYXiGi/r1e5iWileTW+B50c10TmmFD24yX4SU4T9+esEvbtrYHj
         tHzSITotoe3W+pHSiQBR6sKhYSm8INdu0G5IIKf0/DVxRilvUqXSf+p4+I3ZITJelMw0
         o5SIP/0CePZN3SmC19k7Je1e2hhrCLUzMIkn2UisZf8O0C9sP8qGKV0yDZziDbSNJWAf
         B76HQNt7I8ePF2T1UuBrZrVIcK0tphsrZBwNLsUYM9SvESPZIJHvwXVmeD8ofY5ztJys
         JCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753837108; x=1754441908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvzOHnKibLB3ltRouRfCtD2c5Lgi+zp48cQKPXu7/xE=;
        b=gVettFJov4Y9pXraAgwfICocD+EZUYId6/yvfywQhVR23hy91jFUjkmodDyGaXUOR4
         /N8/0SvlV3nKJkQ8x9JeoGpe/91I0EJitoEGnVsAtcOx7Wb1zpYLN75+ZzIwV9mDET7c
         Sgm5A9CyCmVJa3jmw+SNZiEDPDKczb0SE8VOEYvMVae6ZP2sgmdNwWtSgDZnwHPoB/+O
         rJiM+I2Xk0gXsWDIfZsjYHH2P7+MO/Rn1He5+gJH/pdmWPHNj5hulHJOdSxk/xfN9TSE
         oleO+7hHrlcVan+ei59mO28+r9fBoOCW1+vRTHo4h0MFbTz4RDnCMTJsD+0iF8dfzGSb
         hr9g==
X-Forwarded-Encrypted: i=1; AJvYcCWOFkF8qw2wcHiHfKJka9LjgeRPR5sKA/0njk/JV7lodE7/zwGoMkzaRFyo+E8miqpEbwTi9L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9yQls6rxH5R70QU8mtLQaMJcl2D1cwFod8fjgDLzEq9sJa/S
	a8Y92P6C60bjdfvVLbXrHyKuLWclgQOv0AXjxD+WMavRQ3ScFDeUdUruRN5W1Gs1XlH30sUPBtJ
	wNq5Uw7TcP3qOVFATtOz4mVchXt0hOIBfSz4yeQ==
X-Google-Smtp-Source: AGHT+IEE1T/Er3sKrygau3w97VIOA/QCJAiAB2wozTO9pbOU/DTR6qrzKjpzklTM5AEwRfki5E7dO/OqrMcPg2dtONxW4w==
X-Received: from pjbsz11.prod.google.com ([2002:a17:90b:2d4b:b0:315:b7f8:7ff])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f145:b0:240:721e:a406 with SMTP id d9443c01a7336-24096b06962mr15696795ad.35.1753837108130;
 Tue, 29 Jul 2025 17:58:28 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:58:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730005818.2793577-1-isaacmanjarres@google.com>
Subject: [PATCH 5.4.y 0/3] Backport series: "permit write-sealed memfd
 read-only shared mappings"
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Until kernel version 6.7, a write-sealed memfd could not be mapped as
shared and read-only. This was clearly a bug, and was not inline with
the description of F_SEAL_WRITE in the man page for fcntl()[1].

Lorenzo's series [2] fixed that issue and was merged in kernel version
6.7, but was not backported to older kernels. So, this issue is still
present on kernels 5.4, 5.10, 5.15, 6.1, and 6.6.

This series backports Lorenzo's series to the 5.4 kernel.

[1] https://man7.org/linux/man-pages/man2/fcntl.2.html
[2] https://lore.kernel.org/all/913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com/T/#m28fbfb0d5727e5693e54a7fb2e0c9ac30e95eca5

Lorenzo Stoakes (3):
  mm: drop the assumption that VM_SHARED always implies writable
  mm: update memfd seal write check to include F_SEAL_WRITE
  mm: perform the mapping_map_writable() check after call_mmap()

 fs/hugetlbfs/inode.c |  2 +-
 include/linux/fs.h   |  4 ++--
 include/linux/mm.h   | 26 +++++++++++++++++++-------
 kernel/fork.c        |  2 +-
 mm/filemap.c         |  2 +-
 mm/madvise.c         |  2 +-
 mm/mmap.c            | 26 ++++++++++++++++----------
 mm/shmem.c           |  2 +-
 8 files changed, 42 insertions(+), 24 deletions(-)

-- 
2.50.1.552.g942d659e1b-goog


