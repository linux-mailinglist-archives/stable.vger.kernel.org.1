Return-Path: <stable+bounces-230385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OinBAg4xGnkxQQAu9opvQ
	(envelope-from <stable+bounces-230385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:31:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8761A32B472
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A9FA301982F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86518355F43;
	Wed, 25 Mar 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGEZAvwX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08243233ED;
	Wed, 25 Mar 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466953; cv=none; b=JMqF0gJUdVQRGCnJXq8i6UNukQCxYiFA4MfpJt2P8mW5utNQru7CPRtfzf2qlXebmaF/ptogSVIARrNbwWtqdvFIv0UVK14gn3zRQvFDonJFnwzupnBzFcMIh5g+AxbIhU1fTgZSok9JWZt8IWV0Im/dWRIFWve3S7E6KLxdZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466953; c=relaxed/simple;
	bh=L4jELdZiW+yzICSJhXuJ2ZU9mk1EByn80HKLZkT4cOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/+4mlZzRAQC8sPOOMRgOqNBsBzEyPuJae27qnvezOv3Ixj0D5+fjVBLK8fFN/e2hd1WtG9In943/DgDvvPHGRBi3YnzyQGPYvKXi6Znyo9AInMvOzHvrkbbCLQo2qBeCsM7Ebo4aNRuB1Udd++jph6+QiIKO/0RVMlYTylgPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGEZAvwX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774466952; x=1806002952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L4jELdZiW+yzICSJhXuJ2ZU9mk1EByn80HKLZkT4cOA=;
  b=NGEZAvwX8c6BGBSn5pjF4jL0HxtdI7gnjHHs0SEPtXUwTNF13dTePFDc
   c8bH6HIZKkYxhTFeXpvYTolvCjGEejC3Gt4VvKs8ivHqQuuvK0WWMVpGu
   nSOrhOMVbMKebE7FkzNakrrtHXpk14ziI1lvrZ8btAPa3K1MT+EdIKPkE
   CLQ9fXp3Sx+dfANoCDLE3VV0t5orBNDa+qrQ5DESQ+a/bbhlenVQOfNDq
   9f9HlFesb20fpHKpave7ZqP/twoQpRHHhkam/trLl6BkfDRaSTeQy6CKd
   xV/2vq3D6ah2OeIdhLtfiRlLDVcwXRfv55/qV5ezLyCEwKGzd1VEfIwey
   g==;
X-CSE-ConnectionGUID: j2+32zDZTAe6FKQfQnWQEg==
X-CSE-MsgGUID: ZQ1MGXGwRrCKSnraVJbWPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="98136697"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="98136697"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 12:29:11 -0700
X-CSE-ConnectionGUID: e6+Jgx5tRCKnr9KO23nptQ==
X-CSE-MsgGUID: JynbSqVwR7Ow7e6YH5x7qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="248253996"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa001.fm.intel.com with ESMTP; 25 Mar 2026 12:29:11 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/intel-uncore-freq: Handle autonomous UFS status bit
Date: Wed, 25 Mar 2026 12:29:09 -0700
Message-ID: <20260325192909.3417322-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230385-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8761A32B472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the AUTONOMOUS_UFS_DISABLED bit is set in the header, the ELC
(Efficiency Latency Control) feature is non-functional. Hence, return
error for read or write to ELC attributes.

Fixes: bb516dc79c4a ("platform/x86/intel-uncore-freq: Add support for efficiency latency control")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
Not urgent: In any current generations, it is never the case.

 .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c     | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 1237d9570886..b038dbb69447 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -537,6 +537,7 @@ static void set_cdie_id(int domain_id, struct tpmi_uncore_cluster_info *cluster_
 #define UNCORE_VERSION_MASK			GENMASK_ULL(7, 0)
 #define UNCORE_LOCAL_FABRIC_CLUSTER_ID_MASK	GENMASK_ULL(15, 8)
 #define UNCORE_CLUSTER_OFF_MASK			GENMASK_ULL(7, 0)
+#define UNCORE_AUTONOMOUS_UFS_DISABLED		BIT(32)
 #define UNCORE_MAX_CLUSTER_PER_DOMAIN		8
 
 static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
@@ -598,6 +599,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 	for (i = 0; i < num_resources; ++i) {
 		struct tpmi_uncore_power_domain_info *pd_info;
+		bool auto_ufs_enabled;
 		struct resource *res;
 		u64 cluster_offset;
 		u8 cluster_mask;
@@ -647,6 +649,8 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 			continue;
 		}
 
+		auto_ufs_enabled = !(header & UNCORE_AUTONOMOUS_UFS_DISABLED);
+
 		/* Find out number of clusters in this resource */
 		pd_info->cluster_count = hweight8(cluster_mask);
 
@@ -689,7 +693,8 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 			cluster_info->uncore_root = tpmi_uncore;
 
-			if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >= UNCORE_ELC_SUPPORTED_VERSION)
+			if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >=
+			    UNCORE_ELC_SUPPORTED_VERSION && auto_ufs_enabled)
 				cluster_info->elc_supported = true;
 
 			ret = uncore_freq_add_entry(&cluster_info->uncore_data, 0);
-- 
2.52.0


