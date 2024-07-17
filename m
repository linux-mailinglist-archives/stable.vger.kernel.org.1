Return-Path: <stable+bounces-60490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212C09343F1
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5175F1C216E9
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F21187857;
	Wed, 17 Jul 2024 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6NHIgJc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C65185E60
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252026; cv=none; b=QYbvD74Ei5kjOWvfifNkGtkROthEy6JGLIZeGIkzFup8/TOQ3dSO/DfEGrXpkb9BJY3bHbERKDsl8v9eUwUUNHFAz6Nkm1u1gtN4Cw8SeZKKBsASDOX7kLJlonFcU9vH7M5G6rUIfXu09AYeqj/IT9/Y0C6xbmymMFCLUg0+/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252026; c=relaxed/simple;
	bh=x4AxNVE4O+WfqzVJnnmu85pZqmIfGnKYsIXUmc1r8y8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DVVc4Ir1huTuUhghO3IrtvOra10+uOpDGwddo6frUXz6ePbx9QUkUoItIlGRx3xq8/f7EwWvOUcZhOnz1dPirYRND547CHTSYxXMJkjNwfxJQ/ihwt1NDlfVoJfKkmpHGlgl39syjRXxn5Y9j4sII8ls9xxB2jOgDW07jVU5X7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6NHIgJc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650ab31aabdso2237557b3.3
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721252024; x=1721856824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZB/4mcQzsOoOaqb8afktp7uOucLSH7cA09jFpTDUMV0=;
        b=J6NHIgJcOMqdTCGaKfi1bnUBDtXEX1rfUQMrsLm/YojnJve+Lqq40RnVV9Dj3+XWFn
         w6ekM1nf5LUdJ+qgUin5K+hND0jFTtfn5+Y1uHYwAPWh1ENIfC0IqoLYUHjQTDBwSIAz
         8sx3JHjGdaVJn5gQeVTmxAEBso0pEmZV+mKjLgANC1PCKlOi1+B7kI3Rd1jzJ1lBKUm7
         j5OpNwEE1cSr88SSFOZFYQsfTNz2Yl5j+LVm9SC9Tplxa1ahhWhSvsDovaYt/7G/EPVX
         eKdsDMjNqnZc4N/R15P/yWqYiWOK+qKMgDUynQDardNBmt+XiStyM+sq/lgM9rhQzD7m
         sMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252024; x=1721856824;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB/4mcQzsOoOaqb8afktp7uOucLSH7cA09jFpTDUMV0=;
        b=RdsBCHs3qdpHwL9QM4bueQ2DXVaDV1ynizFtkSylcN2Fa4G0R6ynw3ACQt//2+ByQ0
         i1UZ+mK+csXFmrKXRiC7vZDdOOIVMf8xm8qBpPIYoQXh786qrkQgFUGy/ojv7h58bkyY
         X6TuSEyu10j49SQ9FpRXwmIu0vgINQEGjfJ1zO2k3cmIy8WIKVx8NZgrfFDbDeU/JH+B
         Ol4IirNDnkvYG/4lwISo61+uZCijkLgYzVFVHBH/ew+NvgUKjW/5/IkgmVWltrMr67mI
         tLETG3QkrXpXM/Q8s1f7RLwk4d9hoygt56jJk26KmFHpRbpKu53b+7FDUaq/5EHh+Ujh
         R4mQ==
X-Gm-Message-State: AOJu0YwQHQopgxxBjSV9hx34okrVxurfzYBjhaXLOt9ITR6bntFIMx5O
	GN/92padFV+eiUUFr7ZlgYonSCOkKJRnvmiDbmLgrH29EyRTdIDt4XxJQWTCGHJXOd3R5liSCIc
	jNZK5luVKzIVGIAA5Wi69SX3My25ACjK+yC61cLDpAtdPUtdYOqVEZB979ozEElNMhtxNZ0VOVW
	oD/3zhaRiT/jK7Bv7TJ22t+wmTb7fYJheATEN9J2oE3wlB/vumh4mFuqZ2I89SEELog8ES+Q==
X-Google-Smtp-Source: AGHT+IE/F3kuqtrq1gronND0JsdGxzDxmNfarL3qLMn5KiwPZ0T3K407YPV2orhl71mUZY2G4uIIPHcXQ2a4+vbABDfo
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:690c:3405:b0:622:cd7d:fec4 with
 SMTP id 00721157ae682-66605444531mr187067b3.9.1721252024222; Wed, 17 Jul 2024
 14:33:44 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:33:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717213339.1921530-1-axelrasmussen@google.com>
Subject: [PATCH 6.9 0/3] Backport VFIO refactor to fix fork ordering bug
From: Axel Rasmussen <axelrasmussen@google.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Eric Auger <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik <leah.rumancik@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

35e351780fa9 ("fork: defer linking file vma until vma is fully initialized")
switched the ordering of vm_ops->open() and copy_page_range() on fork. This is a
bug for VFIO, because it causes two problems:

1. Because open() is called before copy_page_range(), the range can conceivably
   have unmapped 'holes' in it. This causes the code underneath untrack_pfn() to
   WARN.

2. More seriously, open() is trying to guarantee that the entire range is
   zapped, so any future accesses in the child will result in the VFIO fault
   handler being called. Because we copy_page_range() *after* open() (and
   therefore after zapping), this guarantee is violatd.

We can't revert 35e351780fa9, because it fixes a real bug for hugetlbfs. The fix
is also not as simple as just reodering open() and copy_page_range(), as Miaohe
points out in [1]. So, although these patches are kind of large for stable, just
backport this refactoring which completely sidesteps the issue.

Note that patch 2 is the key one here which fixes the issue. Patch 1 is a
prerequisite required for patch 2 to build / work. This would almost be enough,
but we might see significantly regressed performance. Patch 3 fixes that up,
putting performance back on par with what it was before.

Note [1] also has a more full discussion justifying taking these backports.

[1]: https://lore.kernel.org/all/20240702042948.2629267-1-leah.rumancik@gmail.com/T/

Alex Williamson (3):
  vfio: Create vfio_fs_type with inode per device
  vfio/pci: Use unmap_mapping_range()
  vfio/pci: Insert full vma on mmap'd MMIO fault

 drivers/vfio/device_cdev.c       |   7 +
 drivers/vfio/group.c             |   7 +
 drivers/vfio/pci/vfio_pci_core.c | 271 ++++++++-----------------------
 drivers/vfio/vfio_main.c         |  44 +++++
 include/linux/vfio.h             |   1 +
 include/linux/vfio_pci_core.h    |   2 -
 6 files changed, 125 insertions(+), 207 deletions(-)

--
2.45.2.993.g49e7a77208-goog


