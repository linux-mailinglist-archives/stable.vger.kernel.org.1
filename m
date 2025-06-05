Return-Path: <stable+bounces-151555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 857BEACF768
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 20:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B01892AE9
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402427B505;
	Thu,  5 Jun 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIJVP0kx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79527A46E;
	Thu,  5 Jun 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149122; cv=none; b=tfNTn87k8W7A9DP2Hqd5xuvhT/CWcpCNLEdv4d035a4RzUiJ6JouzdFNFtpV5l6NocBLn34EZjANp0um+CYpul/RdJpr5Xf9U1owQoAO69CD5vqbDNvoI/NXaUoKXVOgSGJTOSrvsI77dh38VzgTYtNUATS/T7GZj3cHbGJbJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149122; c=relaxed/simple;
	bh=vmfk+XbbJDzxMKnIqxi7v5BJuMAG1OuC9cWEsY93Uzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKjM8zpqALOgw1UzK5WB9DU4gwPdWgMshqAXpjIYTdpbuqSLT5BOnr2EgV7f9LjnUbYeErIfvIC2JklIILEJAIrTcvvG7sEpFaTSLtgmSEIuJAvLS30b4RVO27MKWsG9ose4ElSG6z2SN82cKptuBn1tIKbBOmOhX3uiNBQAL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIJVP0kx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749149121; x=1780685121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmfk+XbbJDzxMKnIqxi7v5BJuMAG1OuC9cWEsY93Uzc=;
  b=iIJVP0kxJ2tUO9tjGpWBMC0s01nwLRSI0kB1M2gqu/L8jkc1XZ1bFDUk
   N5XdK6KFU3VzYYnovhOeOABO0HMOrx5hK64hH+Y/qnneR/nv6AFnTTqLD
   pzznE8OVP2Fkl/nSf9X29mUaM5WGM/53UwjqLFi47f3UouIO73NKBsQd2
   LK4XhhR+HCYaV7XT1+DO2g+fy3Hw6llUTgU/xTGSvVWlLZe6v4aGb+Bf0
   3/jIjURLhFVkZeybj6+ew3HgjcpUNItHwULXMIr8cbdnLJ4erAfxeMZqH
   a5aTF1jA8FUmoIKwW9CmrIdQSfot/0W1bxcgcUIaFTvCLnWV2pkicixit
   A==;
X-CSE-ConnectionGUID: NM54N9eNTT2bo/ouhFK6gA==
X-CSE-MsgGUID: Z3H08NTySimB+YK5VOmbLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="38916608"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="38916608"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:45:21 -0700
X-CSE-ConnectionGUID: UYch9V9PTo2v+xNnCmq2Pg==
X-CSE-MsgGUID: 8pb4kvs/SCOCLr0WT+ivrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="182782448"
Received: from mjruhl-desk.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.222.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:45:19 -0700
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: platform-driver-x86@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	david.e.box@linux.intel.com
Cc: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 02/11] platform/x86/intel/pmt: crashlog binary file endpoint
Date: Thu,  5 Jun 2025 14:44:35 -0400
Message-ID: <20250605184444.515556-3-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605184444.515556-1-michael.j.ruhl@intel.com>
References: <20250605184444.515556-1-michael.j.ruhl@intel.com>
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


