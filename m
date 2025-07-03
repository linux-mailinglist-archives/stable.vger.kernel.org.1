Return-Path: <stable+bounces-160123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FEEAF8277
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 23:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22A27AE398
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192FA2BEC52;
	Thu,  3 Jul 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aqlp4yzE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF02BEC20;
	Thu,  3 Jul 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577132; cv=none; b=jDb59m0n3FWX5cdu1zjVefbzCEEZX2EwKxjYaXGdUyRRu+7jC4ID6/pfj5ryVys4YNQvdhgxeCIjos9p+v1wCzdt/fMjwUkNHrkD63T8zIjeOw60PHZjwFSOLsk1/VctPXlzpMu//tpqLh4ifgUwGN7MO5qpWAs2Qm7Xr4Bdg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577132; c=relaxed/simple;
	bh=B6doD9kOSPWFE/Y4BAsd3C6XEna4T0RpkGlNoqHZZLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfQHcfpoRwBRO0UPyKbl7z3TiO/ncyjYjMrQoVfj/Y9K5QbN/GsBh0GfOo9xdZj6N6WFDBfFZDQW40PXz3gBGwQXvrx4jSsdCvhPdUghVbW4xlXoinpoi/+zbfIyuDElipGdjsO6yieCExfC9YTcqQzrNtA4rTFL3ZlOWvtIL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aqlp4yzE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751577131; x=1783113131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6doD9kOSPWFE/Y4BAsd3C6XEna4T0RpkGlNoqHZZLw=;
  b=Aqlp4yzExCi99183Pq+qkGcRCUQckmJWFD7JfXJmyMfW2rzI2HsyAhAS
   Yf2eMFf30g/QCL5HPRfxxlJduXLYlswmlpkL4N/IgmHoU55+C5vYWyCCx
   Y7e5CneClevywBgerSU6e2hwJ/AJR/up0SGIoOZYPO5duICcYQA+7766U
   UYSZOZQPWWE5Z5TwOchAT7MRwlFQkGjPQGGyUQnVuOZM1f+g0yCL1AjJc
   5cMLNWvMsIKrs7eq/HtZmBvDzir/xCxa1xUqZKz2iYHY+am8prApQ2UAU
   Xj7755NPip36GNr+CxC6mvOAHNVV9SY5qVBvG8k5pwNfARiSch7oeEb0p
   g==;
X-CSE-ConnectionGUID: 36Fb/S9RR/KHKX0T1sMiZw==
X-CSE-MsgGUID: IlpM8nnjSXC8oE1wAiXGkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79352995"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="79352995"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 14:12:11 -0700
X-CSE-ConnectionGUID: lXpy82NlTA6aPWMZmq4m5Q==
X-CSE-MsgGUID: l5VKW6JETBC+sv/39t6Xxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154239995"
Received: from mjruhl-desk.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.223.97])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 14:12:09 -0700
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
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 01/12] platform/x86/intel/pmt: fix a crashlog NULL pointer access
Date: Thu,  3 Jul 2025 17:11:39 -0400
Message-ID: <20250703211150.135320-2-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703211150.135320-1-michael.j.ruhl@intel.com>
References: <20250703211150.135320-1-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of the intel_pmt_read() for binary sysfs, requires a pcidev. The
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

Augment struct intel_pmt_entry with a pointer to the pcidev to avoid
the NULL pointer exception.

Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Fixes: 045a513040cc ("platform/x86/intel/pmt: Use PMT callbacks")
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


