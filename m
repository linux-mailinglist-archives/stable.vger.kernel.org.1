Return-Path: <stable+bounces-163619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868A0B0C9CC
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 19:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE9E541254
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C92E265E;
	Mon, 21 Jul 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1kzx+jH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7188E2E1C4E;
	Mon, 21 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119466; cv=none; b=NhHiRzt22v8NB5eRPmKrPNSe+eUCfJNRnQ4UJAAaxlZyYEok8p0xIi5/BtyenFlflARsnx9Y0PNycvX+WfaSKOWs3sQYGI/Q0N4wcZIJRkggrS5T/pGsuRc5Xa91LpwVMZgUSPgYw5MrcuIIZNK/jLVQbq8Gh9ylXmRF2R0qC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119466; c=relaxed/simple;
	bh=EI9fltquaqZZdY0Or/ichzC3EwsphwCeAmCSwIbARFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NY5BUR3X+XmGnXacMiEjVtjKfcqqRxVKAGdttZnqwBa2wEcMUPbjVJNx7tYHWjRDiiyIE8XgfU/7v3gTmccXtMkVAAeVbO13I3+40qC6Ed3h1HAM6yv5yFKKdll14MDtusH21+1Rj9hb7PoIUR/e7W1tqMUgY6MFRWutq2oqisA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1kzx+jH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753119465; x=1784655465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EI9fltquaqZZdY0Or/ichzC3EwsphwCeAmCSwIbARFg=;
  b=B1kzx+jHFCKWlz/T3gBZeh5EYm3kF9owU+m05Tx1tT9kmZZix0bufEWE
   OcrRHM0gQMqrgchIRltFmv2EARvQXtcLi6OSoaEfjDwdYMiWldGNXbIAy
   K10cQvVuNzBBYhowVLTZjj2qD/LsbrarESesBzbAsIfTremCO0kHcff8V
   S2U6XpsBbpV1iVB4ignE6daC6DwK/5/NisCF4tv/awAcxnTcvgda8o1CB
   JXTHEK+uQ8H44LtojMkLb6Q+ZatKWXCw6JxeEA80ZP5nKKCxi3uvSVlaj
   3809Od+O1StNQsfOS9JJbW38IJ0t/HW3Uvv0hEPAO3R1DWeB2mdAHkwzc
   Q==;
X-CSE-ConnectionGUID: CUahJi94QcCZ4vDdUBjrkA==
X-CSE-MsgGUID: SBphea1nRiOgujrxPWl1xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55193191"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55193191"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:37:41 -0700
X-CSE-ConnectionGUID: AD76vKfGQeeHHkH56N0JgQ==
X-CSE-MsgGUID: fxvp7GDLSDecm0zWHFBT7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158231566"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 21 Jul 2025 10:37:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/5] ice: Fix a null pointer dereference in ice_copy_and_init_pkg()
Date: Mon, 21 Jul 2025 10:37:24 -0700
Message-ID: <20250721173733.2248057-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
References: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

Add check for the return value of devm_kmemdup()
to prevent potential null pointer dereference.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 59323c019544..351824dc3c62 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2301,6 +2301,8 @@ enum ice_ddp_state ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf,
 		return ICE_DDP_PKG_ERR;
 
 	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
+	if (!buf_copy)
+		return ICE_DDP_PKG_ERR;
 
 	state = ice_init_pkg(hw, buf_copy, len);
 	if (!ice_is_init_pkg_successful(state)) {
-- 
2.47.1


