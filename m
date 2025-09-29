Return-Path: <stable+bounces-181878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BA2BA9015
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07517B2864
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D53002A1;
	Mon, 29 Sep 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kZlNXzsw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322E824BD
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145185; cv=none; b=ePwgcVRQPXBS+aDhf3mU/E19F9gSpow9pU0AlFAt7g9GSPq+s2GBnmdaJZdpokXIg7fzTkQSJ7TtitROD95oIVINjvkPPijq/IZVkbF9OpS9U6GbH0HaZrJSwdoOQjca7bS+1euoK1RiHGAUpYcFHdNpDwmamSOt7LRmwNrypPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145185; c=relaxed/simple;
	bh=5wX1jikIvC1wKMVC9pvVIxQcNDSm/NQPOCDXnSw6Xd8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y56+Kk7Bn/S/1yQSWU9cGnJbxjml2EOtLAs/mbQV9uaoxBozjnc363bRW4X4fANs4TiRisG9iuJR8OEpBKwaBrf9qU/q27U47fxl7FB1KWeM1ZiF3c0AYcA9R3B0SzbiasmQ8wiTBEKUOYqX65kSwqXcymt+gnMXHNZLZABeXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kZlNXzsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2ECC4CEF4;
	Mon, 29 Sep 2025 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759145185;
	bh=5wX1jikIvC1wKMVC9pvVIxQcNDSm/NQPOCDXnSw6Xd8=;
	h=Subject:To:Cc:From:Date:From;
	b=kZlNXzsw/mmBuPMi6hVEUhCMwoITlA7WZBVL1dsaIxTBDoFupeXukTbNZmdw/y/4I
	 +WTqjMWtuJFvFygCR/XomTWOe4tNBmfs2WQ9BvY3fjRDW6bHpjvZAYCOsrRmJkMp/L
	 Ql2ArdpfabrV14v4gUtjfpJj0LUImQN3BU8TkMgM=
Subject: FAILED: patch "[PATCH] i40e: fix validation of VF state in get resources" failed to apply to 5.10-stable tree
To: lukasz.czapnik@intel.com,aleksandr.loktionov@intel.com,anthony.l.nguyen@intel.com,horms@kernel.org,przemyslaw.kitszel@intel.com,rafal.romanowski@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 13:26:12 +0200
Message-ID: <2025092912-bullfight-urgency-ae9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 877b7e6ffc23766448236e8732254534c518ba42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092912-bullfight-urgency-ae9f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 877b7e6ffc23766448236e8732254534c518ba42 Mon Sep 17 00:00:00 2001
From: Lukasz Czapnik <lukasz.czapnik@intel.com>
Date: Wed, 13 Aug 2025 12:45:15 +0200
Subject: [PATCH] i40e: fix validation of VF state in get resources

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


