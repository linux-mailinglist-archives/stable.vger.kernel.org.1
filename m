Return-Path: <stable+bounces-221476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIAgJTeWo2lPHgUAu9opvQ
	(envelope-from <stable+bounces-221476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBE1CAB3D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73D5D301CFD0
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400BF284898;
	Sun,  1 Mar 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PODTfkjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4828466C
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328359; cv=none; b=FAjmXYLcIG32dwDCgmQFASn7NlHUGouewMN+BzZQIKAEX8i4ETRcb03tfJKx9WEi42PVa7W4X0w29OKcTeU9hpb3XbufOlzzSs6Kys5CqvdHP9ctcqu9fQhVZ5wLjtK4r0rX/Jujdwh/nINFfaddVHeV2jUntNI9iLkwGgFi0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328359; c=relaxed/simple;
	bh=MAY2Y6F5m9+mJiOoiE+RzdsjpFQkLme7ZUvPkVDBvKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1aW6gEYJJ/v8JvrsWlgTPJCzV68FS8DL5HcdjyFSL+fpPTWJwtJ3JDSiqTjLZGwAoF6PaevFSvy5jVmG+TdyMx4Dh7hYzoOgOGlPN/e16RR3bcIB8/ig/robIx2RZqL9FomXldVKNiIA8JFjeMux1MItpmNJ5rvgVbnWUSR1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PODTfkjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6DBC19421;
	Sun,  1 Mar 2026 01:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328358;
	bh=MAY2Y6F5m9+mJiOoiE+RzdsjpFQkLme7ZUvPkVDBvKM=;
	h=From:To:Cc:Subject:Date:From;
	b=PODTfkjKhJOXsNb2rvkfSqE/0qSzUXqp2LCX5Zwpm7CnFXRlw+IdEGNCqqIMUAmyY
	 wJm8e02AkHXtGO6Xa3LuvtbmYQklPApYTOpyeA03IlN1Yk2hIwvvqZHVa/PMR3gQ9D
	 X/kgY3oCGUO0/xPnaljYVY8JVGoaTr5ABpcgWTmMb/WSmZOKlOCdozbP+qaNeGpDw2
	 /YibNBa0r5iOImaIjnv+3fAIBbQ58ThqbwSMlK8vxX1XOK+2ke72PxkaadN69bssAR
	 OLpAgSxjk9M6ZyxD6yONhG+SMS8wBW1StDHG00pyIyusWpmjw0PD/WeyYSW5+oe8+8
	 eyIP1mHq02v8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mario.limonciello@amd.com
Cc: Cal Peake <cp@absolutedigital.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amd: Fix hang on amdgpu unload by using pci_dev_is_disconnected()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:56 -0500
Message-ID: <20260301012557.1683222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221476-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,absolutedigital.net:email]
X-Rspamd-Queue-Id: 1CBBE1CAB3D
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f7afda7fcd169a9168695247d07ad94cf7b9798f Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 5 Feb 2026 10:42:54 -0600
Subject: [PATCH] drm/amd: Fix hang on amdgpu unload by using
 pci_dev_is_disconnected()

The commit 6a23e7b4332c ("drm/amd: Clean up kfd node on surprise
disconnect") introduced early KFD cleanup when drm_dev_is_unplugged()
returns true. However, this causes hangs during normal module unload
(rmmod amdgpu).

The issue occurs because drm_dev_unplug() is called in amdgpu_pci_remove()
for all removal scenarios, not just surprise disconnects. This was done
intentionally in commit 39934d3ed572 ("Revert "drm/amdgpu: TA unload
messages are not actually sent to psp when amdgpu is uninstalled"") to
fix IGT PCI software unplug test failures. As a result,
drm_dev_is_unplugged() returns true even during normal module unload,
triggering the early KFD cleanup inappropriately.

The correct check should distinguish between:
- Actual surprise disconnect (eGPU unplugged): pci_dev_is_disconnected()
  returns true
- Normal module unload (rmmod): pci_dev_is_disconnected() returns false

Replace drm_dev_is_unplugged() with pci_dev_is_disconnected() to ensure
the early cleanup only happens during true hardware disconnect events.

Cc: stable@vger.kernel.org
Reported-by: Cal Peake <cp@absolutedigital.net>
Closes: https://lore.kernel.org/all/b0c22deb-c0fa-3343-33cf-fd9a77d7db99@absolutedigital.net/
Fixes: 6a23e7b4332c ("drm/amd: Clean up kfd node on surprise disconnect")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 528990a595ec9..9758221413814 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4924,7 +4924,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_amdkfd_device_fini_sw(adev);
 
 	amdgpu_device_ip_fini_early(adev);
@@ -4936,7 +4936,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_device_unmap_mmio(adev);
 
 }
-- 
2.51.0





