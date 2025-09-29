Return-Path: <stable+bounces-181874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC82BA9003
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962823B997A
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137E52FFFBD;
	Mon, 29 Sep 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HcBbrPFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E2824BD
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145150; cv=none; b=U+WwEN0PYqF9pe1gteKm0Oe2D0r8HMIRvRMa5EBfOCgdNP84FJ5C1v+9LzMI3/tj8chS3dQHOKlfcc/thTYQD6gABsOGYzVkfQJmT62dOu8KGr9QuJrjkJR74HlEhwdT9aBPh5JF41qKtFEWMxLNNIofdt0TTXzGQ1T2ycmHY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145150; c=relaxed/simple;
	bh=0AaHp3PeXVyPHnfamZN11WWeaAwGYdZf7yU8vLKqfug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F+KTPhugqA1YvBs8k0dNMnh4H9iJqXMbJoYDCnxDsCxHIvWEMVpSNBM93rloqeFh9UodxDknAiVm4UAY3e70epODn8ectyz9zoh3aOgAm/wfVD90xljpDEvOI5yp8qT6J7XrtiqaEUutQB4MQ458X1HH/6w7GBgUFojXZ7Ubmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HcBbrPFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46ECC4CEF4;
	Mon, 29 Sep 2025 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759145150;
	bh=0AaHp3PeXVyPHnfamZN11WWeaAwGYdZf7yU8vLKqfug=;
	h=Subject:To:Cc:From:Date:From;
	b=HcBbrPFRlaYkVEOefDlymfJCzQMN9SdYbQ9E2TDtzIZQ/BSVWg/pPuKrgYOchOYND
	 tewMllC8vy4Uxd/Z6LutfNhoCS9dsOwV5HtFqggCkyvJTZ1U30vM8nx/wFdgL+/tDz
	 hYWlXc3AKYggqhPgPuP9s/FaZ/GU5JyGu8AtA/P0=
Subject: FAILED: patch "[PATCH] i40e: fix idx validation in config queues msg" failed to apply to 5.10-stable tree
To: lukasz.czapnik@intel.com,aleksandr.loktionov@intel.com,anthony.l.nguyen@intel.com,horms@kernel.org,nellorex.kamakshi@intel.com,przemyslaw.kitszel@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 13:25:37 +0200
Message-ID: <2025092937-unrushed-recharger-4598@gregkh>
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
git cherry-pick -x f1ad24c5abe1eaef69158bac1405a74b3c365115
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092937-unrushed-recharger-4598@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


