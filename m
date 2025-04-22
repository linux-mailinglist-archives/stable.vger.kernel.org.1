Return-Path: <stable+bounces-135033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C338A95E3D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF711899583
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB42192F5;
	Tue, 22 Apr 2025 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClvgHKyZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2E135A63
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303589; cv=none; b=oiIvO9QJKGqe/DlbzWKBFeFTGtNF4civ1IQXkUwUATUR6t8HHwfASdBx+X8mrjKNi6Y2ZNMunKKj1Gz9awZN06lloXI0x8Is66MhWXmeA+UMThCXGeRVYCixJUqhLnsi4U3NHMBVpAr/vdTjcrWtGS1Rvh+yJQTfyfeU3ir+kV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303589; c=relaxed/simple;
	bh=wVfatGkMXJJ3IDQQ/NBszhOmicQTxyG2SaA4Jbz4rL4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uT40hAflyXrrPK722t5XIRuH5DdfSy8IHsOEHWR56Nyv6VF7e3dM4JbDxR9B9CFplW8l6lMzQl2AA7YGmkuPwq7OUMBCd9CGZUmaPEuwVevklw6BdtUta0V1AqxKXXh9mIL50qEbj0MV/CnZgda1jNYHZ5CD3g9epsrjMywplc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClvgHKyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26887C4CEEF;
	Tue, 22 Apr 2025 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303588;
	bh=wVfatGkMXJJ3IDQQ/NBszhOmicQTxyG2SaA4Jbz4rL4=;
	h=Subject:To:Cc:From:Date:From;
	b=ClvgHKyZwCaX0xbx2ALm0rrTIPuDyxzhI7i39jBBBJ/PxDjz4xeKEDQQzYXfyLUX0
	 G2cy0JE5Fiwj+TrYc/kq2wDaeg13/rtkZB5wXOby6fPbiofafhYKHnmLm0G9Llfrm2
	 x1fOcXp9QORviXZSd2Olxtzh9a9Q1R/p2q0BwUQI=
Subject: FAILED: patch "[PATCH] drm/amdgpu/mes11: optimize MES pipe FW version fetching" failed to apply to 6.6-stable tree
To: alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:33:06 +0200
Message-ID: <2025042206-florist-motocross-71b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b71a2bb0ce07f40f92f59ed7f283068e41b10075
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042206-florist-motocross-71b8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


