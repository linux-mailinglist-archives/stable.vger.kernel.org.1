Return-Path: <stable+bounces-165163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E332AB15730
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117284E6842
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D019E806;
	Wed, 30 Jul 2025 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVe+dQo7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562172610
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840373; cv=none; b=EuJsaCsSyma2qm8ntbsCvEk9ED2S7DGs+bLuCDBLQhy5fCCYU3lQ+AfvYt1xZVihJMSTMhMjtapLw3r4nixxD7eky83plI3vPDT92pjmKrtBLmVkABnBUTQyDdvB2L23B57CYJIAjaHrW3TMw740gU+tHJH1TOLD4grRASfJKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840373; c=relaxed/simple;
	bh=MFAb+2aknwQ+BUxA4x7uUkT4WSBzNA7W1/F4JB2sANQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RydTmlhmThJsH1iDr59TtWbLL+VqA77qXH0JDebqpqmRjl4X2HQSNSWBLaP7NFK0IXwZoikC9pCr2Mzgla8Jg+oQujFqVzbWuaybfeFGk327QRiBa6WBNzh23RaHvR6ATWc8sxTme7DbdLD5pMGmN8uX+3QpYmBp0KjDwtVKCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVe+dQo7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00e4358a34so4256100a12.0
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840371; x=1754445171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pZbKZno4o5NbyA2p7HuJpqvvJhuZbFTfts+n5dR9Hz0=;
        b=dVe+dQo7c6JVQF15Re1xspjY5zyMXH6VPbTuayhZUTBt9Ftc4CgGObnN4WMim5hYo0
         WZ+whP8uqI9zKSILJIyejoLwtS0SmjbuzsT5eB+u+ZxAVKnuUG3CvE5yN1FcOiQ658Bw
         48CSxeaSXJFIg3ZofwzLt/TNyKhICMKDbJHGNJM4ipbStptMDY1EWsfq3YVagbYdaT8d
         Er4swi6OEZ81AdJ3VZq05otSXW2oXJoONToK4qGSDCrKdAqz6bdHojb5tkloBQ9lCqtL
         M9DyYM/+CyQg1qkXPpHt9/teiKmruCjqN9McM2vKauGO0IzCGoYGhWMRuKg2MiLOI+ys
         7mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840371; x=1754445171;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZbKZno4o5NbyA2p7HuJpqvvJhuZbFTfts+n5dR9Hz0=;
        b=k7QwLQjomyNdKne7DTzVUt/AnIgGAC/sPSRgbv/3DelSQHln+kOt4MKF9p5fP6w93G
         /pmGycB4T1P27foDmt59n+Ama9kQNh9wTqx1qeZ7zGaI4+8AHVtcL4SH7Ey4ambKjIrF
         KpMvahWIsJk2S1E411iM6Ys81DV3mHdwj7KA5jI8DWD4IUP8lgaZ9fzpxcBUvd266tn+
         q0e8F7b/uq+1nj84gX+xaSeqfPk373oezL7N2+TqGrfJCQ2J40S23PIIRwQ1Uq8PC3ai
         RP3I/LNhoTjy2p4BwouLmVt0/gK5l2QBolBzeE3rk42xzi2wEv2mtqD+TUKS+X3FGsNV
         NORQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+h0ZiSbNWuXOEyseE8ILn/vCoflLfO9RqSBtZB4jf6A1GUQuFy09YX/Opdhekv5eD/U9BV5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+BH9UJfRV0dUm+34eJdJxsp6uO8aHNuUBFgjS+e435UAbFBX
	CTxTfPGtuj5qBMw+rx+XB3CRFstMQXlS1EoftpYn0hkJ6gmnauxBSChA6/3LKWVjOSJEYBIQbsN
	L/jQ7ciduidU1n7z8RJZEvvm6auKMvSu/uTGoAg==
X-Google-Smtp-Source: AGHT+IEd7dDHZLpHhcy32wpr7AZ0Gk4ISxRe335Sw3lHZ6ibmDUOXKQVck1Ba2RfqJ7+lq1gBE0gwhQXO8GRP8cWiJdRlg==
X-Received: from pjbsr13.prod.google.com ([2002:a17:90b:4e8d:b0:311:d79d:e432])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ccd0:b0:240:3c62:6194 with SMTP id d9443c01a7336-24096b053acmr17131765ad.20.1753840371409;
 Tue, 29 Jul 2025 18:52:51 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:52:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015247.30827-1-isaacmanjarres@google.com>
Subject: [PATCH 6.1.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org
Cc: aliceryhl@google.com, surenb@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

Until kernel version 6.7, a write-sealed memfd could not be mapped as
shared and read-only. This was clearly a bug, and was not inline with
the description of F_SEAL_WRITE in the man page for fcntl()[1].

Lorenzo's series [2] fixed that issue and was merged in kernel version
6.7, but was not backported to older kernels. So, this issue is still
present on kernels 5.4, 5.10, 5.15, 6.1, and 6.6.

This series consists of backports of two of Lorenzo's series [2] and
[3].

Note: for [2], I dropped the last patch in that series, since it
wouldn't make sense to apply it due to [4] being part of this tree. In
lieu of that, I backported [3] to ultimately allow write-sealed memfds
to be mapped as read-only.

[1] https://man7.org/linux/man-pages/man2/fcntl.2.html
[2] https://lore.kernel.org/all/913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com/T/#m28fbfb0d5727e5693e54a7fb2e0c9ac30e95eca5
[3] https://lkml.kernel.org/r/99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com
[4] https://lore.kernel.org/all/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com/T/#u

Lorenzo Stoakes (4):
  mm: drop the assumption that VM_SHARED always implies writable
  mm: update memfd seal write check to include F_SEAL_WRITE
  mm: reinstate ability to map write-sealed memfd mappings read-only
  selftests/memfd: add test for mapping write-sealed memfd read-only

 fs/hugetlbfs/inode.c                       |  2 +-
 include/linux/fs.h                         |  4 +-
 include/linux/memfd.h                      | 14 ++++
 include/linux/mm.h                         | 82 +++++++++++++++-------
 kernel/fork.c                              |  2 +-
 mm/filemap.c                               |  2 +-
 mm/madvise.c                               |  2 +-
 mm/memfd.c                                 |  2 +-
 mm/mmap.c                                  | 12 ++--
 mm/shmem.c                                 |  2 +-
 tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++
 11 files changed, 131 insertions(+), 36 deletions(-)

-- 
2.50.1.552.g942d659e1b-goog


