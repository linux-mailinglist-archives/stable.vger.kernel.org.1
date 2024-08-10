Return-Path: <stable+bounces-66299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E994D9B2
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 03:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5842826B9
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 01:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D028379;
	Sat, 10 Aug 2024 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uikbLtQy"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F96DDDC
	for <stable@vger.kernel.org>; Sat, 10 Aug 2024 01:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252612; cv=none; b=rj+ShUc9zYqBXm2gQyJybUQeHPKLMvv8iB9EuEqcHRGtvHhBYNLgBrCxFJyxem9i8/lNu3mE6cApvO6zCPF/vjAgk/T1u7nqhmyCPxG+qnH8HhzYnfsNDb0nSfsf/cgwcwV1XNgYUtQBI+VNTt2hbCwVqtG3fDF5TsbYuk98eCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252612; c=relaxed/simple;
	bh=VjGGhtOyocXpyjJRROLI0exgkLI0ipPYyjnDOu75lhY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jXkSTMrT0d7Le6yFdAueMUoI8o+7Sns8bvGv+iuFNzDoVhfkdcFjXhafKGEIVZ+uUvTkQBNJTSG/u/qwGU1GSAjDpvgFtyD9rm4HfYeudI51II3ST6VPq1RUhmr+MmsHa++IloBUf7ENdn5UbEE5r17YJQ/rN9Su0lB6xNz9tSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uikbLtQy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65194ea3d4dso50381617b3.0
        for <stable@vger.kernel.org>; Fri, 09 Aug 2024 18:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723252610; x=1723857410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EmCXfukwms+/EJ7MTbvnKYm8exDEKNtb35voYaoMsqs=;
        b=uikbLtQy3QW0qQsYsoG2t2UK/JQxbc8/teZijJJsMR02gEvBmirI4F+R2NoGEfZI1t
         xnuDuDqwgyp55+UIjHXmb82wDnuJ87IQDQi23ddy9df9bkrrCFfNWi/yHG17MNLmRK1a
         w+ZbK5xRzHqy3bU6UiJoXgOkX+ruYeYWp4GP8ICfqh8A79J3G8ZX+DXO9kk6y02nLuty
         RXupfEghGUjpzDC/YadWtk/5GehsUa4PkVuVPXp5BuA9bkxpdsYrQMeBVM31rEvEhnis
         m8LmlWFwfNFmaVrPiXUmFaiety10C25eyQ9cvjRj9BWHt+EUyuKggpwsJ+5xtKm8U2pQ
         PQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252610; x=1723857410;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmCXfukwms+/EJ7MTbvnKYm8exDEKNtb35voYaoMsqs=;
        b=gAEASgQkKNVTEdizR6XLK2UzgIR3JIo2z5x5Yiy1oq1cOt+Jg8Rwkzb0JCBCOUGhtD
         k4X8PFWGtOPTDkUMssKyG18BeebP7ZAk6Fo10gd9bGcSVtns8W60n8B6ApYj2pS4eep2
         XkBctaZqhi+zsroSRMi+6YJGBgQnfmgGIHdttiaXM5DW3RiclKspsYg3xA331qg7eahv
         jvyfl0dFVrVOGs8RbTS7Yd6CmgFKd4zbSKUwJd7KH8h6fmyYeCC1Ilzj5K+GrqD5nPjO
         8osCsPMOt01f/2JWaK6oKL9G45kVhBAKY1CHpTY0hm78FKWNymaQtzRl1hBFG5i9JfNm
         EOtw==
X-Gm-Message-State: AOJu0YzdmNN57MjImblAYW8ZS5xWjlz/J9du28Sb2pjHsBOxLEOClVk8
	H/n0Ep7Anqw5jqGkIzrPS/3CMesqa5ho7IIWZekqCDgEiyJu/9lGv9i1iY8bdzfvdc5fTd84YRN
	jKSgFZO4h0z3cNub5JDI3R9rwT5syw+7mSC23OAhWXjO4Fsaz5wugHjkBTcOqD1R1Z9icoDxQWG
	r7V+g9ag3oEg3tqyEFT8O5JeLO7ToXjenzqW1Atw==
X-Google-Smtp-Source: AGHT+IFVtWGnhaTamZBHpzFgSGIwIIfeVZIDP36DJQZQHZTs+yIKKjkLkNwptTSiO6ISkxE4hPYJEW/L7yMT
X-Received: from kpberry.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:1f28])
 (user=kpberry job=sendgmr) by 2002:a25:6810:0:b0:e05:ea2a:d466 with SMTP id
 3f1490d57ef6-e0eb9a2d633mr5550276.10.1723252610193; Fri, 09 Aug 2024 18:16:50
 -0700 (PDT)
Date: Sat, 10 Aug 2024 01:16:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240810011646.3746457-1-kpberry@google.com>
Subject: [PATCH 0/1] xfs: fix log recovery buffer allocation for the
From: Kevin Berry <kpberry@google.com>
To: stable@vger.kernel.org
Cc: ovt@google.com, Kevin Berry <kpberry@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks, in order to fix CVE-2024-39472 in kernels 5.15, 6.1, and 6.6,
I have adapted the mainline patch 45cf976008dd (xfs: fix log recovery
buffer allocation for the legacy h_size fixup) to resolve conflicts
with those kernels. Specifically, the mainline patch uses kvfree, but
the amended patch uses kmem_free since kmem_free was used in xfs until
patch 49292576136f (xfs: convert kmem_free() for kvmalloc users to
kvfree()).

I tested the patch by applying it to the above kernels and recompiling
them. I also ran xfstests on the 6.6.43 kernel with the patch applied.
In my initial xfstests run, all xfs and generic tests passed except for
generic/082, generic/269, generic/627, and xfs/155, but those tests all
passed on a second run. I'm assuming those initial failures were
unrelated to this patch, unless someone more familiar with those tests
thinks otherwise.

I'd be more than happy to do any more verification or tests if they're
required. Thanks!

Christoph Hellwig (1):
  xfs: fix log recovery buffer allocation for the legacy h_size fixup

 fs/xfs/xfs_log_recover.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


base-commit: 58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9
-- 
2.46.0.76.ge559c4bf1a-goog


