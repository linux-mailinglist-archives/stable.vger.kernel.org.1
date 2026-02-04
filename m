Return-Path: <stable+bounces-213324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBBeJ02SgmmhWQMAu9opvQ
	(envelope-from <stable+bounces-213324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:26:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F5E0017
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52BF230257E9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 00:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866561C84D0;
	Wed,  4 Feb 2026 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSAmbI5P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2B128816
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164809; cv=none; b=a5GmQcPtDqhRZoosx42URbkFD2K3bo+xTM214xm0Nj1ZaSujqXvS4rAOOPzsj4THU8TgFRKmoXrYbeTnuVClgSNBPngZzp1IIG7OWZYW5cI3MmQI0+q634wF5b+kTqDNTrjebEcxejCGQuLSpLPlakEkiDgLcIx9jrtl1uIbN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164809; c=relaxed/simple;
	bh=e7ynGY6W5JdfmthqtYEh/3FnBYTaB2ZO+EGC6pjPvOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tycL3Gq7/bL0g7m5s0wgAi1QD+15apVzK7ZRx6JPZRtQ2uqRB8LsREjCHNxQRImlWxoOe+6hUV4NYtn0y9hySuTTvKsjylyqctm8cZO7FZuztks6jaea4VcGR9Ln+uQ7kg8WTBoFOBfwo6PK9IbxBXnPz8juvy/HVQfiu+kFVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSAmbI5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC43C2BC86;
	Wed,  4 Feb 2026 00:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770164808;
	bh=e7ynGY6W5JdfmthqtYEh/3FnBYTaB2ZO+EGC6pjPvOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSAmbI5PwT7BH7hJlJf2skTVmIsLlTGsKTgLp0kDK2eYeDEVVDKGii7BX2QhjHCvu
	 2Y0B3fjtp52h4BvBfhhgjzcEUgXtTXiRjI2IVwAlgl99LotuHvHb+rtS9IPcEqrY5s
	 sd48sBgxNjNV+YhrSKTksh5EpUAdpTuL99+osh6t+n/3l8QDqGkDD5EBxli3ExD/Ns
	 /NU9+oMV8+0ZtVT1SGmwNSUnTno+uIta8frfpkDfW6S1kRry7S2EeyxsOdSCygwYrr
	 f5pOLjepH74lROv2xxTetzzDEaMXWtGjZIiANvMPdR59Qf8h0BBvDyfZ4w8/+2+Vhg
	 2wr+Fo8G4FRwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jon Doron <jond@wiz.io>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Philip Yang <Philip.Yang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/amdgpu: fix NULL pointer dereference in amdgpu_gmc_filter_faults_remove
Date: Tue,  3 Feb 2026 19:26:45 -0500
Message-ID: <20260204002645.1462394-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204002645.1462394-1-sashal@kernel.org>
References: <2026020358-resemble-wildness-53b5@gregkh>
 <20260204002645.1462394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213324-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[wiz.io,gmail.com,amd.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 423F5E0017
X-Rspamd-Action: no action

From: Jon Doron <jond@wiz.io>

[ Upstream commit 8b1ecc9377bc641533cd9e76dfa3aee3cd04a007 ]

On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
ih2 interrupt ring buffers are not initialized. This is by design, as
these secondary IH rings are only available on discrete GPUs. See
vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
AMD_IS_APU is set.

However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
get the timestamp of the last interrupt entry. When retry faults are
enabled on APUs (noretry=0), this function is called from the SVM page
fault recovery path, resulting in a NULL pointer dereference when
amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].

The crash manifests as:

  BUG: kernel NULL pointer dereference, address: 0000000000000004
  RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
  Call Trace:
   amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
   svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
   amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
   gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
   amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
   amdgpu_ih_process+0x84/0x100 [amdgpu]

This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
IP 9.3.0 from noretry=1") which changed the default for Renoir APU from
noretry=1 to noretry=0, enabling retry fault handling and thus
exercising the buggy code path.

Fix this by adding a check for ih1.ring_size before attempting to use
it. Also restore the soft_ih support from commit dd299441654f ("drm/amdgpu:
Rework retry fault removal").  This is needed if the hardware doesn't
support secondary HW IH rings.

v2: additional updates (Alex)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Jon Doron <jond@wiz.io>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6ce8d536c80aa1f059e82184f0d1994436b1d526)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 9b225acdcf974..3c24637f3d6e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -454,8 +454,13 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 
 	if (adev->irq.retry_cam_enabled)
 		return;
+	else if (adev->irq.ih1.ring_size)
+		ih = &adev->irq.ih1;
+	else if (adev->irq.ih_soft.enabled)
+		ih = &adev->irq.ih_soft;
+	else
+		return;
 
-	ih = &adev->irq.ih1;
 	/* Get the WPTR of the last entry in IH ring */
 	last_wptr = amdgpu_ih_get_wptr(adev, ih);
 	/* Order wptr with ring data. */
-- 
2.51.0


