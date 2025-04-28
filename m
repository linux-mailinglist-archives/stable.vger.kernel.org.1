Return-Path: <stable+bounces-136866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED881A9EFD3
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6D0189E36A
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801C226738A;
	Mon, 28 Apr 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BPdpMj9e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC525DB1A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841410; cv=none; b=h1FUB8GMutk0o26PeSIoX1fEpUjDSkEJ3cwWL3BagvBkVhtlm4Qw7jUJK50PibX2t1Ty+a4j4QUHuHzZ424r5JDH0w7G+1UvxHgAP4JpAgqyAzi8MXoRSS2Rh9dsqkf6aqfA5WASkOnKBSLSg9DFNaL+0mplcs39Bpdw+ZbZC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841410; c=relaxed/simple;
	bh=zwEM16rN3/eFKaK4zicI5KIn9HNAQ8792FJw151rK8U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fMjTmjkmUvvsnWdsOnSby1Qomqrxix36DcnhJ0ZUZ4/gY3inR7zxlRzBxgZf4XvUPR2HA2qPREv2YlBzdLDcrgpjWD3aEqZTNBG3Jl6R/OToeY6yYriN3/tHp68WkxeYUkCyRdOw0to9Oio+xTRdJ1efZy6lZRBrysPe5aN9dqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BPdpMj9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD28C4CEE4;
	Mon, 28 Apr 2025 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841409;
	bh=zwEM16rN3/eFKaK4zicI5KIn9HNAQ8792FJw151rK8U=;
	h=Subject:To:Cc:From:Date:From;
	b=BPdpMj9eIjQnei40hY3s/+lKNlVFokNEs7FycL4jZmcVu8X7oygsFZ892LP7KRyxG
	 +EZPjqp98cAD7lCEZMnp3J7Ipy8MNYcee2zfwNCTYYdY8ViqSq1i9ZDw3jUFtB440C
	 H4R8UTD8m9/bUvXKLp47K/qIhR0UfkKLCoFsO/18=
Subject: FAILED: patch "[PATCH] drm/amd/display: Default IPS to RCG_IN_ACTIVE_IPS2_IN_OFF" failed to apply to 6.12-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,mark.broadworth@amd.com,zaeem.mohamed@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:56:38 +0200
Message-ID: <2025042838-flinch-defeat-6a51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6ed0dc3fd39558f48119daf8f99f835deb7d68da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042838-flinch-defeat-6a51@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


