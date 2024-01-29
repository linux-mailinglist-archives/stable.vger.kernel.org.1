Return-Path: <stable+bounces-16862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05044840EB7
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AC828325F
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42B16086C;
	Mon, 29 Jan 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zzGKNXDK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C9157053;
	Mon, 29 Jan 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548334; cv=none; b=etSmE18/Z6znhX1geEAaTDqSA8G7XPOAwPvWjiKuA/bF5I7Ut1dIilqeTpCAdOxkBU+Hrr6QLexomIKlZqBug8uOssCwIoYWnfVNpmKO2/PK7F4EiLc2GAOZ0Q5XKIAluMXlMHZHyy/FdH35aS6EmYEnFK3mSGsuy12fjJVzrMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548334; c=relaxed/simple;
	bh=KBRJkM3whjZnioPPguhPKC77DqjcGUrFWw0Qlmi0Ejg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEt1F1tbPIt8FDYWAQmBzlB6IEvyu6r2rZjGCYT9jWFVaQT4tCeHrEJt/azV0POqGvIcjQ+Iww+M6vI2pBq13Ay2tTRopvDa3z/ZhFceL7by1Mu77VMB/mIw6ujvjT1M1VC5TntWmhj66t0r6sF7CLydn82g6ZZceH0PC/5bwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zzGKNXDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DF4C433F1;
	Mon, 29 Jan 2024 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548334;
	bh=KBRJkM3whjZnioPPguhPKC77DqjcGUrFWw0Qlmi0Ejg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zzGKNXDKVASTMa+xvM53VvDxew7nK36z8VwoeeGdtdtEey+cO6ygKJJ/DcLVCXlaB
	 gJI69kMgmpX76bUO7lgKf15fwNRSNTWlT/F5tXfuzfzEgU8wTl3daeoYOKxVIepgJ2
	 Rl39mGSmGI6s/ajT6QT5RscvV/YmSR6rYXNskLns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Wyes Karny <wkarny@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 331/346] cpufreq/amd-pstate: Fix setting scaling max/min freq values
Date: Mon, 29 Jan 2024 09:06:02 -0800
Message-ID: <20240129170026.213252452@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 22fb4f041999f5f16ecbda15a2859b4ef4cbf47e ]

Scaling min/max freq values were being cached and lagging a setting
each time.  Fix the ordering of the clamp call to ensure they work.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Fixes: febab20caeba ("cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wkarny@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1f6186475715..1791d37fbc53 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1232,14 +1232,13 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
 	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
 
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
+
 	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
 			cpudata->max_limit_perf);
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
 			cpudata->max_limit_perf);
-
-	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
-	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
-
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-- 
2.43.0




