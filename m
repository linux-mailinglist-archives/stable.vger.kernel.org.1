Return-Path: <stable+bounces-211358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKsmNqYkc2nCsgAAu9opvQ
	(envelope-from <stable+bounces-211358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:35:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76F71C5F
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9242D3017BD1
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD6533B97D;
	Fri, 23 Jan 2026 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HrJb/cF/"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5B30BF6B;
	Fri, 23 Jan 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153672; cv=none; b=dyZiIN5J7SXsyzpkCL44hf+wkKpvmSbt+uTGC0QVkPFYHcHImDAgD0Yt6S9X+8NNYE0RikNVhTS3xEIDISOcHTAXiPxHSxbih4sQQZ/sfTLkCBmPzYV4OJwXcEezZ4vHDni3zG905QmZCpkAv61DYWaZuR5WI9Wf8hLc+spmo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153672; c=relaxed/simple;
	bh=B6YovAasCi8UBU8SpJT3G5K7K22RxgOk8sEkH/dOVqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t2DUTS4vCCadqCWSciwb8w/rom9ebgDdXNO80WUOqjz/URMAwW/hd/wACsupWpUq4Dqpotw+YPj1N+l/zm1x9i0gOhrQP4BMJYAy3w6/FJMmcb9ykKCvOy5GG2DyHkwVHbaY8UklLEfoZI59RxUhDbUyz+H49QY2g61dvEqPO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HrJb/cF/; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Yg
	pesAWZdRLxrrl26BY9nES3ENgW+s5A7XFzRwdJZxM=; b=HrJb/cF/cxR8zRNp/a
	eXAc/qHnBAL1dpG7l3el7WVHhtiMwQHawN4pQvIXhIMuSTiglJHpsK+mG9a3DT+h
	/3RoWmWVQGqvnS37w2CdJ9EJY2qHLhCdXxBooNArlSTsJi2snPhx6O9P68/yhX+k
	dCRSwo7up+gqJyk65wfGGEK84=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3pLZpJHNphDNaHg--.111S2;
	Fri, 23 Jan 2026 15:34:04 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.12] accel/ivpu: Fix race condition when unbinding BOs
Date: Fri, 23 Jan 2026 15:33:58 +0800
Message-Id: <20260123073358.1530418-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3pLZpJHNphDNaHg--.111S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF43tFWrAw4kGry8XrWrKrg_yoW8tr15p3
	90kr98Cr9Iqa18X34DXan2v3s09a1kKrWUGa45ua15uFn8WF40qryDKFyqqryjgryxAFZI
	qF4rWrWfKF4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEdb1OUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3Qxb9GlzJGwA+QAA3V
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211358-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,oss.qualcomm.com,linux.intel.com,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5A76F71C5F
X-Rspamd-Action: no action

From: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

[ Upstream commit 00812636df370bedf4e44a0c81b86ea96bca8628 ]

Fix 'Memory manager not clean during takedown' warning that occurs
when ivpu_gem_bo_free() removes the BO from the BOs list before it
gets unmapped. Then file_priv_unbind() triggers a warning in
drm_mm_takedown() during context teardown.

Protect the unmapping sequence with bo_list_lock to ensure the BO is
always fully unmapped when removed from the list. This ensures the BO
is either fully unmapped at context teardown time or present on the
list and unmapped by file_priv_unbind().

Fixes: 48aea7f2a2ef ("accel/ivpu: Fix locking in ivpu_bo_remove_all_bos_from_context()")
Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20251029071451.184243-1-karol.wachowski@linux.intel.com
[ The context change is due to the commit e0c0891cd63b
("accel/ivpu: Rework bind/unbind of imported buffers")
and the proper adoption is done. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/accel/ivpu/ivpu_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index 6b1bda7e130d..b4213e63afb4 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -240,7 +240,6 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
 
 	mutex_lock(&vdev->bo_list_lock);
 	list_del(&bo->bo_list_node);
-	mutex_unlock(&vdev->bo_list_lock);
 
 	drm_WARN_ON(&vdev->drm, !drm_gem_is_imported(&bo->base.base) &&
 		    !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
@@ -248,6 +247,8 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
 	drm_WARN_ON(&vdev->drm, bo->base.vaddr);
 
 	ivpu_bo_unbind_locked(bo);
+	mutex_unlock(&vdev->bo_list_lock);
+
 	drm_WARN_ON(&vdev->drm, bo->mmu_mapped);
 	drm_WARN_ON(&vdev->drm, bo->ctx);
 
-- 
2.34.1


