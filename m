Return-Path: <stable+bounces-204120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674CACE7D45
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F3F03060250
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A143321BD;
	Mon, 29 Dec 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuiJeaZU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF633122E;
	Mon, 29 Dec 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033300; cv=none; b=M5mYlOsJkhWwpbQqQP+raZ1zNpvuJtopFR3V9dUqGCD6cpnxG7IS+VTs+4W4DB5cUwJMeyW55zy3IPJRww46KGmXv3K6LarnEO4VqROKodecPkbKoq3FoQbC+VRpRIYYcAUKF38+FEPEPi21FCOE/kPeva9ry7yeAD/CLqRB4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033300; c=relaxed/simple;
	bh=VLsmDFWtMsuAsB/lyKJEUjtf1LGGqwugmcXpvfUHRzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9HkcJHfocqZvVuKLVSkCV+6LCyIWcx0wrxhwErQbj8h578BHjV/xnYj0PAQDAc/VPpkF3zi2YUysp1nUFFC6YoK681T98VLdxbRrvMghAkwsXyvUZXdw1agM4xnLetNXTzCcWJyCVHupK+cMjMcrz1YyeRWqN+Fi0WhjNcIugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuiJeaZU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767033299; x=1798569299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VLsmDFWtMsuAsB/lyKJEUjtf1LGGqwugmcXpvfUHRzk=;
  b=OuiJeaZUYGDQYbWOiY1Ho8PE0KTO32uehn5q8FFQQ5XiQZOIUDYPeAAC
   i7BkRaStElYt2Wwn7JhON1Lv19zgysNd4VT3WT+XfmWHa7TnDI8QRPpY8
   ZvpQjdPMJnfT7mINOUKpQvJPOleh5XbGPdli4TSyHZkO40aI08FBB1w0T
   AydkLdmocObt654angL46Ah43QUuREcJTEmPdSX1MH/1jkwzt3XQPjq6R
   ty6fRpAJpjELwYevGR65EyJGURpgxSjiDSmMl1B/hutZJMSpyLBlofTnY
   2o+/j6hq94aWC6AlxdqLxD9q4EPEWp7SMNF9nVrQ/JyTaTg1NH3zROfrn
   w==;
X-CSE-ConnectionGUID: PvnjQcG+Qf+hxt7cqGStEw==
X-CSE-MsgGUID: DzoPtNWGQcqCAcnJ++IwsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="86218720"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="86218720"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 10:34:56 -0800
X-CSE-ConnectionGUID: x54Y5Sq7RE+0kJ6Fhi2ZJA==
X-CSE-MsgGUID: egmceNQ6RR2YXqvL3YN4dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="205120425"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa003.jf.intel.com with ESMTP; 29 Dec 2025 10:34:56 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: ISST: Add missing write block check
Date: Mon, 29 Dec 2025 10:34:49 -0800
Message-ID: <20251229183450.823244-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229183450.823244-1-srinivas.pandruvada@linux.intel.com>
References: <20251229183450.823244-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If writes are blocked, then return error during SST-CP enable command.
Add missing write block check in this code path.

Fixes: 8bed9ff7dbcc ("platform/x86: ISST: Process read/write blocked feature status")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 34bff2f65a83..f587709ddd47 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -612,6 +612,9 @@ static long isst_if_core_power_state(void __user *argp)
 		return -EINVAL;
 
 	if (core_power.get_set) {
+		if (power_domain_info->write_blocked)
+			return -EPERM;
+
 		_write_cp_info("cp_enable", core_power.enable, SST_CP_CONTROL_OFFSET,
 			       SST_CP_ENABLE_START, SST_CP_ENABLE_WIDTH, SST_MUL_FACTOR_NONE)
 		_write_cp_info("cp_prio_type", core_power.priority_type, SST_CP_CONTROL_OFFSET,
-- 
2.52.0


