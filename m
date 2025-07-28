Return-Path: <stable+bounces-164953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC6B13C3D
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F4F7A76BF
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A2279918;
	Mon, 28 Jul 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPs7RjP9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42290279910
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710908; cv=none; b=Ad8UJRUwWE8BwEcz/RPVsj5Tzb7W0U7Z+9xbGl1E16rF2i8t5e75dUht8RsAi8WLCjNjibTV3E9ZM7c5U9b2pz3OAmISI/yhvC6CZW930E2g1r/uc4NRb6dm9XZPJZazxlY0fUkbix2YdSTiD3UTRR1LINn+kyDGbzzFIKHauXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710908; c=relaxed/simple;
	bh=Z+xqE6niw11196UAMBCd1CY+dCaUlVP7kxYSi+ZQ2gY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u+jQyavU8pMG1FgE925L7QcuIvI2IEePVwwfkT4Xn5esLcAPkr62608bQbQlL/OnlVOBKz0sSgPgvCLDkC/d3l4Iem5sOxq9gIhr6yBKDAuVs2LpP4aig/+Fnfk0JT6SKkozI9VAVjY0M4fM8bs8hEGoxsABy8imUR8WvsgFCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPs7RjP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B7EC4CEEF;
	Mon, 28 Jul 2025 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753710908;
	bh=Z+xqE6niw11196UAMBCd1CY+dCaUlVP7kxYSi+ZQ2gY=;
	h=Subject:To:Cc:From:Date:From;
	b=FPs7RjP9Hfr6jNbvOoL8wkNr4zn0pu82z1eABH7aqK1OHUVswSl1WQ3RN/ZA04x7k
	 OsNIXg8ltJ53qe9FBbXixTRNKDS/ii500X+vYfEOpZTvWQciWELgjaqzc3NXKnl+ce
	 jsN2/e+wLifLhbQsgS4xu6m2C2WDTkj5Sf8Wylf4=
Subject: FAILED: patch "[PATCH] ice: Fix a null pointer dereference in" failed to apply to 5.10-stable tree
To: haoxiang_li2024@163.com,aleksandr.loktionov@intel.com,anthony.l.nguyen@intel.com,horms@kernel.org,michal.swiatkowski@linux.intel.com,sx.rinitha@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 15:53:01 +0200
Message-ID: <2025072801-groove-marauding-e4a9@gregkh>
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
git cherry-pick -x 4ff12d82dac119b4b99b5a78b5af3bf2474c0a36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072801-groove-marauding-e4a9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


