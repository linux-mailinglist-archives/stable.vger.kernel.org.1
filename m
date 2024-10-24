Return-Path: <stable+bounces-87981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C199ADA7F
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420F21C218B6
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1AB15C120;
	Thu, 24 Oct 2024 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnl4cW1i"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A21136E21
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741133; cv=none; b=KEAJYlA5xQETzyRI98bkMDNfzUjAam/dBQK7yp8HDdI+qAZCwDtwLUIqAidnuPwYcCTqyNDFBnDcTudfro7WipWb54z2jH1iwzvg8D45Ua/fbWNLJAVO4ZDOTt9TJzw6zE5gedgU7TfhCXLw+tQ0Sn1KalEieF/q9E62DJeKomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741133; c=relaxed/simple;
	bh=VxSvxGsmAjrlzxkXfHsnvR86krfEkxc7mr2GFAxdG1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4rGt9CfCKtoRG9TaIM+KTAfRYkS9jwrdwngTEeC/m6XMraGIN0I2qdtMBIBj4A6vyTMWAG1VfzJFjh43cYJzTi1r0zHDTUrbaK/cR63UB+YD1ZGcFh8r+3GVkM5Yxk1mfgw52qe4qtauO9nPgYaCjdCEp+I4+gobDw5wYdVBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnl4cW1i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741131; x=1761277131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VxSvxGsmAjrlzxkXfHsnvR86krfEkxc7mr2GFAxdG1Y=;
  b=cnl4cW1i/kZCA4j6dEmu5NDso+2HvrD/w4tJEWcqE+kyrFSRkMM3FcYP
   Q4Ad/Nsn7+TZ6wjtGEGz+NkgQp3sdlymhWKwoVp8cBOFuVNCKvPevCKeG
   +VKLQP5Qlnjti4K1ti1VKIYRXBrOmUdbclaBTMNf+Vq8i+xUFIlMnQjdT
   ww3ybGl7vZMsnqBJvjFM9eE437/pdgX1CSIlc9cguUQ7F3wSocaRnkBAm
   ++nHHUiTbkfVgvw2yl/ZDi8JBh6nOf7YsivgRbh+c+i5C07LsRhrMhtGb
   mPPeXfJLjvxDZOHsZfzPL8HnhIcwQWI4febe9cePTXVorAV9m0WTEbzLI
   A==;
X-CSE-ConnectionGUID: d7jdTkn5RZO74ZPOXLNXdA==
X-CSE-MsgGUID: CLX7be7ZRRKJVTJ0EgUOpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264981"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264981"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
X-CSE-ConnectionGUID: QJuefRXhTYq5hYIJ2PQOKA==
X-CSE-MsgGUID: wSAXKjwPRDGa7CI1HPatyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384936"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Shekhar Chauhan <shekhar.chauhan@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 01/22] drm/i915: Skip programming FIA link enable bits for MTL+
Date: Wed, 23 Oct 2024 20:37:53 -0700
Message-ID: <20241024033815.3538736-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Sousa <gustavo.sousa@intel.com>

commit 9fc97277eb2d17492de636b68cf7d2f5c4f15c1b upstream.

Starting with Xe_LPD+, although FIA is still used to readout Type-C pin
assignment, part of Type-C support is moved to PICA and programming
PORT_TX_DFLEXDPMLE1(*) registers is not applicable anymore like it was
for previous display IPs (e.g. see BSpec 49190).

v2:
  - Mention Bspec 49190 as a reference of instructions for previous
    IPs. (Shekhar Chauhan)
  - s/Xe_LPDP/Xe_LPD+/ in the commit message. (Matt Roper)
  - Update commit message to be more accurate to the changes in the IP.
    (Imre Deak)

Bspec: 65750, 65448
Reviewed-by: Shekhar Chauhan <shekhar.chauhan@intel.com>
Reviewed-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625202652.315936-1-gustavo.sousa@intel.com
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_tc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 9887967b2ca5c..6f2ee7dbc43b3 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -393,6 +393,9 @@ void intel_tc_port_set_fia_lane_count(struct intel_digital_port *dig_port,
 	bool lane_reversal = dig_port->saved_port_bits & DDI_BUF_PORT_REVERSAL;
 	u32 val;
 
+	if (DISPLAY_VER(i915) >= 14)
+		return;
+
 	drm_WARN_ON(&i915->drm,
 		    lane_reversal && tc->mode != TC_PORT_LEGACY);
 
-- 
2.47.0


