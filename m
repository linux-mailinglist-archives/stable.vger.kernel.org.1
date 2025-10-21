Return-Path: <stable+bounces-188418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B43BF83B5
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC14B18A630B
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA59351FA3;
	Tue, 21 Oct 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5zOh/7E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE93338903
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074549; cv=none; b=qIV+tWlwZQvESjoyoFmCmISOH+gz60xlIgPmrfmKXZrcz02MGoYdDcy4Ug4AvOztLrgLxbxmSnADmaAcu3VJ8IoyJOQsLl48IDL+3t4U+7a+FTPDnJlPmw4eUvNMonDAqtmEy1pAdslKt6LeF8ksECGt0PFRLlxBtmBEIZ8ET0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074549; c=relaxed/simple;
	bh=DhWGbXpcQsDGBV9OTPi/NogQqjCF+SH5WMqlYI6HC54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcXOGFQ38vQL13Zc4vyEJsH8VRPYnQkizDRoHdhsb0a3KV0VlhiwjEtwieLK/7LGiNqKfi9i47diwuCPxUXjkukIzbl+UeHLKiW+K6wsz+v7wa1+QtEbP1/JI1RZbPCADvBxDiQIGg5fgJBw2rCptVXoRlgHPV7LCbWrxxQuGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5zOh/7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382C9C4CEF5;
	Tue, 21 Oct 2025 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761074548;
	bh=DhWGbXpcQsDGBV9OTPi/NogQqjCF+SH5WMqlYI6HC54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5zOh/7EritYdeVs2dbGnEf8/W7HbieAAeMQeassc7N+hdXMsOjtLah6BxtMyBDts
	 f9vDpA3Qei5KD2OWD/h8eeuJ0V8fYOQZnCfwiOycSiVBNxSeQMfge72BHXjZCtRLpV
	 WMoaQjYlQuIksB7Zbtk+DOJFFNye4kXE4e7OURtanOqKh7kJF6LfVEuVkaJDRaF0T3
	 JBoe1KhRqQ9DKFLivolu50VT7gqLqFqdmdNYudTaSeRGmjZ8nCGHB9Ids3z4mvVKOo
	 g5OBWObYKAP8IVfs5KbBSJclSF4sfkJI6HPQeYFsDNYYdoLsRjAsiOJ+DykfD1qLFU
	 qKof8+a7q1FyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] PM: EM: Slightly reduce em_check_capacity_update() overhead
Date: Tue, 21 Oct 2025 15:22:23 -0400
Message-ID: <20251021192225.2899605-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021192225.2899605-1-sashal@kernel.org>
References: <2025101616-gigahertz-profane-b22c@gregkh>
 <20251021192225.2899605-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit a8e62726ac0dd7b610c87ba1a938a5a9091c34df ]

Every iteration of the loop over all possible CPUs in
em_check_capacity_update() causes get_cpu_device() to be called twice
for the same CPU, once indirectly via em_cpu_get() and once directly.

Get rid of the indirect get_cpu_device() call by moving the direct
invocation of it earlier and using em_pd_get() instead of em_cpu_get()
to get a pd pointer for the dev one returned by it.

This also exposes the fact that dev is needed to get a pd, so the code
becomes somewhat easier to follow after it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/1925950.tdWV9SEqCh@rjwysocki.net
Stable-dep-of: 1ebe8f7e7825 ("PM: EM: Fix late boot with holes in CPU topology")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/energy_model.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 8ee72c6c1daf3..a035b030ff734 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -769,7 +769,8 @@ static void em_check_capacity_update(void)
 		}
 		cpufreq_cpu_put(policy);
 
-		pd = em_cpu_get(cpu);
+		dev = get_cpu_device(cpu);
+		pd = em_pd_get(dev);
 		if (!pd || em_is_artificial(pd))
 			continue;
 
@@ -793,7 +794,6 @@ static void em_check_capacity_update(void)
 		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
 			 cpu, cpu_capacity, em_max_perf);
 
-		dev = get_cpu_device(cpu);
 		em_adjust_new_capacity(dev, pd);
 	}
 
-- 
2.51.0


