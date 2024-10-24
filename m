Return-Path: <stable+bounces-87985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE429ADA82
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355881F2242A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A828166F1B;
	Thu, 24 Oct 2024 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PP2tEqsf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF71EB3D
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741136; cv=none; b=f8Eohh//koZY6BOWs65y2g89HBIEyPQvjXzBkzURX+m2yQBxNn0iB04aTjopD4YtBkDZCYq0f4NM9nqKgVAtPyximhNBvzGCT9PWpY893zUeuSy0HwrjwtYf+Rovc/bA2gCvgsIjV45wQiurKjR7nb2WvNY+BBKOU5ZISBJ6Mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741136; c=relaxed/simple;
	bh=hRWUGx/BipGTuyxlhcKwWGV/t2eif+GT18dsZWL90pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVplIG9iN84EpuAL/KUc1H5Iimg+b+AHveu1SppFwweB8NYFA+0f1iuhSM43UGd6nMktK1UHnC5J1HpIEdrmibDjoJNF8/47KWo+W/5KpJvxFQCKWwv+Cgif+jUlF17WCd2sjSz2T3kWBDCL+LM5j1xArO/ggWpoWGvz52xtQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PP2tEqsf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741135; x=1761277135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hRWUGx/BipGTuyxlhcKwWGV/t2eif+GT18dsZWL90pA=;
  b=PP2tEqsf1EDfka/U8alwbadzI3/bYm1y0C2/KMhdVbqiAnyzgX/ZhcvQ
   yTbwINRCsVud1Hs6a6jNzY1KEuC41BikbxtIYk/o5HWbaY/dIxRWjDI2v
   8Ao3PPE2CxCHxGbA+vY6/1NF9y9pX7lBHd6mRsk2Th7xLk2FgpVXUvvLr
   Benkvf48d4kWS8vyrpEfumeGrdYmxsXfyvpuPBKb1dkNKkXf0R8v6rfYS
   10lcitrX3/nNxGiMjTCQWQ6q1H2bJRFtUcjUwe/vdYqeup3t+f/7YbWxV
   wWi5p0Zg+owF7VqdwPsmnFH5gDRLFjfF4pClsjenOMCscGolcO6/YjWmK
   w==;
X-CSE-ConnectionGUID: kwORbi32QlOEZP5RqkIqvA==
X-CSE-MsgGUID: c9kAyYV2SE2TVrfW36RkcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264988"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
X-CSE-ConnectionGUID: uShb02YpTfSwrAFv75sJeA==
X-CSE-MsgGUID: 9p9oWW7QSXuGVkeIvTybiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384948"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 05/22] drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
Date: Wed, 23 Oct 2024 20:37:57 -0700
Message-ID: <20241024033815.3538736-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Kandpal <suraj.kandpal@intel.com>

commit 31b42af516afa1e184d1a9f9dd4096c54044269a upstream.

Sometimes during hotplug scenario or suspend/resume scenario encoder is
not always initialized when intel_hdcp_get_capability add
a check to avoid kernel null pointer dereference.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-2-suraj.kandpal@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index b0440cc59c234..c2f42be26128d 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -203,11 +203,16 @@ int intel_hdcp_read_valid_bksv(struct intel_digital_port *dig_port,
 /* Is HDCP1.4 capable on Platform and Sink */
 bool intel_hdcp_get_capability(struct intel_connector *connector)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
+	struct intel_digital_port *dig_port;
 	const struct intel_hdcp_shim *shim = connector->hdcp.shim;
 	bool capable = false;
 	u8 bksv[5];
 
+	if (!intel_attached_encoder(connector))
+		return capable;
+
+	dig_port = intel_attached_dig_port(connector);
+
 	if (!shim)
 		return capable;
 
-- 
2.47.0


