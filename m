Return-Path: <stable+bounces-33583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4F891DB4
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529451F2AA6F
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE029D3BA;
	Fri, 29 Mar 2024 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuPeWIlz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235C29D3B4;
	Fri, 29 Mar 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716414; cv=none; b=Cu1X53gnhwJ7PW9YHSuELHeMZN2p3IWJiDuyMOVlJqlMG/pWQE/5TbOO41fWHb2k/kDyDg5zPGlrY5sq0v3b1AcDQ/LTGOD/ZMWh/tHl39+M9Ri9+/T3nyxsyiOjE/+3I0EfQI2fy+zZR25Y3JI0yYLsf2cuZJZL61DRoh83F28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716414; c=relaxed/simple;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyktluIAmQe5K+dz1KYs1avj5Nw/ifBHHln7Q1zCQV9rsSgOEPNljjbqeeL7T28GtMrPXlB+Cv5BgUB997oV3xDE8fdzo3qIhPvEzRzGpm1yNOwqfWzHIRNhentphfCG3bJMF4WW63Dt9HgCfORvg6kn1UnhfLgoOJMS13IhCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuPeWIlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436C6C43399;
	Fri, 29 Mar 2024 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716413;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuPeWIlzK2Gc0hNLQpWZ4qEgDGiaKRULgs051p2Qt6baqJ5qQtLa8ggEcta6xa4CE
	 qo6xYErVpcIP9grADxMzjAZzcDTMoZOuhz2k5vZJYGdUEWLzZbrR8Cb3IYDBC5KkEm
	 a9V8c96Nl1B84UZLw/NN6m32teTAmKF48XGj1PlHfGvab1VA0pJzfdKpwRXtLj5Yi6
	 XgSwEXmZehq84Kkg+dV8TLW9a+2AnYY32GtQYY3lH43ObQUO2ACjZjJbep6zk9gspt
	 tNRRwMO9iA0Pno/UEQSILJtuIAfHHajEVEUIu9pJU/IIBH4N0ICHAviSlzrNXT/pp5
	 3k9FByO3TRuzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 26/52] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:45:20 -0400
Message-ID: <20240329124605.3091273-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

[ Upstream commit f85450f134f0b4ca7e042dc3dc89155656a2299d ]

In function get_pkg_num() if fopen_or_die() succeeds it returns a file
pointer to be used. But fclose() is never called before returning from
the function.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5fd9e594079cf..ebda9c366b2ba 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1241,6 +1241,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.43.0


