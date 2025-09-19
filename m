Return-Path: <stable+bounces-180693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D733B8AFD7
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C616A1C8868B
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15327AC4D;
	Fri, 19 Sep 2025 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRuCZeSv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847427815D;
	Fri, 19 Sep 2025 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307810; cv=none; b=Z/0LKwqe9P/pwtTzWRZ2kbGx2LTrd/jxtnrM8osTiM+5m9N6hjrfMsgfJP1/zqgrW02izAAPz6Vx03TZCTMdFzTR2xKvZsfAnBoKKFLdJR/pNR4DQKMqE9b4aB1SWlOHE+sKehXzHXEn90xB252uMrIkvttfdTIKEeBnpndUCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307810; c=relaxed/simple;
	bh=TX7UL0cLxTWPtiVoye8gMNAcxASDP7ICcV6LfylSoCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/PfPF8bkPHZNvdz/3kiuEwNezFFjg8VekKoGSpkX634zBP/6fKDkZJI/2TVPLiMg5h7Jfxsfq83sEkcqNqXVGF5EBZZEkHZQ//iLnV0uz+miGkVMuIA3zvX/okvsdQz9ritGEc9nowRvGGoehOVLhLeMQJOjZU3hLIxoCrTcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRuCZeSv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758307808; x=1789843808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TX7UL0cLxTWPtiVoye8gMNAcxASDP7ICcV6LfylSoCM=;
  b=PRuCZeSvqwWsUdDw+qa/k76Q5Xt8TBRuhOiX86DA/UUoiGS1pOCZeJVt
   tLTyWKgIHFdTdxcqxZeabp3RTOaqTV1mbibZh9akxRNazXRW61zW8hRzN
   ftVRDpE4iA34pClcdiA1Seik3HhIYGiScPegnmpRTmbh82Zx2HpyM0giq
   n42aLepv07tWfR3ZlprIi9VwW8qxepHX6PlXohsYxp9fOpJepK8fMA4Jg
   tMNSRqKveo9+ooEgIurGgNi3nxLcqdYCkPFQPJZaB2RxBsDZ6sfNbg+vY
   xPeKtm7W3eswj4CB4vcgtBrLvbqpzXfsyd5owlwBsylQlpIkZyC09uwwr
   g==;
X-CSE-ConnectionGUID: eS1QB9pbQIudBHkK+R/i1w==
X-CSE-MsgGUID: UyXifO1EQzu7kLlFiP5ypQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60589760"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60589760"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:50:05 -0700
X-CSE-ConnectionGUID: umitClbqRhyUuoWJ9DVOlQ==
X-CSE-MsgGUID: 3KDyEJIxTcmu91SoacmQdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175458786"
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
Subject: [PATCH net 5/8] i40e: fix validation of VF state in get resources
Date: Fri, 19 Sep 2025 11:49:55 -0700
Message-ID: <20250919184959.656681-6-anthony.l.nguyen@intel.com>
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
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c85715f75435..5ef3dc43a8a0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1464,6 +1464,7 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * functions that may still be running at this point.
 	 */
 	clear_bit(I40E_VF_STATE_INIT, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
@@ -2130,7 +2131,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	size_t len = 0;
 	int ret;
 
-	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_INIT)) {
+	i40e_sync_vf_state(vf, I40E_VF_STATE_INIT);
+
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states) ||
+	    test_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states)) {
 		aq_ret = -EINVAL;
 		goto err;
 	}
@@ -2233,6 +2237,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 				vf->default_lan_addr.addr);
 	}
 	set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
+	set_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 err:
 	/* send the response back to the VF */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 5cf74f16f433..f558b45725c8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -41,7 +41,8 @@ enum i40e_vf_states {
 	I40E_VF_STATE_MC_PROMISC,
 	I40E_VF_STATE_UC_PROMISC,
 	I40E_VF_STATE_PRE_ENABLE,
-	I40E_VF_STATE_RESETTING
+	I40E_VF_STATE_RESETTING,
+	I40E_VF_STATE_RESOURCES_LOADED,
 };
 
 /* VF capabilities */
-- 
2.47.1


