Return-Path: <stable+bounces-233961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNu8DvyW1mlSGggAu9opvQ
	(envelope-from <stable+bounces-233961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:57:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFC43BFE3A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3023013A60
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE143D8904;
	Wed,  8 Apr 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLh3WwM3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09623D669A
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671028; cv=none; b=bRjUry61mjTQeBAH3mZ3y65aQbLhjdRT/iXmu4nMgYU+3IZxIC+oAZwks08wNL0Bwex3O4uVOiVBTV8HoF71LPTWXdPogzg9MQk5z0Ge/jdqPv9mkD0PJQnhiE/UYgAzVJ6/snO/8tA/pUFAZQ/qLbwPVwxswL8BaPsqLZH5Ngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671028; c=relaxed/simple;
	bh=2zaMY3F7oFRVz7Dea0591yLbfq8b8yX7osp+i4bkhNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdnFED2GE8gsfFPiIjJaJkBE2eY34KaoGRlsGlzKI03S+qJY/DmgrvlBnUj/9nOOVdcADRoej+DHUZFw6cfC1ymTRN0RkYqwwJeBlw0p+D1Hm1wzWpw02Lh6N87iLqDtwwmDquOr8ue3REX7e4ZQEEq6YCZDZJT9nTXplLEUPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLh3WwM3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775671027; x=1807207027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2zaMY3F7oFRVz7Dea0591yLbfq8b8yX7osp+i4bkhNo=;
  b=WLh3WwM3JguZbAi5gYw3wk3Op9YWukCZSLCNjHXZwdyUkMntyysMzyQQ
   LHVXl6L8+840DOSvDUdT1o7NRxktwCTNuo+gC4FXBgB884WHfl/t8LfqI
   CWtjLYgDfS7DRl7xvqF4PVhXFafFUQh1Wb8G/pnbO+ykVr+nKyAK0fZOg
   CbNs83+90WZFfHob2QmJFla349NrSDRw4qIJdqTF8cmK1ZQ2ZPK7S5gmh
   rYv2QabwBCUuYl+XU5I2ZNA2DNJzDC216CEDZVkBzdLDYRblFw38joH6A
   zg9Ui8hW+FnP+GGoWVm64mYTsoFurW6WJuS+/ayhHSB2w43bSnQ/a1Ngq
   Q==;
X-CSE-ConnectionGUID: UiLS5Q3QRW2WjJnUOnGdeQ==
X-CSE-MsgGUID: OXgvfXejSdu5wIWolh2BEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76567687"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76567687"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 10:57:06 -0700
X-CSE-ConnectionGUID: r9LsF5CpTN+OfinSWHZ2Eg==
X-CSE-MsgGUID: Veh+xoPYRFufRQ/lpab7PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="233418803"
Received: from shosgclin.sh.intel.com ([10.112.232.103])
  by fmviesa005.fm.intel.com with ESMTP; 08 Apr 2026 10:57:05 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2 3/4] drm/xe: Fix bo leak in xe_dma_buf_init_obj() on allocation failure
Date: Wed,  8 Apr 2026 17:52:54 +0000
Message-ID: <20260408175255.3402838-4-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260408175255.3402838-1-shuicheng.lin@intel.com>
References: <20260408175255.3402838-1-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233961-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFFC43BFE3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When drm_gpuvm_resv_object_alloc() fails, the pre-allocated storage bo
is not freed. Add xe_bo_free(storage) before returning the error.

xe_dma_buf_init_obj() calls xe_bo_init_locked(), which frees the bo on
error. Therefore, xe_dma_buf_init_obj() must also free the bo on its own
error paths. Otherwise, since xe_gem_prime_import() cannot distinguish
whether the failure originated from xe_dma_buf_init_obj() or from
xe_bo_init_locked(), it cannot safely decide whether the bo should be
freed.

Add comments documenting the ownership semantics: on success, ownership
of storage is transferred to the returned drm_gem_object; on failure,
storage is freed before returning.

v2: Add comments to explain the free logic.

Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive eviction")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 7f9602b3363d..c0937c090d33 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -258,6 +258,13 @@ struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
 	return ERR_PTR(ret);
 }
 
+/*
+ * Takes ownership of @storage: on success it is transferred to the returned
+ * drm_gem_object; on failure it is freed before returning the error.
+ * This matches the contract of xe_bo_init_locked() which frees @storage on
+ * its error paths, so callers need not (and must not) free @storage after
+ * this call.
+ */
 static struct drm_gem_object *
 xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 		    struct dma_buf *dma_buf)
@@ -271,8 +278,10 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 	int ret = 0;
 
 	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
-	if (!dummy_obj)
+	if (!dummy_obj) {
+		xe_bo_free(storage);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	dummy_obj->resv = resv;
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, ret) {
@@ -281,6 +290,7 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 		if (ret)
 			break;
 
+		/* xe_bo_init_locked() frees storage on error */
 		bo = xe_bo_init_locked(xe, storage, NULL, resv, NULL, dma_buf->size,
 				       0, /* Will require 1way or 2way for vm_bind */
 				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);
-- 
2.43.0


