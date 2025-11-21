Return-Path: <stable+bounces-196522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E8C7AD12
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D30E74E1CEA
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F2C277CB8;
	Fri, 21 Nov 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvXlRDe4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC695286889
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742134; cv=none; b=n/GUJaisGQrZUA5MVfkbsCQq/bd++MOCj9rmZPM6yrR6kDbSLW1VDrGiddIRGr9j0/VuFJmWT6QG0onEqJiaN6wpmLa9IwwoUxkD9OQ1hcJlY0Aei5y9Ga68BJIOolY7IggLN7ScJHU9UJ4u2eMlCeGNqLY79R2nWYfSFPsOCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742134; c=relaxed/simple;
	bh=C9N9r060PujhlvGtHWUgKktJZ0Dykf25kePWPYfKRs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdG9cOkogariMrkSu+UZtJy30DvH9LahLZ47njc8fQVC5s303PVXCx0QOwXMgViwl+dFFRjJKU+yWvKAih/oithHRRIOKA1xpzB43raLC9n8wA9xowhXWfSPhw8fVqI+PnbZkGCMFsaP3+KAlh/E42RjqZgahC2sC9iXabD7mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvXlRDe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8CDC4CEF1;
	Fri, 21 Nov 2025 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742131;
	bh=C9N9r060PujhlvGtHWUgKktJZ0Dykf25kePWPYfKRs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvXlRDe4RMfGp1JmNOF4R+XNGmc8LXVmQZDR0oYqMUTvw2wcxerRf6qg4x4/TqRQd
	 P+2JgGkuExrQ8K24UYksEG7bw977hD6sJgeUibMd8wFT37eod4e9nAJbiLkdSyBMVu
	 WvWCpc6zK9nLvDrpNpQNj7NlYky1QjHsQ0D2MgJvcfo+SlzqCXiurDVNoN+MYqS8X+
	 3iSL3iI6lvhu8mFFMSnFH6GV14rnLOFxYf2k479150PhobG58SxpVIjUJKJkcLFrr1
	 taLC+iyzrOokDEvGJj3gP4Ye4dAYApuh+po3jAQ9+oZR44AANzenXi8v21URmhxnwf
	 2WhzR9lxe05pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Peng Fan <peng.fan@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] pmdomain: arm: scmi: Fix genpd leak on provider registration failure
Date: Fri, 21 Nov 2025 11:22:09 -0500
Message-ID: <20251121162209.2595547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112054-mold-femur-4b46@gregkh>
References: <2025112054-mold-femur-4b46@gregkh>
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
index 0e05a79de82d8..82d923a9d75d7 100644
--- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -54,7 +54,7 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
 
 static int scmi_pm_domain_probe(struct scmi_device *sdev)
 {
-	int num_domains, i;
+	int num_domains, i, ret;
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct scmi_pm_domain *scmi_pd;
@@ -112,9 +112,18 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
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


