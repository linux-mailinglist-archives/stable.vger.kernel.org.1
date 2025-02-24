Return-Path: <stable+bounces-119383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F11A4269D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7223B3BABB0
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43FD25D54B;
	Mon, 24 Feb 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ij222nex"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD925C714
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411017; cv=none; b=jrT/t7hAhoVcR9bzRbR4fdXaRidO6Z8J1NANWoZgCE3tr1brEkh/SrEbOyjt8qs233MAzy02ngi8HiXQVZbmZaL01lOozAWbOkHRMEhC8DJHU2R2VIzP7gfz3vBwYtTbVYs5f3BGbxPcC6Eo73yIJJr9EVOvbCctol372lCNWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411017; c=relaxed/simple;
	bh=0Ke9RI6kwlPndtmjx+XwIj2K2vwndqSEKty7im/QNvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaEu2FhpvgA2YVmMEWJpGO93IbNXtC96mDTAAnY+DvdrI9qzeQ7weoWm2C7Ow1e7gmXxG0TKbz7/dUMPOeKwYHvi5fFiBz57CYnMsHsDbKeK0DQEKxwEGsb1zFUiX20iN5lqEi9c7VgKvEa8aZvFGDHL25gfoOP/+jCzSfGrQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ij222nex; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740411015; x=1771947015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Ke9RI6kwlPndtmjx+XwIj2K2vwndqSEKty7im/QNvc=;
  b=Ij222nex/nZhYoumzL70FenulycKo8oqwOdVwlYUa1j+TEc6lnVW1rxt
   lYskXsn+HwV8eHcJ8kFecri7LTMp44bRLXgkqSA+e7G+Qc5b3vI0xeyPt
   hgTVojjGS7cjYgi6VfpVFExVc1f12B3gf3bieBukfNcgQGYWcGB1dxGQr
   Cy4ngtd5Efb0jd2f69FYUSbeJX14YxDSUCkt8TBXPdrRNJyf2vEtxAVLY
   FaTUeqs/hASlAyF7XgNLU6muPWQGXl8zyk2yJhmJgc2sVb1CAlfuSov02
   S7DsVzPA7f7B8ZFGthblsFJ6AutyhOU7RHcGY7KMPXeuQGRBsGwwhk1PV
   w==;
X-CSE-ConnectionGUID: Fx8nuxwfQPm4vIPxRhdHUw==
X-CSE-MsgGUID: c6dGx9DaQ/KeD94bE7Whjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40358249"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40358249"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:30:12 -0800
X-CSE-ConnectionGUID: aQP5QzvSRrC4lHenRyBdVA==
X-CSE-MsgGUID: khLoQnt5SkeYlqsmZ/AzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116594669"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:30:10 -0800
From: Imre Deak <imre.deak@intel.com>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.6.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
Date: Mon, 24 Feb 2025 17:31:11 +0200
Message-ID: <20250224153112.1959486-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <2025022418-frostlike-congrats-bf0d@gregkh>
References: <2025022418-frostlike-congrats-bf0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 76120b3a304aec28fef4910204b81a12db8974da upstream.

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
[Imre: Rebased on v6.6.y, due to upstream API changes for intel_de_read(),
 TRANS_DDI_FUNC_CTL()]
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 5b8efe8e735a9..0a0efeeb790e2 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -797,8 +797,8 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 
 		/* select data lane width */
 		tmp = intel_de_read(dev_priv, TRANS_DDI_FUNC_CTL(dsi_trans));
-		tmp &= ~DDI_PORT_WIDTH_MASK;
-		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
+		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
+		tmp |= TRANS_DDI_PORT_WIDTH(intel_dsi->lane_count);
 
 		/* select input pipe */
 		tmp &= ~TRANS_DDI_EDP_INPUT_MASK;
-- 
2.44.2


