Return-Path: <stable+bounces-249984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAYYOuXLDWqq3QUAu9opvQ
	(envelope-from <stable+bounces-249984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3AD5904D3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A971630CAC87
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7051714AA;
	Wed, 20 May 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCLSi5Ow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9951E3DCD
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288366; cv=none; b=PXm2p9646BaT8vODsYle41sObsirrKvUpVpEWvBI/Ez3GKuOQMmub/kwRH/geL86obfCRpYhZWm46SpI840Ebz4CXDFGiR6KzRoa9L2lZ24ppV9jm03EA3Rk41K2BOHPoobFWFKkL9XSYNgYcloRkOCKkwraXD70nA3U/xUZfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288366; c=relaxed/simple;
	bh=zuni+yHPnq0x7yO+YMZZlHygt87r3ck11QgCb5rlMCA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q/P06WgDmXrAmYqWkMmBJYL95W5dVThicJXkTzifCoIZ3mfnGDzC2zCNc7stZ7l8NOBY2ul+BtThmezIeFRChVemWxaEnIBmVAK4gOEf+nWQiHL1RLsJx/IqFKSejJ7ViRcSO01hRYFcwSSQVnLSCax8WuogvZDN8g6E938nT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCLSi5Ow; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1551F000E9;
	Wed, 20 May 2026 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288365;
	bh=egzhZbK1dA666ADif3a2pMDt4NORqG9EPzdjexT2Yps=;
	h=Subject:To:Cc:From:Date;
	b=DCLSi5OwlvJ/7gbybvF+qhpCwgaWvHYccCTKAp5sVuJruC4Uq7YVxLUMTqCJl64/d
	 Q9mRu5qlXYnfxBt+KR4Mau4Vf86wzT+sdgIF395lWB+sATCpJZ1ymQzAJBz7IubK6k
	 J5g6iRKKtvrdoWUPxPkeQF3lHWgfrTpxzdZibESg=
Subject: FAILED: patch "[PATCH] iommu/vt-d: Fix oops due to out of scope access" failed to apply to 6.12-stable tree
To: zhenzhong.duan@intel.com,baolu.lu@linux.intel.com,joerg.roedel@amd.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:46:08 +0200
Message-ID: <2026052008-landfall-tighten-9f3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249984-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gregkh:email,intel.com:email,amd.com:email]
X-Rspamd-Queue-Id: 3D3AD5904D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a6dea58d8625c06b9654c0555f101742481335c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052008-landfall-tighten-9f3b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6dea58d8625c06b9654c0555f101742481335c3 Mon Sep 17 00:00:00 2001
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
Date: Sat, 9 May 2026 10:43:45 +0800
Subject: [PATCH] iommu/vt-d: Fix oops due to out of scope access

Below oops triggers when kill QEMU process:

  Oops: general protection fault, probably for non-canonical address 0x7fffffff844eaaa7: 0000 [#1] SMP NOPTI
  Call Trace:
   <TASK>
   do_raw_spin_lock+0xaa/0xc0
   _raw_spin_lock_irqsave+0x21/0x40
   domain_remove_dev_pasid+0x52/0x160
   intel_nested_set_dev_pasid+0x1b9/0x1e0
   __iommu_set_group_pasid+0x56/0x120
   pci_dev_reset_iommu_done+0xe3/0x180
   pcie_flr+0x65/0x160
   __pci_reset_function_locked+0x5b/0x120
   vfio_pci_core_close_device+0x63/0xe0 [vfio_pci_core]
   vfio_df_close+0x4f/0xa0
   vfio_df_unbind_iommufd+0x2d/0x60
   vfio_device_fops_release+0x3e/0x40
   __fput+0xe5/0x2c0
   task_work_run+0x58/0xa0
   do_exit+0x2c8/0x600
   do_group_exit+0x2f/0xa0
   get_signal+0x863/0x8c0
   arch_do_signal_or_restart+0x24/0x100
   exit_to_user_mode_loop+0x87/0x380
   do_syscall_64+0x2ff/0x11e0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

The global static blocked domain is a dummy domain without corresponding
dmar_domain structure, accessing beyond iommu_domain structure triggers
oops easily. Fix it by return early in domain_remove_dev_pasid() like
identity domain.

Fixes: 7d0c9da6c150 ("iommu/vt-d: Add set_dev_pasid callback for dma domain")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260421031347.1408890-1-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2a6b6813a78d..a4b123c33022 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3530,8 +3530,8 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 	if (!domain)
 		return;
 
-	/* Identity domain has no meta data for pasid. */
-	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+	/* Identity domain and blocked domain have no meta data for pasid. */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY || domain->type == IOMMU_DOMAIN_BLOCKED)
 		return;
 
 	dmar_domain = to_dmar_domain(domain);


