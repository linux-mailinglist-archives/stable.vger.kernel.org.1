Return-Path: <stable+bounces-164956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACFB13C67
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8088E3AFE55
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4DB27A46E;
	Mon, 28 Jul 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nVlhxBpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A099270EB3
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710918; cv=none; b=Pk0lEKhj4VMhMVwwjQ0ARcJfD3AhoaSDqZFsMVlqeGoh9ArZLkEgmeIkc7C/HxhOQzVVYlBCuyOi/hKoVBOLzVJ+Uj51J+dUsweOw5YuWD7/ssTI3fNugRm51CKUskBnRSZwIS2zNCnVepFkJNZTrKijpKmPzkHG1JNbXT0yu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710918; c=relaxed/simple;
	bh=v8c88xRDRAbUN3GiI8IiimEam5miHYBZdGtxIKPDN40=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CWmaqeww6N4/cHTJVHHDpchLpJxsDKRD0CV6+zMUeJR/PloiWGo/GOZ61ocfWEJfPKtZf9yJWxXoEHqB3y5AS/4o5/ZZRgRAlxoXI1Kn21kiLhArhhHjM9iOHPAiLEJsH3t6FxgyN0qvImSeRybcu9/G4o9gSfLoeDMDt4uI2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nVlhxBpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B683C4CEF7;
	Mon, 28 Jul 2025 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753710918;
	bh=v8c88xRDRAbUN3GiI8IiimEam5miHYBZdGtxIKPDN40=;
	h=Subject:To:Cc:From:Date:From;
	b=nVlhxBpA8h+qOPi6XsGBhmGw5IFgkSFuO1+gNISc3maYESAPBMlsB2CWep/m6fHts
	 PLtEZZVzH2+5IqJ9mSLdrMyZJILMh0hyooufGRymg6FI9aPdwwta5ufKDGf6MWI9Qf
	 MZnC1GvV49NQZnLeBsoGXsyPErvRxWXMSzrE0XKM=
Subject: FAILED: patch "[PATCH] ice: Fix a null pointer dereference in" failed to apply to 5.15-stable tree
To: haoxiang_li2024@163.com,aleksandr.loktionov@intel.com,anthony.l.nguyen@intel.com,horms@kernel.org,michal.swiatkowski@linux.intel.com,sx.rinitha@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 15:53:58 +0200
Message-ID: <2025072858-pentagon-gumball-b400@gregkh>
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
git cherry-pick -x 4ff12d82dac119b4b99b5a78b5af3bf2474c0a36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072858-pentagon-gumball-b400@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ff12d82dac119b4b99b5a78b5af3bf2474c0a36 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Thu, 3 Jul 2025 17:52:32 +0800
Subject: [PATCH] ice: Fix a null pointer dereference in
 ice_copy_and_init_pkg()

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


