Return-Path: <stable+bounces-221943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MmEI0+qo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:54:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC521CE09A
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 505F73326C06
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4372DB7B5;
	Sun,  1 Mar 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/E0xwlN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93F20010A
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329519; cv=none; b=EXeL5vCGtK1XBzOOKZb9NSdQIvY+Ymcw9JgzdxounhTT998LKn0CTfM/BOkATWZjsmSCbgoOqH3nh16kgb/BglTXMGbbJXkceJsqEZ5jGFpurC8pt/1fRt3C6w7VUpQzTybVZg23aJUUrrdKt9Q8TypNpy3N6DSa+89eEURMaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329519; c=relaxed/simple;
	bh=lCxpL+urHOTREi6/gPVC4Y9b8CjTIH+jPjr29gff8Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSHfb3z8dwaWSNO9agI9jDCdfqMOCq2NcCye/L8szTmqKaOMmitTCL/dk3E6SGayBB7AYrNKuR3FaVNDGHulWqZrJeUtviRVYqi0b+ScXfYZOgd+ie5LLv7LeqaR5bEbhjyNeNUGKkP02+A5fx1Cq1xDBXdBs/RUu6zHl3u1pEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/E0xwlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F6C19421;
	Sun,  1 Mar 2026 01:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329519;
	bh=lCxpL+urHOTREi6/gPVC4Y9b8CjTIH+jPjr29gff8Zg=;
	h=From:To:Cc:Subject:Date:From;
	b=r/E0xwlNhyoRoCvZ+5REM9BW3543xZg4+OOJN6S5z4/1PV9tqNyKv6QbTLnP6FUHm
	 HRxEMuyluv1oe5qBhpIQxyFQIw7bCJpDOXs4sNpl7QW2s1hnPKqJn6J8xicL1DZxKU
	 Vk/2fcL3disXY5pPN1cSAhFs2f23OLybxiAA3t2gdxioBvmFwGjm7Vpx2IZQOzoD/s
	 bWNeQsC/17UkMEagf2/3ga3gSlP8suZlNqxvVx5x6MwGrtEl698ZKfoxwCKT738hmd
	 5YHdShatV7gTuXaeV9Gv5ol+xQ2zRvUl8/1yFXLBX8YV85fbfoLSPaBq+ecbV3MJPh
	 QvKH29fTwn20A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yifan1.zhang@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdgpu: Protect GPU register accesses in powergated state in some paths" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:45:17 -0500
Message-ID: <20260301014517.1707859-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,amd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221943-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1CC521CE09A
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 39fc2bc4da0082c226cbee331f0a5d44db3997da Mon Sep 17 00:00:00 2001
From: Yifan Zhang <yifan1.zhang@amd.com>
Date: Mon, 2 Feb 2026 13:17:39 +0800
Subject: [PATCH] drm/amdgpu: Protect GPU register accesses in powergated state
 in some paths

Ungate GPU CG/PG in device_fini_hw and device_halt to protect GPU
register accesses, e.g. GC registers are accessed in amdgpu_irq_disable_all()
and amdgpu_fence_driver_hw_fini().

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c1ffc63e23ab5..528990a595ec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3504,9 +3504,6 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
-
 	amdgpu_amdkfd_suspend(adev, true);
 	amdgpu_amdkfd_teardown_processes(adev);
 	amdgpu_userq_suspend(adev);
@@ -4902,6 +4899,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_virt_fini_data_exchange(adev);
 	}
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
 	if (adev->mode_info.mode_config_initialized) {
@@ -7360,6 +7360,9 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 	amdgpu_xcp_dev_unplug(adev);
 	drm_dev_unplug(ddev);
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	amdgpu_irq_disable_all(adev);
 
 	amdgpu_fence_driver_hw_fini(adev);
-- 
2.51.0





