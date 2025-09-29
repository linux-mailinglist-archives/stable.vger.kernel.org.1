Return-Path: <stable+bounces-181942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3017BA9BA9
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B871893AAD
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4973C30276D;
	Mon, 29 Sep 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrtE5IWj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A852BF00B
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157918; cv=none; b=cPDQXQKT+DmPLJ3jiXEIQbteJ3o0djQ2Vg4QJ9y3+jOxp+10X65BGuDlz5MdEOoqc3v2odGHRNrMaRtj4v+sNLwpuMq8QUZACuYXtMdjB4mYeBzSDOqiw2Ob63op+SMRXPS1YzyGmT+eTPOYzPbkBbaUhc4PKqCZSH6vyBI1vqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157918; c=relaxed/simple;
	bh=eiFosAe5b8gss9L9X07ut2wSK4tIW7TzyIQmiiUIsEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbnbakaIu6GCw7L0JjIgqTvDKqsvLFjdIgQGIXibbkKy4klzI6XXp5YiMJ9o1GHLJb/0+zq8/oXYXfmW3Tra2yVViLG6lHiT/FJEngwBeugnynUsVHtEm39uXnKNr3W9/F6UogIQBejq3Na7zbAF1sNUERLzUYc7z2llRctsMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrtE5IWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5F1C4CEF7;
	Mon, 29 Sep 2025 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157917;
	bh=eiFosAe5b8gss9L9X07ut2wSK4tIW7TzyIQmiiUIsEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrtE5IWjmCDaTGFcA0y+NKwJ005punuBjzUZYGFy8Z6lNzM1L3XF8W8ZrprauCzwA
	 bez3pvV8jWiNZXMTWSP7y2/INUGqItejBszT/JhpufF8NbSCtm/QfRj+AZhjPqTBPF
	 BV11aaCYttXgYFaUg12xcP5l/re9MlfA6jHbYcSVfXaaSJ4YynPyli064C22erPsHH
	 o9YxInW2kdFPZALR1b4p6LgzWrTRsR0VXQksZ8po1vJ+sFnUQdMTyP1KKHY9fhc3B2
	 ky+mMjWnYrBFKGIe6dAPr/dJd6+rdpwxA9tLM5aRLZ3YxRNCsETsvPeIFiO7/IFMPB
	 a49CXDFiqc3Lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] i40e: fix validation of VF state in get resources
Date: Mon, 29 Sep 2025 10:58:34 -0400
Message-ID: <20250929145834.112517-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092912-bullfight-urgency-ae9f@gregkh>
References: <2025092912-bullfight-urgency-ae9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

[ Upstream commit 877b7e6ffc23766448236e8732254534c518ba42 ]

VF state I40E_VF_STATE_ACTIVE is not the only state in which
VF is actually active so it should not be used to determine
if a VF is allowed to obtain resources.

Use I40E_VF_STATE_RESOURCES_LOADED that is set only in
i40e_vc_get_vf_resources_msg() and cleared during reset.

Fixes: 61125b8be85d ("i40e: Fix failed opcode appearing if handling messages from VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c86c429e9a3a3..af649be234268 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1402,6 +1402,7 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * functions that may still be running at this point.
 	 */
 	clear_bit(I40E_VF_STATE_INIT, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
@@ -2068,7 +2069,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	size_t len = 0;
 	int ret;
 
-	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_INIT)) {
+	i40e_sync_vf_state(vf, I40E_VF_STATE_INIT);
+
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states) ||
+	    test_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -2164,6 +2168,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 				vf->default_lan_addr.addr);
 	}
 	set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
+	set_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 err:
 	/* send the response back to the VF */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 97e9c34d7c6cd..3b841fbaffa67 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -39,7 +39,8 @@ enum i40e_vf_states {
 	I40E_VF_STATE_MC_PROMISC,
 	I40E_VF_STATE_UC_PROMISC,
 	I40E_VF_STATE_PRE_ENABLE,
-	I40E_VF_STATE_RESETTING
+	I40E_VF_STATE_RESETTING,
+	I40E_VF_STATE_RESOURCES_LOADED,
 };
 
 /* VF capabilities */
-- 
2.51.0


