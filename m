Return-Path: <stable+bounces-169369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AA1B247BA
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E183AFE0E
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158972F1FFE;
	Wed, 13 Aug 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz/BrJsw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8C2F068D
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082317; cv=none; b=GqXkhJkxMmNy//lWtLuJiMIL9UrENFEicV91YhWVnz+n0V4cjJKIKmrCER1sEX8xLbF1M4qslsni2g6K7OjjGR3TCUQ3rTFrX+r4wn8Y53WC6g3TxDQeM2aPIt2iqARfacgJ+ZGoAW6Y+lbNYjP7a9mwTemEeEW+60ORvvrp+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082317; c=relaxed/simple;
	bh=4rqOygMrK62Mat9scZxA/yc726dLPGBBwSUnHBPU864=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kx51DgK/amwyTKvm3xShBetmQVte1VAcS4MpNO348WjeUAECi3ix56uLsrbsC0fitwZkGyHJkMXcoJMpnsK9W3UZ2oAx6ZMKYoUBJe2EY+W9mgdVBxXJ5tiUGPx0ydmYNFeoSE8l3iokXC1YE51RibSs+TamVOSaAqY+MVyhiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz/BrJsw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755082316; x=1786618316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4rqOygMrK62Mat9scZxA/yc726dLPGBBwSUnHBPU864=;
  b=Iz/BrJswHXILm/UTqKa0BHaI0a8NpJ1P5kreIZ9AdKX29cK2mpTjpbgJ
   dAZ66JxnWGv29YfCan1yTYCt8jht2cqY9MwPuQXgppfg3DlWzjcSmoxp3
   5dTjF44SxL1iTf6ndJWgP9CfxFsXt9VXR8qHml0hNu61Sq3snAyG9iDSA
   BoNq9ihM34QXrjbwa7DzCFRIbreWgV+VxZoRiHAXuRWv8n+2zY8kP5Vdk
   BarZWAwzJgv/7xVQ42F7swqkZUOAaappOo8oZ8QHm8e/qa9zWpiITjoHt
   ubf04e6Ct3zw8Pmd144SFLw8ILJdDc8iVsv5Q/F5PqjQKmZDVuB5p3zWT
   g==;
X-CSE-ConnectionGUID: K2jIjlwaStWvsn4in9535g==
X-CSE-MsgGUID: 0vxoXSq0RCyaiu51CtvBWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57449988"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57449988"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:51:56 -0700
X-CSE-ConnectionGUID: NGyPkn6LRmS+ANSmzxl+uA==
X-CSE-MsgGUID: 3Hs5yEATQR2sotQXsXHPiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166068944"
Received: from agladkov-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.199])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:51:53 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Brian Welty <brian.welty@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 03/15] drm/xe/vm: Clear the scratch_pt pointer on error
Date: Wed, 13 Aug 2025 12:51:09 +0200
Message-ID: <20250813105121.5945-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813105121.5945-1-thomas.hellstrom@linux.intel.com>
References: <20250813105121.5945-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid triggering a dereference of an error pointer on cleanup in
xe_vm_free_scratch() by clearing any scratch_pt error pointer.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 06951c2ee72d ("drm/xe: Use NULL PTEs as scratch PTEs")
Cc: Brian Welty <brian.welty@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_vm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index d40d2d43c041..12e661960244 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1635,8 +1635,12 @@ static int xe_vm_create_scratch(struct xe_device *xe, struct xe_tile *tile,
 
 	for (i = MAX_HUGEPTE_LEVEL; i < vm->pt_root[id]->level; i++) {
 		vm->scratch_pt[id][i] = xe_pt_create(vm, tile, i);
-		if (IS_ERR(vm->scratch_pt[id][i]))
-			return PTR_ERR(vm->scratch_pt[id][i]);
+		if (IS_ERR(vm->scratch_pt[id][i])) {
+			int err = PTR_ERR(vm->scratch_pt[id][i]);
+
+			vm->scratch_pt[id][i] = NULL;
+			return err;
+		}
 
 		xe_pt_populate_empty(tile, vm, vm->scratch_pt[id][i]);
 	}
-- 
2.50.1


