Return-Path: <stable+bounces-230588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD/eG2cVxmkGGQUAu9opvQ
	(envelope-from <stable+bounces-230588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 06:28:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B133F3F3
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 06:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE17E306F5F4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1194D377011;
	Fri, 27 Mar 2026 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdZkY8Qs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC73783D7;
	Fri, 27 Mar 2026 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774589227; cv=none; b=B8LOSpV5dZfhj9ALHL/RDT5933BtvLRfwXH4nb4K6aHvv3hkR7VbGnWX+7fxIkv0oU1o0cJtumJgqZk7VIuPuy5q2NXyWhVSDmxoeTNqVegVoBXPpENLwqg6H1ShpNFA7Yi3bOd+3GSLDhpuI/BS9jNyREUdTnCcaIeyfe5oado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774589227; c=relaxed/simple;
	bh=6du4GSLdFcOKnui2hMxoipbmDJNYMO6D2vPAVJPls/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVmV+jsJDm0/jd4ujoLMTfiBeg4VdJ6rEWxdmjb9UNbrTb1HVd/4qg2orgX1f71jSG/ZYVI0dPcKM27QTiyHZZ69+ZJv9Hh6eoMGDEUUZJvFmDa4jG2WgAEO5ahRCprs0sh4nXFTPZBsAvZYvjDlyqLrdr/8Wtrg2N4iSW9jDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdZkY8Qs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774589227; x=1806125227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6du4GSLdFcOKnui2hMxoipbmDJNYMO6D2vPAVJPls/k=;
  b=ZdZkY8QsKAvgqJpLqLZ3pAshBSC4Lp5MXdPF4ocKslTCSDizEXEXMY1f
   5fHaC+kmpqbxfm0CYeyNRaRin+1PLFKmO7wG3DELn0Y+6AP6r0+CrF/hS
   OaYNFNFoiGWFslLM9zNXK4UY2PqKUhqUb0F65Vt6xCesYvSaDZ13vLCfb
   vwPrkzFqr9PmvxmY2ALqFT61zzRVPVRUW7Sa+vS30M5oI07GnSQ24eB2U
   9a7HLdtptcrr97fLq4ZUTapJ+o0yw4TyGvm6xslrUNzrXMhad3L58P3aV
   wep6NjeT3tVVUXYRVaUw2W5xBUCUWmQp1wGhDu+0HURGezn2pjt5VXuUo
   g==;
X-CSE-ConnectionGUID: mdPY6XO9SfOeVQWHKdvBHQ==
X-CSE-MsgGUID: aD95+amMTjuy30l6XzzLxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101117940"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="101117940"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 22:27:05 -0700
X-CSE-ConnectionGUID: dejRaGOsSLmdSRhCHQ5deQ==
X-CSE-MsgGUID: x7JZO6bXSbKpWkWjrm+tgg==
X-ExtLoop1: 1
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa003.fm.intel.com with ESMTP; 26 Mar 2026 22:27:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: patches@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/9] cxl/region: Fix use-after-free from auto assembly failure
Date: Thu, 26 Mar 2026 22:28:13 -0700
Message-ID: <20260327052821.440749-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327052821.440749-1-dan.j.williams@intel.com>
References: <20260327052821.440749-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230588-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: E08B133F3F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following crash signature results from region destruction while an
endpoint decoder is staged, but not fully attached.

---
 BUG: KASAN: slab-use-after-free in __cxl_decoder_detach+0x724/0x830 [cxl_core]
 Read of size 8 at addr ffff888265638840 by task modprobe/1287

 Call Trace:
  <TASK>
  dump_stack_lvl+0x68/0x90
  print_report+0x170/0x4e2
  kasan_report+0xc2/0x1a0
  __cxl_decoder_detach+0x724/0x830 [cxl_core]
  cxl_decoder_detach+0x6c/0x100 [cxl_core]
  unregister_region+0x88/0x140 [cxl_core]
  devres_release_all+0x172/0x230
---

The "staged" state is established by cxl_region_attach_auto() and finalized
by cxl_region_attach_position(). When that is finalized a memdev removal
event will destroy regions before endpoint decoders. However, in the
interim the memdev removal will falsely assume that the endpoint decoder is
unattached. Later, the eventual region removal finds the stale pointer to
the now freed endpoint decoder.

Introduce CXL_DECODER_STATE_AUTO_STAGED and cxl_cancel_auto_attach() to
cleanup this interim state.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Cc: <stable@vger.kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h         |  6 +++--
 drivers/cxl/core/region.c | 54 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9b947286eb9b..30a31968f266 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -378,12 +378,14 @@ struct cxl_decoder {
 };
 
 /*
- * Track whether this decoder is reserved for region autodiscovery, or
- * free for userspace provisioning.
+ * Track whether this decoder is free for userspace provisioning, reserved for
+ * region autodiscovery, whether it is started connecting (awaiting other
+ * peers), or has completed auto assembly.
  */
 enum cxl_decoder_state {
 	CXL_DECODER_STATE_MANUAL,
 	CXL_DECODER_STATE_AUTO,
+	CXL_DECODER_STATE_AUTO_STAGED,
 };
 
 /**
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f7b20f60ac5c..b72556c1458b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1064,6 +1064,14 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 
 	if (!cxld->region) {
 		cxld->region = cxlr;
+
+		/*
+		 * Now that cxld->region is set the intermediate staging state
+		 * can be cleared.
+		 */
+		if (cxld == &cxled->cxld &&
+		    cxled->state == CXL_DECODER_STATE_AUTO_STAGED)
+			cxled->state = CXL_DECODER_STATE_AUTO;
 		get_device(&cxlr->dev);
 	}
 
@@ -1805,6 +1813,7 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
 	pos = p->nr_targets;
 	p->targets[pos] = cxled;
 	cxled->pos = pos;
+	cxled->state = CXL_DECODER_STATE_AUTO_STAGED;
 	p->nr_targets++;
 
 	return 0;
@@ -2154,6 +2163,47 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
+static int cxl_region_by_target(struct device *dev, const void *data)
+{
+	const struct cxl_endpoint_decoder *cxled = data;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+
+	if (!is_cxl_region(dev))
+		return 0;
+
+	cxlr = to_cxl_region(dev);
+	p = &cxlr->params;
+	return p->targets[cxled->pos] == cxled;
+}
+
+/*
+ * When an auto-region fails to assemble the decoder may be listed as a target,
+ * but not fully attached.
+ */
+static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int pos = cxled->pos;
+
+	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
+		return;
+
+	struct device *dev __free(put_device) = bus_find_device(
+		&cxl_bus_type, NULL, cxled, cxl_region_by_target);
+	if (!dev)
+		return;
+
+	cxlr = to_cxl_region(dev);
+	p = &cxlr->params;
+
+	p->nr_targets--;
+	cxled->state = CXL_DECODER_STATE_AUTO;
+	cxled->pos = -1;
+	p->targets[pos] = NULL;
+}
+
 static struct cxl_region *
 __cxl_decoder_detach(struct cxl_region *cxlr,
 		     struct cxl_endpoint_decoder *cxled, int pos,
@@ -2177,8 +2227,10 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 		cxled = p->targets[pos];
 	} else {
 		cxlr = cxled->cxld.region;
-		if (!cxlr)
+		if (!cxlr) {
+			cxl_cancel_auto_attach(cxled);
 			return NULL;
+		}
 		p = &cxlr->params;
 	}
 
-- 
2.53.0


