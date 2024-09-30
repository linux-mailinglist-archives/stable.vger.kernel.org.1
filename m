Return-Path: <stable+bounces-78304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56098AFF4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 00:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCB7283829
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CEB194C92;
	Mon, 30 Sep 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2R+eLd4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86218951C;
	Mon, 30 Sep 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735770; cv=none; b=F7IEGgiU50mxEZ9S8EvVx4GOp+VUnLJnFNb5FV/QFqDBH+XN2YXIarwE+3T/meoZHZE1WzrM7CZAmzdDcPhIEkUEoRv20q/rxTWCxZ+cj1kfmMfoK0vZUVoZ46uI1PlgCiGik+aneQIJtfRNSqrKobrZH0Bv/HhZoL7+ewufkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735770; c=relaxed/simple;
	bh=BqBjza3dVs7RuLhK/O/xvl0SxSraob6n8ODHpbQfFmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h64sg2jAXvEJsy8CdlOddk3wRfSHSz0wpIvgdMT8dSci+RQsJ9nrXd4X+SIm07UaPkpDzDtllGF+u3mj+bcX1toECNr6DnEhSG/U4+CT3NwIBLkDWPKODEhgKOU9U3I8MRNo/fLUvAkAclNu6pv9YNtL5+kWA0UJM1QCCKyVAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2R+eLd4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735769; x=1759271769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqBjza3dVs7RuLhK/O/xvl0SxSraob6n8ODHpbQfFmE=;
  b=Z2R+eLd4KUVhB+GVCVuZtGvJy1eUSFkMM/E7dtxg2jT/+baPgYfhaBay
   zcaLlB/mLJwpF+D3qmb2rd8ZJRlu8utG7j6RV8Uu+MRJ1X2nX11WO63GG
   NNfh6LZeFySbc5dJUeIa9laaSJtwaV7OCSRwe9PBTyr/DN80OxIKcSNN3
   9JA4nufp/9eEUu3K36BvlqU0d0Vb+zoAYSNwu1J68NWYZg+HUliAeaHM+
   JOHJ25kV4tuecKEQ7schmdEBifkIYaSk1zcp77lu+uhvIewVe59xAn7XG
   48QRC+3SH+6SpQDJBzZztVG5CY/TD5gjBnF+cerPM5UTyvknOPZNum87M
   Q==;
X-CSE-ConnectionGUID: RoRvZsR4TLi+QIgl82U6lQ==
X-CSE-MsgGUID: Wv87B7eRThyCk1UFETTGdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734865"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734865"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:06 -0700
X-CSE-ConnectionGUID: tlEcuuCHQoueWZf29Mwz5Q==
X-CSE-MsgGUID: c58JJvNIRDuBtZ0mAIXOTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496614"
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
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 03/10] ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_count()
Date: Mon, 30 Sep 2024 15:35:50 -0700
Message-ID: <20240930223601.3137464-4-anthony.l.nguyen@intel.com>
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

This patch addresses an issue with improper reference count handling in the
ice_sriov_set_msix_vec_count() function.

First, the function calls ice_get_vf_by_id(), which increments the
reference count of the vf pointer. If the subsequent call to
ice_get_vf_vsi() fails, the function currently returns an error without
decrementing the reference count of the vf pointer, leading to a reference
count leak. The correct behavior, as implemented in this patch, is to
decrement the reference count using ice_put_vf(vf) before returning an
error when vsi is NULL.

Second, the function calls ice_sriov_get_irqs(), which sets
vf->first_vector_idx. If this call returns a negative value, indicating an
error, the function returns an error without decrementing the reference
count of the vf pointer, resulting in another reference count leak. The
patch addresses this by adding a call to ice_put_vf(vf) before returning
an error when vf->first_vector_idx < 0.

This bug was identified by an experimental static analysis tool developed
by our team. The tool specializes in analyzing reference count operations
and identifying potential mismanagement of reference counts. In this case,
the tool flagged the missing decrement operation as a potential issue,
leading to this patch.

Fixes: 4035c72dc1ba ("ice: reconfig host after changing MSI-X on VF")
Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e34fe2516ccc..c2d6b2a144e9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1096,8 +1096,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 		return -ENOENT;
 
 	vsi = ice_get_vf_vsi(vf);
-	if (!vsi)
+	if (!vsi) {
+		ice_put_vf(vf);
 		return -ENOENT;
+	}
 
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
@@ -1142,8 +1144,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	vf->num_msix = prev_msix;
 	vf->num_vf_qs = prev_queues;
 	vf->first_vector_idx = ice_sriov_get_irqs(pf, vf->num_msix);
-	if (vf->first_vector_idx < 0)
+	if (vf->first_vector_idx < 0) {
+		ice_put_vf(vf);
 		return -EINVAL;
+	}
 
 	if (needs_rebuild) {
 		ice_vf_reconfig_vsi(vf);
-- 
2.42.0


