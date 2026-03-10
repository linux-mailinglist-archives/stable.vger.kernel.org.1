Return-Path: <stable+bounces-223963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE4NHFD9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A1724A3DA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F078730C8A0B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A636EA89;
	Tue, 10 Mar 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuaytctF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD512BF3E2;
	Tue, 10 Mar 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141097; cv=none; b=k8MRUlLxQZc1eqm6mYq9rHQYzuDS37pBxsj6jH9MfxV7cGvBgw825T8cLeysWID+c5rkmN8QRpiQ3IzN6ol/DlVmU8zFLQha3e6VcjFOMkbIvnq8DOc5d2Zn+u1ziN5NAljYP1iUVIFtsxW5TvEY1uCDFin1geBeF7Mo7iRp+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141097; c=relaxed/simple;
	bh=lJQdq2iaaHSa9q7Xv/z4g9O2ReS/644I+1V3+c23Fuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6PGl7qxMdaaToOSVUxsc9uJT48FoZFXyMW70kHpsJylZP5s2Go7aC9lf63ukvIT/p9dFx3NoL2kYS+p14vukljQcRmkL+Bu7nu09n4avIDxQ7BdnuDMwbiy6GfysqgZw7OvFsI5F0DU9sdZMxSaz1obPA8MWLtF51QFn7ORcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuaytctF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D514EC2BC9E;
	Tue, 10 Mar 2026 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141097;
	bh=lJQdq2iaaHSa9q7Xv/z4g9O2ReS/644I+1V3+c23Fuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BuaytctF03CfdEeg78YqlMwqSptEnzrFTblkM0D9ROlPPycpWWoyDsvSHeGoxDvor
	 glCqRxAkFtpEcU49CwLmJjdAsbXmvmzgqdUsh2nw3RUXrCySaeYesducBNFpwOOzj5
	 6U/OAFg1eszCknJePSIs3DLaChlmrRQuJ0C1sHO7HpsjqSqup9tQhPChSRv+FQY0I7
	 9IEDWt3VhE6wRB/y8ToEmRLcvvcxJZ4THP5yLNM7fRGIU8gBwVsrlZwxepKRYUdOro
	 WJTsfX9IOJQ2jbvwdpNmEjYJ+O15uaZ0WaJeEi7wltqlMO3oX2FHX0BpDwMFsHuSQi
	 rgk5MxKOqPVRA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 098/311] accel/rocket: fix unwinding in error path in rocket_probe
Date: Tue, 10 Mar 2026 07:02:25 -0400
Message-ID: <ebf2f86537ec70c933674ef4123979834188cd49.1773140655.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 09A1724A3DA
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
	TAGGED_FROM(0.00)[bounces-223963-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,cherry.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Quentin Schulz <quentin.schulz@cherry.de>

[ Upstream commit 34f4495a7f72895776b81969639f527c99eb12b9 ]

When rocket_core_init() fails (as could be the case with EPROBE_DEFER),
we need to properly unwind by decrementing the counter we just
incremented and if this is the first core we failed to probe, remove the
rocket DRM device with rocket_device_fini() as well. This matches the
logic in rocket_remove(). Failing to properly unwind results in
out-of-bounds accesses.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Link: https://patch.msgid.link/20251215-rocket-error-path-v1-2-eec3bf29dc3b@cherry.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/rocket/rocket_drv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 5c0b63f0a8f00..f6ef4c7aeef11 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+#include "rocket_device.h"
 #include "rocket_drv.h"
 #include "rocket_gem.h"
 #include "rocket_job.h"
@@ -158,6 +159,8 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -177,7 +180,17 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->num_cores++;
 
-	return rocket_core_init(&rdev->cores[core]);
+	ret = rocket_core_init(&rdev->cores[core]);
+	if (ret) {
+		rdev->num_cores--;
+
+		if (rdev->num_cores == 0) {
+			rocket_device_fini(rdev);
+			rdev = NULL;
+		}
+	}
+
+	return ret;
 }
 
 static void rocket_remove(struct platform_device *pdev)
-- 
2.51.0


