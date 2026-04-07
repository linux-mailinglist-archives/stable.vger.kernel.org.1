Return-Path: <stable+bounces-233717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDwwFhZn1Wm05gcAu9opvQ
	(envelope-from <stable+bounces-233717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:20:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4713B47A4
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFD64301CC5E
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806B377ECE;
	Tue,  7 Apr 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dc8sYB00"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316335EDBD
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593234; cv=none; b=IlQ/BtmXTPkRfBSnh7LjzuczkEFm6TE1gJY6ErV1leUOqHgyqQsxNvgQQv1IOD33uRPj+61W436x9Bvv15OT4OthUlhlgtkf9CQTfqeEvPgwhxYpIJ+BepEPJ2JhGkZlCFF9B21gl7GyVhrQQ1sC1A6247CSWEg03QcL6i3DQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593234; c=relaxed/simple;
	bh=EcrmHavUKndm2lGYIBgasbiFen8md2OQR+b6SHHHeKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7rQNfdXFpZLV4UjwjHnXsnNRnI5+DKcR3Bs4OLh9jnOTf9pV+RmYmsX6ZSzwpIV/hMMRqzS+7aT6/Fz/V/XthNnW/PAyLKHpPYqo7J27shUvi/r2DLKNF18oVDlqt1GeETdZLAxwbAPB0B1em60M3HV0bhCMIQWlRXfDySeKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dc8sYB00; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775593232; x=1807129232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EcrmHavUKndm2lGYIBgasbiFen8md2OQR+b6SHHHeKQ=;
  b=Dc8sYB006r6NGjbXFh8XPa0mO/gpOav8+nsVhhQeHH2BliDRS+uC2Hsa
   28+lCHyibMf14t034Y7fiJdnY99pkrMXcg9FDmdoHfkEJdHI5aYiYhTVb
   WU2ErT9Ov3bBmHIfnazpkK+aD5qFWZ+EEa4dXTy8iLYEv6/+5TmNqlvSB
   baf8nkY3YGwc7uhUVSWJ/pifVWhHn/Xw9P5dQWRzWA7HKB7UvAX1/zISL
   IxuL+gc8hHEtndHn9qIJTdDMnMkrcGyZZFKXrwOXKqBQuNjESy4j+gFmk
   5rHrIUFpvhGEZwdzlKv0cZeClOp055J9cYKJTt9tAG0pq6n6CM0GJYnB4
   Q==;
X-CSE-ConnectionGUID: fR67hq0JQBGtAJ2nxZIxJQ==
X-CSE-MsgGUID: /s9i3wQ5RNyHfTz1sfvytg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87268147"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="87268147"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 13:20:32 -0700
X-CSE-ConnectionGUID: Nkf+RkoQRO+VfxCyksurSw==
X-CSE-MsgGUID: F4HWOUpyTuGoJZKRIZMBTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="233231570"
Received: from shosgclin.sh.intel.com ([10.112.232.103])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2026 13:20:30 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/xe/bo: Fix bo leak on unaligned size validation in xe_bo_init_locked()
Date: Tue,  7 Apr 2026 20:15:39 +0000
Message-ID: <20260407201542.3396317-2-shuicheng.lin@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233717-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: BC4713B47A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When type is ttm_bo_type_device and aligned_size != size, the function
returns an error without freeing a caller-provided bo, violating the
documented contract that bo is freed on failure.

Add xe_bo_free(bo) before returning the error.

Fixes: 4e03b584143e ("drm/xe/uapi: Reject bo creation of unaligned size")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index b70e8396e56f..6e4ebbe72952 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2342,8 +2342,10 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 		alignment = SZ_4K >> PAGE_SHIFT;
 	}
 
-	if (type == ttm_bo_type_device && aligned_size != size)
+	if (type == ttm_bo_type_device && aligned_size != size) {
+		xe_bo_free(bo);
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (!bo) {
 		bo = xe_bo_alloc();
-- 
2.43.0


