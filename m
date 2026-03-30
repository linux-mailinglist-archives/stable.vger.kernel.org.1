Return-Path: <stable+bounces-230995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJljLT7pyWmP3QUAu9opvQ
	(envelope-from <stable+bounces-230995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:08:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17C354F76
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3413300CE47
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 03:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604E375AA0;
	Mon, 30 Mar 2026 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACPiVoY2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3EF26ED35;
	Mon, 30 Mar 2026 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840117; cv=none; b=irMtHr09vGlw+Xcb6yJBqCe/Fqq5DTi+9lDXMNYGGFfBWNErCxVpCs5MDREfjAPpuibdiw7Ef+Vs1PuNwySj0r03EKuUeEuVnJas7J/q0GKUM8+x2eINP+i0iW2RM48MjsowpSiTw0/w69xZ32a/hguYRkzMQ1pRdYrUlTAl0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840117; c=relaxed/simple;
	bh=mcEVOJ2LG3KT7zONZb6BF8om4Uq2uTeYaEizPU+/NBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtsFs5B0VHzW0v4ORSF7pf9cCS/5uBOefCDGgzpzdjF/n6vtc83B4JlqxX+3V8YDQL4EVRsNbXRG1vcdBOGAx9rpNzLOcmxtsdEAlWlx3uR+vAV0lKviSozGItY3HIzmhIVhl43E7Dw/LfxzznZy1GEydfUeoVUKoOzS0nAZEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACPiVoY2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774840116; x=1806376116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mcEVOJ2LG3KT7zONZb6BF8om4Uq2uTeYaEizPU+/NBE=;
  b=ACPiVoY20nZCi22gtkY/fKFVBE7XVah7onbo8BlM07gvIzm7IyJsJYuT
   xrVr3UVhmuYfuOEuRCxqkf5prYWpJAt+9jVWHOW7jccdFfyzPIQtoKVrE
   Yq2ILzndu1ZFSliz49Cp02lE6sQMCH3xyG8ip9lRd79kBHRj9xYFaY52r
   Ho2XancGeZnIFnpyz5hpeEnQjcD2vK+thRJhBPdUfw6L+3rvcLJj92mXx
   jwDLy0vquDSbAViXp6ROLEhGFkacTYuOuzDF5kiQU9kfNYThmt7YW8jmQ
   yySpSHvIRxRGTWsxQZsEz5dMhd8nIqGX18wULeiDa23H/urYQbD/yO+F+
   A==;
X-CSE-ConnectionGUID: gBQVLZGvTZud53Jnvv0bQA==
X-CSE-MsgGUID: rc/pYEedTYK0fGKEyZUemg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86517932"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="86517932"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 20:08:35 -0700
X-CSE-ConnectionGUID: 4letKbCoRZecnFtED8Tt2Q==
X-CSE-MsgGUID: zdxweSVWTpK9Z6OblDc3nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="221052606"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 20:08:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
Date: Sun, 29 Mar 2026 23:07:55 -0400
Message-ID: <20260330030755.12856-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230995-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenzhong.duan@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 1A17C354F76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

copy_from_user() may return number of bytes failed to copy, we should
not pass over this number to user space to cheat that write() succeed.
Instead, -EFAULT should be returned.

Cc: stable@vger.kernel.org
Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/eventq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f1e686b3a265..710eef0b6004 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -187,9 +187,10 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 
 	mutex_lock(&fault->mutex);
 	while (count > done) {
-		rc = copy_from_user(&response, buf + done, response_size);
-		if (rc)
+		if (copy_from_user(&response, buf + done, response_size)) {
+			rc = -EFAULT;
 			break;
+		}
 
 		static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
 			      (int)IOMMU_PAGE_RESP_SUCCESS);
-- 
2.47.3


