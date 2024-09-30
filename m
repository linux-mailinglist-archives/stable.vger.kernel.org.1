Return-Path: <stable+bounces-78303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521A98AFF2
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 00:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95C21C223B0
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 22:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928518CBE0;
	Mon, 30 Sep 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbhK0Mw6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CDD188CDC;
	Mon, 30 Sep 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735769; cv=none; b=uB1Phm62PMRWX2386X2A5qoEmlZn6SSF8PRAf882mToEeGhgXNaMdcHltWM5icRWPcqYB1u4rHtrjRN1iOZoBAemO7HTPNMCRZAgWc500ehZz4seDeYp0w9yb7oudSE9TkAuIYTxLaJQ05BH536f7LsrspmHmoACJrHQRsP3j3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735769; c=relaxed/simple;
	bh=PKn7oc2AZRvdVDnrmUspmIG/9ddRENlq1gIXvjjGLdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl4Yyj6f1k3A254VZhLommjHmWDYfnGlsohh5GUg2DMRfDsDQusnhiZ1aWkb/pVxqZuot1k+mVt4y0MLV9T0vY0zhwTgJVdIL0bfqCI8zV8ixX6tsIenj6mQUP6Is5reUeqyWXmUeG/d/M3TWXjHNyFbOyq4rU1LYlx7TbFE5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbhK0Mw6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735768; x=1759271768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKn7oc2AZRvdVDnrmUspmIG/9ddRENlq1gIXvjjGLdI=;
  b=JbhK0Mw6DkoDsWv3F8Y8g72XB6jShL+cFroEzPSkeYUXpQYAJFC+k0uz
   qnpviS5ImU/WlpduP65xNN++Txa0AiHBP4j8/FeBNgp/6xyTmwcaIzuEV
   AUdWKkqOXURcWHiULEnj5Wub9SYMlOtQgQlEIE2+8mwtjAlGXNPoJ+6y4
   aJTKleE9TgIlNyyWYraujgb9f2wogieq9jfvihB/ZNeJmHC8MioGW1jF1
   tIR7Nine4jbAQvT2QQSpPW3D9+ufdOsl/WreywSfN3asBexHoz1g3Ko/d
   BEm8zr4HbVsw9eXhGO2njHjhZ3XkmKNBIORuqO1A17rvcEf9qa1tGRid7
   A==;
X-CSE-ConnectionGUID: 8BjGIhunRumTpHGQ0uw6Ew==
X-CSE-MsgGUID: 2CVOrnilRminBHjE1br+gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734856"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734856"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:06 -0700
X-CSE-ConnectionGUID: NmXZQtPNS/m2yuX930RRGw==
X-CSE-MsgGUID: 983sn0jNQhKNDcZVlwVEwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496611"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 30 Sep 2024 15:36:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Gui-Dong Han <hanguidong02@outlook.com>,
	anthony.l.nguyen@intel.com,
	baijiaju1990@gmail.com,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 02/10] ice: Fix improper handling of refcount in ice_dpll_init_rclk_pins()
Date: Mon, 30 Sep 2024 15:35:49 -0700
Message-ID: <20240930223601.3137464-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gui-Dong Han <hanguidong02@outlook.com>

This patch addresses a reference count handling issue in the
ice_dpll_init_rclk_pins() function. The function calls ice_dpll_get_pins(),
which increments the reference count of the relevant resources. However,
if the condition WARN_ON((!vsi || !vsi->netdev)) is met, the function
currently returns an error without properly releasing the resources
acquired by ice_dpll_get_pins(), leading to a reference count leak.

To resolve this, the check has been moved to the top of the function. This
ensures that the function verifies the state before any resources are
acquired, avoiding the need for additional resource management in the
error path.

This bug was identified by an experimental static analysis tool developed
by our team. The tool specializes in analyzing reference count operations
and detecting potential issues where resources are not properly managed.
In this case, the tool flagged the missing release operation as a
potential problem, which led to the development of this patch.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index cd95705d1e7f..8b6dc4d54fdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1843,6 +1843,8 @@ ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
 	struct dpll_pin *parent;
 	int ret, i;
 
+	if (WARN_ON((!vsi || !vsi->netdev)))
+		return -EINVAL;
 	ret = ice_dpll_get_pins(pf, pin, start_idx, ICE_DPLL_RCLK_NUM_PER_PF,
 				pf->dplls.clock_id);
 	if (ret)
@@ -1858,8 +1860,6 @@ ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
 		if (ret)
 			goto unregister_pins;
 	}
-	if (WARN_ON((!vsi || !vsi->netdev)))
-		return -EINVAL;
 	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
 
 	return 0;
-- 
2.42.0


