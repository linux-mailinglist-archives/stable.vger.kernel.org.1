Return-Path: <stable+bounces-234381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIIyNzWf1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:32:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E83C0E79
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850D03165C70
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4943D6CAE;
	Wed,  8 Apr 2026 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8vtV0W5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D43ACA41;
	Wed,  8 Apr 2026 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672711; cv=none; b=hWAeCW9YgecfqGZnNI3w/5eyri+c8zfzNCClzTQTS55IjAEZA8ITSw/h2iy9MXKALgQWvXsiQbFmtJ/8Ag/7kv3v7GxMryWd54QTUw9DQql0rqvfMjcRutbgDxHOXlrOLx2mTZFPNJAWshU05pEz7pPPlL0vAPvujAQpKOX9CWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672711; c=relaxed/simple;
	bh=d1vOaSmNtomZiZhsixRxFjOAPpiJlTqsbT3Gvk9+onk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef3mUO+2CbOsXVqUpFZ9cOWDdYwO64/kaPhp1JtDKDzW2XaX87Z2O7df7VJ/hfz2iDK1ptIBcS/Wsa1zODEH7VfzFAc6baA4Y6k3dipNr+4Sn/vCioaHy/4KGLWP1C0J3aBunj/2mIjSsi+77QDhCDBoI5FV4/9gYSi5hb9gIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8vtV0W5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE7AC19421;
	Wed,  8 Apr 2026 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672711;
	bh=d1vOaSmNtomZiZhsixRxFjOAPpiJlTqsbT3Gvk9+onk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8vtV0W5lCq4xgq/EA1J91O1ZEGpmyUIhYQ2ExIg7e0NKaoY/2qNYTYQBZZvvPd6y
	 xcPl9Ow4BsOWRFDp0ndAi8uYF0aNn5IYgAzxH7djz5fJMvhOAFJN/IZJ1CWncRD92/
	 SofK/8rgxBGbdBrU8FRDy0u7o+NNROWPFSAxK7AE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yan Zhao <yan.y.zhao@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Tugrul Kukul <tugrul.kukul@est.tech>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Pavel Machek (CIP)" <pavel@denx.de>,
	Ron Economos <re@w6rz.net>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 113/160] vfio/pci: Insert full vma on mmapd MMIO fault
Date: Wed,  8 Apr 2026 20:03:20 +0200
Message-ID: <20260408175917.401861766@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234381-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,redhat.com,google.com,est.tech,broadcom.com,denx.de,w6rz.net,fedoraproject.org,kernel.org,microchip.com,nvidia.com,googlemail.com,shazbot.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D6E83C0E79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Tugrul Kukul <tugrul.kukul@est.tech>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Pavel Machek (CIP) <pavel@denx.de>
Tested-by: Ron Economos <re@w6rz.net>
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index e05d6ee9d4cab..55e28feba475e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1651,6 +1651,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
 	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
+	unsigned long addr = vma->vm_start;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	pfn = vma_to_pfn(vma);
@@ -1658,11 +1659,25 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
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
2.53.0




