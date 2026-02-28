Return-Path: <stable+bounces-220301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE83L0Mwo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE461C58DC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70BA23095519
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A238C5BC;
	Sat, 28 Feb 2026 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmirHJ/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97A38C5B4;
	Sat, 28 Feb 2026 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300205; cv=none; b=uLTuPC3YaUEb89vZSqpfR1B+16RszYY4W86lSOYPRWPYytKkXoh7WeP9TL2Xr5A79Fm2C7gULvQJjt0ZFAt2xmOQwafXRs/kYrkjIvVkVdU+FwAjaqAtOJiHPIbCh4QhcNNa9yuOh6rq5ZUR9Gg1/0SyuMgDy+N4YgVt3MuP2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300205; c=relaxed/simple;
	bh=b0bCWCCM+U5MnoXGr6BF/KjjFV15RPUhwQmlKKcJK9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfxMDElWE6hUCSozszRCiDcjDR8pyDm3OKzTZMVhNdAHC9nUQSfNhgfMaCETTE/wMKwQiq67iEOuscH49RScgLjTVQdQY0DAggVwi00c6IXAjr+iS3WXlGOXmKwT7uJwr7ELfvVbYyTke5CT90b6duN0FbFkmn+HO6aiYXvYpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmirHJ/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA32C116D0;
	Sat, 28 Feb 2026 17:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300204;
	bh=b0bCWCCM+U5MnoXGr6BF/KjjFV15RPUhwQmlKKcJK9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmirHJ/W92wonBVbSrNHhkzHGMEEh7N+DGISiPLJ3jRyYgfEJwOyRNZp2/5ivLwI0
	 BM7VzAXftYn/nsgstz6oqzFud9drbsGNBoDDFqWQfAw/WRwwFmITc6NG0MkKWj0zuO
	 E30YsfgG88Q1+gXYyX81pSXLUxjwOyyuRHqLdA79GRPkh43Wb2pouXz18peo2U0ooK
	 qRKeS3SLgfXpLSbwUJ5m3zK4jSjTGAgorU+em2HzBW+L83sM7O5E/yxgTWAs3+PR62
	 dMkx9lWKlxADm1hQoXUpgBz5dyGO8oWxkc73BnDpsJWpwC9RdtRUekXE3c8PjAz4vO
	 rALZ351sVQjzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jesse.Zhang" <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 223/844] drm/amdgpu: validate user queue size constraints
Date: Sat, 28 Feb 2026 12:22:16 -0500
Message-ID: <20260228173244.1509663-224-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220301-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 6DE461C58DC
X-Rspamd-Action: no action

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

[ Upstream commit 8079b87c02e531cc91601f72ea8336dd2262fdf1 ]

Add validation to ensure user queue sizes meet hardware requirements:
- Size must be a power of two for efficient ring buffer wrapping
- Size must be at least AMDGPU_GPU_PAGE_SIZE to prevent undersized allocations

This prevents invalid configurations that could lead to GPU faults or
unexpected behavior.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 58b26c78b6425..ab934723579c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -860,6 +860,17 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 			drm_file_err(filp, "invalidate userq queue va or size\n");
 			return -EINVAL;
 		}
+
+		if (!is_power_of_2(args->in.queue_size)) {
+			drm_file_err(filp, "Queue size must be a power of 2\n");
+			return -EINVAL;
+		}
+
+		if (args->in.queue_size < AMDGPU_GPU_PAGE_SIZE) {
+			drm_file_err(filp, "Queue size smaller than AMDGPU_GPU_PAGE_SIZE\n");
+			return -EINVAL;
+		}
+
 		if (!args->in.wptr_va || !args->in.rptr_va) {
 			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
 			return -EINVAL;
-- 
2.51.0


