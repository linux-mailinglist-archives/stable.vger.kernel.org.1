Return-Path: <stable+bounces-135018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD4A95DE8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B18A176A53
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9404217F5C;
	Tue, 22 Apr 2025 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+3skhaE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686421148F
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302492; cv=none; b=kjSswGlFHQfEsZCPyR0Eu9GeAen2d6GOLDH/oCNbjDpAMYKyydnNuuR6U8K/QlPf9tUp5n0A7HWcgUL0drkWBPvJghcWYt07I3E6+9+nXVaKKWJo0zPPTCod1MAuH4O6zzBV+lCb3C9MuX+wQrjh42hoBgvnU02/7nzfM+LgaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302492; c=relaxed/simple;
	bh=EnBrPBx0QyL+VyQPtYu5AlFIDMO02CZhH+8OiP2qnjw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N9dNigmWBIR54urtv7EujFV2WL8Fb59Bw1J4Ad3cc9fHqVUfk2dyzfVf7cuJAcwynlgbPi747Sh45C5IXETvSr18sLXcyJHDqc4gepqjjFwGFG6MiDUtYWPMtnimuApgLn1Q7vH5nnWGE53FDf8uwHLymRSpdJrscyKOWVHMHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+3skhaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806EAC4CEED;
	Tue, 22 Apr 2025 06:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745302491;
	bh=EnBrPBx0QyL+VyQPtYu5AlFIDMO02CZhH+8OiP2qnjw=;
	h=Subject:To:Cc:From:Date:From;
	b=g+3skhaEk6JAt0UzniyPLejR/qfJBUxyiQ1xMvxvCeLSm6uoCJAK6RIrzXhbh0waJ
	 J9D5Tg1i3/+bpDOpITJmg5+qOVNdsuWHegHyRBOKDXrPsoKttdeNOZdi2Sps1droCP
	 u3zOxSPxpmlL6z7sl8i3lQDLkXAaos1ZAW8bXSRg=
Subject: FAILED: patch "[PATCH] drm/amd/pm: Prevent division by zero" failed to apply to 5.4-stable tree
To: arefev@swemel.ru,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:14:49 +0200
Message-ID: <2025042249-versus-think-8c6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 4e3d9508c056d7e0a56b58d5c81253e2a0d22b6c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042249-versus-think-8c6c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e3d9508c056d7e0a56b58d5c81253e2a0d22b6c Mon Sep 17 00:00:00 2001
From: Denis Arefev <arefev@swemel.ru>
Date: Fri, 21 Mar 2025 13:52:33 +0300
Subject: [PATCH] drm/amd/pm: Prevent division by zero

The user can set any speed value.
If speed is greater than UINT_MAX/8, division by zero is possible.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 031db09017da ("drm/amd/powerplay/vega20: enable fan RPM and pwm settings V2")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index a3331ffb2daf..1b1c88590156 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -191,7 +191,7 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	uint32_t tach_period, crystal_clock_freq;
 	int result = 0;
 
-	if (!speed)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl)) {


