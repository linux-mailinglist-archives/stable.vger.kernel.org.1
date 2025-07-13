Return-Path: <stable+bounces-161787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8C1B0324A
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 19:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0814E3B9822
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEAF280318;
	Sun, 13 Jul 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dshQBYDU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AB27F4D9;
	Sun, 13 Jul 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752427797; cv=none; b=eQskuaLMts7IHdWX7GlJVaGylP98pkT/XhzZ/r3G/luVen/wOC4OI/qClQvvfRRYiePxZni//j2zVCDDpWtUmcFYvTXxGgDZ7K/tFOPNR8J4NjqK1gDl87ioEtEU98Or2DoO2xXfzrydoTEAZQLkqFLnauB/tAPhuLbc7chbelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752427797; c=relaxed/simple;
	bh=xDEfxrZXVShq+Qj7chXkah+DfC6F5cV0MK8+jeraBow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO/itsxiWWta8+2ksxIyIYe8B5jLxIKK9I0X2qwCB3CI4+PlWK/iS2ccFa4qYe27qOguIsuNFj6YwRCg9J7+4736rudujYA1CDwOlHrAhCsOt8VD0bgkowo60Dam3qIoAmZY8yJc6TsMHD1CYN1KA/XMysqE9DD34it1KqKsXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dshQBYDU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752427796; x=1783963796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDEfxrZXVShq+Qj7chXkah+DfC6F5cV0MK8+jeraBow=;
  b=dshQBYDUsWyk1BZrt2DB7vVkmfuongo8UWiPklbUe6b6+sdyCwcvkDf6
   aAuSKBJvOvoycM+kJ0TpAA+RTD0RXz7BIBa0ibNQso+2zhOAWDOH8y68E
   s2c2f+E3PbumJ5zVYgmVky4ytTsM36CJP3hiLkm2YLPdB92C3gLZEoO2E
   lHf7cqsr+0BkbNcb5TcQ1AeW/4LSMX2+puOkYbFfldBY3WWUQsN/8xm+h
   7t3y2vTbf570RkiJR5lAFao4BzQMI9LC6VHvb034xsMEnIMhIKLIutTtf
   r8S/lnWf3U/mXOLJe3oC7yHVAdOuRdkttBnmWcXr+DSymUcSwGfMvANZn
   Q==;
X-CSE-ConnectionGUID: gl0/PAn1QQimlHPIc3nnoQ==
X-CSE-MsgGUID: L9mXuP2JSJ+zpFAs4laUQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65334111"
X-IronPort-AV: E=Sophos;i="6.16,309,1744095600"; 
   d="scan'208";a="65334111"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 10:29:56 -0700
X-CSE-ConnectionGUID: zpaf+F0kTcWkj+1WNJWVwQ==
X-CSE-MsgGUID: QL8gho/HReWgU8hx+IOlUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,309,1744095600"; 
   d="scan'208";a="161069175"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.223.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 10:29:54 -0700
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
Subject: [PATCH v8 01/13] platform/x86/intel/pmt: fix a crashlog NULL pointer access
Date: Sun, 13 Jul 2025 13:29:31 -0400
Message-ID: <20250713172943.7335-2-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250713172943.7335-1-michael.j.ruhl@intel.com>
References: <20250713172943.7335-1-michael.j.ruhl@intel.com>
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

Reviewed-by: David E. Box <david.e.box@linux.intel.com>
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
2.50.0


