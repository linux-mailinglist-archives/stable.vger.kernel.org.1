Return-Path: <stable+bounces-73591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07996D708
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 13:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6681C24DA5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B5819924A;
	Thu,  5 Sep 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKqWKhXn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79CF1991AC
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535535; cv=none; b=XVXPSEHPBCcpIPJUpo3n6WVQ2Xsqs1UAk2dSrYx6KRMxqo5vKemtiV9aMmsT5ayyBRbPMJz9k8bWuULaqH+uSdxNVMgxX238KvI0CQZxfogBRPfsKrQEeZFAw/z570f7jgRiipDj7VrYWq6pXzbyw6pnJYKSfTqlXx8QYfgekRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535535; c=relaxed/simple;
	bh=j8Ldpm8iCkYgj2my+479dHGIPt74KD7gfUIog73lHic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bASS8EJkCOZEnJSOEDJZSXE65JMehHb3vAp4HVp++mxgMfvirQ9lBPIvosz4jM5Yhwgj0Ssyd6dp56LAf3DEp+AX0yD8lKQE4lJf0aZWRXyVjADy0EdIdLIoRWRKFqJofLgjCkgnnIxSqwkhZ6qddisQWYANrV7EMwOEClP/UM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKqWKhXn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725535534; x=1757071534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j8Ldpm8iCkYgj2my+479dHGIPt74KD7gfUIog73lHic=;
  b=hKqWKhXna0OykRw8Za/IOW+XMBY4ZyCmCD+YOr3AqVp/r/vg+ybnF4Ew
   mZYG5n7KuCCF1BkRaLZZ4VUgRihu/uy+f+9oq4H7ScsuXoHooyVsbVh5c
   4iVGiiHXm2SKJzW5Tw/VBu7Zqvwe9hjc25Os0ADM2bzmZ5PW3tTAJMKTY
   orHC7xb6YMKs37m3sdCpdKkaU4HCpBQ4TYTrM9nqg7cAkcLV5LAPbXx0F
   q3UkkGip1Bvnutdz6d6Si7Aq2xwPet+j1hcFMghCjvX1gLty0p6Pzohie
   Yh/XvSFcsFen0ZRJqMeaKtUcj3obqnurlO5phihLiWLJLHD2Ei7kQN06n
   A==;
X-CSE-ConnectionGUID: ROIZqA0GReSa5JeNpihx8A==
X-CSE-MsgGUID: kKO7LSlqTV29qa/c9rdYRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34816328"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34816328"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:25:34 -0700
X-CSE-ConnectionGUID: izNM5Pu4RAm1sqLYHcUJGw==
X-CSE-MsgGUID: VkgNiS/ES+2++lPfirgvHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70389059"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:25:32 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/bios: fix printk format width
Date: Thu,  5 Sep 2024 14:25:19 +0300
Message-Id: <20240905112519.4186408-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

s/0x04%x/0x%04x/ to use 0 prefixed width 4 instead of printing 04
verbatim.

Fixes: 51f5748179d4 ("drm/i915/bios: create fake child devices on missing VBT")
Cc: <stable@vger.kernel.org> # v5.13+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index cd32c9cd38a9..daa4b9535123 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -2949,7 +2949,7 @@ init_vbt_missing_defaults(struct intel_display *display)
 		list_add_tail(&devdata->node, &display->vbt.display_devices);
 
 		drm_dbg_kms(display->drm,
-			    "Generating default VBT child device with type 0x04%x on port %c\n",
+			    "Generating default VBT child device with type 0x%04x on port %c\n",
 			    child->device_type, port_name(port));
 	}
 
-- 
2.39.2


