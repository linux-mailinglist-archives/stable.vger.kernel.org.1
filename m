Return-Path: <stable+bounces-268772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jiBYEX0uPmoEBAkAu9opvQ
	(envelope-from <stable+bounces-268772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 09:47:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88546CB0CF
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 09:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="UQktW/sG";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268772-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268772-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C49433020030
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1853B3E2AB9;
	Fri, 26 Jun 2026 07:47:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC730F52B;
	Fri, 26 Jun 2026 07:46:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460020; cv=none; b=Yn95mbp/BAvzyxQeksfCOi47v3WJGocwdp8b98mKeAjOVrfhXFMKAVOVwJi+soc5vtOthhvw+332IaeQIToofm0BoKRzSSUSgP587vKlXwsV0y08r7rQBITn36IxWguKl8mNsK3M8cL4WtypYoxTN1l5oTJS8j/BukVwI1BIyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460020; c=relaxed/simple;
	bh=e3IG+R5dVcnKL4ygLKeL0m2vEuU45wiOiGT8SBpf4eY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TIzGrkssUMCAxMbZLYSgp3Vi5WS6c/IMkXE+qA5j79uDijnRaVdu5I0tSEMXLq1Ei77M31eBgeHi5GA09G4KRbFyf0jTk7Kn6deRNYVeZY57FGoF4GYwZuL+xfGUkqQh9S95bqwnnG8ba2W132+NfhZC4RIAi3EiV2cELT9p7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQktW/sG; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782460020; x=1813996020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e3IG+R5dVcnKL4ygLKeL0m2vEuU45wiOiGT8SBpf4eY=;
  b=UQktW/sGUsk4kf+l4f9iToYF/ur+JcVeoL2MdA8PkSACmyzEe5qmSlPR
   +2p/VWxzQ4avlrkCka55xv4ZmheSmcyUFjgbOxLZfUrobnbaiNkeI/oEF
   n4P9SWkt7W8JyE/FWBUbl0AWfw5HAJNkKRKhUnfp2tl9RGymjpujf14Y/
   CANap0WtzdfuHjl1ZyfDdVIlq7ETyfusuL3gZ0OFiJafsd2XT032A4fFf
   266uaMwxvWg0JrhL+abBlEB3Svo3+hPJfe++CG+O00g8oWcKCPmoJS67a
   NqZwJCxqvt09DKZTj17IY79y7UVq/jT/LTAl/Cx6TTc7rr4tfjRh8B5FP
   A==;
X-CSE-ConnectionGUID: 9UQN9HZORvCOOBXd30fZrg==
X-CSE-MsgGUID: FESa2F5KRH2eW3E1r2ji8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83022639"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83022639"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:46:59 -0700
X-CSE-ConnectionGUID: NdUpLxY3SBWPzMmklOKPQw==
X-CSE-MsgGUID: HBLSC6LcQ+GSKqajZFZ5BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247304328"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:46:58 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Account for NULL pages in ttm_pool_backup
Date: Fri, 26 Jun 2026 00:46:53 -0700
Message-Id: <20260626074653.1326683-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268772-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:thomas.hellstrom@linux.intel.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,lists.freedesktop.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A88546CB0CF

Pages in ttm_pool_backup can be NULL, and set_pages_array_wb() cannot
handle NULL entries. Switch to set_pages_wb() after checking for NULL
pages.

Fixes the following oops:

Oops: general protection fault, kernel NULL pointer dereference 0x0: 0000 [#1] SMP NOPTI
RIP: 0010:__cpa_process_fault+0xf8/0x770
RSP: 0018:ffffc90000a87718 EFLAGS: 00010287
RAX: 0000000000000000 RBX: ffffc90000a87868 RCX: 0000000000000000
RDX: 0000000000001000 RSI: 0005088000000000 RDI: ffffffff827c5f34
RBP: 0005088000000000 R08: ffffc90000a877cb R09: ffffc90000a877d0
R10: 0000000000000000 R11: 000000000000001b R12: 000ffffffffff000
R13: ffffc90000a87868 R14: ffffc90000a87868 R15: ffff88815b882ae0
FS:  0000000000000000(0000) GS:ffff8884ec840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f930b844000 CR3: 000000000262e003 CR4: 0000000008f70ef0
PKRU: 55555554
Call Trace:
 <TASK>
 __change_page_attr_set_clr+0x989/0xe90
 ? __purge_vmap_area_lazy+0x6c/0x3a0
 ? _vm_unmap_aliases+0x250/0x2a0
 set_pages_array_wb+0x7f/0x120
 ttm_pool_backup+0x4c9/0x5b0 [ttm]
 ? dma_resv_wait_timeout+0x3b/0xf0
 ttm_tt_backup+0x32/0x60 [ttm]
 ttm_bo_shrink+0x66/0x110 [ttm]
 xe_bo_shrink_purge+0x12b/0x1b0 [xe]
 xe_bo_shrink+0xbb/0x270 [xe]
 __xe_shrinker_walk+0xf7/0x160 [xe]
 xe_shrinker_walk+0x9d/0xc0 [xe]
 xe_shrinker_scan+0x11f/0x210 [xe]
 do_shrink_slab+0x13b/0x270
 shrink_slab+0xf1/0x400
 shrink_node+0x352/0x8a0
 balance_pgdat+0x32c/0x700
 kswapd+0x205/0x2f0
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __pfx_kswapd+0x10/0x10
 kthread+0xd1/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1b1/0x200
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 49 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 682ae4f40424..ea14447411a6 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1064,34 +1064,33 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	    ttm_pool_uses_dma_alloc(pool) || ttm_tt_is_backed_up(tt))
 		return -EBUSY;
 
-#ifdef CONFIG_X86
-	/* Anything returned to the system needs to be cached. */
-	if (tt->caching != ttm_cached)
-		set_pages_array_wb(tt->pages, tt->num_pages);
-#endif
+	for (i = 0; i < tt->num_pages; i += num_pages) {
+		unsigned int order;
 
-	if (tt->dma_address || flags->purge) {
-		for (i = 0; i < tt->num_pages; i += num_pages) {
-			unsigned int order;
+		page = tt->pages[i];
+		if (unlikely(!page)) {
+			num_pages = 1;
+			continue;
+		}
 
-			page = tt->pages[i];
-			if (unlikely(!page)) {
-				num_pages = 1;
-				continue;
-			}
+		order = ttm_pool_page_order(pool, page);
+		num_pages = 1UL << order;
 
-			order = ttm_pool_page_order(pool, page);
-			num_pages = 1UL << order;
-			if (tt->dma_address)
-				ttm_pool_unmap(pool, tt->dma_address[i],
-					       num_pages);
-			if (flags->purge) {
-				shrunken += num_pages;
-				page->private = 0;
-				__free_pages_gpu_account(page, order, false);
-				memset(tt->pages + i, 0,
-				       num_pages * sizeof(*tt->pages));
-			}
+#ifdef CONFIG_X86
+		/* Anything returned to the system needs to be cached. */
+		if (tt->caching != ttm_cached)
+			set_pages_wb(page, 1 << order);
+#endif
+
+		if (tt->dma_address)
+			ttm_pool_unmap(pool, tt->dma_address[i],
+				       num_pages);
+		if (flags->purge) {
+			shrunken += num_pages;
+			page->private = 0;
+			__free_pages_gpu_account(page, order, false);
+			memset(tt->pages + i, 0,
+			       num_pages * sizeof(*tt->pages));
 		}
 	}
 
-- 
2.34.1


