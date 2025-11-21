Return-Path: <stable+bounces-196542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E40DEC7B0BF
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E92004EE6B3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA32346A0E;
	Fri, 21 Nov 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANpqiAin"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8BF3370EC
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745368; cv=none; b=kw6uFmtBxyvV0/c2LSHkswHF85X4ZRYBt08p6AvaHPfzYcq1usBOyPqGgZRKlUrLrCLJG8YgCbtdGwVUdrgPxoo25MZnUf1qFIALh5QJeJR9W8p2ZJ2foKc39S9BTYygAtp8LO8KO5e2m/AHwufg8EZ5kxsz7Dt1thVxSr0oIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745368; c=relaxed/simple;
	bh=irm1EkUbl/XuRAs0eIMvWECj3M9YrpXy8luCaIfPAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffyTudLPg2FLUcpqEb+B1jdVe8i68zs280204gDngcVpBErr1UX2V21pEYp3OEGW9Zesv+PDvV6/6xs8C71uYttt10wPHcY6Prc7NtA9RszaeAMo6IVP6A27gPlGCk0rlIwoLniIwDyPK3Ng2DeAx1lJLgbb5tRxiI4V+bvo8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANpqiAin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814B3C116C6;
	Fri, 21 Nov 2025 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763745368;
	bh=irm1EkUbl/XuRAs0eIMvWECj3M9YrpXy8luCaIfPAeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANpqiAinDn4vk01Lg7hP1SUQLyqIlWjutakS1h68FQb3Mmp0q069yiMqQ5xM/4WDX
	 8/Nv/Mpz+tr9jgXV973Foi/JYx1S0Ig7lb86XvglIDpqPa2W7uaRnnd8MfcHDqueug
	 wLs7lcUURHPAqUBgb8qJXCG7WTWmSCwKcHmKrdtZwFH3wMNTQK43K7tQWeO92cUoeW
	 JYjUiObUhNyUwr3v4e/RYYbT5yiQgMZjsq28K8u/YB3nmu40waG1yKMmThGTixWpoC
	 F8OfeMu/7jHudhQnHjAx2rB8ZqMPX/lwFIRbbvUOAST5oR3rG2x1EisCBt7ZalrPW3
	 zSmKHjnofUbyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Peng Fan <peng.fan@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] pmdomain: arm: scmi: Fix genpd leak on provider registration failure
Date: Fri, 21 Nov 2025 12:16:05 -0500
Message-ID: <20251121171605.2611489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112055-muzzle-swimwear-7693@gregkh>
References: <2025112055-muzzle-swimwear-7693@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 7458f72cc28f9eb0de811effcb5376d0ec19094a ]

If of_genpd_add_provider_onecell() fails during probe, the previously
created generic power domains are not removed, leading to a memory leak
and potential kernel crash later in genpd_debug_add().

Add proper error handling to unwind the initialized domains before
returning from probe to ensure all resources are correctly released on
failure.

Example crash trace observed without this fix:

  | Unable to handle kernel paging request at virtual address fffffffffffffc70
  | CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc1 #405 PREEMPT
  | Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform
  | pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  | pc : genpd_debug_add+0x2c/0x160
  | lr : genpd_debug_init+0x74/0x98
  | Call trace:
  |  genpd_debug_add+0x2c/0x160 (P)
  |  genpd_debug_init+0x74/0x98
  |  do_one_initcall+0xd0/0x2d8
  |  do_initcall_level+0xa0/0x140
  |  do_initcalls+0x60/0xa8
  |  do_basic_setup+0x28/0x40
  |  kernel_init_freeable+0xe8/0x170
  |  kernel_init+0x2c/0x140
  |  ret_from_fork+0x10/0x20

Fixes: 898216c97ed2 ("firmware: arm_scmi: add device power domain support using genpd")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ drivers/pmdomain/arm/scmi_pm_domain.c -> drivers/firmware/arm_scmi/scmi_pm_domain.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/scmi_pm_domain.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
index b0c8962b98854..5a9794bbe2c2e 100644
--- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -53,7 +53,7 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
 
 static int scmi_pm_domain_probe(struct scmi_device *sdev)
 {
-	int num_domains, i;
+	int num_domains, i, ret;
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct scmi_pm_domain *scmi_pd;
@@ -106,9 +106,18 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 	scmi_pd_data->domains = domains;
 	scmi_pd_data->num_domains = num_domains;
 
+	ret = of_genpd_add_provider_onecell(np, scmi_pd_data);
+	if (ret)
+		goto err_rm_genpds;
+
 	dev_set_drvdata(dev, scmi_pd_data);
 
-	return of_genpd_add_provider_onecell(np, scmi_pd_data);
+	return 0;
+err_rm_genpds:
+	for (i = num_domains - 1; i >= 0; i--)
+		pm_genpd_remove(domains[i]);
+
+	return ret;
 }
 
 static void scmi_pm_domain_remove(struct scmi_device *sdev)
-- 
2.51.0


