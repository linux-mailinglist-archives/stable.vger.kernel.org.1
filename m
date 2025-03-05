Return-Path: <stable+bounces-120446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A317AA503AB
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA25B16C325
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B638230BC6;
	Wed,  5 Mar 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTbeOh3H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED524E4B4
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189325; cv=none; b=Gn/86Ls59mXmSkLJJGv9T9EIBryxkt/D18hqEMX1iw4P3JStFvxXlPHJcLInIeFZ8t/FHNG0tg4HjAaFuHGA+pKYwl0gSZa96vC6vtDfNRVXCs5X1NDQmsaqXT5zNrbTCP8JWnc/DloaKsB9G2+8ugwtbwzya9m0zCFcrsxw9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189325; c=relaxed/simple;
	bh=+xHc+7gf61sWgKOBmN4FEL14/XlJrXFFfXG1QCVXkRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS3uMwE5xHn2Krcak1gwbefY7U1BD+HfRdroKkFXrmk30PSKkX1wAPpwD1agvT3TYzqeThnddKSjGefsE/yXhwQLKHLWMfmXDZG+bXN9uFz0jiD/IE9ngA7SV/amswZy1kXIzh6JdHKm/TYTJdqkeCRBMPJfcouaMubt4sZ0//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTbeOh3H; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741189323; x=1772725323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+xHc+7gf61sWgKOBmN4FEL14/XlJrXFFfXG1QCVXkRc=;
  b=LTbeOh3H7xzQ5k4OQ2Q5DMh8qxSvD9XFK4kcGRs7xo4bgFC0t3M/MVPk
   hbjRO3N9bAltNb9e3nmv4xHzIjAgvCQlFIPykjVnAhOxF99A7srkk3hS1
   KizRfEDMqAvHzjl8Rb+AywOzzN6mc8Jzmm4AhK6J8Qa43trixHhy3D051
   1QG4oKCNi5qCtuyPNm61xc+dP8LQ9Fh+xSAvFj5SgWxEtaC8YdBChAKqM
   8PzKKMYYyYrpEcWRjqwZzEqmboM2vTN8ToLrD6gyV0x7r9/mDBi34L6nN
   wLVwJ64loMSZdgywUSUrfFQUo3YQIZLrhIxTrG8CiJI5MKcfG/h2V7FKA
   Q==;
X-CSE-ConnectionGUID: 13zkjEqYT/yA0zAzjIphkw==
X-CSE-MsgGUID: G0YgcdY4Tf63VNuRYtpPfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29741612"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="29741612"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:42:02 -0800
X-CSE-ConnectionGUID: 2E1uDXQkQF+KPYsI86MPVQ==
X-CSE-MsgGUID: TUg9s0pcQ2OgVB6MxdCvVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123821186"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:42:01 -0800
From: Imre Deak <imre.deak@intel.com>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 1/2] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
Date: Wed,  5 Mar 2025 17:41:59 +0200
Message-ID: <20250305154159.3564978-1-imre.deak@intel.com>
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


