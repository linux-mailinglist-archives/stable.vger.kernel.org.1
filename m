Return-Path: <stable+bounces-151549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624DCACF575
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5DF3ADF34
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003971A76D4;
	Thu,  5 Jun 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZYr3dVm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030213B2A4
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144790; cv=none; b=d0d0vs3cylW4oXa9R04QltFRY5ZT/duqVt/ac22270t/W99BbZrQ0r4P+og6F9GnN20cGHEivOUfCi0hzZ7YxawQTxl/enCRxCJSfWsDWrhnNGby1KDPGvIPwKvmFl2ieo+VP6tl4/Si9R4dxW/QbpTt/Kbi5HmV/RQ+HNXnZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144790; c=relaxed/simple;
	bh=vmfk+XbbJDzxMKnIqxi7v5BJuMAG1OuC9cWEsY93Uzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORQgYnbKzMVfNThQh6jYPovZcszNDEe2R8EjB6sqWMpnwU777jUSTvWABSUdmPCRYSNIhhR35Jn+GPxCvjyirRkZpFJX8+o0xXZLQEnec4VE4MKNOjqRWt8R+uju/hNCUOXWT3J1Cp8gbXErb5l12UjUyj/gBbJMr9jjGBVBNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZYr3dVm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749144789; x=1780680789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmfk+XbbJDzxMKnIqxi7v5BJuMAG1OuC9cWEsY93Uzc=;
  b=KZYr3dVmmMmx0dAxL7qOZdhm3Fq8JtClVL6p3KdmKtTobSEvNJhdgzH3
   hrm3W01d5xnmlvNY0YIq9yux3Yv9ejcYXbTS45o9TA1o1ty3aStqpwpWD
   dadTn4CsHJltwlie8d9HPod3BNTY4YV77LVFlc00FOtbqMKgo6f9lCy+E
   7G4Q9oaSFeQC1MHhpRZRd8HE9UQBLA6WfI6a8sA2fB760GNnR67qW2DYR
   OPV0NcRYmLiWs6wxIzbTeDdhPK50E78ucgbNwux19SrdnR1tGczYc02Mz
   rtshOPNvq4UmyFfQLdUpOCBYXxbbmfUweb/GIr0OkSOvfuX/EdVLVBcIj
   Q==;
X-CSE-ConnectionGUID: 6ueQ5rySSGaubdEVbV5WGQ==
X-CSE-MsgGUID: oQ/0894BRnOfWShCosJuSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="61899228"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="61899228"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 10:33:06 -0700
X-CSE-ConnectionGUID: 2V44j+YZSHSU3RpjVp62ew==
X-CSE-MsgGUID: jg9UDJrFQh682Yc0r0PjxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="146074779"
Received: from mjruhl-desk.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.222.42])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 10:32:59 -0700
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: michael.j.ruhl@intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3 02/11] platform/x86/intel/pmt: crashlog binary file endpoint
Date: Thu,  5 Jun 2025 13:32:39 -0400
Message-ID: <20250605173248.510441-3-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605173248.510441-1-michael.j.ruhl@intel.com>
References: <20250605173248.510441-1-michael.j.ruhl@intel.com>
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


