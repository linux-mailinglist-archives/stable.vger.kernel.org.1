Return-Path: <stable+bounces-151553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4CACF630
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24516174482
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378D2750F4;
	Thu,  5 Jun 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Na6XS0Ub"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77D33062
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146966; cv=none; b=f574UOylYjqCH8yh8SwKtXaa3qlg3HMowWPokgBHeA9WkeLGm31Y+14P6k/oUxVGYioQFeUCk+5WR1mnPeU8tcbxVfbKPKG0GKUTUHcY0CV/JybtSjRdIQL2Q+GFHyU2MNiLHVJkVngmlQI2veq7n7jC9xIDfWQf6B/QhSCMFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146966; c=relaxed/simple;
	bh=vmfk+XbbJDzxMKnIqxi7v5BJuMAG1OuC9cWEsY93Uzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSuwlHuNtoKAnvXSsRu2Oi4uSdFFuVC/b32TQ818UcSKoKvgCYVaY2fZeCCHXGB9SmQoM7Y6XTh3LINVgn/g4S33rE92c4xPTA38OBU7YXckKn1T0Met7+vwpf+L2PNucoozwGZHs9kaxRtBzlix6MQSLB5UEv9ZV8m2oavjcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Na6XS0Ub; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749146964; x=1780682964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmfk+XbbJDzxMKnIqxi7v5BJuMAG1OuC9cWEsY93Uzc=;
  b=Na6XS0UbaK6JbNSc3kFGflqZDOxRrguX7EGCnVYo29aHdi8/zcyNKhUi
   rEMg4NbbEWUxi3ZzqAIEudhm2h1tb23T7pjK1uirzjkUk8YBQV4FD+d4E
   5hIPqdE7R1oGGd2bQyNeVOoSBQ/+SlsnxJqC/dmAI99o3CCW/nrHS7ua7
   BbeM8vC7cs+JVUaDOs7SKTAMS+P+aegTc+CzEbDSCPqOBnXGSa/p3AafZ
   ePNuhVI9Lk2owxdV+9Qz4fCufjmOQNwghQpZ5IZaO4eBttjJSYCYQMye2
   Xf3lXrKJR2NXmZwkRAxc+U9dX8vGCsCjZ6ETchmusvSZQJhAG119d4DRD
   Q==;
X-CSE-ConnectionGUID: vfJ5zM4qSku9uGzIPSTyFQ==
X-CSE-MsgGUID: eOGf+HGkR1uJYwdMarUeXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="68839530"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="68839530"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:09:24 -0700
X-CSE-ConnectionGUID: VxYPvJ/TT/q8gcYrrJkSdg==
X-CSE-MsgGUID: X5JtWjz+QyadK5aLY8ZbNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="145622376"
Received: from mjruhl-desk.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.222.42])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:09:24 -0700
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: michael.j.ruhl@intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3 02/11] platform/x86/intel/pmt: crashlog binary file endpoint
Date: Thu,  5 Jun 2025 14:08:57 -0400
Message-ID: <20250605180906.515367-3-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605180906.515367-1-michael.j.ruhl@intel.com>
References: <20250605180906.515367-1-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of the intel_pmt_read() for binary sysfs, requires an allocated
endpoint struct. The crashlog driver does not allocate the endpoint.

Without the ep, the crashlog usage causes the following NULL pointer
exception:

BUG: kernel NULL pointer dereference, address: 0000000000000000
Oops: Oops: 0000 [#1] SMP NOPTI
RIP: 0010:intel_pmt_read+0x3b/0x70 [pmt_class]
Code:
Call Trace:
 <TASK>
 ? sysfs_kf_bin_read+0xc0/0xe0
 kernfs_fop_read_iter+0xac/0x1a0
 vfs_read+0x26d/0x350
 ksys_read+0x6b/0xe0
 __x64_sys_read+0x1d/0x30
 x64_sys_call+0x1bc8/0x1d70
 do_syscall_64+0x6d/0x110

Add the endpoint information to the crashlog driver to avoid the NULL
pointer exception.

Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to read telemetry")
Cc: <stable@vger.kernel.org>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/platform/x86/intel/pmt/crashlog.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
index 6a9eb3c4b313..74ce199e59f0 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -252,6 +252,7 @@ static struct intel_pmt_namespace pmt_crashlog_ns = {
 	.xa = &crashlog_array,
 	.attr_grp = &pmt_crashlog_group,
 	.pmt_header_decode = pmt_crashlog_header_decode,
+	.pmt_add_endpoint = intel_pmt_add_endpoint,
 };
 
 /*
@@ -262,8 +263,12 @@ static void pmt_crashlog_remove(struct auxiliary_device *auxdev)
 	struct pmt_crashlog_priv *priv = auxiliary_get_drvdata(auxdev);
 	int i;
 
-	for (i = 0; i < priv->num_entries; i++)
-		intel_pmt_dev_destroy(&priv->entry[i].entry, &pmt_crashlog_ns);
+	for (i = 0; i < priv->num_entries; i++) {
+		struct intel_pmt_entry *entry = &priv->entry[i].entry;
+
+		intel_pmt_release_endpoint(entry->ep);
+		intel_pmt_dev_destroy(entry, &pmt_crashlog_ns);
+	}
 }
 
 static int pmt_crashlog_probe(struct auxiliary_device *auxdev,
-- 
2.49.0


