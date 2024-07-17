Return-Path: <stable+bounces-60502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282C9344D8
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 00:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CDD1F2245C
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB25555E58;
	Wed, 17 Jul 2024 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bzy3MF1A"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA84D8BA
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255512; cv=none; b=A+9dvncyAEKkW3e4dtese1D+sstwhExuOAyL8KyD+Jw23ZXl1Q9s4aVu9s1KxZzY7t4KwwKSVGva3hAjmMvXzZLnhu0AZ+ulK2Jlt0Bj3aWfAesM1nAkLjGM+CPnqiYqAk8JXWbQbwXS43rAO3SAYpkuOq2sN0tNJ6in35uVJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255512; c=relaxed/simple;
	bh=ZeVb4NV1UtDsKj/hoB610U1gFo/rAq+Zrk+VLQva224=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHpwlHV3btCvjmM4cV2v14vcWZ6ccyaLRCN/7QHYTTUJOlsLAzn11YPe7yB5j8uFgPgmU2xxPv3DuNBiOdEHtmHUMx7WeoTFL2awekVY38qUcqGia8FK+NsQ9wsWrcUzG190Ipes/F821gr5LvXMGf8Ft/mBm9jW3rZOF7OwrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bzy3MF1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721255509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBsCYjvHFqCofeJfqJ0FDpq4lR84OryByqZWEVkFAUs=;
	b=Bzy3MF1A4joU8//Plh7sgFZk/HzXD+PXa4s5PH/qobj2sg2sWqlqBdSqEpMdJ/gGqDnnyz
	z0lJ55NzIw2lbRofykw2XULxt3nm7mskOJ0UJrDNAOzmNFqWJ9ITcDh3bjTX+RlIbS16Cx
	TqKTRz9SOl5pCLEsS0oZeVT8NT75u4M=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-VoxxvVbaPyawZmm0RPD0dw-1; Wed, 17 Jul 2024 18:31:45 -0400
X-MC-Unique: VoxxvVbaPyawZmm0RPD0dw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8152f0c4837so25813539f.0
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255505; x=1721860305;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBsCYjvHFqCofeJfqJ0FDpq4lR84OryByqZWEVkFAUs=;
        b=hoC+Rv3iLaDtlcOFxfWCwgEbF1E885sEJ6QjSWwmdh/NueW6E4Fw0pCDlNRGvxr7zL
         CFqbaHjrlmgGvKm7Awo3YN8b6CUwi1pl0PBFQwRtpSpjqW0sVlVRFZsJPVe5Hw5VTB7I
         s2MmwfRCHk7sA0ij9xMiWEdte1gFVnY6V3KKvkYbxPgEUd56L5vN362wEF1/Tw8KGTPy
         KAVNrdNPWD7H0v9UOYhV9bBYS7+0hWKBupsizfMu3c/O7/C6hyPs59ILS89OrV/hrG2j
         pr6ZKFB3TYBZXqRIfoAXkjqgL4L8saiG6V1jJOoLjJoEa9cKehK5XQ0tUZjAO9L49+sq
         i36Q==
X-Gm-Message-State: AOJu0YxNlA0ATmkjD8lQBYoGQDvsyGGcfpRa3GVk/U4t1AhAXYESxENJ
	dAvqjEMtKaF3pp4Kd6c3e3k5QPZQQu2Ivh8ENstCE/Hh7MhccAktsrSvjbHKHBRMuG/wXmxAz8c
	afyz4eP459+NFBZrXRBoZc9SlMCmHcL0Q7uYOAT7E7aHFa5sgZnqcAg==
X-Received: by 2002:a05:6602:29c2:b0:806:2e60:d169 with SMTP id ca18e2360f4ac-817123e1c6fmr434707939f.17.1721255505091;
        Wed, 17 Jul 2024 15:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPb97hbNXON2ByzzRKRynxRHlbiYrD3yDjp2uo84hIKMI6iQ+GFeGYUQQkaZREiI+LQxB6iA==
X-Received: by 2002:a05:6602:29c2:b0:806:2e60:d169 with SMTP id ca18e2360f4ac-817123e1c6fmr434705739f.17.1721255504742;
        Wed, 17 Jul 2024 15:31:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c17c5044sm92133839f.19.2024.07.17.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:31:44 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:31:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: stable@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik
 <leah.rumancik@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6 0/3] Backport VFIO refactor to fix fork ordering bug
Message-ID: <20240717163143.49b914cb.alex.williamson@redhat.com>
In-Reply-To: <20240717222429.2011540-1-axelrasmussen@google.com>
References: <20240717222429.2011540-1-axelrasmussen@google.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 15:24:26 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> 35e351780fa9 ("fork: defer linking file vma until vma is fully initialized")
> switched the ordering of vm_ops->open() and copy_page_range() on fork. This is a
> bug for VFIO, because it causes two problems:
> 
> 1. Because open() is called before copy_page_range(), the range can conceivably
>    have unmapped 'holes' in it. This causes the code underneath untrack_pfn() to
>    WARN.
> 
> 2. More seriously, open() is trying to guarantee that the entire range is
>    zapped, so any future accesses in the child will result in the VFIO fault
>    handler being called. Because we copy_page_range() *after* open() (and
>    therefore after zapping), this guarantee is violated.
> 
> We can't revert 35e351780fa9, because it fixes a real bug for hugetlbfs. The fix
> is also not as simple as just reodering open() and copy_page_range(), as Miaohe
> points out in [1]. So, although these patches are kind of large for stable, just
> backport this refactoring which completely sidesteps the issue.
> 
> Note that patch 2 is the key one here which fixes the issue. Patch 1 is a
> prerequisite required for patch 2 to build / work. This would almost be enough,
> but we might see significantly regressed performance. Patch 3 fixes that up,
> putting performance back on par with what it was before.
> 
> Note [1] also has a more full discussion justifying taking these backports.
> 
> I proposed the same backport for 6.9 [2], and now for 6.6. 6.6 is the oldest
> kernel which needs the change: 35e351780fa9 was reverted for unrelated reasons
> in 6.1, and was never backported to 5.15 or earlier.

AFAICT 35e351780fa9 was reverted in linux-6.6.y as well, so why isn't
this one a 4-part series concluding with a new backport of that commit?
I think without that, we don't need these in 6.6 either.  Thanks,

Alex

> 
> [1]: https://lore.kernel.org/all/20240702042948.2629267-1-leah.rumancik@gmail.com/T/
> [2]: https://lore.kernel.org/r/20240717213339.1921530-1-axelrasmussen@google.com
> 
> Alex Williamson (3):
>   vfio: Create vfio_fs_type with inode per device
>   vfio/pci: Use unmap_mapping_range()
>   vfio/pci: Insert full vma on mmap'd MMIO fault
> 
>  drivers/vfio/device_cdev.c       |   7 +
>  drivers/vfio/group.c             |   7 +
>  drivers/vfio/pci/vfio_pci_core.c | 271 ++++++++-----------------------
>  drivers/vfio/vfio_main.c         |  44 +++++
>  include/linux/vfio.h             |   1 +
>  include/linux/vfio_pci_core.h    |   2 -
>  6 files changed, 125 insertions(+), 207 deletions(-)
> 
> --
> 2.45.2.993.g49e7a77208-goog
> 


