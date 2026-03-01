Return-Path: <stable+bounces-221726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKoAOYaco2l2IQUAu9opvQ
	(envelope-from <stable+bounces-221726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:55:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDB1CC409
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B11E23052381
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D272F3600;
	Sun,  1 Mar 2026 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtoyXd0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C72F28FF
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328991; cv=none; b=s1RvzxY0IYmCCWsJHVHqRZJplmvkbDOFnJ1QwaRg9/AMx8SvR3SdszL1inssqSU64SHUL3JEHay2+j1JK5tec3iIaV/sfu1P1wXaaMV67OQni/6hfVJ4UT4xL9G/LkDVOrEdcHTBROgKWjdwF9Jw1yNjdhew+X5JvfmReuyt4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328991; c=relaxed/simple;
	bh=4crob1UvAd93a+tL/1ynEA6fwTArnQzdEwHFE8Ze7gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkbYbpzLQeVfjaMF0NUs/uX955kUrG8WE1PG8k2XH5xWWBOS8QsXTyVXiV7gdyrjjgWA07XNNZM+BTwMtuj3PAj5DgDgEDf42CJTXpVx4E99QGVofGUpcjx3t+d9JTnzJJwT12YTDVnAQSC70ecatU39D/n/0FnwQn8mbYM8NN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtoyXd0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FB1C19424;
	Sun,  1 Mar 2026 01:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328990;
	bh=4crob1UvAd93a+tL/1ynEA6fwTArnQzdEwHFE8Ze7gQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NtoyXd0X4Y4aKFD5mTjepotNRkQizjboUSJ1gUgMRDmH6E1oqgRu/iGGD3H+Wp1oJ
	 C6kZ86pDgQAevku8wbB2I7BplA/RZyCkyJtL4//ds5zxTcxan+TsYkpUzyV23CjSlm
	 IG2H9473RKrHaC1m7PQViTRJDKXQEiVoQk8skNwqErFnB1GByUeMmXXai9cI5KFqKp
	 Ewu5MvusiJUPRu/0sLwbu9OzIjMIfD9cF8d0tSCfELOR4v118bBjsQYPPqCKa9khWT
	 LtGAmlBY+V1zbtarNaC6l7XRbeGusqMQJUqxSWS683L3ht00C6yLVgI9KIh6hfmSes
	 jqAK0btXa1sug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yifan1.zhang@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdgpu: Protect GPU register accesses in powergated state in some paths" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:36:28 -0500
Message-ID: <20260301013628.1696446-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221726-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDFDB1CC409
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





