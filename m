Return-Path: <stable+bounces-233719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMDNIGxn1Wm05gcAu9opvQ
	(envelope-from <stable+bounces-233719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:22:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C814B3B480E
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EB0B302966C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226153783DE;
	Tue,  7 Apr 2026 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ag/BeRR9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414B3783C3
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593237; cv=none; b=LFEmz5XAiT5xw7BwaJ7T9+OJP+HxH+OjVHRpTt+JowW5opVgdve61pAXigCD21p+ZuS4i3owwkqwR0RmoS0Msv4YHWP/TBJtslssRejTMrx7ylg6PcfrfzyeNhBINQHO9hswmIo3XdMayYLrzoz/xvl5ZvIQHK/IW3tXqD1RsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593237; c=relaxed/simple;
	bh=lOrt+2LaP42yZ3B1bpDURZfcXn0SuRnqjpSnPDCOwv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrp2iyg8HOZkppIuNDGskC6GcCvtBqTHl9LTDzp+J7aW3arJAggwDG4UQXzCTU8e7rbmys1DI45cg1PjtoYBkRapFs+09bjork8UG/wbR7o1fAx6VBGuIgb1y6zQlGSa0OmjmIZ4EiF/Zu1n+zovOY6dsXA9Pkk84IuFQsY3/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ag/BeRR9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775593237; x=1807129237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lOrt+2LaP42yZ3B1bpDURZfcXn0SuRnqjpSnPDCOwv8=;
  b=ag/BeRR9XnbtgBvWZLboEnI/0lSBBDEzQTfErJS8wpUf9ps5uVawVZ9E
   wTgkqBjtv9F2d6JG1PxNeSzvqKWs/i7vfYAQ8ic4dUvEIuV01zox56Jla
   ADBm/l8wyUei5VEu9Uy5vgm+nXYM8JR8RDUIPgz6OkA08yaD1Rldup0oX
   t/y9ADjgZvc/6132+Kric3PM9V1ON0brRrcgV2OQuv7jCyJWj/UZDtxsv
   6Lcj6AG1xniD2gd9bdV5hOcorSyv3qVdDCnJSaLYYW6GScVysqmnOvkHF
   P0An29mHDC6tB1dZUOUFP8GjanySQSQDlBlhL/r6y/cJWqcxlGjSx/Aao
   w==;
X-CSE-ConnectionGUID: TitnvouzTlqcuIfRT+MEAA==
X-CSE-MsgGUID: TR77hdUTRfuk0dGwNvJ7+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87268152"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="87268152"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 13:20:36 -0700
X-CSE-ConnectionGUID: fUqYcaX+QPWtmjtDuvDbDw==
X-CSE-MsgGUID: f3xPo4qITriWfXyJQ1iqbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="233231598"
Received: from shosgclin.sh.intel.com ([10.112.232.103])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2026 13:20:35 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] drm/xe: Fix bo leak in xe_dma_buf_init_obj() on allocation failure
Date: Tue,  7 Apr 2026 20:15:41 +0000
Message-ID: <20260407201542.3396317-4-shuicheng.lin@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233719-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C814B3B480E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When drm_gpuvm_resv_object_alloc() fails, the pre-allocated storage bo
is not freed. Add xe_bo_free(storage) before returning the error.

Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive eviction")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 7f9602b3363d..24d9d82426b9 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -271,8 +271,10 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 	int ret = 0;
 
 	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
-	if (!dummy_obj)
+	if (!dummy_obj) {
+		xe_bo_free(storage);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	dummy_obj->resv = resv;
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, ret) {
-- 
2.43.0


