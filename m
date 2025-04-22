Return-Path: <stable+bounces-135032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A990A95E35
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AC31887631
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE70E217F5C;
	Tue, 22 Apr 2025 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwHR2Lsf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9AF50F
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303535; cv=none; b=SOe8m9zi1Mi1rnSa2mBQ73lrKaweg1hiTh1WuWfAWqNCt5fqhdbENVVLfTCJdusHHcS7opZx4hfVbiq9J0drflRRJnoT96QNk/DAevucwdD8o0j9097k3FO7SvCLqORrkNu0VATST+QdZL7EiZmcv5AMeD1F+EBG0HKvksGrDmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303535; c=relaxed/simple;
	bh=P0L7fyBqdauCxKT2UhkuG7uROVSQvKHxiWSk31czWug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ckcRUjplPLpsI9diT9ooILmDcLDp2QMjRTFAtYKVHndj7shtHWU7tzBtw+gBpWw2RUABUV7dYCj9jXXQLZXTYej3Xt3kSWXyE91Jd5IJsA3dnVF0PTY7zVR2QwBn+b52j51005Pn9QSaQdB3GNa9rBPTDB+McPiVrolG+cx7iUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwHR2Lsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEDBC4CEED;
	Tue, 22 Apr 2025 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303535;
	bh=P0L7fyBqdauCxKT2UhkuG7uROVSQvKHxiWSk31czWug=;
	h=Subject:To:Cc:From:Date:From;
	b=LwHR2LsfWUEgPaevV3IPr79QoXNlFN1hZrmSQKyD6sTGD0nlWIUCl21M7VXonWDzW
	 MuC6jRfJmExWJpo/8tReYcBfUeWQbw9I03wRByOIEIVaBv504StqMkk89nStEfXKRS
	 p5veFbLQFVn0RynFRjGbiSXUgUGSOx5mDKHL4KXU=
Subject: FAILED: patch "[PATCH] drm/amdgpu/mes11: optimize MES pipe FW version fetching" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:32:13 +0200
Message-ID: <2025042213-attendee-apricot-f988@gregkh>
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
git cherry-pick -x b71a2bb0ce07f40f92f59ed7f283068e41b10075
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042213-attendee-apricot-f988@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b71a2bb0ce07f40f92f59ed7f283068e41b10075 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Thu, 27 Mar 2025 17:33:49 -0400
Subject: [PATCH] drm/amdgpu/mes11: optimize MES pipe FW version fetching

Don't fetch it again if we already have it.  It seems the
registers don't reliably have the value at resume in some
cases.

Fixes: 028c3fb37e70 ("drm/amdgpu/mes11: initiate mes v11 support")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4083
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e65916ada23b..ef9538fbbf53 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -894,6 +894,10 @@ static void mes_v11_0_get_fw_version(struct amdgpu_device *adev)
 {
 	int pipe;
 
+	/* return early if we have already fetched these */
+	if (adev->mes.sched_version && adev->mes.kiq_version)
+		return;
+
 	/* get MES scheduler/KIQ versions */
 	mutex_lock(&adev->srbm_mutex);
 


