Return-Path: <stable+bounces-65542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6494A960
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226C1289B91
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453C1EB29;
	Wed,  7 Aug 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bg84iqwb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0B1DDEB
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039550; cv=none; b=slWQJMCz4hmhzCSz0a1m8mECQEoMFZ9Qw0r5GFr5p9jlreuIawIMY3jVEM5jpntZbMDggWT9Ixnr5hLw4s2BRIr3s5AoINaFtN3cf0IIQUJPSiaLEDkJhVK9gtOfemTBnFshOVhTEeefxNhIA27Njm9NeTIbyxZtHHeI8PuO+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039550; c=relaxed/simple;
	bh=2e72dADE4Zc8zlL7zrgb3UMxkUQ6itNch26enxSBIPE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TPm8OCAtwhsBo+lWp8oYeyJyJJWwoOydC5mCxtcYkI2zxwdeZ0Ue5xHwoXtKoDtV6T/KsgJSe21vox2sso4xSITvse13eG7PvHQ2QmDdyLBk6pGal2i2arPhp/QSGQJ+adUXvYi6/+cHwyKikGRaEz/kJPOktNeDZgNgwb6vpQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bg84iqwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4F6C32781;
	Wed,  7 Aug 2024 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039549;
	bh=2e72dADE4Zc8zlL7zrgb3UMxkUQ6itNch26enxSBIPE=;
	h=Subject:To:Cc:From:Date:From;
	b=bg84iqwb+r4O7Bb9lNXJ7r0ikB/PPb+zjkfCZ9RX339dzF0JNhML2tpNQd/owJFez
	 K/lDQ6e+KhiPd3unsfsj/nzw7/cR5kzXkAq9rH2vBu46f72ejwBPPkRREnt38Pxoyl
	 bMAEzxfRW2pBLuPAO6CLjazGBSRFluzvA3jqNznE=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible" failed to apply to 6.6-stable tree
To: mdaenzer@redhat.com,alexander.deucher@amd.com,christian.koenig@amd.com,jsday@noreason.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:05:38 +0200
Message-ID: <2024080738-gopher-uphold-0739@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c4dcb47d46144d8f5b1ace1d8d2fcddeb5dacd8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080738-gopher-uphold-0739@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

c4dcb47d4614 ("drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible")
394ae0603a67 ("drm/amdgpu: fix visible VRAM handling during faults")
ba1a58d5b907 ("drm/amdgpu: add shared fdinfo stats")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4dcb47d46144d8f5b1ace1d8d2fcddeb5dacd8e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>
Date: Wed, 8 May 2024 15:19:16 +0200
Subject: [PATCH] drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It incorrectly claimed a resource isn't CPU visible if it's located at
the very end of CPU visible VRAM.

Fixes: a6ff969fe9cb ("drm/amdgpu: fix visible VRAM handling during faults")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reported-and-Tested-by: Jeremy Day <jsday@noreason.ca>
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 80974d72cbc1..0364a7bb5893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -432,7 +432,7 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 
 	amdgpu_res_first(res, 0, res->size, &cursor);
 	while (cursor.remaining) {
-		if ((cursor.start + cursor.size) >= adev->gmc.visible_vram_size)
+		if ((cursor.start + cursor.size) > adev->gmc.visible_vram_size)
 			return false;
 		amdgpu_res_next(&cursor, cursor.size);
 	}


