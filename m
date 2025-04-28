Return-Path: <stable+bounces-136865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D820A9EFCE
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182193BAD82
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866D224244;
	Mon, 28 Apr 2025 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aVOejCus"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1D1CD213
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841401; cv=none; b=FeNPee5UY7Hg2ZUZtKBYur8Xj44D0S6zCamgq7w+u/OA04FVvQu1cNrl7XjF5F5U7Lx698pcegTiwYCwEkbQLjiBRjkUY/zSTfj91QrnOiA19xzB6TX7ogi11LQrudjk0Zw5os8sbNYGdcAwxmdtiCJkcyi4f20/p7nJt0VwAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841401; c=relaxed/simple;
	bh=g76ZkZewqkXc7jhSz14Cfb0IBipRvP6tocXSMA4ADbw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GDW8kQlF7iHNi1xlgPCwvKoehFtNx2koudwCyE4p11xruWJ7aYns1+rYbEMRi39+nmWZY1mtF5IzyXOkN4qw2Ar0QW444Tk+bv2HAYVYrwgdB6AJ5Sbj7+sX22MA3EfZxx7UvvkujJQTkGws4i7OO+8kBhctLkU8Zc4jjy8clB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aVOejCus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B34C4CEE4;
	Mon, 28 Apr 2025 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841400;
	bh=g76ZkZewqkXc7jhSz14Cfb0IBipRvP6tocXSMA4ADbw=;
	h=Subject:To:Cc:From:Date:From;
	b=aVOejCusWlQQxc3ayTRK8mNGogShmJP5/yXVczlYgp1uUHY1io9LefCqqvWmPRY9p
	 a+TfrpFtlc+Iw52zbOCcM1b5OdUDGrMHK3UnTapSu67aIO5zAGrcnh1qiKuswmk2Aa
	 i2iE0U9HGCkCG6U913GHMES5FaubS1mqVYhyQQL8=
Subject: FAILED: patch "[PATCH] drm/amd/display: Default IPS to RCG_IN_ACTIVE_IPS2_IN_OFF" failed to apply to 6.14-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,mark.broadworth@amd.com,zaeem.mohamed@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:56:37 +0200
Message-ID: <2025042837-embellish-dragging-2996@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 6ed0dc3fd39558f48119daf8f99f835deb7d68da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042837-embellish-dragging-2996@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ed0dc3fd39558f48119daf8f99f835deb7d68da Mon Sep 17 00:00:00 2001
From: Leo Li <sunpeng.li@amd.com>
Date: Tue, 18 Mar 2025 18:05:05 -0400
Subject: [PATCH] drm/amd/display: Default IPS to RCG_IN_ACTIVE_IPS2_IN_OFF

[Why]

Recent findings show negligible power savings between IPS2 and RCG
during static desktop. In fact, DCN related clocks are higher
when IPS2 is enabled vs RCG.

RCG_IN_ACTIVE is also the default policy for another OS supported by
DC, and it has faster entry/exit.

[How]

Remove previous logic that checked for IPS2 support, and just default
to `DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF`.

Fixes: 199888aa25b3 ("drm/amd/display: Update IPS default mode for DCN35/DCN351")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8f772d79ef39b463ead00ef6f009bebada3a9d49)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 61ee530d78ea..5fe0b4921568 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1920,26 +1920,6 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(3, 5, 0):
 	case IP_VERSION(3, 6, 0):
-		/*
-		 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
-		 * cause a hard hang. A fix exists for newer PMFW.
-		 *
-		 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
-		 * IPS state in all cases, except for s0ix and all displays off (DPMS),
-		 * where IPS2 is allowed.
-		 *
-		 * When checking pmfw version, use the major and minor only.
-		 */
-		if ((adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
-			ret = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		else if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(11, 5, 0))
-			/*
-			 * Other ASICs with DCN35 that have residency issues with
-			 * IPS2 in idle.
-			 * We want them to use IPS2 only in display off cases.
-			 */
-			ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		break;
 	case IP_VERSION(3, 5, 1):
 		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;


