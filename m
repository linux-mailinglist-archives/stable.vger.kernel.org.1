Return-Path: <stable+bounces-245287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOR9MQkFAmo3nQEAu9opvQ
	(envelope-from <stable+bounces-245287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:34:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5551241D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A37B31343DA
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8D3FBEA3;
	Mon, 11 May 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VG1jFpyC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB3401497
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516709; cv=none; b=qBdqBb0gHiUEhIVY4uDvFKCqmF8ywCLf+mntgZzckgtwmDBjvCqbNk3kCDSMEIj4amOK1yW/wxhQM04vJL1SZjoIpAwviU0XRUnA2HaiFaeqMB3Ho0qlEMxSiMdtcNpUbXOY34w0E4GiU/ekVQSYo90gvbOYYaHhT137giTbq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516709; c=relaxed/simple;
	bh=lwopUE8/yDCHMwZy/+ucK4EpsJaJ9gDkggd5H3h/eZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5zhkRZEB8PwJ3C9VuPB1XT3hrBNrzCB/HMn2B7oK0UdZPq4qe4HnIxlLz2i1/aUr9I9mMjlBBRJWhc3x31T0GnObAt2ziwazeYGzMRCLBqcPLLtlIk1cYL2brWTK4nQsUJEHIypQJgIIBzxyUo2NNxrenxv0KxJCZHE9CUTl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VG1jFpyC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778516708; x=1810052708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lwopUE8/yDCHMwZy/+ucK4EpsJaJ9gDkggd5H3h/eZo=;
  b=VG1jFpyCGBQjIke2BzJ74EKO5RUOgaVtpWasWv8UWwIKhRyOi790NHLE
   QSfkYFBDC95w0ejXIgXX3ftJHn+jZD4yYbxeV3mkVLcMLRRvUu8owvnEm
   qeCZIYgVbg4jdm8CWfSMDPmBBk6lXm8flmHL90LxeySr15I5+KcKOK/hz
   oga1H1tC1VIT4RcBB9WMI+npXgJoBUfMvV8P7m6VlGUwTy3LZDy17zS1r
   xqDxLk9dkiOQZu6ke6dlqfmbReOS4ZZkyz2VW1VrKXyuExs6vrZtJUj5b
   X4dWPEinj7oXDTb3oY0J+VznWKw0g8+gLLEy3D3bJJXv0ElO+yqjla/31
   A==;
X-CSE-ConnectionGUID: 7CbmZC3TRHq1/z1kWV4IQA==
X-CSE-MsgGUID: W3kpuiauQ9+BMCDN0Nu1jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83023047"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83023047"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:25:07 -0700
X-CSE-ConnectionGUID: 8OSRMlNfSUOOjgD1CkPVvg==
X-CSE-MsgGUID: sbKhPI1OTFy9cYaycmlv8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="241489203"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora) ([10.245.244.248])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:25:05 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure
Date: Mon, 11 May 2026 18:24:43 +0200
Message-ID: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38F5551241D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245287-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,intel.com:email,intel.com:dkim,linux.intel.com:mid,lists.freedesktop.org:email]
X-Rspamd-Action: no action

Apply the same fix as b2ed01e7ad ("drm/ttm: Fix ttm_bo_swapout()
infinite LRU walk on swapout failure") to the ttm_bo_shrink() path.

Move del_bulk_move from before the backup to after success only,
using ttm_resource_del_bulk_move_unevictable() since the resource
is now unevictable once fully backed up.

Fixes: 70d645deac98 ("drm/ttm: Add helpers for shrinking")
Cc: Christian König <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.15+
Assisted-by: GitHub_Copilot:claude-opus-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f83b7d5ec6c6..3e3c201a0222 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1112,19 +1112,14 @@ long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 	if (lret < 0)
 		return lret;
 
-	if (bo->bulk_move) {
-		spin_lock(&bdev->lru_lock);
-		ttm_resource_del_bulk_move(bo->resource, bo);
-		spin_unlock(&bdev->lru_lock);
-	}
-
 	lret = ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
 			     {.purge = flags.purge,
 			      .writeback = flags.writeback});
 
-	if (lret <= 0 && bo->bulk_move) {
+	if (lret > 0) {
 		spin_lock(&bdev->lru_lock);
-		ttm_resource_add_bulk_move(bo->resource, bo);
+		ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
+		ttm_resource_move_to_lru_tail(bo->resource);
 		spin_unlock(&bdev->lru_lock);
 	}
 
-- 
2.54.0


