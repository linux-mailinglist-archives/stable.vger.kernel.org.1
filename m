Return-Path: <stable+bounces-135030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5467A95E1C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0281890D1D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B31F473A;
	Tue, 22 Apr 2025 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSpc6JsL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E0135A63
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303196; cv=none; b=q8MbgmRAoYIyxzYHgeM2NiZIqdey5PvaLyduappLibbrbx1cNFNa9GDc4+t0/10FBir/URKa+8xKwBFKN5dzVrYv+9jIPHMGgOkDH0L5V3qIBq/x577j2pNN4+1Q9HTpn4RwqEVlDeo1Ju0TEU7Y25wEATwIasSgDVq34hLmHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303196; c=relaxed/simple;
	bh=lF2CbcvOEnuKaprgDIAGdOvd2GywmUaOA5Zww3lWUbI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V6Z0WcNirL/USH5JyxmYqKG+T0bibywnDxUPxKXq1K5g6G5Fl71WkPTXMYWHK2lNMgdu2Z2kGUjWKTmwljidkK5+fQfDc7oHkiueLci4vwRLDYyELdQ3B7xYNdeKVZik0c+0OEFYXnSI44H1JI+DTGMB5p7BbqJGMf7SB6XurwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSpc6JsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E14C4CEED;
	Tue, 22 Apr 2025 06:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303196;
	bh=lF2CbcvOEnuKaprgDIAGdOvd2GywmUaOA5Zww3lWUbI=;
	h=Subject:To:Cc:From:Date:From;
	b=eSpc6JsLvF1J/lbaLc08XmghwPJ6SJWwu6XNjvpty0C+Kr7bINVNIdB9K5kW0yw8v
	 PmDAf0q4Uu/m562XwUV7twbcesFpMm3QU1BzUikvYc+r9M9jdY73RKmS9j6R5A+sRK
	 Y3mxVzWjE/pjg8l4si6g7FqciBVr65Io4xxZKtaI=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix warning of drm_mm_clean" failed to apply to 6.6-stable tree
To: zhenguo.yin@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:26:28 +0200
Message-ID: <2025042228-nutlike-rectify-b5ec@gregkh>
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
git cherry-pick -x e7afa85a0d0eba5bf2c0a446ff622ebdbc9812d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042228-nutlike-rectify-b5ec@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7afa85a0d0eba5bf2c0a446ff622ebdbc9812d6 Mon Sep 17 00:00:00 2001
From: ZhenGuo Yin <zhenguo.yin@amd.com>
Date: Tue, 8 Apr 2025 16:18:28 +0800
Subject: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kernel doorbell BOs needs to be freed before ttm_fini.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4145
Fixes: 54c30d2a8def ("drm/amdgpu: create kernel doorbell pages")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 39938a8ed979e398faa3791a47e282c82bcc6f04)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b34b915203f2..7f354cd532dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3510,6 +3510,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 			amdgpu_device_mem_scratch_fini(adev);
 			amdgpu_ib_pool_fini(adev);
 			amdgpu_seq64_fini(adev);
+			amdgpu_doorbell_fini(adev);
 		}
 		if (adev->ip_blocks[i].version->funcs->sw_fini) {
 			r = adev->ip_blocks[i].version->funcs->sw_fini(&adev->ip_blocks[i]);
@@ -4858,7 +4859,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		amdgpu_doorbell_fini(adev);
 		drm_dev_exit(idx);
 	}
 


