Return-Path: <stable+bounces-181873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAE8BA9000
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAB91C066A
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86C2E8DF0;
	Mon, 29 Sep 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dj3/Desu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC92824BD
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145147; cv=none; b=dUnL6S0Y7Mufv4mazM6+pCfby+x9bG6zuyhDwmGWkXRmsHrPIhyu/CjmiPQNJWhfEtPmR/oyKd7mC3c+DHPO8bRyqeILzK3Nyzb8TaSYgNY8oI/AINYzjVZRZOJ5SZ11SDSKdT40AG/wBj4FnBHy9mQ3ekjfB59+ttVB9W3XPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145147; c=relaxed/simple;
	bh=+kdNhr617WXChjI3J5G5YNZvwgSOUW8s2p9F895YgqE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i8O3E0Zn+CA/2yJidB++6uoQRwkMkGWQ/ocKcqY1/UYyRHUDFsh39JPBN6WJknVg4rNDWscR3hH1kP5D12uW1J8sJrlfjiwgej8si8UW1QKkYPxrg1HIBzLLRFv4SD/9JflfgPuWBl8jJSLhHErTChcpGmghEbxfCdRLHa0q5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dj3/Desu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A46C4CEF4;
	Mon, 29 Sep 2025 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759145147;
	bh=+kdNhr617WXChjI3J5G5YNZvwgSOUW8s2p9F895YgqE=;
	h=Subject:To:Cc:From:Date:From;
	b=Dj3/DesuqrSc32dwodTZ4bFZ7o161tCmfXhQaqx8f2bq82HJSvtiwujN2orXCjng7
	 cDLvi0G78kHcFqCrftLubVYkB1C4mOCmV/vL9j9CLoutmk1IgzCHuf88OL9bIK9wvo
	 c9ZtuvV5ECzyWmW2ILrzUKlUm3btuO3Ep0dtpgvc=
Subject: FAILED: patch "[PATCH] i40e: fix idx validation in config queues msg" failed to apply to 5.15-stable tree
To: lukasz.czapnik@intel.com,aleksandr.loktionov@intel.com,anthony.l.nguyen@intel.com,horms@kernel.org,nellorex.kamakshi@intel.com,przemyslaw.kitszel@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 13:25:36 +0200
Message-ID: <2025092936-outflank-unwoven-3758@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f1ad24c5abe1eaef69158bac1405a74b3c365115
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092936-outflank-unwoven-3758@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1ad24c5abe1eaef69158bac1405a74b3c365115 Mon Sep 17 00:00:00 2001
From: Lukasz Czapnik <lukasz.czapnik@intel.com>
Date: Wed, 13 Aug 2025 12:45:13 +0200
Subject: [PATCH] i40e: fix idx validation in config queues msg

Ensure idx is within range of active/initialized TCs when iterating over
vf->ch[idx] in i40e_vc_config_queues_msg().

Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Kamakshi Nellore <nellorex.kamakshi@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1c4f86221255..b6db4d78c02d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2395,7 +2395,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}
@@ -2416,7 +2416,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}


