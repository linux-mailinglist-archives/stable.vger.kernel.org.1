Return-Path: <stable+bounces-213323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMo9I02SgmmhWQMAu9opvQ
	(envelope-from <stable+bounces-213323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:26:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F359BE0016
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76EE430A9AF3
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12A19D074;
	Wed,  4 Feb 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWZ+j23G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61296128816
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164808; cv=none; b=BDCZNuoD/Xg4qhO60BftY42FlRR15Vz5QCIHg/dTN7CYGsufcy/FVoEjA0kCUAj/eS3eVXH99gBxMrdWL/KrLPKVRv/y3TWNChSVbEIzw1+zESPfJUfbGBREBefzLCvTNVfWlmsQnAhprn7z1s+ZyoSeWlum3a6WRLrHkyXlLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164808; c=relaxed/simple;
	bh=o/c5o865DTQNIzAqFJPNUrcNI/EA63KHy4KZrAdWtTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iE3jTy2AqXb1Nc6rRiNYA1kWoqV1i3O+soLSwZWRsOXY3ReGUM4rgWHNlloPpNhrwiwf9witmd6HAdVUEP1S0YMVTLtAt+v5PoyGZdD6NcbPRxszjD/Rjh29awr3XxYuHOkjRjNOPnxvEXXlzDdwHXpsCkEehtPV4fL80RHXIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWZ+j23G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E828C116D0;
	Wed,  4 Feb 2026 00:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770164808;
	bh=o/c5o865DTQNIzAqFJPNUrcNI/EA63KHy4KZrAdWtTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWZ+j23GeH9cr3FGTrUyt9Z9QGuWWK+4P3D6HYPz3TpDXgEs/hEhhwybTZP6dyQzG
	 t7DO6DJ+8fPTZYSE+BPISk0OW+YyP5ICNnPTTZTaZznGcajQXTUoSXNGDoieD8IUWC
	 cnjI0J7dehUv6zy/ATU6Olmzkf7X0Umyk6TCKdhW76T0KyVSsGfO87jiRU84x5FpOJ
	 k8/LQqgfhK15N4LqdmRZeylkz/cBubuO2EvYij7npAc2VcjfsNcemq5eaP5nJic6MD
	 +wegv9wnAlZFUMR90F+IQYbvHVqG+U1q1B0nOHZ2/oKiLTmNK+FzKM611PkCGKT1mc
	 ldqHrK6yUtEOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/amdkfd: Don't use sw fault filter if retry cam enabled
Date: Tue,  3 Feb 2026 19:26:44 -0500
Message-ID: <20260204002645.1462394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020358-resemble-wildness-53b5@gregkh>
References: <2026020358-resemble-wildness-53b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213323-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F359BE0016
X-Rspamd-Action: no action

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit e61801f162ddcf8874c820639483ec4849b0fb0b ]

If retry cam enabled, we don't use sw retry fault filter and add fault
into sw filter ring, so we shouldn't remove fault from sw filter.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 8b1ecc9377bc ("drm/amdgpu: fix NULL pointer dereference in amdgpu_gmc_filter_faults_remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 0b6a0e149f1c4..9b225acdcf974 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -452,7 +452,10 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 	uint32_t hash;
 	uint64_t tmp;
 
-	ih = adev->irq.retry_cam_enabled ? &adev->irq.ih_soft : &adev->irq.ih1;
+	if (adev->irq.retry_cam_enabled)
+		return;
+
+	ih = &adev->irq.ih1;
 	/* Get the WPTR of the last entry in IH ring */
 	last_wptr = amdgpu_ih_get_wptr(adev, ih);
 	/* Order wptr with ring data. */
-- 
2.51.0


