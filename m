Return-Path: <stable+bounces-165173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2181EB15748
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F9D560EB1
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555FC1E1E19;
	Wed, 30 Jul 2025 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7YCGmwB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7931DDA31
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840453; cv=none; b=BAWjE9dsN+cmiwhIRW6E5HpXDuzJo9RI8LC5DGBfzZRweCVuLuqFw05FUbwkhvAnY0MShPnefOzD0gMin+7mycYfVJDzHv/RDlGJ6f6g4ZR2f/g/USVgYJDpymoeqVkf58xH5KxYr48eoUvkX+O8CE9He8LKgsl6GFP3zmWkpFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840453; c=relaxed/simple;
	bh=3WxHfj/Ljk5xIlrLQ3R7S8nAy5xEKlu2DWP45lbRVn0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lnqwm5NvVGNkYXSDu5VEey7SRrKHJzPuvJ9+qcbSVSiWOq0Wb8uulTw6aJi7khZWSI0Lv8OxKrQfVLjFjv/WDv2eEdPnaYosmPc7IoDKhVqrDGHumHOzh1uBCyja0loi8b39pvmt9nForyul6rgjLckoNRYaok1S9ihmteUD/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7YCGmwB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso11342849b3a.3
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840451; x=1754445251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52DJuthZ1IDvEaSGkXEVyEYL3TZdVX9M5SuPe/Wwrpo=;
        b=e7YCGmwB76hgQ/hfuMSH7jQ1S5o1WD0a9B5pOG3rOCmCKnf9QLtdyt/N+otG0fSmjG
         4PF1lU3ON4vyaOjgrPwhB54xXmu5lEvPIsmEnslbrG0Xw21s9YpBogBewbiD/Nagk7vm
         UFuaJ73hmBlDZELEN9Ohk5WCckV3YYnkcz688rZCYwem3Kw8lwiGLbeCLBZFzjClA7AI
         P+KpX43n8Z28hbq4t4G3LPzV6L7jnTshQxFBrbrmqBr1x1O3d4JRoRfs1dO+Kexl/+m4
         ve4314s2aGUPysNqYApKxZWXBbZK/tfiSH+urafpcf0zqiPuSYMLvKVEz6uGYs0fadkC
         usxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840451; x=1754445251;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52DJuthZ1IDvEaSGkXEVyEYL3TZdVX9M5SuPe/Wwrpo=;
        b=D5z9ETqct1VJLWiupr/eP8PpYas/Z8EdoN6ZY6Vt7P6XE/NDEHxne37uKGMYddNswA
         JW6nIz5aCF9faT64DMn8cOv32N+x3cJ2b7q9dmk7QyUeOBpc2LrXjyoAZhvX1J4FTA48
         r3PKRBWAPVHdw4MlzmFqiQjyXzMTdij9H+B3566IHw7RK2b/ybgQU4eYzBSIf4mqTot0
         oNGwSx/0MHY3ssBSnbzTN+2OcU1vVP7B6U/YRlPMI4dkaThNTVteH/UcQTCPhGaCes+E
         bhxxOOYdvjBrqAT0Mm2ckuX4MG95WRcbV/hoB2XThZuJdna6U62qy9GwPedrFXQ6Qwzq
         N7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGULUYs8rXmuBDjLCTj/WuU9xDq7jMQMJzK3ShDufeiZTEMyuVB6bM380s+P5LM3a3Z95f5tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcdd3yNpnfMlrXPJH+fFZWEM/yKM5MYKShiU/5FFtSmx+69UBC
	0li764iAapmonqFfmOAYXx10BZUsoWeeV/kFfAeKz82m7sY/2yGaXvbFo4zFUlBZNZtBt7tGHI5
	w6Yew98xmE8ikku2VAiaPVVBe3HGSXd9nwmOY0A==
X-Google-Smtp-Source: AGHT+IGLLaOgoxA27Xq5C2gkMJEIlVOXIlu5fvFed/ysm8bzg1hI+PANo84zHHeSCoJ7WrapFy4I7IMsOOKGwSKu+KE05g==
X-Received: from pfd1.prod.google.com ([2002:a05:6a00:a801:b0:747:7188:c30])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9998:b0:220:4750:1fb1 with SMTP id adf61e73a8af0-23dc0d0444emr2571064637.4.1753840450950;
 Tue, 29 Jul 2025 18:54:10 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:53:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015406.32569-1-isaacmanjarres@google.com>
Subject: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
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


