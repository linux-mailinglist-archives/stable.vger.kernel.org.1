Return-Path: <stable+bounces-126045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D068A6FB71
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550111899CC4
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D99259CAD;
	Tue, 25 Mar 2025 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ug4EAGJY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AD265627
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905156; cv=none; b=H8R63z/zEj3rnVvykwyB7VFrH9FLcd3nCDbGEDYLsmdeLonnCPSOVirGBRBZqqvfSyedy0sVGUZgEl2nHwp4KENW0gZ4VaPuhcF22WeR8jCrXnYDWyNq3BsghAAI2/pNVRfRlu4sJ4+GZwciEMSIt+qRqKzJSKJihQHCPvuphzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905156; c=relaxed/simple;
	bh=5kH1KO8WDs5aIZd9WwwTtnXTdH4djBhFZ6Hvt1YKRCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX4hCgn9E8x9qCAbRAiYc0SUdZiApWLAPPFyI4+mEW0ipHp5YVM+SNm4w3+hcVnIvL/xwhgjH4XDw5XImVzwvzn4dwK4OfBvn5E4ZpTKqSJ2g1/VMfKmLaHqYovkvSWnZ0JC/uBX8cbEeuATVRY506DLHmx20hC57GsyHIkfZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ug4EAGJY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742905154; x=1774441154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5kH1KO8WDs5aIZd9WwwTtnXTdH4djBhFZ6Hvt1YKRCg=;
  b=Ug4EAGJYk7pNC/yYO280GaCwIlk+i8C6wep6meJwPT/Q0fCJ0goWcPeN
   2Mg6qISJraJXESn78jOoPkABotc8BkkSCI+72UGKYJ1GxPYvQ3nxyKYm9
   45Ky+QE8NvyA5ekkLI/NXU8gh0OKLu50PdX69HJWGt9CC4JGTNWjk2eql
   8DMnll79vs9Noz9d6JdmnJpka6piD7z/tycuRITz4yM4c6fnZXh+J9c4y
   bzzS1CRoQWypXP5j2YkkdOVouSRl338XEeCULng16OLTEuWDjiywdsYF+
   yZKnZfeFihbwpgAttVd9lA4I3CajkM2e0F/Xd9zG4GljmTeR129cemNd+
   Q==;
X-CSE-ConnectionGUID: 9GmPzi6KTDSUp581wcqHEA==
X-CSE-MsgGUID: ovw1hVhnTJ6Bwa+iOwHocA==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="55518323"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="55518323"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 05:19:14 -0700
X-CSE-ConnectionGUID: yGiuUG3vR/emptbm68gb9A==
X-CSE-MsgGUID: mdYZFPAyTpmjxGXZZJZjrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="155373146"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 25 Mar 2025 05:19:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 00CE6367; Tue, 25 Mar 2025 14:19:09 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	David Hildenbrand <david@redhat.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Thomas Lendacky <thomas.lendacky@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/page_alloc: fix memory accept before watermarks gets initialized
Date: Tue, 25 Mar 2025 14:16:21 +0200
Message-ID: <20250325121621.2011574-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025032417-prior-uncooked-bf1f@gregkh>
References: <2025032417-prior-uncooked-bf1f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Watermarks are initialized during the postcore initcall.  Until then, all
watermarks are set to zero.  This causes cond_accept_memory() to
incorrectly skip memory acceptance because a watermark of 0 is always met.

This can lead to a premature OOM on boot.

To ensure progress, accept one MAX_ORDER page if the watermark is zero.

Link: https://lkml.kernel.org/r/20250310082855.2587122-1-kirill.shutemov@linux.intel.com
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reported-by: Farrah Chen <farrah.chen@intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Thomas Lendacky <thomas.lendacky@amd.com>
Cc: <stable@vger.kernel.org>	[6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 800f1059c99e2b39899bdc67a7593a7bea6375d8)
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 191f0f95d3ed..bc62bb2a3b13 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6653,7 +6653,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 
 static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
-	long to_accept;
+	long to_accept, wmark;
 	bool ret = false;
 
 	if (!has_unaccepted_memory())
@@ -6662,8 +6662,18 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
+	wmark = high_wmark_pages(zone);
+
+	/*
+	 * Watermarks have not been initialized yet.
+	 *
+	 * Accepting one MAX_ORDER page to ensure progress.
+	 */
+	if (!wmark)
+		return try_to_accept_memory_one(zone);
+
 	/* How much to accept to get to high watermark? */
-	to_accept = high_wmark_pages(zone) -
+	to_accept = wmark -
 		    (zone_page_state(zone, NR_FREE_PAGES) -
 		    __zone_watermark_unusable_free(zone, order, 0) -
 		    zone_page_state(zone, NR_UNACCEPTED));
-- 
2.47.2


