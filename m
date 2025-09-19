Return-Path: <stable+bounces-180692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A2B8AFBF
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBDE563358
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC7279DAE;
	Fri, 19 Sep 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeFeoos8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FC276050;
	Fri, 19 Sep 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307809; cv=none; b=il1eum3gZ8lQDE2hGaYQh76CYQNO866X/ZSTtwHcmIjD+Ay0jMGep6HRu/CEW2de2PH2qTq0ZKNVTz+WWeh8pCxqns+n3o9/IZPY4qX1uXtX8Z4z2Z+elc0HHuMfJsYcXJiS1UuSxmye1yetEIZIKMJleqJfjtBSUTUpVJ4dZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307809; c=relaxed/simple;
	bh=9jgxN2hb2oX58Mj3p3jPGEEAipYs05bu/Fpc3dikX7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc+4DADTP091M4Enneh7dUQ5Snsf5kh+fLHnK0zdmSAsmHCUK+bgHwXuovnD1VvSHECRS98nAwndAPF3PDX5XgPTaW/OptFXqoFOhyrZYWOhZDNM6aWAR6CvQFSg+aj4zuBY3w546yzumF7r0241WEidWCy/2kQwgdCc1i8f63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeFeoos8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758307807; x=1789843807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jgxN2hb2oX58Mj3p3jPGEEAipYs05bu/Fpc3dikX7Y=;
  b=eeFeoos8Xvuw1lsmCyqmUmphkH/nAUHmLKZsy1Ofoyt+cXditxDMLr4z
   ju6tVFrp0n6tMcQ4xTMZ/EoMNRVXMrRkCkGvRr18eJCWtKabesPmDD0A1
   +pT9b8CKC84OmVBLFG/5ITuXwNdpdzrNML+drKZKvIRQVK7vaX4EtJrif
   EcdVvdGvdI2EdZvgNfCa8gWTqwI2cmxaLJG07N97x8nrVo1KVcVaSmKwd
   tt/pRBXixzFBF+97aSbsP7VhdQvewQMzO7X0GPNHcPj6Q3e7sHdpFBADe
   s5cyxzGezdsrU+DvlzerMElgnGxWqu9VG5BVRvN7r76IbU8lROCX9a5Sl
   Q==;
X-CSE-ConnectionGUID: KjOH6rDTSq+6lsN/Gb0reQ==
X-CSE-MsgGUID: 9Nm5iY7ZQn+yWg7X7ixWXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60589750"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60589750"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:50:05 -0700
X-CSE-ConnectionGUID: 8wb9w+0rQ6iisePt+Jjn3A==
X-CSE-MsgGUID: XXypAbvSQsWWychJhfPV8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175458774"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 11:50:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	leszek.pepiak@intel.com,
	jeremiah.kyle@intel.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/8] i40e: fix input validation logic for action_meta
Date: Fri, 19 Sep 2025 11:49:54 -0700
Message-ID: <20250919184959.656681-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
References: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Fix condition to check 'greater or equal' to prevent OOB dereference.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b6db4d78c02d..c85715f75435 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3603,7 +3603,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
-- 
2.47.1


