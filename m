Return-Path: <stable+bounces-220521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIKPCXg9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122C1C6A7D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C522632529F0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC1F481AA8;
	Sat, 28 Feb 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O53EaLrz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20D3CD1BE;
	Sat, 28 Feb 2026 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300405; cv=none; b=R91ZXz87Jmq2/OhDnwZd1KuUc6xeUB3jcsnHbAZg3zyAlljqz6/wjeqIiQfHSH54vQEyNDCImG+IHoKcgo1tqkvUMakuJOirv/iGOFOKGHH2cmvStHw/oRBi3VPyf5RDfW0L7uMIf7fXvdwt8AzrjSBKDif2ATwgfQUUiTx+LyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300405; c=relaxed/simple;
	bh=nGfWN/RyvxmqAuCr2FHXkxLg68q650iTb5z6WbxzE9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGLrmilgM9tPpCVh9yAF3Cpo1m+minkfSyEKjo8zASVjRcSFloc/BYW8RWC63NNF80x22Ur1skic1RX6GRA63Y4jRwOyPJoCzHHYPvFhrwrPLAOibwB3wOy7AqxL8OxAIApQFq55ybPAC4nxry+Y21uF+zMe07D++Z0nduN3Wio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O53EaLrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F96C116D0;
	Sat, 28 Feb 2026 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300404;
	bh=nGfWN/RyvxmqAuCr2FHXkxLg68q650iTb5z6WbxzE9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O53EaLrzlMs0u83WZlP8Rj6sAYU/7w6Cmyv41czsa+sGUAPpzWCLfR43wfFfPtdLO
	 oB3Qzgf66ysr3qIkdpBGF5No4wlVUNaoyCfpiOmySnNYffyKZGGbIFPnx606uDAhqd
	 9t61nRqmekGeDZXtSHZ3HCPKUXOqqTzerBMqB2KsFB8e5FTUl7Yy/JMnHMdw31n9mo
	 1kW47DzCWQ4JGO6yckc0Z8zJnyYSRIcb5NOnvwHuMtf8K/XRYvwO4qJdmnT+RYeX8E
	 7H62nWUs+iDSXcyoBV6FX9ZJba+hC1Fn9ZXO2jeiZLy7fkpbmYpGJ4GE4VQbBPJdw+
	 2uJRpPu8Q+w4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Zhao <Victor.Zhao@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 442/844] drm/amdgpu: avoid sdma ring reset in sriov
Date: Sat, 28 Feb 2026 12:25:55 -0500
Message-ID: <20260228173244.1509663-443-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
	TAGGED_FROM(0.00)[bounces-220521-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 5122C1C6A7D
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


