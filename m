Return-Path: <stable+bounces-76657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC997BACA
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 12:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18DB1C20DEF
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C3176ADA;
	Wed, 18 Sep 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="VqWgKoxa"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4615D5CA
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655255; cv=none; b=bCoMivlTBpsfDPxagbCi00nA2qc/j+KO8AD2sa011NLBgOKY77Ld0Yfy2CasYGhkRdGjPYjZ86RzUh1dlU+1MR27PrSXcXYXZNsd5Y9jS5PaebN8iS3IgcPwKnl6q1P9uYuWoAGKhS8VSCj/pTZLFmgjZVErmZ1i3kNu1yLOiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655255; c=relaxed/simple;
	bh=RKbm7xcKCteoFq9/F0wkOyMS6K/628Tr9NoWSDd0DUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mkzj9zrexKPeTYiA4ZWpYK+NX6RMwsYYrPxwazNH0QCFuLBMupG47Lg1Zb5+i6M2exJoG+r0LhEvqltqcFOx1jCI3oDLNW80iXgwTakPcGiRfdwVTNYst1M0AIlh5SSwWOdY2Mo//b0x3X5xulfSRtZ0RQQUPN/tFJodnDk2Hj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=VqWgKoxa; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726655245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JqIG8yxuspLnq8acVcDregoevK+cZD3jUXci1wiy264=;
	b=VqWgKoxai6oe1j+ndFgYcH9YES/8LVXillVjHIkw8wIkl5z5YzhhqFQiB53QnrTSmZ925J
	5T4JBW9pyKBD808lAfHhW37zm964+j/nl1XEEZO+zvvz5RLI4hQ9JxICUonrjX4CWoIpi/
	VocoZSNf9UYPEmmEbVfRfnvnUGWnuB8=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Wed, 18 Sep 2024 13:27:25 +0300
Message-Id: <20240918102725.63985-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From:  Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 2a3cfb9a24a28da9cc13d2c525a76548865e182c ]

Since 'adev->dm.dc' in amdgpu_dm_fini() might turn out to be NULL
before the call to dc_enable_dmub_notifications(), check
beforehand to ensure there will not be a possible NULL-ptr-deref
there.

Also, since commit 1e88eb1b2c25 ("drm/amd/display: Drop
CONFIG_DRM_AMD_DC_HDCP") there are two separate checks for NULL in
'adev->dm.dc' before dc_deinit_callbacks() and dc_dmub_srv_destroy().
Clean up by combining them all under one 'if'.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 393e32259a77..4850aed54604 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1876,14 +1876,14 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
 
-	if (adev->dm.dc)
+	if (adev->dm.dc) {
 		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
-
-	if (dc_enable_dmub_notifications(adev->dm.dc)) {
-		kfree(adev->dm.dmub_notify);
-		adev->dm.dmub_notify = NULL;
-		destroy_workqueue(adev->dm.delayed_hpd_wq);
-		adev->dm.delayed_hpd_wq = NULL;
+		if (dc_enable_dmub_notifications(adev->dm.dc)) {
+			kfree(adev->dm.dmub_notify);
+			adev->dm.dmub_notify = NULL;
+			destroy_workqueue(adev->dm.delayed_hpd_wq);
+			adev->dm.delayed_hpd_wq = NULL;
+		}
 	}
 
 	if (adev->dm.dmub_bo)
-- 
2.25.1


