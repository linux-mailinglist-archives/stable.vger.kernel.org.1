Return-Path: <stable+bounces-221241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIapCTOTo2khHQUAu9opvQ
	(envelope-from <stable+bounces-221241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:15:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC01C9FD3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19A5B30193B8
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69423A937;
	Sun,  1 Mar 2026 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHrtQpBF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9321B9F6
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327708; cv=none; b=NUKDG25MchvKrnGBF1ECqNrZH4Mx4EJ6aQgMXLe7u+/0gt5qxviPvy/WTdupPYm65gFYYFAd4hdpLwg68/oNd+K8V36NAMJHsWp4+lccYH7sCh/QbKDh36fHRn/cshCBKLyXA1dE+bIN6hgqCfbUB14pFO+hCxKYqjf2VtpQTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327708; c=relaxed/simple;
	bh=fPHCvD2H9nYeBw3rrOrowqbJMs59jQUUx/KELcs0N+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7jqM5A07D9TNN6q6A39oV3iCFr3Bo2YChQ0/ep/EjwMpwmYR+yXbqooRISNNBqPAe4H6wFbm5BAYFTTa9uNMkC8XoRyGja8k3UfCSJRktKvPGtISoEyCncWtKq0vkG50oeCUHBUrFBRFTAkZc0M3KQLv67VmmkJnrgjA3vcnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHrtQpBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23410C19421;
	Sun,  1 Mar 2026 01:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327707;
	bh=fPHCvD2H9nYeBw3rrOrowqbJMs59jQUUx/KELcs0N+s=;
	h=From:To:Cc:Subject:Date:From;
	b=gHrtQpBF0SbC10bLtAPbshk/PDfJ5w3r6/oNvqNC0bjAPtbEvb33fnMZr7Fgu4G2g
	 5gfoGAf9Fx08JQnPIkzAO9zEBM6tjOTh+HnbLgAwCv1ZGEExHSKdnynDm4LVaHdOuJ
	 Ix3Dt6bg6q2k8uFAhjx+nC2JLvGtPhvr6vK3/S9iYLXMSV33FFZ/51uPd+X1vsiqff
	 eNcGaPcIQ+I5pAk5+D5unQk6dqKC65xDF5dq8I6lw4Th4ghvm9kKnJFuwalIm/DlGH
	 5E/7k+nEB6U0Zi0bCekpPGJtxly2/4k3LGkma2IH/V2Oq4G92G07wDQXXFgWeZKgUq
	 w5D+Ptw0rH01Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mario.limonciello@amd.com
Cc: Cal Peake <cp@absolutedigital.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amd: Fix hang on amdgpu unload by using pci_dev_is_disconnected()" failed to apply to 6.19-stable tree
Date: Sat, 28 Feb 2026 20:15:05 -0500
Message-ID: <20260301011506.1667986-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221241-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2CC01C9FD3
X-Rspamd-Action: no action

The patch below does not apply to the 6.19-stable tree.
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





