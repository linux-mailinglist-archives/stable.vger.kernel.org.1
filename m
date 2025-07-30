Return-Path: <stable+bounces-165158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3BB15725
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3285018A6D39
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9908BEE;
	Wed, 30 Jul 2025 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zbBpltgW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CCC84D13
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840337; cv=none; b=oExjwBRBK5xshlkmIHArOGiQQF0SPZ55ExtFd3Erd237F8syyzdJ2tndbjeOb1e8vgmy3gBZ0xD2AjnV4rtHvF0gwy6o2TefDZLPATH8sXB6k/iQuulo706dasgNQZeIkLXc0yPZSFasOwYppQsEyrXQJdz0DD4WyMLmrPhUko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840337; c=relaxed/simple;
	bh=MFAb+2aknwQ+BUxA4x7uUkT4WSBzNA7W1/F4JB2sANQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mIY8F/kNmkr4o46HAoALm8k2hNA0rIlKqQsW0yHf1WBdcSUDhRIwwIl5JEYlu7FuouOq1Gn55IV6wcaDD1XPK1FOx8sLJOeBeTMK9RgFKajEDWHgHkA3otWUXDG/3WScg1hBMbGykVChmi0wpO5kf/BaQSH9l0jVlv+4G8B8IH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zbBpltgW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ea14cc097so3289184a91.3
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840335; x=1754445135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pZbKZno4o5NbyA2p7HuJpqvvJhuZbFTfts+n5dR9Hz0=;
        b=zbBpltgWaKa0P/DJ0na8mPaQjWD79PTQpx5PUvboojMcmhVgU31j6mNW+47lHw3cgN
         gHAPIklckbR9yptoO1ydp849YkxKIDHRTJ/1wQ04eBPn8jvCMZEqTp9cNVptwdTuvmX0
         2zZwp7XQZnzedDQ2IWHX8lQsgc0KuaurhEUdxgz1hGfgpZMTeFMdWuOy1qMBI+fQNEjc
         mMAoFxWBBwMqpuw+blggfA9I9F24GzpKbOXlPugwukdqp2rHSCfa9h+vzsc+Q6GaH13N
         kgs1GP5ptBEW/joBKBrv5CeefWxUSpvqBglAZGvfg5z0zuK6yA+ATYEDJp8e3PP2/BWF
         U4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840335; x=1754445135;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZbKZno4o5NbyA2p7HuJpqvvJhuZbFTfts+n5dR9Hz0=;
        b=nZQvQzGu7gi/pI6Ni2R5j3v11mIGCebJNCcyqnsTZtWdkAFdQGuuMk4vw1HgkpvLOP
         xIOhBzAG1sASUmjkmIExdKMSOWR0yhUnLPqpDRBp4VI+bFfl/iBKgi29n2zkPyDs+6it
         OxssLt3xuUgkVe6w4k5k9Y7tBYijX0EwLQTGhCCqHf3g6EXQfkjUsnr1BQIIWLBIOX81
         zE+eHgwyMgyP7AdeUuMRd7JgoHuI+6wyUV17aV8SWsjj4b6IWxQ2hbg/KaHx4v0LA6/Z
         hqEai4wBnSBAvKJJ++Rw0fyMYWPpxn11o2H8/+cQUYcE1OtxtZBe6MFSYLwvfL6NIad8
         a5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVNJ2KDxnr8a+C8l5wv/QR7xdcxO7ntds6ukw5+Pet3N1pKDY2wbxqBlHZcSW6jI8O+cmYze8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDye2fsTHmE7cW1t0yX4i0g6NWX8DdLMmFp5V6GuLIqYSjEvlk
	03v8Kxd4J8g/2dQJp/k78KKW5iUEHELs4cxvnCp47jxnyRr2NSZnmVHEJBf+AdzrbhYSYWwzeMd
	MuU4TRoMq+Fcczu8sSCx7YFzPCcYs8ubgbVFaaA==
X-Google-Smtp-Source: AGHT+IEBqhTXyFrfwCpj/7NbPcuneHFHPgmfwfQDvXuLyG6VL+ZIZT1N7dHhjgYNnSZakdrulhatJ4cjs+Ipv+FbrqaZKw==
X-Received: from plgl6.prod.google.com ([2002:a17:902:f686:b0:240:25ce:3b7a])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:291:b0:23f:f68b:fa1d with SMTP id d9443c01a7336-24096b41b12mr19279155ad.39.1753840335093;
 Tue, 29 Jul 2025 18:52:15 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:51:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015152.29758-1-isaacmanjarres@google.com>
Subject: [PATCH 6.6.y 0/4] Backport series: "permit write-sealed memfd
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


