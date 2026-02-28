Return-Path: <stable+bounces-220506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K+3Ekc7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:00:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B694A1C6801
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2487531A4359
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6E3491C9;
	Sat, 28 Feb 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSDg/mF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB23C9FD9;
	Sat, 28 Feb 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300391; cv=none; b=LjV5Dwt7xE42U600ncdPZ3yYRBRMc5akRXMPT8Sxkrjq2dG4IsR6cLCyhOrDCgH6UXrMRvYovL446Qi2KTaC0suDTdUHfZfviD5rFhzdC8VxbjGfZ5GX4yVawniLBe75FUet1MXDjY15gZA4wx60oM3DEarDCOMK6rKulmavcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300391; c=relaxed/simple;
	bh=amOzwzQjItQiIy9ZvowQ6ojMd3CQtr0MIAbVNTIUAj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtlhquNQPIhJ4vxEG3S7QzLXc7F6Z/cH8vPKiqt6QmWe+4NK24+IxW6UTMRrypiaDORkKm1kP5zDr0LbokMY/83MLm8J9gIbby9MppFvl42Iy+u+YXZk/Xlq6PBPLfhF+zdI3peQvB6da3ItCENfCzsHzSOEj9U7K532RytsYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSDg/mF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387FAC19424;
	Sat, 28 Feb 2026 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300390;
	bh=amOzwzQjItQiIy9ZvowQ6ojMd3CQtr0MIAbVNTIUAj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSDg/mF4ldvhuWSMMocETZtymmtswGZ32SLCogg4NTC7Sp/5wCIpKFCf3m0mEM6z5
	 nC1ClTBJJtrRGcXA2rxk0WiPYM57ngVs+A28WGo8JEqkkr7mXc5Gf7FmwxmThSt/o3
	 DQq8eDvlKRUEBM5Y8ttlHUSas1vvVNDBcJaD/HGY1+C8YeFTzklBOH1t0Ko/1oBk69
	 q0xcihhi0ViyHTsSlkz9+XvJFGBkgZClVbrSNX4mzIE1l7zdARm9VIzFK6yRpjHSHt
	 Zz/4jjMfN+6UH7M/o+miEe/CZgXZ3E6Qaud4NR0CeeOGdIYtWSW1bkPnR+OyWWsW1f
	 dHUUs3qu4wCQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ce Sun <cesun102@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 427/844] drm/amdgpu: Adjust usleep_range in fence wait
Date: Sat, 28 Feb 2026 12:25:40 -0500
Message-ID: <20260228173244.1509663-428-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220506-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: B694A1C6801
X-Rspamd-Action: no action

From: Ce Sun <cesun102@amd.com>

[ Upstream commit 3ee1c72606bd2842f0f377fd4b118362af0323ae ]

Tune the sleep interval in the PSP fence wait loop from 10-100us to
60-100us.This adjustment results in an overall wait window of 1.2s
(60us * 20000 iterations) to 2 seconds (100us * 20000 iterations),
which guarantees that we can retrieve the correct fence value

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b10497d487c3..81bdd6aaad2a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -726,7 +726,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		ras_intr = amdgpu_ras_intr_triggered();
 		if (ras_intr)
 			break;
-		usleep_range(10, 100);
+		usleep_range(60, 100);
 		amdgpu_device_invalidate_hdp(psp->adev, NULL);
 	}
 
-- 
2.51.0


