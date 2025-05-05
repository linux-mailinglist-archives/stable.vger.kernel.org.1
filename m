Return-Path: <stable+bounces-140156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B8AAA5AF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8D618845C4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95703290DAA;
	Mon,  5 May 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STL6I8Wb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122E290DA0;
	Mon,  5 May 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484247; cv=none; b=Tq8+9pb7wZTUU36MbvOmVSqQ73r5vqlhP6V+POTXY6J/2JnekZ2bVKqypmED4r07bVTbXpXeDUr6ihODxtaZuRE6EvzRIpDFJHmtQPpt3h6IkYkFkYZlkKngSwGLhiHhIdY3Odtjf81RLmmC4lkuoGrnbZe3jKJ14W27+4KEf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484247; c=relaxed/simple;
	bh=NrinHYX4PH31v6qA5R1I34ocHc3zepB7/N6RwLwUcb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJyMh8ooPzxTX00UThB0q9ktd/zqU65S3hKQalSRaUX/4el2YJJlI82KfTo3LqXMScWotXeLyWQG2RyFyBz1R56Tej4I7uwVewIkqMJRIqREQJhxnZoZsJmCsAFiUwMb+F/06aJpOBxLIQpdLsbO8QZMiJvvZYlp573y7AbADSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STL6I8Wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6C7C4CEED;
	Mon,  5 May 2025 22:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484246;
	bh=NrinHYX4PH31v6qA5R1I34ocHc3zepB7/N6RwLwUcb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STL6I8WbMrdHtpDKVZ6rl8ZWuJGf8XlGv3wbgOZ+kvb+pZF8qiBl2mJniJcZxnsIU
	 T+57ru3A/1lJJuMJzrhw+ubjofPdAIiDn9GKHuYyT58wprhndJnYGi9cU/3vxZXfAZ
	 hQmlw+TPaoyu8MiAAe7/dGlnU94P3scoRcXxpZJnrYl6m0eeVo2MltyYKStfxONHBd
	 vae+NFhINlimdlGQTkJa2114Zp9ZHR2VjJREBmK4Hh+Z0ySX+Yuf64QOzuTSMkBWmL
	 xLJpjeIHDtC3VQQATjJKBBbHrzefeZyi6WRXSU/oP1PaOnxRRMcQ3MIq6C8++acuhx
	 VzFN7ByzOv0Rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 409/642] firmware: arm_ffa: Reject higher major version as incompatible
Date: Mon,  5 May 2025 18:10:25 -0400
Message-Id: <20250505221419.2672473-409-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit efff6a7f16b34fd902f342b58bd8bafc2d6f2fd1 ]

When the firmware compatibility was handled previously in the commit
8e3f9da608f1 ("firmware: arm_ffa: Handle compatibility with different firmware versions"),
we only addressed firmware versions that have higher minor versions
compared to the driver version which is should be considered compatible
unless the firmware returns NOT_SUPPORTED.

However, if the firmware reports higher major version than the driver
supported, we need to reject it. If the firmware can work in a compatible
mode with the driver requested version, it must return the same major
version as requested.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <20250217-ffa_updates-v3-12-bd1d9de615e7@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 655672a880959..f14aedde365bd 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -150,6 +150,14 @@ static int ffa_version_check(u32 *version)
 		return -EOPNOTSUPP;
 	}
 
+	if (FFA_MAJOR_VERSION(ver.a0) > FFA_MAJOR_VERSION(FFA_DRIVER_VERSION)) {
+		pr_err("Incompatible v%d.%d! Latest supported v%d.%d\n",
+		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
+		       FFA_MAJOR_VERSION(FFA_DRIVER_VERSION),
+		       FFA_MINOR_VERSION(FFA_DRIVER_VERSION));
+		return -EINVAL;
+	}
+
 	if (ver.a0 < FFA_MIN_VERSION) {
 		pr_err("Incompatible v%d.%d! Earliest supported v%d.%d\n",
 		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
-- 
2.39.5


