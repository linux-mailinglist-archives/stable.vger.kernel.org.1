Return-Path: <stable+bounces-8310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56AF81C4EA
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 07:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051B71C23CDA
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 06:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20D63CF;
	Fri, 22 Dec 2023 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lorgN/wM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351679E4;
	Fri, 22 Dec 2023 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703225535; x=1734761535;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pcZ2daKc+SJVkk1sDMwNbWFHvIytoWAsxUQw+eQSGKg=;
  b=lorgN/wMrLjAY8r1OXCwLC+CyTmj3LbQ9TzphqDLKY7ERPLMzA2Wq7MS
   VUMQLF4u8Ag4K5X3EfUSHv4pY8lSWePRgCn5tTleV+i1A2UEuFl8yPPOY
   ODSSH/2y9aqKTVZdAaLZFdI3xuL4JehO3QxczP9lgbn5OMPrgat57VJth
   mYDr447AM7KIe880CRlGjaFMkz5+WVT60+aDBO0/O/fCZsQuLkxL1J+HM
   KY8fXVD/yfs+5KTolycfy4kzMnUgKHv49W+FVUKItjFuw7kZ9G97CkOEK
   EuR826RiMnDPV+l7jr0TpiwjwZ6udmoKykgbRF+nRVABxqutUIMwjtH0u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3330546"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3330546"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:12:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="920567558"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="920567558"
Received: from yvgambhi-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.48])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:12:13 -0800
Subject: [PATCH] cxl/port: Fix decoder initialization when nr_targets >
 interleave_ways
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: stable@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>,
 alison.schofield@intel.com
Date: Thu, 21 Dec 2023 22:12:12 -0800
Message-ID: <170322553283.110939.32271609757456243.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Huang Ying <ying.huang@intel.com>

The decoder_populate_targets() helper walks all of the targets in a port
and makes sure they can be looked up in @target_map. Where @target_map
is a lookup table from target position to target id (corresponding to a
cxl_dport instance). However @target_map is only responsible for
conveying the active dport instances as conveyed by interleave_ways.

When nr_targets > interleave_ways it results in
decoder_populate_targets() walking off the end of the valid entries in
@target_map. Given target_map is initialized to 0 it results in the
dport lookup failing if position 0 is not mapped to a dport with an id
of 0:

  cxl_port port3: Failed to populate active decoder targets
  cxl_port port3: Failed to add decoder
  cxl_port port3: Failed to add decoder3.0
  cxl_bus_probe: cxl_port port3: probe: -6

This bug also highlights that when the decoder's ->targets[] array is
written in cxl_port_setup_targets() it is missing a hold of the
targets_lock to synchronize against sysfs readers of the target list. A
fix for that is saved for a later patch.

Fixes: a5c258021689 ("cxl/bus: Populate the target list at decoder create")
Cc: <stable@vger.kernel.org>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
[djbw: rewrite the changelog, find the Fixes: tag]
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b7c93bb18f6e..57495cdc181f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1644,7 +1644,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 		return -EINVAL;
 
 	write_seqlock(&cxlsd->target_lock);
-	for (i = 0; i < cxlsd->nr_targets; i++) {
+	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
 		if (!dport) {


