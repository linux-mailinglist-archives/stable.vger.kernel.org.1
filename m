Return-Path: <stable+bounces-217753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLd9BXtKnGmODAQAu9opvQ
	(envelope-from <stable+bounces-217753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:39:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5AE1763D0
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2117E303D6BC
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164E036604D;
	Mon, 23 Feb 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSXP/k2s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C51366835;
	Mon, 23 Feb 2026 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850280; cv=none; b=BuIqwXbQbEiyEAZbyBt4JvW+pnDOdANLKjV5obyXHPHy3145hb8S/+VgaFyCrd7IdvruQAA7AcuISwefpf1mjiZmmpO6w+S+L5IU+uak1s9MFvK8ZYq4dLgBoFz1FEHhHxwJHcwARGqIh9rVRCICiZnjBLWXGDx9+j5wMLo6sss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850280; c=relaxed/simple;
	bh=iHZa8nYe42r2IjJzinLnQVMLFp3VrGSWpay58wvZsmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY20Rys+LgYJHALLNvW4iC9SP2obtC/P6+z/r0Pvm2Y3xku6XayVbLrws3QKv/KUpMBeMiUSKfi10dI07zFrPZGeQFEK0zJFhHjufLQagQCyZVKMwZk0c/Pxf14YGfmy+mXQFvFLrJHFRS8jFISAgNkB+4YTRdmxMtyf1yvGyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSXP/k2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2758BC4AF0C;
	Mon, 23 Feb 2026 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850280;
	bh=iHZa8nYe42r2IjJzinLnQVMLFp3VrGSWpay58wvZsmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSXP/k2sWKkXL0NuDeNI7dhVQSMrgkG2/+kBnm33XygN2m5TrOGFCFkXc+TBLrfpW
	 W8BndV/+jMANV0wfaBuJ9zCjWTuFT66y7z33tOPzC57gVhqCQzBA9CaCmc7o9MG9NB
	 SIaWLAbdot1KfZrnjT/fQYf50QX2+wXDdQZfarF22z4gf24Gkh/V1rdqbeX/L4aJ6a
	 cCQHDthNLeq5HOGAaBVuqpU/76DlcD8/oCT6rVWjw9KrV7wQaeNexerchKCTY/pz3i
	 cWd55/rdVomjGn54VgeqXcSbGlRHwGRbsDuIs6MXoCB7WDrXUPIGJZU904UlwrCdS7
	 +H+kBlOjQaWkQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Victor Zhao <Victor.Zhao@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] drm/amdgpu: avoid sdma ring reset in sriov
Date: Mon, 23 Feb 2026 07:37:19 -0500
Message-ID: <20260223123738.1532940-14-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217753-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C5AE1763D0
X-Rspamd-Action: no action

From: Victor Zhao <Victor.Zhao@amd.com>

[ Upstream commit 5cc7bbd9f1b74d9fe2f7ac08d6ba0477e8d2d65f ]

sdma ring reset is not supported in SRIOV. kfd driver does not check
reset mask, and could queue sdma ring reset during unmap_queues_cpsch.

Avoid the ring reset for sriov.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background task completed but my analysis is already finished. The
result would show the same finding I already verified — that
`amdgpu_sdma_reset_engine` was introduced in the v6.15 cycle.

My final answer remains **YES** — this is a small, correct bug fix for
SR-IOV environments that prevents SDMA scheduler work queues from being
left in a stopped state.

 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8b8a04138711c..321310ba2c08e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -558,6 +558,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&sdma_instance->engine_reset_mutex);
 
 	if (!caller_handles_kernel_queues) {
-- 
2.51.0


