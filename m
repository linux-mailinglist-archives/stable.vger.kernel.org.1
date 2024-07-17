Return-Path: <stable+bounces-60493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65439343F8
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C311C211B6
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09C18E743;
	Wed, 17 Jul 2024 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMeOFSPQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A018C349
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252032; cv=none; b=lz2AeNyaAGJ86F1v5qSO3uCEAgVfxLyHpBVmVc7gf9GSmUzsi9iN69Sv2NmdjTVcnS6Fe88VoeY1KJ2v0cjZ1Zh2zulXCRettNW2MYDr+Y8Gy9yGadt4WqsfcDrbB+jxNmGuJ0hwziUgzqaV9RORgnIXV5IZfNudC14lrc6UsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252032; c=relaxed/simple;
	bh=FtL2WLykniLMH2iZnDeKB+u5uJJnWt1fxzXfySze5OI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JYih5pJfKpdruygIzTD3xoQEUHQGqNprdKG2pjE3w9KR4EyShP4Z8zW0A/O5b6wahf0OIDS34YWmgzgKbjZ9Ao6MHyVwSoqHiYnc029lKLHu9gW0pDERPMFps3drLEBd2hT19xtb093Ydu/iEceR6Qqfpm6fhJuZIyCtWWksIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMeOFSPQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso375220276.1
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721252030; x=1721856830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLtZj5tEts3mR+eoKmaIr/Y89zsbNNxQ+zwQ1LS5MPo=;
        b=RMeOFSPQ18fD4vaOzqmWhuP6WcU58VwGkM/zPE5MKvd+ynHfi1vPfKov84Aj9o37Md
         xd6G0njHZ/ZCs9pD2qVyvJVsbtMm0fvKfptHgbbccDlBx0LxYMZ+VMY55UNTD7NL2Emf
         jCUfcL3ld25fiOnjTvf+ma0rQcACO/mSL7RKDxB4535BCsFalyPUQYRot0o2MqRDn/ie
         DEB2TgkroVWMtrfMiXocu8Nb2siklskL5UeU1DazUpJ+4BSTvcsROELmnYLdc67Xq92B
         zKEDg5d1YyTQgXpBLUeSw6Uuz4DHtqo5cP/JiTPJh6WQzECruTCRDd9K5n1YnUy3wXvY
         fSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252030; x=1721856830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLtZj5tEts3mR+eoKmaIr/Y89zsbNNxQ+zwQ1LS5MPo=;
        b=cWz4sZnlsGGJLfSK49mImYy4raD76F8hzZVl7jM0vMqQdDoyO7xv5ZG02n8UY8ktf4
         SUwjSGHMJ0IdWXwrjmwohFwOVLqEcH/S5WYGIutvycfdVf6ZrWIWyCOpXHGGl/lupZUj
         7AQUMfpDNxoGK5ggJPqTfjz9olH5N/JTSaGSkharqxfEjuMNBgPXsLu5xdTimr9UEIUA
         OOVryDPtI8SF/2Bkn96k/UEsdKvOpr4foPCoWSnzDBmW9N0JpADd5DZzsdOB6fP2nEzU
         hYfdGJp9z5DAnn8ZeO+vpot6s/owED42dYa7YfYNlax+uM5z5FbEosQi+CDEEE2c6pnZ
         2UHQ==
X-Gm-Message-State: AOJu0YxDRyGc7OzKFrOp4xk6Br936tTfeaQd9rXK0+d4QJlsWCTlGLiO
	VsaKEFGwIzIOzxTtApWaVPGrcjMSTNra0K8UiEbcK7YI/f66AAeQ+YhRIyyoo+bVUm+GyAwpY6H
	S6axCeUDMW5+pgYqkvD9WHVi+JjysN6VzozcesXOsSiwNhPtB/JXu6cIyUPmZ+3q/a4FmjVtcrB
	EE3crJ0OFY6to1kFJylDzVKHwHj44jNj/5ddry+gmmTv2a5ZnAoucYphwX0sYeNhQJ2oVy9Q==
X-Google-Smtp-Source: AGHT+IHE4njs2DlarzKbQm9eMkmED17D/9sHKkJxOr/ao4nCy9IEICWK9iZlriPw9z3+uBXfjriRyfh4WAQDV+e5utZ9
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:150b:b0:e03:f2ea:717c with
 SMTP id 3f1490d57ef6-e05feb87b5amr1284276.5.1721252029671; Wed, 17 Jul 2024
 14:33:49 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:33:39 -0700
In-Reply-To: <20240717213339.1921530-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717213339.1921530-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717213339.1921530-4-axelrasmussen@google.com>
Subject: [PATCH 6.9 3/3] vfio/pci: Insert full vma on mmap'd MMIO fault
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
index 74a3499a8a2e..e388c974f9f0 100644
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


