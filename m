Return-Path: <stable+bounces-200485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E29CBCB10DB
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 21:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9366C30B0A76
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 20:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86C2C235E;
	Tue,  9 Dec 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdCxdFAf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD6262FC1
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313394; cv=none; b=HUKyR347eEyfIAl4G13xTIsGz9UH1od4nW1l+hqdnWIbqW76jCAILkKP6FF16K8S06VjEQibb6iv/s8Qd/kAC+pmp2ff1F6QtqpHIlMosFFTXKICedwUZXgIV9V4L9ZYGJ1sRC3cNQ0Y+XjZ27Ef3FNaOxez86q5wkxhSAi76es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313394; c=relaxed/simple;
	bh=xGOPOCm5km5iEeWfZJKFi+xuMvKiI6/Zb+EwuEX2+Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oizlaZx/rzNi+4fYBlht9HahxY2KVh1z5bR2UH8yMr+7hHlLMQUQ6fnifvkf6tXbvPNSpqcYlHTDzL6m76+WZ8i5Y2QhFs0/Q6PdGtECJXPlav5C5tHjmk0TFLujOE0UDHpTnW5hGnnhhYdSGXYfNCdQqEhE0sAsQe5a6hdVa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdCxdFAf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765313392; x=1796849392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xGOPOCm5km5iEeWfZJKFi+xuMvKiI6/Zb+EwuEX2+Yo=;
  b=AdCxdFAfTxSRQSnVks0VhSg5HwH7e6R1Shyw1gJeyF1T+OcG+cXq9Anx
   nLkUYOTA1I61uMaHY8pDScbJ+XrZE2tAdafartdtyUzSwLz+W6CcpZm6m
   5FGC3v5ccrMPPpomYN8UeabQ4jwvrQ/Kz3OPQ7Owf3u6WtfYx0lVfm+0L
   NCuoIuZba9fo5HIXD1WSUvgtG4VTfH1Cmen2C5/GCggaxgE9kMzs3edwT
   T2tBAPeg1eIqmgWSw/kuApsocIauTCqHgc88J46DhRFCWkzd5au2/Rs7S
   wlWHkW5Ay1PMG/rY4phhBkhgmmaaJgu+w+U5XyW2QmKBcxKL5QS9THsIV
   w==;
X-CSE-ConnectionGUID: 5gO6HIxiSc6Pf8tzG/eH0Q==
X-CSE-MsgGUID: 8IjGn52XRR2Q0Luj6dRcEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67175097"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67175097"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 12:49:50 -0800
X-CSE-ConnectionGUID: jkWs4bCGTguTsCMSqdk4CA==
X-CSE-MsgGUID: aGkQ5sY7TpSjIo7OQd3sTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="196369570"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora) ([10.245.245.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 12:49:49 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/bo: Don't include the CCS metadata in the dma-buf sg-table
Date: Tue,  9 Dec 2025 21:49:20 +0100
Message-ID: <20251209204920.224374-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some Xe bos are allocated with extra backing-store for the CCS
metadata. It's never been the intention to share the CCS metadata
when exporting such bos as dma-buf. Don't include it in the
dma-buf sg-table.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 54e42960daad..7c74a31d4486 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -124,7 +124,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
 	case XE_PL_TT:
 		sgt = drm_prime_pages_to_sg(obj->dev,
 					    bo->ttm.ttm->pages,
-					    bo->ttm.ttm->num_pages);
+					    obj->size >> PAGE_SHIFT);
 		if (IS_ERR(sgt))
 			return sgt;
 
-- 
2.51.1


