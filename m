Return-Path: <stable+bounces-252150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKB/BKX/DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:38:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2F4596D4A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 784D038CB903
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E53FA5FE;
	Wed, 20 May 2026 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pWP0l0IF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6A3FA5FC;
	Wed, 20 May 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299923; cv=none; b=PUnR4i+gF0+7jRbZRYW+WuOMQDESegFrHSE5QWZFhvZCHOiq2e9LVPgJLpVS5fYbKIwoN8sqiJ4i7hzaVeP3hmjgiQQwMxzopiyQ3czMhJWm7eXfh0kz3Vzytai1c3cDhX9dtG4cJvrzU7cbduye6ysFSLDAmNLmgy2DtRdk7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299923; c=relaxed/simple;
	bh=GsURD7lOeNpQFT1UW1fSM9v4Hza+5dCdqiTphYAmifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip0ZZCqCCDp4IqTZ0Dn3o7RyRf7LxuF2S1YkSEJG35cUkVITxuA2bC9WJ/d2gpJj4+0hU3jVCQwJ4B/gVeTKGTRT7jjUE49Hm8IbfCcRN56VBqaaPQ7tkrTvNykXcLZUXcwvs4dZsAQLP+CQZ7mLKPn4TCtMZWsxPDxNotPhahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pWP0l0IF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C081F000E9;
	Wed, 20 May 2026 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299920;
	bh=pESAa3gE2NGMplvMNhyBffozNfTduPOVKBZDdshwsmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pWP0l0IFczvVdUpHKZ7c7Wf493xrd3sQjApfiFEEtyavrLKIp3OcIWPA8NdUFz1yp
	 piUFnY9w+CVI0mL3wtLjTHbBy7WPKaeKqve00YU+C9eAOoYGh3jBLrdlZFmidD++ig
	 ZzHxto6nCmzts0jBa43Cxiz88P2o8OxYh4eeifIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.18 938/957] iommu/vt-d: Fix oops due to out of scope access
Date: Wed, 20 May 2026 18:23:41 +0200
Message-ID: <20260520162154.939434583@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252150-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: 6A2F4596D4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

commit a6dea58d8625c06b9654c0555f101742481335c3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4068,8 +4068,8 @@ void domain_remove_dev_pasid(struct iomm
 	if (!domain)
 		return;
 
-	/* Identity domain has no meta data for pasid. */
-	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+	/* Identity domain and blocked domain have no meta data for pasid. */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY || domain->type == IOMMU_DOMAIN_BLOCKED)
 		return;
 
 	dmar_domain = to_dmar_domain(domain);



