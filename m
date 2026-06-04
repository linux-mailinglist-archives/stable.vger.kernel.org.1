Return-Path: <stable+bounces-260360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NbRrMsBMIWpBCwEAu9opvQ
	(envelope-from <stable+bounces-260360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:00:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B263EC18
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:00:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TrfIVjHv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260360-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260360-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78E6C3096E68
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849F12773FF;
	Thu,  4 Jun 2026 09:47:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5636A36B
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 09:47:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566447; cv=none; b=kZHtHVHMi6CW6oIKXAPxEVWv7ft4RDMWRbL9GTIadNl/OFztO8d9vJ/LzWFcQSNX+5h9JfBR1RkZrzCnfDufw/Cm8Mt3zE8HVLFDcp3fehMA6USsZge2Gyk0dXUPFQ71pmXAleTM5Ot/WRL1WMxRNeWFPKdBTkqkUCWfzlH1Rnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566447; c=relaxed/simple;
	bh=7zjpdh6oSs6AzbIICc9QTMPLzGWJFXjunDw5u+bcy/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osxvu2IxtLmeqB02QcT2XDBqLjPQc2hpOpb7j7fSrw596FLvhacNtJxni3/23Bapv4/id9cvw9v+foPd7dc/70fivN954JfmYuJqm/Raz3c+H9L0Oovdsjo304zq8dYSv4jBSPD9n6x/1+lA9OCvrAziwEtx7faq/qf+vTDH1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrfIVjHv; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780566446; x=1812102446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7zjpdh6oSs6AzbIICc9QTMPLzGWJFXjunDw5u+bcy/E=;
  b=TrfIVjHvRXxyqH+sXMTPl87eIbjj99fKPHap0v+EdGdsMvLEoYEbHdgU
   POXldEnWXtW6N8ig8suYWUz5DwFPnfG8X9TME2FXby8CXcLS3o0fHjlVG
   yWvGHafX8doEAiEF/PJu6kzx/6o8MOtp+fC6r3l3s5DBAUrTLLBR3K639
   oD3R7aA5WMu+LtGTqbJbezmuuKBSoLsiKrXAvAku4tyyMkqCU31h6qaIh
   mswyr39qxC+H4fvu5k2Bd1oMT/UtxW5omADNNMcrgn27OywFjOydQ/lkR
   vhvqZvn6pStDgtjLv2EUgzHHUUYc1pNKEXgTrA1HqJglkq9Wyelim8U+k
   g==;
X-CSE-ConnectionGUID: 092JSycvQJ2smOpg1NL3pA==
X-CSE-MsgGUID: 9L2fjcS0RjeS+1HyuwKC0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810336"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98810336"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:47:26 -0700
X-CSE-ConnectionGUID: JT5USxL7SkCw0jl1p2Cv9g==
X-CSE-MsgGUID: EA4IqH5mSg2m0bkesMFMLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282601718"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
  by orviesa001.jf.intel.com with ESMTP; 04 Jun 2026 02:47:23 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nitin Gote <nitin.r.gote@intel.com>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Christian Konig <christian.koenig@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach failure
Date: Thu,  4 Jun 2026 15:53:20 +0530
Message-ID: <20260604102319.1812827-2-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260360-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:nitin.r.gote@intel.com,m:stable@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:christian.koenig@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nitin.r.gote@intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[nitin.r.gote@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B71B263EC18

xe_dma_buf_create_obj() creates the importer BO with obj->resv
pointing at the exporter's dma_buf->resv. When dma_buf_dynamic_attach()
fails, no dma_buf reference is held so the exporter can be freed
immediately. Since ttm_bo_release() now always defers cleanup for
ttm_bo_type_sg BOs to the TTM workqueue, the worker later calls
dma_resv_lock() on the already-freed exporter resv, causing a UAF.

Switch obj->resv to the BO's private _resv under lru_lock before
dropping the last reference, mirroring ttm_bo_individualize_resv().
lru_lock is needed because the BO is already on the LRU list and
the shrinker can read bo->base.resv concurrently.

Observed with igt@xe_live_ktest@xe_dma_buf_kunit on BMG (QEMU):

  Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b9c
  Workqueue: ttm ttm_bo_delayed_delete [ttm]
  RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
  Call Trace:
   <TASK>
   ? __ww_mutex_lock.constprop.0+0x2dd/0x18e0
   ? ttm_bo_delayed_delete+0x41/0xc0 [ttm]
   ww_mutex_lock+0x3c/0xb0
   ttm_bo_delayed_delete+0x41/0xc0 [ttm]
   process_one_work+0x239/0x740
   worker_thread+0x200/0x3f0
   kthread+0x10d/0x150
   ret_from_fork+0x3bd/0x470
   ret_from_fork_asm+0x1a/0x30
   </TASK>

v2: Switch resv to &obj->_resv under lru_lock
    (Matthew Auld)

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Cc: stable@vger.kernel.org # v6.8+
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 8a920e58245c..e3ccb3cc6218 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -384,6 +384,16 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 
 	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
 	if (IS_ERR(attach)) {
+		/*
+		 * Attach failed with no dma_buf ref held; switch resv to the BO's
+		 * private _resv under lru_lock before the last put, so
+		 * ttm_bo_delayed_delete() doesn't dereference the stale exporter
+		 * resv.
+		 */
+		spin_lock(&gem_to_xe_bo(obj)->ttm.bdev->lru_lock);
+		obj->resv = &obj->_resv;
+		spin_unlock(&gem_to_xe_bo(obj)->ttm.bdev->lru_lock);
+
 		xe_bo_put(gem_to_xe_bo(obj));
 		return ERR_CAST(attach);
 	}
-- 
2.50.1


