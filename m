Return-Path: <stable+bounces-60495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDA993441A
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15DA2824F2
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6A21891AE;
	Wed, 17 Jul 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRM06IAv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45232188CA4
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252674; cv=none; b=hOo2fexf7NyRogEjH48ftED68+zZi4TtQBPrhK/QGM+Mu6Z7l6HdXL18Cb6hrVx+hrpKDzZZ3BxqM0N+r90h8KZtKGr/aiu8ZKB+9t3NEsL2r8SHNztz8uYyvbSLlStTbH8peYMsUFCWwLka6TkJ/OPXV1msclWZZmdiZz0qXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252674; c=relaxed/simple;
	bh=nm1sn8H+UwA2gzDfCfCPgna/4ZDRkMbtFZ/jJS2k4dY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4V7EO7jsqpkyySZm/x4sxtmfgZjiS9vbIS7wWysiTrTNyKw994hlzXz2TyvZBYKXlfEKzvCm4OU8WG3zmXHHu5sI6JLPM+u0GoEGuHrVKvSVezeFIEc6+VE4NLqnYd+1eUIrhpwYYlrUU1eLnZlcxChURA1nPXUSs/VDaXGV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRM06IAv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721252670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wjxz20iy8G2qBsoFEZ2vcnJOu/C66k+kPs/38ZB7V8=;
	b=HRM06IAv+K4caEO/Jfu3J0KLvy1sma7fZuNJ/eiSLLdW+Z7kLdsml0JnutnNAbLXeTJUwf
	Lv6QdRo0eO+0EJzlgJ92FLHrx+ao+YLBqmGswXFkA53vnBe2R233DmtclLRFWoHPTv5qfP
	cn4MUS64L9vl+kavou9gA+/+Blg7630=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-aZIf7-hLOPmyUAkTIFQQyg-1; Wed, 17 Jul 2024 17:44:28 -0400
X-MC-Unique: aZIf7-hLOPmyUAkTIFQQyg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so16523539f.2
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 14:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252668; x=1721857468;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wjxz20iy8G2qBsoFEZ2vcnJOu/C66k+kPs/38ZB7V8=;
        b=qzLy2x5+uZjjtiAykOu5RV1XvLzyyToK53mBI3pK8Qsv1n+NcwOZIPAEsQkDB37HHn
         UGHg52Me/zWPnFzxgxvkIrCm2hOSgkxs3p7ivEFZSbmzZEIbjvttlFtvpc8ELtLkACAX
         MSOVi/5Y01Edg9c2mAAZevB/J9OqwPP/ZBEuB7GetKXc5l3UxnTR2dV0MWv16BR64Xxs
         mfRDh3YlPDVfqRoMMB+jK/RbrVkD1ojFX6BLbyXRPMdoNF9k0Sj/vPV4OwjJAyzD8+EU
         KDvo0LwDQhKtiLQS51BQQad+BOcTnqR0o3ReZJRAkvzt5UoPi8QpdNMtNI4xqk6bMu8N
         1Dfg==
X-Gm-Message-State: AOJu0YzvU50mB5jNDhHRsKOA474cP7S1T+HbM2ULXYYxnpXNMuhOMXSI
	InujRstX2+T9uK8dKJxaATFzaGYNUDA7ZULMcYOAIqAUOLudAz+/RrlR+LwHNd1TSHjgqGhDGPJ
	OfoBrrbcZ9RoLSXgsD3wx0AznBbD3RT6Sm3uvilIE0LYOVz1sX5pJog==
X-Received: by 2002:a05:6602:2c92:b0:7f6:20d2:7a96 with SMTP id ca18e2360f4ac-81711e18b30mr344228439f.14.1721252668207;
        Wed, 17 Jul 2024 14:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg3w+Houb1Be8pF3Zf31Isom/zcA7zD4gXvl4BNJsg1iNrkpkV/hEYMiAVNuTjdPIuOyIyVA==
X-Received: by 2002:a05:6602:2c92:b0:7f6:20d2:7a96 with SMTP id ca18e2360f4ac-81711e18b30mr344226539f.14.1721252667843;
        Wed, 17 Jul 2024 14:44:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210ff4c3bsm961063173.171.2024.07.17.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:44:27 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:44:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: stable@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik
 <leah.rumancik@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.9 0/3] Backport VFIO refactor to fix fork ordering bug
Message-ID: <20240717154425.43437eea.alex.williamson@redhat.com>
In-Reply-To: <20240717213339.1921530-1-axelrasmussen@google.com>
References: <20240717213339.1921530-1-axelrasmussen@google.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 14:33:36 -0700
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
>    therefore after zapping), this guarantee is violatd.
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
> [1]: https://lore.kernel.org/all/20240702042948.2629267-1-leah.rumancik@gmail.com/T/
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

LGTM

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Thanks,
Alex


