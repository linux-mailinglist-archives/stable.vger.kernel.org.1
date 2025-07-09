Return-Path: <stable+bounces-161485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2AAAFF10B
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 20:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAAA542AA7
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62823ABB3;
	Wed,  9 Jul 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VC9y5nf5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E923ABB4;
	Wed,  9 Jul 2025 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086722; cv=none; b=LTHvKzOYjncpc+CYr9MCg3koa9fd0vbGlPJjHf5FaDLItbPsJ8BWo0WGarVCzMF+YKEvxQz5pC40v4TKcB/2St4Oh2YB/tGEgE15G877TCKm4AFWp0yvjNe3U3gRi8IxSzLwuDBptoFEZ5xlMhoPSoKD+D2Lqx/CIaYVAQN+SxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086722; c=relaxed/simple;
	bh=DsMHUj1PCbtPTOnyHGKOzdgaPopMri+qwoCvFjk5k4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKQXe7UdzGc+VU0F00/EqnNVIu1MgRT3BkV0vbgo7YMtFaLWUHF3bJFya86usFOg9us9mujvDTSWkCYJIbnl/4M1aM5wBxYGJ+kAdYVztqK33iSi6EDWOa7QcaUsaj0W5bMYrWt2H2qppoGvzRoNpf4iiU6b3xulXT6+JTkz0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VC9y5nf5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752086720; x=1783622720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsMHUj1PCbtPTOnyHGKOzdgaPopMri+qwoCvFjk5k4E=;
  b=VC9y5nf5cSNKOg0aBIIHdwztdQm7Zjp8360oim/ORVa3+cWZm74nTitM
   4Eybqa3Klo/USkaWInXphb4zf+8VhyydV3cKexKSbgyj6KjB8CK4tkhMJ
   leVSzurub/LcKSyG1KGaeowVadGUqx2nzpsnSV2FNckPKeTHa87V2PMKp
   YNFf9XL4BXh2RxS1Np3/LGdnBxc8sEaoMDxnaJNoLeKsO6oP16A6iItlU
   VEstBooYMApyStbZbHhZutBbnz3nsPQ2P7qJe662LlrmHGH0M4GBzxxUq
   GdM9KadVIb33tmDssNgoykaRCUJIfNCMCFgWxX9mmKoT50AgFrHE4lqfF
   A==;
X-CSE-ConnectionGUID: KAPzRq2hTnGyNfm2Evk05Q==
X-CSE-MsgGUID: akBZIyVWR0y51wUf1gJlcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54451011"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54451011"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 11:45:18 -0700
X-CSE-ConnectionGUID: epK/AetvTyWFZis1DfygqQ==
X-CSE-MsgGUID: fz9FymE3R7KvHdxID+0xYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161404834"
Received: from mjruhl-desk.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.221.121])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 11:45:16 -0700
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
Subject: [PATCH v7 01/12] platform/x86/intel/pmt: fix a crashlog NULL pointer access
Date: Wed,  9 Jul 2025 14:44:47 -0400
Message-ID: <20250709184458.298283-2-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709184458.298283-1-michael.j.ruhl@intel.com>
References: <20250709184458.298283-1-michael.j.ruhl@intel.com>
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
2.50.0


