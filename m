Return-Path: <stable+bounces-165168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491EB1573D
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2793BA54F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D3198E9B;
	Wed, 30 Jul 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxeXwSL/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523484D13
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840423; cv=none; b=Zd6ifONV2kpSlMToRt6OAs1Mbm1IvqMf0jM3m6lOoINmj1kUek3dtrCDQHiJe2NEBGr4eanHpN2KdebVKjZps8i+E7NJ0BAiqA/bvZjdPd6kL2Ve5LuhWVN7zZnHhbEzg9mhLbNx69mz+Lsv3Ikl1ekhR5+LtVoLG9t1aBVmNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840423; c=relaxed/simple;
	bh=3WxHfj/Ljk5xIlrLQ3R7S8nAy5xEKlu2DWP45lbRVn0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qHC11xLbyhUv8IKXxrunX3dEJ1UsKNIG6ZRVWrzbmKwohz4dA9aJRk79PbjaDStTEkham7g3mdGTsNOItWSOQlRsRxfB3+T0ogZqBQ8N7tzpvgagHn7vq1dvD0Y5s5xuitCosPgGFTbVK6Htpie/KWgVZLuyDeFFaMTNW8l6N+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lxeXwSL/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7492da755a1so5589840b3a.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840421; x=1754445221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52DJuthZ1IDvEaSGkXEVyEYL3TZdVX9M5SuPe/Wwrpo=;
        b=lxeXwSL/ySGavRx+6DE8/Mm3NCA9+a3h+X2J4cuQ/zfedlXp0zUMABysdUbVwhKinM
         h0n4lICyNuVMgxfU34PWq3Ouvvy364QdoHU4L9+892+yOCJcIDlId21E1C/6QCDEPfmk
         WXvjqEaGHbrh2+Bn4r56F/L54q6mUIEV7pzOg5lANvu3VnkQLOPfKCmeyM0JXAyzcOpT
         Nl9sQ1wi8LkwLE+5hctw2IAiWTeqXvZRHoGqILzKnf0Y69Auj6kcH5utO4tRF3KUlko9
         hwyY9VGHzydJ5mGM/gkzOeF876WfBubgvoYvDNa7l4+8Ln4goxxCI2iEpt8srXV+BEDS
         3nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840421; x=1754445221;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52DJuthZ1IDvEaSGkXEVyEYL3TZdVX9M5SuPe/Wwrpo=;
        b=we8r81pPrCErO3clbICyzDJAkjY4Kp23bxxgyL4rxN920nccqB468KG+Mom2Ymnp3+
         rIZ+PBJ/t+kVckmvfn9A4466pZzCmZgaBMyC3euLe5jhjK/U8xVmeuQ46+UVdgeCMt4N
         TxnWFzW3FI6+X7MjgV97AEBgd/K3ICvJ4QjbE4UBuxHo/eFk+vlvxVWtbfB/DMVZvCtD
         08jVVobibLgMfcnPFVCQgrQtVTkdbbQ7/l6jZ3z8DwI1EFbvyyoLStQwNuSesYuZlwoR
         1pMW9sg2rYki/EIucFyd/+k4HfhB4ZRkCStQ3DL3sAMEeFza1tNlF0WtQ8tO+EXnLr9W
         kdrg==
X-Forwarded-Encrypted: i=1; AJvYcCVKsGJXBYhKHbyjjj3XnwgUChYJPt+mZkkP8ndjHPuzI0UZV5hohwAvUYt2PzXmM4ozamhWbS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyV+V+jrpFV4oWq8PD8yVgwQieQ5AGztYMtaa40TBzzT2Nq+bb
	8C5Ce/JOh/KgKtJYecfYPWjpb2dWP5VDfrjZKWvM4ZXtMWbjlAEl9/BfJH2Ac4admEpq85D3eWh
	uHy6sx07VyluwjccVJijKDAW0oB/BH1OAqXPXZg==
X-Google-Smtp-Source: AGHT+IFfLPh0BJ9ZwU2wV31nJ5OHWq2GsvdIF3nrI5nAZddzJ2/3tabHuX/TzTSU8Bdem/b+gF39rs5Lfto01JVimcm/WA==
X-Received: from pfbg18.prod.google.com ([2002:a05:6a00:ae12:b0:748:ec4d:30ec])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a95:b0:74e:aa6f:eae1 with SMTP id d2e1a72fcca58-76ab293882dmr2178661b3a.14.1753840420819;
 Tue, 29 Jul 2025 18:53:40 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:53:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015337.31730-1-isaacmanjarres@google.com>
Subject: [PATCH 5.15.y 0/4] Backport series: "permit write-sealed memfd
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
 include/linux/mm.h                         | 80 +++++++++++++++-------
 kernel/fork.c                              |  2 +-
 mm/filemap.c                               |  2 +-
 mm/madvise.c                               |  2 +-
 mm/memfd.c                                 |  2 +-
 mm/mmap.c                                  | 10 ++-
 mm/shmem.c                                 |  2 +-
 tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++
 11 files changed, 129 insertions(+), 34 deletions(-)

-- 
2.50.1.552.g942d659e1b-goog


