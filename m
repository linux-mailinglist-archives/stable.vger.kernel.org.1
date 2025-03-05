Return-Path: <stable+bounces-120449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4924A503CB
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 16:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267397A43C3
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9024BC12;
	Wed,  5 Mar 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVnq31A7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D02054FA
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189825; cv=none; b=eGVitv5f4pfki4Mq9yps7FBd/Rc0GcSLJpf449ONXAmPOIRO+ai8OhOg/uITLryE+BJ2ciU6irpfX2fw5zRX5BZQ25THHLlk4QYZAsMKg4bmOKoCyRRI2iD/bkz78+iT6HEEw2+Z0T0tIB4QzEHHM6DozQtwbeNSmvwPMm3irEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189825; c=relaxed/simple;
	bh=LKWrSgv73IWxhBXVs/rM594SSLrUnLrWz7BGAxmeP2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsjjrqk2QSIYe+qejNWaS/FPIIdlytNCQ0b5BfYOwpdrhkSfIw4NEHqsSC8fHaNnMhFWoW1nf8r+nBmWFVV0ZmvIMlJToXX6m1e18guUSBJFqyI8fv9eHvb4OERlfaApUTXwVJIG4YlbFKdS96XY/5XsYVWcOyWK00fnPH/0Rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVnq31A7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741189824; x=1772725824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKWrSgv73IWxhBXVs/rM594SSLrUnLrWz7BGAxmeP2w=;
  b=BVnq31A7SE5hc6dnsXbmcEESHsSYYU35HACi/k2cRof7WAq80QHiZJP/
   eXykXkPzzmS19rtfJW/at6kTOWrQEbQQ9N+1+osOtYjkmXBRBje3L91kV
   TtEeXwbofYmCBIaKDDKelGIQYZSMjVgbrbifHpNyH7jHK9ePpcZ7+L+ws
   zgq8WJwYipUV5fV0e1TrXhzfrp+W7HB/u39vtu3qxxKpOY/3HNM+AvakX
   0Jsaqn8DnumGCDMJ/GJRqW/ikUZS8C5Mw1zxLn9R8VK+58dZ9yNOkC3t5
   5NqrTAJz6ebqS1HYhLkNCYayUdiN5fMg30J1Lr1aDQN20/HrVwMesOKIU
   Q==;
X-CSE-ConnectionGUID: Jyjg/mZSTkuYwSO4sXdn2w==
X-CSE-MsgGUID: 8prRsWXYR4iTK4fCznFWZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52796571"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52796571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:50:23 -0800
X-CSE-ConnectionGUID: uvdPnwN+T+m1I/d6Z5ppDg==
X-CSE-MsgGUID: Kr5qJAkCQEymm+10IpIiZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="119416614"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:50:22 -0800
From: Imre Deak <imre.deak@intel.com>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
Date: Wed,  5 Mar 2025 17:50:20 +0200
Message-ID: <20250305155020.3565643-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <2025022418-clergyman-hacker-f7f7@gregkh>
References: <2025022418-clergyman-hacker-f7f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 879f70382ff3e92fc854589ada3453e3f5f5b601 upstream.

The format of the port width field in the DDI_BUF_CTL and the
TRANS_DDI_FUNC_CTL registers are different starting with MTL, where the
x3 lane mode for HDMI FRL has a different encoding in the two registers.
To account for this use the TRANS_DDI_FUNC_CTL's own port width macro.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: b66a8abaa48a ("drm/i915/display/mtl: Fill port width in DDI_BUF_/TRANS_DDI_FUNC_/PORT_BUF_CTL for HDMI")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214142001.552916-2-imre.deak@intel.com
(cherry picked from commit 76120b3a304aec28fef4910204b81a12db8974da)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 879f70382ff3e92fc854589ada3453e3f5f5b601)
[Imre: Rebased on v6.12.y, due to upstream API changes in
 intel_de_read(), TRANS_DDI_FUNC_CTL()]
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 293efc1f841df..834ec19b303d5 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -800,8 +800,8 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 		/* select data lane width */
 		tmp = intel_de_read(dev_priv,
 				    TRANS_DDI_FUNC_CTL(dev_priv, dsi_trans));
-		tmp &= ~DDI_PORT_WIDTH_MASK;
-		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
+		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
+		tmp |= TRANS_DDI_PORT_WIDTH(intel_dsi->lane_count);
 
 		/* select input pipe */
 		tmp &= ~TRANS_DDI_EDP_INPUT_MASK;
-- 
2.44.2


