Return-Path: <stable+bounces-152310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A56AD3B9B
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153BF18876DF
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EAD1E379B;
	Tue, 10 Jun 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVO6Figh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38A186A
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566791; cv=none; b=ZGbSoYHHxN9mvpVzaPB/Nbo1NVkYm2idmiV4CLTMnYLYcgMEY+JxYW76qwVkIFQn4e6plHmugdH4LXcVxsJK5m8in4PddERsFqLyEGw9fR4eaGKs1aHu/cYz92TzKPaHf39Hvn4GARimwubAgzRi7gu8Pw0a4fTzaNXgJaZaiqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566791; c=relaxed/simple;
	bh=kwEHHm7zFRCrwj7rWWQ34/8yUWTPvbFGYiZ3ig5tFMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+UcR0FWyi1PDFNbkhD0hhoOmIFCz0tb0kznmtMSat2Rsv5p+t2SyqkBWsVcTAejkHGmum1DiUdCd5511rtbfSAnDDhd386h7DilOTsHJJsfRKmXYJvSL5L1nM1h6dDJGmG9kCfN8lYuDtiYWjgm5TK9tBfqvxmTuogDNEgRK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVO6Figh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749566790; x=1781102790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kwEHHm7zFRCrwj7rWWQ34/8yUWTPvbFGYiZ3ig5tFMk=;
  b=GVO6FighyB1Wo+zFlQFmw60q8Pe98SmFmdF3z35cYUuD2FJxKbo+xbN0
   zNbMXl2QIw2TVYPU/X/78/qK3bnzjZhp/iHDtPCgvKkrjmSl/0XHfCeRN
   aR8rXM7sAbFkQFb35B74kUVWmkSYKcYc4+FQRie8WwlbMP5OfXbFMDp55
   RjJVSyDBcZq0gIJ1pbx//KNPr07GkGylec4xgsnS1rePoqGhtp6I+fQSo
   6+kq+MTPJpetaLv/USjSVOYjXUTm+PIniRaSjNir484SmLgzAbl4aI4fF
   dM53jvhCfjanCTmYCl8ZFNl1oNjcGQKw5xmURz/aWCpGXdrQh4RwftFPj
   A==;
X-CSE-ConnectionGUID: AHVby9tZRHeQlymflh193w==
X-CSE-MsgGUID: 2OuTJf7LRLyyPstrJ9DMxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51822300"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51822300"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:46:29 -0700
X-CSE-ConnectionGUID: YJxLzApUR2OtC6C46i9fPA==
X-CSE-MsgGUID: xs9ohlj/QNu+Y1mCakJ5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="151740023"
Received: from mjruhl-desk.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.220.88])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:46:28 -0700
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: michael.j.ruhl@intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH v4 01/10] platform/x86/intel/pmt: fix a crashlog NULL pointer access
Date: Tue, 10 Jun 2025 10:46:10 -0400
Message-ID: <20250610144619.1079056-2-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610144619.1079056-1-michael.j.ruhl@intel.com>
References: <20250610144619.1079056-1-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of the intel_pmt_read() for binary sysfs, requires a pcidev.  The
current use of the endpoint value is only valid for telemetry endpoint
usage.

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

Augment the inte_pmt_entry to include the pcidev to allow for access to
the pcidev and avoid the NULL pointer exception.

Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to read telemetry")
Cc: <stable@vger.kernel.org>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/platform/x86/intel/pmt/class.c | 3 ++-
 drivers/platform/x86/intel/pmt/class.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 7233b654bbad..d046e8752173 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -97,7 +97,7 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 	if (count > entry->size - off)
 		count = entry->size - off;
 
-	count = pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, entry->header.guid, buf,
+	count = pmt_telem_read_mmio(entry->pcidev, entry->cb, entry->header.guid, buf,
 				    entry->base, off, count);
 
 	return count;
@@ -252,6 +252,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 		return -EINVAL;
 	}
 
+	entry->pcidev = pci_dev;
 	entry->guid = header->guid;
 	entry->size = header->size;
 	entry->cb = ivdev->priv_data;
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
index b2006d57779d..f6ce80c4e051 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -39,6 +39,7 @@ struct intel_pmt_header {
 
 struct intel_pmt_entry {
 	struct telem_endpoint	*ep;
+	struct pci_dev		*pcidev;
 	struct intel_pmt_header	header;
 	struct bin_attribute	pmt_bin_attr;
 	struct kobject		*kobj;
-- 
2.49.0


