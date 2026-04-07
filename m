Return-Path: <stable+bounces-233720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HobHBxn1Wm05gcAu9opvQ
	(envelope-from <stable+bounces-233720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:20:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D43B47B4
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F5DB30231D4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1EF3783DE;
	Tue,  7 Apr 2026 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIUZ8Z3I"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780335EDBD
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593240; cv=none; b=cj9udI0ZDIoAK8GFWU1NNMP8qGPvMULwF5q/kI/p+cYuwCfvhKf/SA5cEOxIhL+8WBUKmjU/MTAH0dVg7DqkjiZMU8E4TGOzaNEd4XlT3s7gSo7ol1P0YhhC9WpMQoSSBilyNcJ1gXlkY26VcqGq3K3ljhQFk13kmjNd6EA9MOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593240; c=relaxed/simple;
	bh=nwodmheEQYwnNfMfuAng0eNZhbi/Eemg/3Wh3HnSvbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvPrjZMO9Crq+zH+ZLe7vbDVKHiTi5bjPApd54rCB/D3QTk8yQmmrYwFUadl+bwA5y7NQpsWlN7qfmqdlXTx1RvcGZuvtbp8tk56cgTqR+tRhNQwP5IRDkn19c8pNyjFM0r2LMl+AFLdNqc7+mMlCEuJJ0jfZijpe9IjyMEPGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIUZ8Z3I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775593239; x=1807129239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nwodmheEQYwnNfMfuAng0eNZhbi/Eemg/3Wh3HnSvbU=;
  b=BIUZ8Z3I3ubJSeXKExm3UtYs0tBc5MH6uQwS1w0j81a7VMO51dGfxjWh
   hKyRobxmV7zmVOYgtW6a1RdoFnBngxXfwxiox0vq9KmyJzp1+NLUhZnXu
   F1sE1XmHVTHGoNyZY4PhYv9breiRTC6WLPBE/4ZN+ajDOeYdE70NFUo/b
   iuJxVKqzRrQ+OJhdtqlonbKeSy1oRlhUDW0qtUa3RgSbZ023WR5nd0InC
   mLSr/s4nP/Y3WgCxM0PyM53XxyG//6L9853h6oUm/dfbQ/pM4FsPSwp3p
   28tsf93kOZtwZGwBIgfvaYCkqBqNQkMNVqEU2UFK5BlBdIJ+W/PUMgcQ3
   w==;
X-CSE-ConnectionGUID: SxxNbSxoRU+xsnFkLpYf0w==
X-CSE-MsgGUID: dN/s9T67Q2KXpZS6JNfeJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87268156"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="87268156"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 13:20:39 -0700
X-CSE-ConnectionGUID: PrT8G1H9Q+a+KT95Tdx6Jw==
X-CSE-MsgGUID: ym/+Fl0ZQ1uQf6aCMKjU1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="233231606"
Received: from shosgclin.sh.intel.com ([10.112.232.103])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2026 13:20:37 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] drm/xe: Fix dma-buf attachment leak in xe_gem_prime_import()
Date: Tue,  7 Apr 2026 20:15:42 +0000
Message-ID: <20260407201542.3396317-5-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407201542.3396317-1-shuicheng.lin@intel.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233720-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 096D43B47B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When xe_dma_buf_init_obj() fails, the attachment from
dma_buf_dynamic_attach() is not detached. Add dma_buf_detach() before
returning the error. Note: we cannot use goto out_err here because
xe_dma_buf_init_obj() already frees bo on failure, and out_err would
double-free it.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 24d9d82426b9..7702a6bdaae5 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -370,12 +370,15 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 		goto out_err;
 	}
 
-	/* Errors here will take care of freeing the bo. */
+	/*
+	 * xe_dma_buf_init_obj() takes ownership of bo on both success
+	 * and failure, so we must not touch bo after this call.
+	 */
 	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
-	if (IS_ERR(obj))
+	if (IS_ERR(obj)) {
+		dma_buf_detach(dma_buf, attach);
 		return obj;
-
-
+	}
 	get_dma_buf(dma_buf);
 	obj->import_attach = attach;
 	return obj;
-- 
2.43.0


