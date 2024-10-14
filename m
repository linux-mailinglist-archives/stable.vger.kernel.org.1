Return-Path: <stable+bounces-85055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E499D44B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CF21C20EB3
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BA61ABECD;
	Mon, 14 Oct 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SC6bAct9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F01ABEA0
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922182; cv=none; b=tFT836X4RBOnrVCttTncPyCzu4xjyrcCsnbqh1aOPKjSTksNDtOd0Xa78AvugzZVIMx9F23vhxrIYcIMzhQM6FyBhPkSKDTpP1n2ivbYRntfn31gFI2ttQI2pw112jXNOXjC89n+0zL+CqBBaXP/SjwjxTlmYLtgDSla0yEUvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922182; c=relaxed/simple;
	bh=Qnv02q9ID0opb9y+eBj++9oNKzynDcChPobJVDYMsPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bonKUJTTP511izu15xXWOdV3LjQUlNIN83U5ShPwQ9nDJtATXsxSA6c57EJsFiOQY1K+vMPJDiI2gMMgCWA91R+JBwr2KEc0ireP0h4uURhNICvFqhNCtv1Uk+WSbb27O171pcG8qQ7x1CNIM80/zBWaj9WblrsYvCkhYOY4xhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC6bAct9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728922180; x=1760458180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qnv02q9ID0opb9y+eBj++9oNKzynDcChPobJVDYMsPM=;
  b=SC6bAct9GP6uzHGIOtbJuA4YGE1Q7Qc4AzrZmX/DubIlw4g7wF4kSpZo
   ilJFkJ8xtMCStNiHcHepaSiJQRffqspgkBmqx36p2KWxu29tqE0dOic4u
   NdNYpADgKQJxBhKThVGm54QYyZxdTIehn34YrieCZkCEqHh7vv00Kj4Z0
   cJQR686TGOdBPy44yGWII84+eld2o/nNBMOLV6opD0alCIWC661J5u3M+
   cURzXi06X+H80rxwohkcdpGkMxM9g1prA5kG4vwQXRlSeV3lkphzrQ16R
   JAGq5eLgB6Sh+eyENZGdO/L5tELiu6eyFlNhYdCiWFL3PvCZ6IaCoqG9X
   A==;
X-CSE-ConnectionGUID: znLkoTwcSJWaYbND6tLF+A==
X-CSE-MsgGUID: aY8oCSwkQkGn9LjCD8lVFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28408479"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="28408479"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 09:09:39 -0700
X-CSE-ConnectionGUID: bScTTqBnQY6FfKili8oakg==
X-CSE-MsgGUID: auhFY9CbTRyXrgY44mG+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77720745"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 14 Oct 2024 09:09:38 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 14 Oct 2024 19:09:36 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: [PATCH] drm/radeon: Fix encoder->possible_clones
Date: Mon, 14 Oct 2024 19:09:36 +0300
Message-ID: <20241014160936.24886-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Include the encoder itself in its possible_clones bitmask.
In the past nothing validated that drivers were populating
possible_clones correctly, but that changed in commit
74d2aacbe840 ("drm: Validate encoder->possible_clones").
Looks like radeon never got the memo and is still not
following the rules 100% correctly.

This results in some warnings during driver initialization:
Bogus possible_clones: [ENCODER:46:TV-46] possible_clones=0x4 (full encoder mask=0x7)
WARNING: CPU: 0 PID: 170 at drivers/gpu/drm/drm_mode_config.c:615 drm_mode_config_validate+0x113/0x39c
...

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Fixes: 74d2aacbe840 ("drm: Validate encoder->possible_clones")
Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/dri-devel/20241009000321.418e4294@yea/
Tested-by: Erhard Furtner <erhard_f@mailbox.org>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/radeon/radeon_encoders.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
index 0f723292409e..fafed331e0a0 100644
--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -43,7 +43,7 @@ static uint32_t radeon_encoder_clones(struct drm_encoder *encoder)
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
 	struct drm_encoder *clone_encoder;
-	uint32_t index_mask = 0;
+	uint32_t index_mask = drm_encoder_mask(encoder);
 	int count;
 
 	/* DIG routing gets problematic */
-- 
2.45.2


