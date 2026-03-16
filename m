Return-Path: <stable+bounces-225497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ih5nLAp5t2k9RgEAu9opvQ
	(envelope-from <stable+bounces-225497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 04:29:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC65294698
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 04:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBC6A3008E10
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6E31E833;
	Mon, 16 Mar 2026 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LCFHekan"
X-Original-To: stable@vger.kernel.org
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DD2248A0
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773631749; cv=none; b=PgkWufalAi8pS7c9GJfV6W5zjZ8HjAXnIqXVMOhEaceIMPrC1XffFdWSGA2sjxDPVgpG5aznZ5i8QOwyjQyh6Hr9kztv5mlJFq3Rb4squKAXkSLbH7tYPF9/lr3swf47fglXTRI2KCDANDo1jO6PTQdRt+U8nszaAM3y3+QBYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773631749; c=relaxed/simple;
	bh=nDCEkiMBSJkq83qtDB2UfmzjB8QDzKSiI6zhVpqInEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XhnMi2CPePAsx+IiFqlOUoQ4qQiGhHY0KpOjywXL0lQ7At9X47vxsE3IV3vdPnFzBxijaWJ/wcW9mzDgWTIYvqBn7Gf0N0VBaFo+6YY9fK9UTMwsYB6CK1lE8EsFwLZXfZ48k+8ezq5N8dRgXF4eHfpIzJPzDkMi3vPcEx07Bwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LCFHekan; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773631746;
	bh=VxfbjtCzWItjsvhY21xBF6X/Ve2lQuBcY7H86bU8ujE=;
	h=From:Subject:Date:Message-Id;
	b=LCFHekanW7pmE0Vnyz4PCDwrfiru4m8RN0iarMPCxnGi1mQ/75Z6B/NyiTG/BLyIh
	 pSJLtPElZX6cBRbs05AHP4Ido7BDTBSerEvl3gJuCNkKnpVvXH8fmQIHodwAXnJsP9
	 RhkVmMi0F2ROZugM2lgHu48ECX957CpQSDWt9gyg=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.22) with ESMTP
	id 69B778F400007515; Mon, 16 Mar 2026 11:28:56 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 9515797602529
X-SMAIL-UIID: 42F187FB0F524273B6D19C5D4AEF4D68-20260316-112856-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lang Yu <Lang.Yu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] drm/amdgpu: unmap and remove csa_va properly
Date: Mon, 16 Mar 2026 11:28:51 +0800
Message-Id: <20260316032851.3319377-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,sina.com];
	TAGGED_FROM(0.00)[bounces-225497-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,csa_tv.bo:url]
X-Rspamd-Queue-Id: CDC65294698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lang Yu <Lang.Yu@amd.com>

[ Upstream commit 5daff15cd013422bc6d1efcfe82b586800025384 ]

Root PD BO should be reserved before unmap and remove
a bo_va from VM otherwise lockdep will complain.

v2: check fpriv->csa_va is not NULL instead of amdgpu_mcbp (christian)

[14616.936827] WARNING: CPU: 6 PID: 1711 at drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1762 amdgpu_vm_bo_del+0x399/0x3f0 [amdgpu]
[14616.937096] Call Trace:
[14616.937097]  <TASK>
[14616.937102]  amdgpu_driver_postclose_kms+0x249/0x2f0 [amdgpu]
[14616.937187]  drm_file_free+0x1d6/0x300 [drm]
[14616.937207]  drm_close_helper.isra.0+0x62/0x70 [drm]
[14616.937220]  drm_release+0x5e/0x100 [drm]
[14616.937234]  __fput+0x9f/0x280
[14616.937239]  ____fput+0xe/0x20
[14616.937241]  task_work_run+0x61/0x90
[14616.937246]  exit_to_user_mode_prepare+0x215/0x220
[14616.937251]  syscall_exit_to_user_mode+0x2a/0x60
[14616.937254]  do_syscall_64+0x48/0x90
[14616.937257]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ The context change is due to the commit e56694f718f0
("drm/amdgpu: rename amdgpu_vm_bo_rmv to _del")
in v5.18 and the proper adoption is done which
is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++----
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index da21e60bb827..b0016d634e1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -106,3 +106,41 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_eu_backoff_reservation(&ticket, &list);
 	return 0;
 }
+
+int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			    struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
+			    uint64_t csa_addr)
+{
+	struct ww_acquire_ctx ticket;
+	struct list_head list;
+	struct amdgpu_bo_list_entry pd;
+	struct ttm_validate_buffer csa_tv;
+	int r;
+
+	INIT_LIST_HEAD(&list);
+	INIT_LIST_HEAD(&csa_tv.head);
+	csa_tv.bo = &bo->tbo;
+	csa_tv.num_shared = 1;
+
+	list_add(&csa_tv.head, &list);
+	amdgpu_vm_get_pd_bo(vm, &list, &pd);
+
+	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
+	if (r) {
+		DRM_ERROR("failed to reserve CSA,PD BOs: err=%d\n", r);
+		return r;
+	}
+
+	r = amdgpu_vm_bo_unmap(adev, bo_va, csa_addr);
+	if (r) {
+		DRM_ERROR("failed to do bo_unmap on static CSA, err=%d\n", r);
+		ttm_eu_backoff_reservation(&ticket, &list);
+		return r;
+	}
+
+	amdgpu_vm_bo_rmv(adev, bo_va);
+
+	ttm_eu_backoff_reservation(&ticket, &list);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
index 524b4437a021..7dfc1f2012eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
@@ -34,6 +34,9 @@ int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu_bo **bo
 int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
 			  uint64_t csa_addr, uint32_t size);
+int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			    struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
+			    uint64_t csa_addr);
 void amdgpu_free_static_csa(struct amdgpu_bo **bo);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 70d49b998ee9..b8b0b819de72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1273,14 +1273,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
 		amdgpu_vce_free_handles(adev, file_priv);
 
-	amdgpu_vm_bo_rmv(adev, fpriv->prt_va);
+	if (fpriv->csa_va) {
+		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
 
-	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
-		/* TODO: how to handle reserve failure */
-		BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
-		amdgpu_vm_bo_rmv(adev, fpriv->csa_va);
+		WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
+						fpriv->csa_va, csa_addr));
 		fpriv->csa_va = NULL;
-		amdgpu_bo_unreserve(adev->virt.csa_obj);
 	}
 
 	pasid = fpriv->vm.pasid;
-- 
2.34.1


