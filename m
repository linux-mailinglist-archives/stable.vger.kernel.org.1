Return-Path: <stable+bounces-142252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A5AAE9C2
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA377BA42A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBF928AAE9;
	Wed,  7 May 2025 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQj4XXfZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E8211A2A;
	Wed,  7 May 2025 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643681; cv=none; b=RfrrBoSDYtMU1S6naMaUhwuk/8ouKtZppJKdmviaxiaOgEq/cdmY3LowAm1iDxpDb079Va0HsaTL+l1rcPX+NsLWhNYhKP1SQb2F/KlLMPnTk/a8QXsbTTp3r5PT5N8fayF92vMFepYiogjTgjKx4vkNm/PTiOA0kdfj1RYILls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643681; c=relaxed/simple;
	bh=z9ujjcpb5PFxXEZmPUuElGGpigaSIOmqZFQFda1681s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRg5G81tR+CoHxqjTRpfz00H8/CbXFGRy8SpasOOsK19gK1+M/jNJ6CTdBZnOkfn/1F3dLQbRPtm03ewt71uHLPabGFyvBClQwd5DZituKkKQwzNoThT8uVn2UPhysil52KQ90zIiN2taGJfmSD/JkyZPDnvoZzkNgYxuZldQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQj4XXfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14377C4CEE9;
	Wed,  7 May 2025 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643681;
	bh=z9ujjcpb5PFxXEZmPUuElGGpigaSIOmqZFQFda1681s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQj4XXfZgqeqfikYMVU0xV3gl8iKwovh1VT9SQkY9XKH9gVa+wUjoktvB4icI2u+G
	 +JJ6cqRSU+bTzNKTZEZv04aXLTOrX7ZhXRljWLd+pUiLkm5edDFeomGBLS9oFRfPm+
	 c3CwFvPr2e7QpJ9wMAD4c47MV82joa/tzA/AGpzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 54/97] ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()
Date: Wed,  7 May 2025 20:39:29 +0200
Message-ID: <20250507183809.171796877@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183806.987408728@linuxfoundation.org>
References: <20250507183806.987408728@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

[ Upstream commit 425c5f266b2edeee0ce16fedd8466410cdcfcfe3 ]

As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
pointer values"), we need to perform a null pointer check on the return
value of ice_get_vf_vsi() before using it.

Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20250425222636.3188441-3-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index bff3e9662a8fd..a9df95088df35 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -1811,6 +1811,11 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	pf = vf->pf;
 	dev = ice_pf_to_dev(pf);
 	vf_vsi = ice_get_vf_vsi(vf);
+	if (!vf_vsi) {
+		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err_exit;
+	}
 
 #define ICE_VF_MAX_FDIR_FILTERS	128
 	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
-- 
2.39.5




