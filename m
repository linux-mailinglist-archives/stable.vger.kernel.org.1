Return-Path: <stable+bounces-117427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF54A3B66C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013013BBA19
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042921E32D5;
	Wed, 19 Feb 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jEiIfric"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC7155753;
	Wed, 19 Feb 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955251; cv=none; b=VzOTcmzQaSDr7H2+ZUONsYyTPPRBIiLy5nG2YWZI3efeDq1eLPNbbzpUiHKnBuemQBZx6QujubvROuUmlAmCFvLdV7jRo9xvwA5PlFdlvnwfolYhdXzJpZXoPgBTWyQHBy9R6pHvtnHAay6adAv7lOR47PNHnA2phz8ac0EpHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955251; c=relaxed/simple;
	bh=GgVNu3A8dyLDU5E+U2ZE0JfXVP+rLQHbs1GxOx/eYkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG/szJW94vmwV4nbKb3gyIK4ry7q2D9pHfJT40bZdebSPdnW0oSFuJklbQgjCDw8R2thmbMxPkG/t66meWfmhHksgW2hY3F7+8i4w3J/3vyrbLvXurcEG0zP6mNSzJZLrhfw+mrrO3LD2ks1oJT8sKSLM8OLxAo7I0yqUfev2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jEiIfric; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C39C4CED1;
	Wed, 19 Feb 2025 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955251;
	bh=GgVNu3A8dyLDU5E+U2ZE0JfXVP+rLQHbs1GxOx/eYkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEiIfriczMAMCBGhBM5CBFxUTDgpJ2dckaTr8m/15LClGZP2utPON4AOeFavPGUuL
	 ZCdhqsX0QZKT7qx2Sjw5YiDaBEYyA9YClD+2nHLU5ZlXKqFQ/75a+Sn224fFSlaBzi
	 8JDmeyfPnJ3f01Jtvjomx1mu/QkAzw275Jk0Yjro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 179/230] cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and amd_pstate_epp_offline()
Date: Wed, 19 Feb 2025 09:28:16 +0100
Message-ID: <20250219082608.706756674@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

[ Upstream commit 53ec2101dfede8fecdd240662281a12e537c3411 ]

amd_pstate_epp_offline() is only called from within
amd_pstate_epp_cpu_offline() and doesn't make much sense to have it at all.
Hence, remove it.

Also remove the unncessary debug print in the offline path while at it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20241204144842.164178-6-Dhananjay.Ugwekar@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Stable-dep-of: 3ace20038e19 ("cpufreq/amd-pstate: Fix cpufreq_policy ref counting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4dfe5bdcb2932..145a48fc49034 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1604,11 +1604,14 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
+static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	int min_perf;
 
+	if (cpudata->suspended)
+		return 0;
+
 	min_perf = READ_ONCE(cpudata->lowest_perf);
 
 	mutex_lock(&amd_pstate_limits_lock);
@@ -1617,18 +1620,6 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
 
 	mutex_unlock(&amd_pstate_limits_lock);
-}
-
-static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
-{
-	struct amd_cpudata *cpudata = policy->driver_data;
-
-	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
-
-	if (cpudata->suspended)
-		return 0;
-
-	amd_pstate_epp_offline(policy);
 
 	return 0;
 }
-- 
2.39.5




