Return-Path: <stable+bounces-60501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01AC9344C9
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 00:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1691C21437
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 22:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545166EB56;
	Wed, 17 Jul 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Trx5I8WJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850084AEE9
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255080; cv=none; b=odWDXkIy3ojzxEXz++RaXS+MPfjLayKce6JKxziZULhvhm2xz+GEDtzgk7PIhaQbz8LKwmZz9ZsotbK0IxrcSAnSQecVXGVngPJ36rIQ3bWQYPQeN79l0HBlp6tVWUzyG++2jG2yC2Au957WHA9zwyf9tTVPpP1NcHIh2SirpF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255080; c=relaxed/simple;
	bh=Ntl9tRnYPr/zJHNKvphgoIXwclc8AMU5292YrLEeLMg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QOLhmoGeAgoEquu0DSSvME8fmAgKlX7TuHOEXdGZQblLI7uu7yTUohnVr45t3u51+rRlXDJzjPMBxWlc43rBqSdKL3+ivpZhjrw1UoRP8+E2La8VttXiXEu2m87EjOaJFid4DexhaXPDTCb9GdkJgGzF5oqqT+Cr77Hr3jJ6u7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Trx5I8WJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65fe57ed70dso3916867b3.2
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721255072; x=1721859872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MezEZvDkvM+1W/zRjucz+iEQh8YeOxqZVDK0/PzLMrI=;
        b=Trx5I8WJWSde4ZXTL+SX1MKXfpd8aEEjLHqkVa5LYd994J6dWBmChwK9QssfVILCOT
         lVYy0v4DHdbkarhzeNQsK2p6wWZFTg24cALYe5rpsllEv23MqCPnp/IvS6xhlPyo2iMw
         3HzJbMTDKk0PmVHxio8MGH1qdP/IudTrjziBCP43rBYpkwyl7Z1N/6f1tdq3yFOhAR/8
         6VOC2WAMDylcK+YlmDOP5BU9hwo7zNkEDB0+73yqG6Gfkxh1MDCNHd0GIcKOnoq9imqW
         qNTwCAqzV1+NChDcDGiO7ie0ZDbVwgUfiB/kQRFHfR5aa0JILFppfra4R7tRcCT7QIwC
         EBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255072; x=1721859872;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MezEZvDkvM+1W/zRjucz+iEQh8YeOxqZVDK0/PzLMrI=;
        b=hoFNAEzwfDiOd/i0fPffX5ZWeHg98o7ww6oQLqgEmL8M6HiYSjDKVyBZGjrB1YYCTT
         ICO1mSbvMQKZ8qHr3QTEcxkctRqpccYZ4pxIPoZ8+y1sJUWOSYsqC8XxtxKwUFnJ3hD7
         ZEvDUNbI4AryQfLBIwEB6VHbjXP+LPIClxx97hhJwlvL3EVL6yIHd5hJjTkEHBQx+cBL
         H3v7aREOh/9yaENJxOugig/ncC+v4x3DdCqFu1CUukPxOOt2FpNFrZZLGYJ8QkNGvkZv
         D8dCKPcl56w93xJRC03OUABhdTtMYi+dazVXTNEzG4CBorYyT+Is6ILKZ6uK4BMfWflZ
         PLPQ==
X-Gm-Message-State: AOJu0YzTJVW8eM0tYLk8/KhX1zPaVPchVWuGYHSjHWewrPMEaLS5PIcf
	sCfEQY3gTHTAy3HWB6PvZoJ5atjIe2vNfE/GutupNtr/v6i6LArLR1i78KItQRo2ezqbhEbW5xb
	Fq72ByazlYIPYDv3wytwUzR4dEXPjZCantM//845o8h3rDBwTqCGmci0D2oHJUTZF7Y7h5TXfFX
	3lZTTdUCwlufxXgUdsoDwg9LaYxLENph0+e6eVVJioM1Fa7jk/1QRkmIbQ4Xw0XnwtknjmrA==
X-Google-Smtp-Source: AGHT+IG3+vxstPdTJZp8jxDQlLO2DBDeon/AfyXaM8QcDfmGpsUe4BCC7qLioU+mUNebeDuzOmN7MsFB77LhWaaMobJI
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:c03:b0:e05:fc91:8935 with
 SMTP id 3f1490d57ef6-e05feb62eebmr2039276.3.1721255072045; Wed, 17 Jul 2024
 15:24:32 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:24:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717222429.2011540-1-axelrasmussen@google.com>
Subject: [PATCH 6.6 0/3] Backport VFIO refactor to fix fork ordering bug
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
   therefore after zapping), this guarantee is violated.

We can't revert 35e351780fa9, because it fixes a real bug for hugetlbfs. The fix
is also not as simple as just reodering open() and copy_page_range(), as Miaohe
points out in [1]. So, although these patches are kind of large for stable, just
backport this refactoring which completely sidesteps the issue.

Note that patch 2 is the key one here which fixes the issue. Patch 1 is a
prerequisite required for patch 2 to build / work. This would almost be enough,
but we might see significantly regressed performance. Patch 3 fixes that up,
putting performance back on par with what it was before.

Note [1] also has a more full discussion justifying taking these backports.

I proposed the same backport for 6.9 [2], and now for 6.6. 6.6 is the oldest
kernel which needs the change: 35e351780fa9 was reverted for unrelated reasons
in 6.1, and was never backported to 5.15 or earlier.

[1]: https://lore.kernel.org/all/20240702042948.2629267-1-leah.rumancik@gmail.com/T/
[2]: https://lore.kernel.org/r/20240717213339.1921530-1-axelrasmussen@google.com

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


