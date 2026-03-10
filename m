Return-Path: <stable+bounces-223781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4COZDdbPr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:01:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1BA246D63
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01EB53047DE9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060ED3659EB;
	Tue, 10 Mar 2026 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEGZLiNh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04A364959;
	Tue, 10 Mar 2026 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129495; cv=none; b=kJHgXlkxChmVkyYCYp4OBqZ/qv7ygkVPoor7cRgTUjYURZGbAxZa3RAODr4kjStAYgcz6m318JxMd59aBGus2w6qYDQKXfaf7KWetm7/RmbVb/+FitRuc0J20EchyzcW8+JYxbLqFB6oG/3Tt8PFdmDoQ6KUZohw4YmmrSv2P1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129495; c=relaxed/simple;
	bh=9rrgTplL9Jyn3YMjwg2ZeOydsNyzxReM6UUAuxh5reM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSjMQgV8KXmcFKPpuNA0/dsw1ZHMhYIubEjiKks3TNiKC2E7EXO7T/9QzQ52Zx+sa9a4frO83q3ZGXUybzFYNNJzzJdzCBx9PydDPA236CeEf1QqiT3W6uQcDPN1jNiYkU2B0t6irWUOOpJQ+X0ZBVnndUd6AcnwYzWZX8lomTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEGZLiNh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773129493; x=1804665493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9rrgTplL9Jyn3YMjwg2ZeOydsNyzxReM6UUAuxh5reM=;
  b=hEGZLiNhoOwnmyXWfQHDqAXAGHlFz3gkI9z5DPGT3W04x8dDZQDOibUD
   P2j/aKhei39+OYr1i+9pamISfj+ZIzrjXiWgY6+6cQHeB4m9V786INGbx
   08y/9GY4ilW9zcfQipWaO74n26kMAORG/rJ01ishoqkJ6q2OhlAPzOnVl
   ii0Bh1ZYGlUYWSpxawxBBDnOFsm5f+WwDF1siRWosa6jSk5T6CgV91IvS
   +VdZ2rNN1qvATKtAecwBDhEZi74t/47K1Ab/YefCiiU68WRYSD/2zLQxp
   Wn+wD/UcuN9fj4CxBKwq4ja3lwCB3LP41bCfh/H63V0NWR1JabIVwopCw
   g==;
X-CSE-ConnectionGUID: agdlsgR3T6Gk0mkcribI4A==
X-CSE-MsgGUID: pHuZHbT+ShSWIZWRhDwCpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="78045007"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="78045007"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:58:09 -0700
X-CSE-ConnectionGUID: Y3MHkOYCRJOTQu+Z55BGAA==
X-CSE-MsgGUID: RgOeO4QgR6S9fb3Et5pDCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="220066680"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2026 00:58:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Only handle IOPF for SVA when PRI is supported
Date: Tue, 10 Mar 2026 15:55:20 +0800
Message-ID: <20260310075520.295104-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF1BA246D63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223781-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

In intel_svm_set_dev_pasid(), the driver unconditionally manages the IOPF
handling during a domain transition. However, commit a86fb7717320
("iommu/vt-d: Allow SVA with device-specific IOPF") introduced support for
SVA on devices that handle page faults internally without utilizing the
PCI PRI. On such devices, the IOMMU-side IOPF infrastructure is not
required. Calling iopf_for_domain_replace() on these devices is incorrect
and can lead to unexpected failures during PASID attachment or unwinding.

Add a check for info->pri_supported to ensure that the IOPF queue logic
is only invoked for devices that actually rely on the IOMMU's PRI-based
fault handling.

Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fea10acd4f02..57cd1db7207a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,9 +164,12 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	ret = iopf_for_domain_replace(domain, old, dev);
-	if (ret)
-		goto out_remove_dev_pasid;
+	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
+	if (info->pri_supported) {
+		ret = iopf_for_domain_replace(domain, old, dev);
+		if (ret)
+			goto out_remove_dev_pasid;
+	}
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -181,7 +184,8 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 out_unwind_iopf:
-	iopf_for_domain_replace(old, domain, dev);
+	if (info->pri_supported)
+		iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
-- 
2.43.0


