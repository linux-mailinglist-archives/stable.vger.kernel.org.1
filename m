Return-Path: <stable+bounces-181932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728DBA9AB2
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05AC16F8C5
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E6C2ECD19;
	Mon, 29 Sep 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA0svfTz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11928B400
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157157; cv=none; b=dljmACjQ82rLYW3vpD/O//rIxwSMtRr9t0eVgRYZ46j/uTmZSs1q6UgSY+IyBUde2g7UGMGQ0oKEiuWCzRG8OKcUd54TW3ToeCSuCguD84wff95ZJg+ZT6Jaei3HqSntDrMEJTEn4iRolOWSeZUbK0zfstAwBSVh4USfsg4i4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157157; c=relaxed/simple;
	bh=EeLvTq228AmWRG00i0V+a8J/xvi3j181bAEPPCqBkvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQKqJjiKKECmQ8THUVHopbs6hRGjqxqRG760tpT+HR5UofK+aI5Zk/zZi0Gfuo1EFeGxvYz+EJLcLTPECQnFy6nAchmaVXv4JBnJ0UHI0uzKRFNoC961Vbnaf2xf1nBeBf28tVIsviLot04KoBPcXNMA+MgzVSd9uuSSI/PgrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA0svfTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6097C4CEF4;
	Mon, 29 Sep 2025 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157156;
	bh=EeLvTq228AmWRG00i0V+a8J/xvi3j181bAEPPCqBkvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UA0svfTziAI2pJ//+uzdC8JyNkSmzYHJnYlKVb2OTs4bRHeCcJqd+iUHT23BqmEaC
	 oZSDouzmNgtNJvIXk7g8hIVfJ7ZbJjrYOrs4sn7LSPlzrLI9oQ6nLr5LsihLGTsRo2
	 JOJCsPODn5VXhf83khru1gQIIH0Z8xInsv+3TQPnU9sru1yOxUCb+bFDiIzI52Gv5o
	 qr9H0Crzv4/OAahjDRphg3103rvb+1lnaKs15zqQ3A8/74J57RgcWgH5LzQ/DpxUXw
	 XNBASpyJHuKU83EPpuDZ/ZD9rkrk6Z+a3Cf5a4U1E7u705XzpGt3jdRmemP55D5gaG
	 hvMIYnCGQNxjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] i40e: fix validation of VF state in get resources
Date: Mon, 29 Sep 2025 10:45:51 -0400
Message-ID: <20250929144551.106680-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092910-busboy-umbrella-d6c5@gregkh>
References: <2025092910-busboy-umbrella-d6c5@gregkh>
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
index 7cfcb16c30911..e2c83b317c156 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1455,6 +1455,7 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * functions that may still be running at this point.
 	 */
 	clear_bit(I40E_VF_STATE_INIT, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
@@ -2121,7 +2122,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
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
@@ -2224,6 +2228,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
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


