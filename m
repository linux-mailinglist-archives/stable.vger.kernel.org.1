Return-Path: <stable+bounces-206096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B1CFC239
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 07:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 501EF3002D18
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 06:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01D26C385;
	Wed,  7 Jan 2026 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dw6c7FNf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627E20468E;
	Wed,  7 Jan 2026 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765786; cv=none; b=fRw17bsmCauKiLv3VJ5FqhlUAceMPzeOY8CzYHIU6FOeikqhFTls+HuZiwfEsfjzc/u5P2k7P3yN0YTubFOyfsQXj0afbySHZMZ3/MVCYydMRPa/pzNrC2e9U23OWHC0N1Ygk5kj8moMwfWP9pcXs1QdeGOsqagUBfioB2Wfjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765786; c=relaxed/simple;
	bh=h3YP1/3kcOqfQtC9oDt/rAoWE1Mgnw0+zP1KLSf+690=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2wJrb9ui2WjLdLWdGbxDdtSgZM7N0ebspJHvrE7by5avbkN8aadLGh17zbl2TgR1o5L+RdoTq4lXv0EsA9w8iNESgC4H4gIpnJ5HF6BuPph5JGatJzX5nqFMYH6zwU5Axx7UfLpYSbIDsboTKvu+fC3Sb26ps7pOI6/8zWn6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dw6c7FNf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767765784; x=1799301784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3YP1/3kcOqfQtC9oDt/rAoWE1Mgnw0+zP1KLSf+690=;
  b=Dw6c7FNf/pQ/WgKAexH1/+C1ntrwPGnr0/vx6Vu0mhsfl1MAch8Jjnrt
   USmq4MGBVKsqOVcJwgyCg75iZy3a5nf+PgGH0ozY6sYpKHlK+rv/+R164
   3eCwQdmMZ776gWMLRG8e/38OIbJferpRtRDMUBNdG8FwWuE76SejLAne9
   sj76f3dSaQrjilhECVpuAWAthJiPCz/BJlrkG6gxqJYYGGooV1/5q5V3w
   tN+lSQU2GXqTn0rO5VjfnAGNfBV9A9mDOm8anU7Zcu+wICID6/6GpUOzW
   s/EJm/6f7N+c/RXPqQP/rcM8Y8b2/LpTo8W61Y55l4eAzI0N7ahj0dv1s
   g==;
X-CSE-ConnectionGUID: cNG8ucfAQGCByH6jcOdkZg==
X-CSE-MsgGUID: BoLCrRaeQmeJctlqRcNHHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="79434350"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="79434350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 22:03:02 -0800
X-CSE-ConnectionGUID: E5p8ufV0TEeZTVOmevAMmA==
X-CSE-MsgGUID: NT17D5qARpuFFZqbJVEv1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="202746873"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2026 22:03:02 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] platform/x86: ISST: Add missing write block check
Date: Tue,  6 Jan 2026 22:02:55 -0800
Message-ID: <20260107060256.1634188-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107060256.1634188-1-srinivas.pandruvada@linux.intel.com>
References: <20260107060256.1634188-1-srinivas.pandruvada@linux.intel.com>
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
v2:
- No change

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


