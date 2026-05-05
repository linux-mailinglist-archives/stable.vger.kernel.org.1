Return-Path: <stable+bounces-244031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDUJJ5K6+WmNBAMAu9opvQ
	(envelope-from <stable+bounces-244031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:38:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5E74C9ED2
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91511301CFA6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A1B40DFB4;
	Tue,  5 May 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZrN0FWu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0D322B8C
	for <stable@vger.kernel.org>; Tue,  5 May 2026 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973634; cv=none; b=QlcrUYXZvxwncjYJxq3/Xi0P+LIt1aUXBmF31G6k7lxUxewInsAENlBhCR6jnpek8bdgFI3WV4QbPBuviPoo7RgFKrObJUQ6ueT/HoOeci6ctG2A3983WXpgCWemnSJ8G9cFUlv3sHDat+5YVSCDz9YpxCqtyflrclUvzyQ0u38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973634; c=relaxed/simple;
	bh=zC85hwRfuu/eBQfcZfR1bL5Fss7ScSU6b2YmZVq7/+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+W8vr8Ih7v/ah1JlARs6WYiW5zMVtJBdnmDpQvhaN3XU6X9PaBT0vk58+fX8AD1srZArGM0+vit7eOU1mYoU0lC4us8wBT6e0ZFFlpxOWCLyKAgf2o1MsPizWXTIU5e7GB2RuziqcJHInsn2cPgbyIzWFQvG6Om+s3EnKO2ARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZrN0FWu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777973632; x=1809509632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zC85hwRfuu/eBQfcZfR1bL5Fss7ScSU6b2YmZVq7/+c=;
  b=HZrN0FWuIX9n/QhA/1LXqLAbu3ERz+LXMlp0LpVIgSkbQQvYznNX+8XE
   1h4P2sgPZZ0F0XRTwB4eTi673LEkN+H5fMQs2JiL3D7Q3Jrzl7J2xtnuN
   1ajhAT4IPpCWERqhXjPWAJVubep5lH+5z9nWs3r7QpKPp87SeThfNXBW/
   2TNKHg4Wy4I2+FwNiUB2nyTn8H8Ws+hHSKFLv4oUW0QM0MLFfgq5AsSNI
   djqSzu71FS9Z0led+YKl9D2daT2GLTXqMWsBORqzvjv7iJyciom2GgouP
   MXC3VuyZvLzxZfO82MH4tpBh+R4dhMJFoNLSBtKF5soBwUOqZp+g6PJPI
   A==;
X-CSE-ConnectionGUID: yR55jU6jQE6E8xTdTni6/Q==
X-CSE-MsgGUID: 0lWdH3T+RpaBjMgKQDcQPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78889687"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78889687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:33:51 -0700
X-CSE-ConnectionGUID: T1BvX/UeStKHKMntSqpvDg==
X-CSE-MsgGUID: GHyA6LkjRPyLNrVcee55zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="273915241"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by orviesa001.jf.intel.com with ESMTP; 05 May 2026 02:33:49 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: gwan-gyeong.mun@intel.com,
	uma.shankar@intel.com,
	imre.deak@intel.com,
	chaitanya.kumar.borah@gmail.com,
	stable@vger.kernel.org,
	suraj.kandpal@intel.com
Subject: [PATCH v3] drm/i915/dp: Fix VSC dynamic range signaling for RGB formats
Date: Tue,  5 May 2026 14:39:20 +0530
Message-Id: <20260505090920.2479112-1-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A5E74C9ED2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244031-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url,outlook.com:email]

For RGB, set dynamic_range to CTA or VESA based on
crtc_state->limited_color_range so sinks apply correct
quantization. YCbCr remains limited (CTA) range.
(DP v1.4, Table 5-1)

v2:
- Added Reported-by and Tested-by tags

v3:
- Add back YCbCr comment(Suraj)

Cc: stable@vger.kernel.org #v5.8+
Reported-by: DeepChirp <DeepChirp@outlook.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15874
Tested-by: DeepChirp <DeepChirp@outlook.com>
Fixes: 9799c4c3b76e ("drm/i915/dp: Add compute routine for DP VSC SDP")
Assisted-by: GitHub Copilot (GPT-5.4)
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 98df93884e9a..c1279afe0224 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3163,8 +3163,13 @@ static void intel_dp_compute_vsc_colorimetry(const struct intel_crtc_state *crtc
 	drm_WARN_ON(display->drm,
 		    vsc->bpc == 6 && vsc->pixelformat != DP_PIXELFORMAT_RGB);
 
-	/* all YCbCr are always limited range */
-	vsc->dynamic_range = DP_DYNAMIC_RANGE_CTA;
+	if (vsc->pixelformat == DP_PIXELFORMAT_RGB)
+		vsc->dynamic_range = crtc_state->limited_color_range ?
+			DP_DYNAMIC_RANGE_CTA : DP_DYNAMIC_RANGE_VESA;
+	/* All YCbCr formats are always limited range. */
+	else
+		vsc->dynamic_range = DP_DYNAMIC_RANGE_CTA;
+
 	vsc->content_type = DP_CONTENT_TYPE_NOT_DEFINED;
 }
 
-- 
2.25.1


