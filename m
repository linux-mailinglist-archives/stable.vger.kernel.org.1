Return-Path: <stable+bounces-224268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NAcOucAsGm0eQIAu9opvQ
	(envelope-from <stable+bounces-224268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:30:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A204424AE09
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35318308522D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF5389DE0;
	Tue, 10 Mar 2026 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7sWF9wo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D831388E65;
	Tue, 10 Mar 2026 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141965; cv=none; b=nKp67zBL1tQgqNnnyfuoPN1Ze6ZyJ5RdX+0LxLWj8xaK32G2J/E/6ls0wZVE73u8uLcXqcGpVTTLFt/5OHYa/LVNXO8MgNxTagHk96qF0akTaiE9YH4F2zOUfV+Rx02iftcGqjbHkAdy2erWWbTAV7UAtpxlHIphjwrxi7hsSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141965; c=relaxed/simple;
	bh=SFjRd4elT7G9raIHeBY7bncbL/XUAXtc8D65yTLJP04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSOEBL5T+18XBTLOcpdo7ag514pfiLofd/SZc+zFUk9Rh1bp3vgwKhyah63cTvml+spPjyxVkVJBxjsqALmckt1kwFlzX4c+TZ2ixmpxlJbY0q2TUN0aYS0iK9kjeWxfhbk4Afognl+HUlZ0zI0YmVvFalbHyU1NXYs8eYyVGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7sWF9wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D696BC19423;
	Tue, 10 Mar 2026 11:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141965;
	bh=SFjRd4elT7G9raIHeBY7bncbL/XUAXtc8D65yTLJP04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7sWF9wohjLzNJtT5rgGnr0Kvm+vEPqr+yzoKnL6fNl28mwUUMBAooTc38fCnki+c
	 0BXkgcTlU3AgX7X6yDe1ze5mqms3UYs0KlqRA0WR/buQWXjMTZDucfsE+oKvc+6eSH
	 W6DH/1Ejuh9wobWGVZNzQPsCn6Fwh+VwGVSpWwomgVKBvSv6Gf/zfjJdqNgEGUU0Eb
	 yZylXgLdRJXXlnZ3QThNIopgGBADgRWUhiE4FqkVUoQL1rHvmv+EcVGrdkMsxcocUV
	 EUp9b+VEkjym5aONt34cLu26D+VF+QrwnWFMbd8j0try4Hx7yDsrmprMjzqPfVn0VD
	 iEP+L+crH1YQg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 089/314] accel/rocket: fix unwinding in error path in rocket_core_init
Date: Tue, 10 Mar 2026 07:15:48 -0400
Message-ID: <c12a151205f04338a510b2550e776a50dcff3d65.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A204424AE09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224268-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
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


