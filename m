Return-Path: <stable+bounces-16172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E94283F187
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF82B21F1C
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4E200BD;
	Sat, 27 Jan 2024 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mpJ6MnlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A51B809
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397008; cv=none; b=NKI9WwjjA4tIoAqx7fiT0Y6a4VonII6NReicj/kBYbGv9fJTQFDFEzcnV7ppJ0MlYHeCmsMLR3uJL8DvPkQmHLVljiyb/vBD/9jzCHNiO5lnHXNGWL7Sf0C1HYoIiGzCwPtgXnWseWWqClSTymHWn3GvbYWZO+3cD8pIlXzpQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397008; c=relaxed/simple;
	bh=tGd35B2C+4pJ379aZkXlilq8Y7lGQLGIE28QHi2yLww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VyLt8gmeeZv+OaAZwU6/SPOSzq6MC6eJOy8izn41s/Dq1xw78Kf2Cqw2DatFsLCpRzwyINOyfoYCyKkqJY/5bVj1GWNjMvqEPgTACr2eoTbOGP2a54WSmeYi9oWYKBVhx3sh6UdgPq+IfAyvNVN/bnLZR9LnyphUvdWHDhz2YW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mpJ6MnlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C0FC433C7;
	Sat, 27 Jan 2024 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397007;
	bh=tGd35B2C+4pJ379aZkXlilq8Y7lGQLGIE28QHi2yLww=;
	h=Subject:To:Cc:From:Date:From;
	b=mpJ6MnlWarD7J5xxg7TO/Fc6fTOr0/8xS6qUEzpvVICQHs7n0RjVd9Af3npaAUms5
	 U0BGaAX4z/vD9vJb9R0KrIe6K0Q8Mc6Xi9EmxVtcVL1Z25yXKRvMUL/TxUr6KqzpHk
	 Q/5SWrcU3pJdFWS4463CbPIeK4TsIrSAozaVBPYE=
Subject: FAILED: patch "[PATCH] drm/amd/display: pbn_div need be updated for hotplug event" failed to apply to 6.1-stable tree
To: wayne.lin@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,jerry.zuo@amd.com,rodrigo.siqueira@amd.com,wade.wang@hp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:10:06 -0800
Message-ID: <2024012706-clad-unscrew-8cf8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x efae5a9eb47b76d5f84c0a0ca2ec95c9ce8a393c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012706-clad-unscrew-8cf8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

efae5a9eb47b ("drm/amd/display: pbn_div need be updated for hotplug event")
191dc43935d1 ("drm/dp_mst: Store the MST PBN divider value in fixed point format")
4e0837a8d00a ("drm/i915/dp_mst: Account for FEC and DSC overhead during BW allocation")
7ff2090c7c98 ("drm/i915/dp: Pass actual BW overhead to m_n calculation")
d91680efcaab ("drm/i915/dp_mst: Enable FEC early once it's known DSC is needed")
7707dd602259 ("drm/dp_mst: Fix fractional DSC bpp handling")
987c945ab2ee ("drm/i915/dp: Use connector DSC DPCD in intel_dp_supports_fec()")
07f9cfe2ef6c ("drm/i915/dp_mst: Make sure pbn_div is up-to-date after sink reconnect")
7824a88b4286 ("Merge drm/drm-next into drm-intel-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From efae5a9eb47b76d5f84c0a0ca2ec95c9ce8a393c Mon Sep 17 00:00:00 2001
From: Wayne Lin <wayne.lin@amd.com>
Date: Mon, 4 Dec 2023 10:09:33 +0800
Subject: [PATCH] drm/amd/display: pbn_div need be updated for hotplug event

link_rate sometime will be changed when DP MST connector hotplug, so
pbn_div also need be updated; otherwise, it will mismatch with
link_rate, causes no output in external monitor.

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Wade Wang <wade.wang@hp.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ddde330860fc..a144024df97c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7005,8 +7005,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	if (IS_ERR(mst_state))
 		return PTR_ERR(mst_state);
 
-	if (!mst_state->pbn_div.full)
-		mst_state->pbn_div.full = dfixed_const(dm_mst_get_pbn_divider(aconnector->mst_root->dc_link));
+	mst_state->pbn_div.full = dfixed_const(dm_mst_get_pbn_divider(aconnector->mst_root->dc_link));
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;


