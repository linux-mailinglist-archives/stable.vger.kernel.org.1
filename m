Return-Path: <stable+bounces-256616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEY1EeyCGWobxQgAu9opvQ
	(envelope-from <stable+bounces-256616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:13:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EAB602154
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF8C8307650B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2A83DF01A;
	Fri, 29 May 2026 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSFcHxqW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62B3D4103
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056775; cv=none; b=rKN6ff6A/2r6+vLixsW8RGx+fbhiHO20wd92O2500Lp+2K2cC370aNoPamXiJZRazjshvX33EomNvT9RMrlb6VUZF4v3KUT9DNYyXE9xUrbIXuipQf3PnPYBfbyU4O6+Ouvr8whrqPNdEIvSxAIZFTeanaXCmkaqY1c9+0ow7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056775; c=relaxed/simple;
	bh=JE8LA9juPD4juxz/MBf5J8J9Ac/f41r/b9qVSaNW1ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b88ZoHSzspMkyvx8IrmJm/phyiOq9uDCpbpCS9IQ3jaX8/ftR+X97LD+6ToYBGlaZ637pe7DdNLR31TMJdSnHJF0b8BsRQJHDCQrsGmJs5GETiRhpVVia+y+44DwM/NLj2JFG98yvcef9piCQk64dhAgbvQ4aQ1IV4oNbDJ2Yho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSFcHxqW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780056774; x=1811592774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JE8LA9juPD4juxz/MBf5J8J9Ac/f41r/b9qVSaNW1ow=;
  b=YSFcHxqWmhiUUJBSBTPo/nVBT/5IqKfl9wSVINxWdu8415IjbYtHWewZ
   odLpU5DBvGRgmEeODcU5M9k/5n4xfP63D3s6bouC+KPExfo7xhf739ejM
   9qedFdIkDPYzkczvj7EeeMRZ0jH/m2UXPKLDe3UexH18hzHIP/3SHR/uT
   wMb5W57lLgwNSfDOSz61NdE/B/csAECXizaSd/RwYJqPT0vyL7ER+mtEl
   oC9vKfrgoLHZd5CG4PIAPj/6iIpQfGZF0wcdxM6fEw0Q7XJyirHTm4tyC
   +dIj0djLeoU6hy+vUQaDTkqdYjbCjai+zDA0n/PrSvHuATS1zB+6fMbhP
   w==;
X-CSE-ConnectionGUID: 8s+IML3QTKSgC0dKD/F0cg==
X-CSE-MsgGUID: E3xZFdm2SsaVLauYsDpqRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91216943"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91216943"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:12:53 -0700
X-CSE-ConnectionGUID: GONU+tfLSqyGrcb+KMdNIg==
X-CSE-MsgGUID: YbkXHhWWTuaGq6BkQqDhRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="238643348"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:12:51 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	karol.wachowski@linux.intel.com,
	dawid.osuchowski@linux.intel.com,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Add buffer overflow check in MS get_info_ioctl
Date: Fri, 29 May 2026 14:08:41 +0200
Message-ID: <20260529120841.135852-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256616-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,amd.com,linux.intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrzej.kacprowski@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: E7EAB602154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add validation that the info size returned from the metric stream info
query is not exceeded when checked against the allocated buffer size.
If the firmware returns a size larger than the buffer, reject the
operation with -EOVERFLOW instead of proceeding with an incorrect
buffer copy.

Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_ms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
index be43851f5f32..cd176e77b9a0 100644
--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -291,6 +291,13 @@ int ivpu_ms_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *
 	if (ret)
 		goto unlock;
 
+	if (info_size > ivpu_bo_size(bo)) {
+		ivpu_warn_ratelimited(vdev, "MS info overflow: %#llx > %#zx\n",
+				      info_size, ivpu_bo_size(bo));
+		ret = -EOVERFLOW;
+		goto unlock;
+	}
+
 	if (args->buffer_size < info_size) {
 		ret = -ENOSPC;
 		goto unlock;
-- 
2.43.0


