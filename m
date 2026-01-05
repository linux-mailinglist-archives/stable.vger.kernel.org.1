Return-Path: <stable+bounces-204799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66DCF3EDB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E68A3003F97
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F295833A709;
	Mon,  5 Jan 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N5sRsAmV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC11DE89A
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620295; cv=none; b=bP86/t5vaIgAZdi7QcetypVpdfBAJymLQDd66yYKZjR20FLooM/+hqEAyH+EV9+4IQLGBnIaLOgt8UvRYqC9Gjk9xMlUqPc5zoGfc5d65f8kXNzn3JaFCY42cqbccNN9LTZxOrn5/E4R5nsgHLKAU8+gWnvHfcxbG/EGJnEctEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620295; c=relaxed/simple;
	bh=BxRnVoepYo961Wnmb3LCCTWN4Z7mpoIUAwWPfPX5Pmc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i+9trv+hxOdeTGZibm+g86HGa5aZeoV/X+t5hLxuJn8gnri6FMPw5KIe9o5g4Yb901VhE3+KnRyZNHwwFIVZYtFY/4v82hRIZq7mRej564ptaQlku9ne8IH5pGmeE06dHnGruG3pWO5nxVRI5V9HDbeQJoY8dcip1BbADOG7xvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N5sRsAmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3172EC116D0;
	Mon,  5 Jan 2026 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767620295;
	bh=BxRnVoepYo961Wnmb3LCCTWN4Z7mpoIUAwWPfPX5Pmc=;
	h=Subject:To:Cc:From:Date:From;
	b=N5sRsAmVSV7rVFfba8anKQLR/C+ghg3pW2mm9zJm3sEESAxxkwPuXuWcbfCx43lKW
	 gZo8vvnSu4RFkC4/xvLiosIWTynzntI9gQomM0dgMNf2gcxHbd6/GT37fFyDkndBJJ
	 oip7IoqU3nR5S7YnlWoHiff9pp8JhUI1JMCQ9+d8=
Subject: FAILED: patch "[PATCH] drm/amd: Fix unbind/rebind for VCN 4.0.5" failed to apply to 6.12-stable tree
To: superm1@kernel.org,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:38:12 +0100
Message-ID: <2026010512-maturely-filling-6860@gregkh>
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
git cherry-pick -x 93a01629c8bfd30906c76921ec986802d76920c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010512-maturely-filling-6860@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 93a01629c8bfd30906c76921ec986802d76920c6 Mon Sep 17 00:00:00 2001
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 8 Dec 2025 22:46:46 -0600
Subject: [PATCH] drm/amd: Fix unbind/rebind for VCN 4.0.5

Unbinding amdgpu has no problems, but binding it again leads to an
error of sysfs file already existing.  This is because it wasn't
actually cleaned up on unbind.  Add the missing cleanup step.

Fixes: 547aad32edac ("drm/amdgpu: add VCN4 ip block support")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d717e62e9b6ccff0e3cec78a58dfbd00858448b3)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b107ee80e472..1f6a22983c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -265,6 +265,8 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)


