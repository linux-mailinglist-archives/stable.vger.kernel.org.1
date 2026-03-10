Return-Path: <stable+bounces-223962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB1MFkn9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B824A3BD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D02930BBEBA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD0371067;
	Tue, 10 Mar 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I70CJxgx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9A2BF3E2;
	Tue, 10 Mar 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141096; cv=none; b=Jsse97WuFy8Cuwhd6Vk6MfiIBN8RFTMsd5KDiFBr3ER4dcBlOFjSGyjkS6pyrDHPIZJEk3KBDJLtKFsVeNzLsWslBlMzANcRvVuw0Veo38BC0LmAKg1ynIrzVYG4M1/L8OxJACvJwaQgupKWJahAKoY5POJqvAP+GXW8geEMdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141096; c=relaxed/simple;
	bh=SFjRd4elT7G9raIHeBY7bncbL/XUAXtc8D65yTLJP04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB+j5B+qph03sg77Zgs1PS1ZOexSioTfeuZqe/8fcZlmLrpcrPhGzkXbNhrMtDIRI89jhYexiQZ562b2hlyhe83eroHsZmDOoB7gyBaCS5onFGZvzzWvSoJ+edm2MI19dX1X2zhzVwMlB7zqCrD3OSUZWbtw4r2hPhGpWzV7JoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I70CJxgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09351C19423;
	Tue, 10 Mar 2026 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141096;
	bh=SFjRd4elT7G9raIHeBY7bncbL/XUAXtc8D65yTLJP04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I70CJxgxs/M4XHejP3mZuyN4KTGCIfPRYsDLFxwbbjPDm0AbVUyGYB4pFNYmJWQHr
	 Aw/IY5fKZdFpJsVOzQMTSjVzuxcAgP303fYsLv4FPMaSwrLjIq09Wa6acdRz1Vky0i
	 w3wnmMCkH8ayWy0pMj0meZkKuPFtYoMJ82voaRLf/JtmN4zIdO8MgOSdycdln3pd19
	 e2ZPV9ByliuBdt716gWU+ND6x9d2KJ1joOQamoGJ1zE4H7KdyJDkCW1rN0qP5oTdzC
	 Bxa25uin0LLbBjRhk267a+FPFvwF6ZM6CNH6aUGojavT13E8oEkcoiS7PoKdLT9lOo
	 aLJDlbq5HNcTQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 097/311] accel/rocket: fix unwinding in error path in rocket_core_init
Date: Tue, 10 Mar 2026 07:02:24 -0400
Message-ID: <2b05c06b4f95a9bd05cafb9bd1f480c603ffe8ba.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 797B824A3BD
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
	TAGGED_FROM(0.00)[bounces-223962-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cherry.de:email]
X-Rspamd-Action: no action

From: Quentin Schulz <quentin.schulz@cherry.de>

[ Upstream commit f509a081f6a289f7c66856333b3becce7a33c97e ]

When rocket_job_init() is called, iommu_group_get() has already been
called, therefore we should call iommu_group_put() and make the
iommu_group pointer NULL. This aligns with what's done in
rocket_core_fini().

If pm_runtime_resume_and_get() somehow fails, not only should
rocket_job_fini() be called but we should also unwind everything done
before that, that is, disable PM, put the iommu_group, NULLify it and
then call rocket_job_fini(). This is exactly what's done in
rocket_core_fini() so let's call that function instead of duplicating
the code.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Link: https://patch.msgid.link/20251215-rocket-error-path-v1-1-eec3bf29dc3b@cherry.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/rocket/rocket_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index abe7719c1db46..b3b2fa9ba645a 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -59,8 +59,11 @@ int rocket_core_init(struct rocket_core *core)
 	core->iommu_group = iommu_group_get(dev);
 
 	err = rocket_job_init(core);
-	if (err)
+	if (err) {
+		iommu_group_put(core->iommu_group);
+		core->iommu_group = NULL;
 		return err;
+	}
 
 	pm_runtime_use_autosuspend(dev);
 
@@ -76,7 +79,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	err = pm_runtime_resume_and_get(dev);
 	if (err) {
-		rocket_job_fini(core);
+		rocket_core_fini(core);
 		return err;
 	}
 
-- 
2.51.0


