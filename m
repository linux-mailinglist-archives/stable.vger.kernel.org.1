Return-Path: <stable+bounces-148081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C49FAC7BDD
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B163B7BDA
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8C26B2D7;
	Thu, 29 May 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOyADN3f"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623019E826;
	Thu, 29 May 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515135; cv=none; b=hTlArhO4e72InZawmYqjqTqxSMB+sWwcx7z0c0hJy2Vb8QWicD8S05lxV/R7JvGwC9PDuTKXj1a9kzv55TxaE840yyZ+x7m9R+hZPmpj7jSiNmyc82cs6JWVVIA8E6PEj2ZDAtaL6K/Q8JnqYO4VYb8XY/Spf/2bcIRsDJk2Cg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515135; c=relaxed/simple;
	bh=3bwpOAfDP2xis2b8Ms1ESGPRgcgZxfOUstbNhdd9Crs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwwkdQKefypYyEagy1s42Wa3kP50B15XMuT18FdYUYPrXZLp45exr/EFvCMwVF5Iqzl0xtS4PMp/IkC/jCnvxpTfWkWCyiSoqPVX9Wq9sz5bID3riMkio9htXzuwmVRUAttb2NAhH3bAP29l2ggK+AJvbrkZozdEiG8szp1eb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOyADN3f; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748515134; x=1780051134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3bwpOAfDP2xis2b8Ms1ESGPRgcgZxfOUstbNhdd9Crs=;
  b=GOyADN3f20FCRRutkkukzJxAZInwFTaNHz7MANf8DjyS5V5v2Ho+r06k
   dyn6UqD37RFqQj+duMvWYat6dxu1zp1WHmynEJT4A5iGry1S+nW7W5umA
   dgoi+rs0zqTloPnCTOIe/YqQu2RHKZC2XQeO4F32lgcgyhCsDkLaVRazF
   TBm+XJB6TxnaSz31t+cVRLslQ6jQkxqZadgTs8VbuYbGlQL+NJa+hj8cM
   FmPozjXzwYGXAzNmYATQuK3UDgb2YV5rtBoWwh+BwFb0DNEjn1whcecsy
   2dA5Kp9c7/qZxnnZb7J9+6NRvHV1HZ25icnsOlcbBNg6jUzRRlAIjEeIB
   g==;
X-CSE-ConnectionGUID: ajU8j2yyQcaFcsu7+Ik/hA==
X-CSE-MsgGUID: YyiG/+GQTHO4d05ALFYgLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61234488"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="61234488"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 03:38:53 -0700
X-CSE-ConnectionGUID: 29giuBGfRmO0SF7iSjqTIQ==
X-CSE-MsgGUID: CpJhmQdlReS4TLagMLLVZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="144511733"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 29 May 2025 03:38:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4057414B; Thu, 29 May 2025 13:38:47 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
Date: Thu, 29 May 2025 13:38:32 +0300
Message-ID: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hongyu noticed that the nr_unaccepted counter kept growing even in the
absence of unaccepted memory on the machine.

This happens due to a commit that removed NR_BOUNCE: it removed the
counter from the enum zone_stat_item, but left it in the vmstat_text
array.

As a result, all counters below nr_bounce in /proc/vmstat are
shifted by one line, causing the numa_hit counter to be labeled as
nr_unaccepted.

To fix this issue, remove nr_bounce from the vmstat_text array.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Fixes: 194df9f66db8 ("mm: remove NR_BOUNCE zone stat")
Cc: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 mm/vmstat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4c268ce39ff2..ae9882063d89 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1201,7 +1201,6 @@ const char * const vmstat_text[] = {
 	"nr_zone_unevictable",
 	"nr_zone_write_pending",
 	"nr_mlock",
-	"nr_bounce",
 #if IS_ENABLED(CONFIG_ZSMALLOC)
 	"nr_zspages",
 #endif
-- 
2.47.2


