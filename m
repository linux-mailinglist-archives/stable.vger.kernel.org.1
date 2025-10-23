Return-Path: <stable+bounces-189160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5AC02D58
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7430A3ABEA8
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE643446A3;
	Thu, 23 Oct 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lykHND2z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABF236453
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242502; cv=none; b=B0aGdQh7o4728TV5wcGUIFAxqJevGhVvWnCkabO/lzaGDIa02qMXqm0YsRHHbq4KnGab75kTzqjoPpFbhGtRCGRwaqqcU8dPL1gbzZHfvyJfqQ/r5Qzc+iJW5+wgd4kDXwMT6GyjnRD6JW9Db1uYzFWBPyGs5myyXX+rC/Rsd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242502; c=relaxed/simple;
	bh=a4YFELyl3UTNxlSSCOM9DTPR9OQOU/m3i/VmvCHO7Qg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oIVqXQzEsJy9CP+FNKdA3Z8H2Gz9V+cFfdEZDFTMkqBTHG/833ZJVKxdO96BRS3HgQrTStZu3QkwA8DSWujjSBbzQ23TwkEYqVmNleJRXQnPNefrPHo4Uenr16r2Lb/HL/hZnH9yqgxWEptFuCx7K5hZweS77MaDCpIJa8AHgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lykHND2z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so1511145b3a.3
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761242500; x=1761847300; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOfpW2F0dLhMpb8zi4+tT7+zxDG4noiF/FBCYOCAu60=;
        b=lykHND2zY85yAxtfme94LboWPkNetwVUKyXaNeI8oODVqW79V9bTkH50KLLjHIIPDW
         wlpwC7TZrbvJvVBmCwnfHRsCyQyZNyhSV5wilh8cLE9Prr5yK7uOH4k1IOdhA9auW1qj
         5a3RR+kMdfG0Q/NX/AMsP8VhFJ7TtDQxrOZI5xb8w35bi3DbngQJKlx1Ob5Z15rPyNr5
         uIWyKJK+ACeHe2HWlCQXDSU/LjCJeHbUdHJk6RqtkfoBAokb2qsC6fh7ULSsBCFaO/JE
         QhAceGtqy0crDcTHpNT1Xfxbo5JChm3UFtkIzElSjxLSSU0jmDD17sqjfWL6DMIUly27
         IdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242500; x=1761847300;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOfpW2F0dLhMpb8zi4+tT7+zxDG4noiF/FBCYOCAu60=;
        b=aK2ZVi77tPZTWXQH34Z97buHUWUnlqjHBwhljtutu8FzYoouplFzcQAv6BLvshgALd
         C7Jt7wNoJu3PI4jnNQn7alxYGI31W5g39RqbLMjPFWbbTufPBmBS8kTvUDrL8ltXxbA4
         0+LrGavLcnISMGDrH1KTus4ZlOaZQLmUg1rxLoG+1JcCAtqUPw+1LiGdKnm+aAVVgRmX
         fzn0e64JzPPryIU/jJnQbFjFmyvMUUuo++07fwC9WsNGBLvHM8HMpNTfN0cvW2XoigiH
         Rhxn+SpQx3s/FNwH1bSZ8taG+y4M+iqDaMkGhxWqJ1a1ImYzLWkDZhT+tw7AIJvz2+0q
         oCig==
X-Forwarded-Encrypted: i=1; AJvYcCVONzSWhS8bjZrfY+M0ZJ/GHrlbZeBLFrwcKVxedAdF7XrnZNUd3RE+hAlvnA3AwKDJSTd6K80=@vger.kernel.org
X-Gm-Message-State: AOJu0YytwkmwqsMy30naGbcLMCACDvX4ZbXJxu10inOxOvvTDclcMEqm
	HOIMk9KQkxxZBSWymA0jNe8hvuZRRRL+i66ANw8YdMWk5R2qnlEkF157
