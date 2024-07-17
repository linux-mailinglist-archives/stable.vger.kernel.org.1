Return-Path: <stable+bounces-60500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7175B9344CA
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEF0B20D17
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 22:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4716D1B4;
	Wed, 17 Jul 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipDKW34L"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168546426
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255080; cv=none; b=h8QsCVbvBEcR3cEIamYVgpfcWnJKSeI0sKk6g6tKtLS4xB282cjv5T2YYNKTmE4NoKVQMXHHNoPkLXa48KQWnUaUfzKsQ9IDvgu9+CvWZH9w7sIzPHctm2VUStBHy7SF6yBEJNMRgUgwgLV30MKQciVRijUqKD8+L8Sj43K11M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255080; c=relaxed/simple;
	bh=kMqdRxWNiI9YiTgGPD1e6dunxlUyzqetxFSiKFvNiPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qNLdKb8A4ysomUOoNmydUGWOmxAcS+AIEELfZulIFQZUQ7vsFhQEF2UptUUHjtgOVH6Yl1HtZ5kmCSEbt7FWkeJfDbcOp+mvasm0CuNguum2K2OlcDOppN2oiSJL+T5mfyvx7ii/nkYeKPuXVPny21XLTL4wb3WRaq6qrSYPtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipDKW34L; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65fabcd336fso4296737b3.0
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721255077; x=1721859877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdMf+ufr3mRNGP33DXF0RnpzY+vpJ6GjjPw/JpyYHhE=;
        b=ipDKW34LDXjO8jvBw0bPwF8/fNk4EqV5BGvo9qg0sVImlHjWi1b9PmeFX59ArGeq+G
         +i92H6fx9Zom8toZlHZ9HQF5vhCiO1RQYmS6YLDnVQI2wGn+lq0odiF3k6V8ZJZbtcLr
         0LiqXaebg4WO/L6OdwhPdoVLCiQJBX2plUpgQ166DwNFAr9oJkRL1DkBp1M2g7DTyRxg
         TsBuG+pcUM4oVi7Chgdl8gb02CoLdpd3ksTFQuvOm/piV4JTADM2ueoReE4JYuHAbNR2
         Vp8XB1S2nK1Iu4hZD6iO6qPbwdttkv+vRU+IqIGfJ6DO7WdRbqqqSHJ2b3PDp0XbmXh1
         t69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255077; x=1721859877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdMf+ufr3mRNGP33DXF0RnpzY+vpJ6GjjPw/JpyYHhE=;
        b=gnAKQ476CGnqT99UA9Tzr0LmV7B+X+xVWLwhQa+kkct2lPSBxlfzoqmMNYDftTC8Wa
         bfCrcCJZ8tG/uxMei4SIgser1QbfbCX2aS+Ip6cVhkGiRn6yRAqK7Q18JlmJ53J6VN93
         s0BdWLGZMDcyP0TFEPa5q6+CLa5gV/Y07bn3MmbucWksm0Uo3UMGybKPn2Y04AuP1kaT
         BgHRMafJoTQoNX5al9dvfVoghuScliGu2Hjwy+dxjsJwu4SXtYdSkZD5SlLlYNw64tXP
         3E2mCNBQGXRx4GEcADXi92EL3jyCbV2gLvgu5U9DX1pKOe5g0QjEs1/5Ha+eGD9q2eHE
         Ax2w==
X-Gm-Message-State: AOJu0YxBiBmMD6+6NJxTW2FcCgXWK9TlmKEALJggrQFf/szKwgMTd2DK
	4FVVzrDQAJ71yb6bQwEhhA2QAXZM6a8/DKI0bTk2fGF1O4V/tTbiNdhuCZXp6SpVPuxFBS38i6I
	tmpafeKDa0nNTWOKEndNPaXP3ro4NXkdRmR7tLQ1I2d4WL97nPiKs51ymUBVgrFxQAG7/Va+5w6
	Sj/g4rb6KS6xEDz+nvd64OcMAy1j/zZ8rXsXWe3PlHx5l14hvYzF+kF2C66UBAk+eX57WnLA==
X-Google-Smtp-Source: AGHT+IEV6mYusUj8ULHke+1RPPJco+bwaOOORCvPCTttFeFfrfUKPgZ9QPG4zLl9wVzK07pSlcLnXXgBKQS8++ePE95q
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:690c:f94:b0:64a:e220:bfb5 with
 SMTP id 00721157ae682-666015f1508mr450367b3.1.1721255076965; Wed, 17 Jul 2024
 15:24:36 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:24:29 -0700
In-Reply-To: <20240717222429.2011540-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717222429.2011540-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717222429.2011540-4-axelrasmussen@google.com>
Subject: [PATCH 6.6 3/3] vfio/pci: Insert full vma on mmap'd MMIO fault
From: Axel Rasmussen <axelrasmussen@google.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Eric Auger <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik <leah.rumancik@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alex Williamson <alex.williamson@redhat.com>

commit d71a989cf5d961989c273093cdff2550acdde314 upstream.

In order to improve performance of typical scenarios we can try to insert
the entire vma on fault.  This accelerates typical cases, such as when
the MMIO region is DMA mapped by QEMU.  The vfio_iommu_type1 driver will
fault in the entire DMA mapped range through fixup_user_fault().

In synthetic testing, this improves the time required to walk a PCI BAR
mapping from userspace by roughly 1/3rd.

This is likely an interim solution until vmf_insert_pfn_{pmd,pud}() gain
support for pfnmaps.

Suggested-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/Zl6XdUkt%2FzMMGOLF@yzhao56-desk.sh.intel.com/
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/r/20240607035213.2054226-1-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7b74c71a3169..b16678d186d3 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1659,6 +1659,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
 	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
+	unsigned long addr = vma->vm_start;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	pfn = vma_to_pfn(vma);
@@ -1666,11 +1667,25 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	down_read(&vdev->memory_lock);
 
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
-		goto out_disabled;
+		goto out_unlock;
 
 	ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
+	if (ret & VM_FAULT_ERROR)
+		goto out_unlock;
 
-out_disabled:
+	/*
+	 * Pre-fault the remainder of the vma, abort further insertions and
+	 * supress error if fault is encountered during pre-fault.
+	 */
+	for (; addr < vma->vm_end; addr += PAGE_SIZE, pfn++) {
+		if (addr == vmf->address)
+			continue;
+
+		if (vmf_insert_pfn(vma, addr, pfn) & VM_FAULT_ERROR)
+			break;
+	}
+
+out_unlock:
 	up_read(&vdev->memory_lock);
 
 	return ret;
-- 
2.45.2.993.g49e7a77208-goog


