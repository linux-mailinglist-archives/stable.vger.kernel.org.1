Return-Path: <stable+bounces-87986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A7D9ADA84
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0197328360B
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E221167271;
	Thu, 24 Oct 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlQeC6RA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4E1662EF
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741138; cv=none; b=sbFWKECd5x1Q2dMjIxcTiKrlgxlVfUzvU6IpLs6phfWkM4qQ500r0WYhvpfugRvhpVuPxwD4zkmD4C0i/4T1PUSOgWBIlCnz4whItcuWzCpcEHiVOqIkecr7rFkxOhQopX13+A8EyiwL7jlPUryk7q24bQxIACrZcmW4/AvyPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741138; c=relaxed/simple;
	bh=Zyu4mZ9EwA0er7XMs+TdzzGPQnkeQcRJKmMiDs4T6HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShnoFm/F+sMTKaQAtRK7D2ckW3IPIWv6hsj+0WRg9sTXlcYcCCsqyHpDobWg/DX8kmG+aAykdPYRH2ryfHmHzahS27wKP9YCt8u/j3812lGEalfNFWnInQqm13JogTPtNmSeIP3TTt8/CT2RFvC+v6s8cd4V3Bi/zzqTY3OYk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlQeC6RA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741136; x=1761277136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zyu4mZ9EwA0er7XMs+TdzzGPQnkeQcRJKmMiDs4T6HQ=;
  b=FlQeC6RAjJY46ths4vlN+j4not5rpIEZzoqCVzESIlW4iy2A4+h+SjFO
   DtLNY0pgTggX4g6yu94L0otnobHDI6inuSCc4K314e+qIrIzP5yRdqB0q
   jyixdgsuh/HMhOeAIf+t8y6ZIHQ/rAnlEpOZtgheU1GC5A7shQcjuHXjp
   8ZN7ikjnA3Vax+0IrXfffxVn30QbkxC+nfknh6FKXQ2B/yr6DLl6vnjDa
   25VzEWV8iLAdrtT2PhC7BaP3mJyZzfu/qPB2t+l+pgWdap1Puw7+yFRsW
   zVr0CSIucKK16CRtsyz//LQo8v11F1v1qG/a0uyTlB8QlQmgzcj87WDhP
   g==;
X-CSE-ConnectionGUID: 6WRKvBBBRYqpN66+37W+0w==
X-CSE-MsgGUID: HLYX0noMQHqc/Nu83IEwvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264989"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264989"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
X-CSE-ConnectionGUID: BA7glHkETqSOqEkrkbfM1w==
X-CSE-MsgGUID: GYFyO0u5Qm2+HLXBF7pCow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384951"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 06/22] drm/i915/hdcp: Add encoder check in hdcp2_get_capability
Date: Wed, 23 Oct 2024 20:37:58 -0700
Message-ID: <20241024033815.3538736-6-lucas.demarchi@intel.com>
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

commit d34f4f058edf1235c103ca9c921dc54820d14d40 upstream.

Add encoder check in intel_hdcp2_get_capability to avoid
null pointer error.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-3-suraj.kandpal@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_hdcp.c b/drivers/gpu/drm/i915/display/intel_dp_hdcp.c
index b0101d72b9c1a..71bf014a57e5c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_hdcp.c
@@ -677,8 +677,15 @@ static
 int intel_dp_hdcp2_get_capability(struct intel_connector *connector,
 				  bool *capable)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
-	struct drm_dp_aux *aux = &dig_port->dp.aux;
+	struct intel_digital_port *dig_port;
+	struct drm_dp_aux *aux;
+
+	*capable = false;
+	if (!intel_attached_encoder(connector))
+		return -EINVAL;
+
+	dig_port = intel_attached_dig_port(connector);
+	aux = &dig_port->dp.aux;
 
 	return _intel_dp_hdcp2_get_capability(aux, capable);
 }
-- 
2.47.0


