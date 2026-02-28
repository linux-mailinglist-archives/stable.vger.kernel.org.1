Return-Path: <stable+bounces-220208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMyrF3Aso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63851C5413
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC2F3136442
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9F4D9907;
	Sat, 28 Feb 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLCjrVup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD124D98FD;
	Sat, 28 Feb 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300113; cv=none; b=je5UIDL8YhlRVgc+lNsbYK9VNzAmCXRmZCj3MZbBEBqNcr4IvKbWmHnK63prRFXDvJHeDq1+4HE2yCc20CCsZjhAGBeT7+tmdgwIDvzZZFhyQZt5oQCeeV1GDqKOcRtLGKROLXs3ERMcKXF3azu8jsVVCEfe2qZEHzk1RW09Pag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300113; c=relaxed/simple;
	bh=4tVWj2D0Kmv3FbEwQy/QSrljpJfLDz+tARS2Fp3sK08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5Si69ySnat/PGPeYkjPt0N1ZPQI0FrTsnaHiYvSRd7+rDmrY26zxd26Xc1rQ7/oVsMkH/ytGeo4S+jOYL+JnpukdUz3rVX8D6K8keUEoxefZNLfZIPYuDvYt4Ni3HMJuEAtzIk3lKRHA0Nl2Q3QaANVnOwEtfZryUHNd9XZn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLCjrVup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BFAC19423;
	Sat, 28 Feb 2026 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300113;
	bh=4tVWj2D0Kmv3FbEwQy/QSrljpJfLDz+tARS2Fp3sK08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLCjrVupEm/W5V/qS56iH12uQNzVCgZwHBQyqniJnV/ylrLr2yEcvS7J0ibN4sVcX
	 ZPeYXQUTeyAZCueQVN+iYjNZeBiSt3C9CdSLQ4xsl49kVysHvm8HrKewiLgcaeozV1
	 HU+rczvTTU0o6LtclZ3At2ZBSHZBwfbeR6r3KyT1KjNGTRFeWDqtlUjuYrxjzQrEnb
	 mecPErSeMVZPSfjNFjbbB4CQmJ74XxqF+9ffKz5DijA4jD/27btNP5qz72vJYc9f8J
	 W9MDI4JKuLwd+42nTK6b7s8Txrv+X3/b15epiBkkZxFTN8KZeJpaHgzCiyNfkY5tbw
	 qLZkTZH+nTzAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Likun Gao <Likun.Gao@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 130/844] drm/amdgpu: fix NULL pointer issue buffer funcs
Date: Sat, 28 Feb 2026 12:20:43 -0500
Message-ID: <20260228173244.1509663-131-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220208-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D63851C5413
X-Rspamd-Action: no action

From: Likun Gao <Likun.Gao@amd.com>

[ Upstream commit 9877a865d62c9c3e0f4cc369dc9ca9f7f24f5ee9 ]

If SDMA block not enabled, buffer_funcs will not initialize,
fix the null pointer issue if buffer_funcs not initialized.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d2c3885de711f..ba6fb23b840a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3309,7 +3309,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	if (adev->mman.buffer_funcs_ring->sched.ready)
+	if (adev->mman.buffer_funcs_ring &&
+	    adev->mman.buffer_funcs_ring->sched.ready)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
 	/* Don't init kfd if whole hive need to be reset during init */
-- 
2.51.0