X-Gm-Gg: ASbGncuU1YtC2ac8UkecJ0UskUN0v4raOZUQdZqHd08w35hZ1v5Gb5+hjMHWHXYk91v
	TGiENhDwAcg78YStHEIGHFvdinMNC/mSvBO6SSXa4UZIvTJoiwkKyUeY1IFzCEgUQ3+hkRfxB/c
	oGfZjKfmOaEX9xRoanv3p1BK4X0Zwhp6GfNqMQh98VriBKh8JN7YFsqj0gPPHvreJKBQSHIM4yR
	SWcNrN2HjKNbRBe56+9oSuYOcmQY7RvKZQTwMWqy0pDmOaQ0vuH30yGb6Al1usBAHCiwgQXqDv0
	s5Xs7TRGl5nfpuorSIEtLcI+Co9gW3DPfIVeknxv7o+6DjnU7YW19uIdGtn7i8yB3Z0Bzyd/KF2
	mmPhUk/0RHhSoIf4sSohXFV433j7YZQ0ue+nQNiLzBYaVuX9Bd8DaGPvtPx70o4LDCedhGKjhNH
	d5KnPseIXlrI84VObJ
X-Google-Smtp-Source: AGHT+IHIZOFsj/SegFVrNbdOjeH3WRgln2EKfh0ASZUCKq0ad8fJDrSau2Rt6XTQaNzq2A7iutDbkA==
X-Received: by 2002:a05:6a20:1611:b0:334:7e45:e69b with SMTP id adf61e73a8af0-334a85a552bmr30672459637.29.1761242499397;
        Thu, 23 Oct 2025 11:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm2734532a12.18.2025.10.23.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:01:38 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH v2 0/5] mm, swap: misc cleanup and bugfix
Date: Fri, 24 Oct 2025 02:00:38 +0800
Message-Id: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZt+mgC/42NSw7CIBQAr9K8tc9Af1RX3sN08YoPS1JpA6RqG
 u4u1gu4nFnMbBDYWw5wLjbwvNpgZ5ehPBSgR3J3RnvLDKUoGymEwvCkBfXE5JBMZP8TkYaJcZE
 4nEi1VcNcGYIcWTwb+9oH1z7zaEOc/Xv/rfJr/06vEgWqumsFm24gVV8iO80uHvX8gD6l9AGaQ
 0SPzgAAAA==
X-Change-ID: 20251007-swap-clean-after-swap-table-p1-b9a7635ee3fa
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 YoungJun Park <youngjun.park@lge.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.3

A few cleanups and a bugfix that are either suitable after the swap
table phase I or found during code review.

Patch 1 is a bugfix and needs to be included in the stable branch,
the rest have no behavior change.

---
Changes in v2:
- Update commit message for patch 1, it's a sub-optimal fix and a better
  fix can be done later. [ Chris Li ]
- Fix a lock balance issue in patch 1. [ YoungJun Park ]
- Add a trivial cleanup patch to remove an unused argument,
  no behavior change.
- Update kernel doc.
- Fix minor issue with commit message [ Nhat Pham ]
- Link to v1: https://lore.kernel.org/r/20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com

---
Kairui Song (5):
      mm, swap: do not perform synchronous discard during allocation
      mm, swap: rename helper for setup bad slots
      mm, swap: cleanup swap entry allocation parameter
      mm/migrate, swap: drop usage of folio_index
      mm, swap: remove redundant argument for isolating a cluster

 include/linux/swap.h |  4 +--
 mm/migrate.c         |  4 +--
 mm/shmem.c           |  2 +-
 mm/swap.h            | 21 ----------------
 mm/swapfile.c        | 71 +++++++++++++++++++++++++++++++++++-----------------
 mm/vmscan.c          |  4 +--
 6 files changed, 55 insertions(+), 51 deletions(-)
---
base-commit: 5b5c3e53c939318f6a0698c895c7ec40758bff6a
change-id: 20251007-swap-clean-after-swap-table-p1-b9a7635ee3fa

Best regards,
-- 
Kairui Song <kasong@tencent.com>


