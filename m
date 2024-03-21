Return-Path: <stable+bounces-28531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8748857C9
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 12:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D71C21625
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764B57303;
	Thu, 21 Mar 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMAdy8kA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589531CA9A
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019215; cv=none; b=RA4MIh0lfZPHLuWbTsRJ+HsuqY+W/O7dGA/Si234wKAHVZDBSZAP4lkprE4rjhhPUnkKePC+cjYq+8qJYIid5AwW0GdnNRE258lriPBv2CdtM0IvwwfIsyDReudsMYDulVsns998YrFvwFF3MTGBVpd3wHqov+10gApBdDZf36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019215; c=relaxed/simple;
	bh=tQXD7Hwd2gMtRCd6Pr3b7WgYWBCWl0r/po9N6KGtuSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtCCoOa8qePmD6w5UrN89dq4wGBVTiFQcyF2A8ya2G80n9pIInq/gDW/wesZDwVLyKfpOIwWyimNkRafy1SqZFHlzuQ2zdTPnUbbN8FytPYC51yFgW516ql2Bjg9lzFeDwM+EvmIqX/FfHZHtM0zSIV4wXDMwsma3BUShPpdFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMAdy8kA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711019213; x=1742555213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tQXD7Hwd2gMtRCd6Pr3b7WgYWBCWl0r/po9N6KGtuSg=;
  b=cMAdy8kAAiG9uQo74WytiYyLrXVyUU3ewiwMNLCvB8p5bn2Lq+MGNgTp
   ltsazgtinFrW+ACG3NtJL5Grs6/O60bdnjLFYmo1FHaZ2eroJ0BlKEkUj
   OZ1Ut6w/AS14bh6c8v+NHaC0V4HCqtNLDtyZd65jTTjC558BZJjpINb3g
   mweKowxBFahdwVx+BLBYI+447rsvLeICHfBLV3blF00fThDzo1li8fX8a
   kOlewy+GhRRkDzpc8d5A7ChwhnU/3YKOaxMD2lvTXvvyl47Iu/iPt+gFQ
   xrECuhd36GmCnxIfb4PMa/p2u7JxyjSok9E/3PhU6n7zGakGKyidJhiRl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16638923"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="16638923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="45469580"
Received: from unknown (HELO mwauld-mobl1.intel.com) ([10.245.245.59])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:06:51 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/query: fix gt_id bounds check
Date: Thu, 21 Mar 2024 11:06:30 +0000
Message-ID: <20240321110629.334701-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user provided gt_id should always be less than the
XE_MAX_GT_PER_TILE.

Fixes: 7793d00d1bf5 ("drm/xe: Correlate engine and cpu timestamps with better accuracy")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_query.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index fcd8680d2ccc..df407d73e5f5 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -133,7 +133,7 @@ query_engine_cycles(struct xe_device *xe,
 		return -EINVAL;
 
 	eci = &resp.eci;
-	if (eci->gt_id > XE_MAX_GT_PER_TILE)
+	if (eci->gt_id >= XE_MAX_GT_PER_TILE)
 		return -EINVAL;
 
 	gt = xe_device_get_gt(xe, eci->gt_id);
-- 
2.44.0


