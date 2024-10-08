Return-Path: <stable+bounces-82224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4501E994BBC
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636571C24E96
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100B1DE8B1;
	Tue,  8 Oct 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uHALNdAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F01DE3A3;
	Tue,  8 Oct 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391554; cv=none; b=iDomwd6SxfW0FAlleWwYI0LhPCuOHzS+PzK6miZ9Io66kxH6K7+CzsEl11noHaItuqAM7mR+AdFF36v8NaH49tLbhBHmJOcuu7rLArfL4+LgVJcC44Uxit6Cny7I/VKfZmmJksdOkUmN5PVpHe/uwpLqwaMsPgfMi8GzMlQkP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391554; c=relaxed/simple;
	bh=6EYmzzVjqmzlFG5bnyWXOMKMdiI5TOC40t4OKpInJ8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdcSnOvMtwkKGOPRl1z+K4IvBAfRc2mIWYc0ktp2+OaJ+RKLuk/8hHqY8YWGnPUMst6h2NTYFl8REzswcq8pU3K0ksdbqnJEb5g7ZuOax6Xd9Xjb8X/b3Jm/mDbWTlw2v+oGXFVUMsGO+hCSbYeIU6BKnKrLzIso/Gwen3z24T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uHALNdAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B881DC4CECD;
	Tue,  8 Oct 2024 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391554;
	bh=6EYmzzVjqmzlFG5bnyWXOMKMdiI5TOC40t4OKpInJ8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHALNdAYnBp/Nmd2saY0khpZg2KqZqWPGcn3/bmBNttYqkRkP0Isw8MD0LxsbXzys
	 GFQIIHPr4auuF+JHCDUOywEE5u/xnYPVwPEKYlSCWU4qUdd+oXpJuDJBdf/8zGvSLP
	 l3RQQlPb5d+vXU0gh09B3POEq4SddA2AyJ7Y6nu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anastasia Belova <abelova@astralinux.ru>,
	Perry Yuan <perry.yuan@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 151/558] cpufreq: amd-pstate: add check for cpufreq_cpu_gets return value
Date: Tue,  8 Oct 2024 14:03:01 +0200
Message-ID: <20241008115708.304917735@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anastasia Belova <abelova@astralinux.ru>

[ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 073ca9caf52ac..589fde37ccd7a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -659,7 +659,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	unsigned long max_perf, min_perf, des_perf,
 		      cap_perf, lowest_nonlinear_perf;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
+
+	if (!policy)
+		return;
+
+	cpudata = policy->driver_data;
 
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
@@ -873,11 +878,16 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 static void amd_pstate_update_limits(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
 	u32 prev_high = 0, cur_high = 0;
 	int ret;
 	bool highest_perf_changed = false;
 
+	if (!policy)
+		return;
+
+	cpudata = policy->driver_data;
+
 	mutex_lock(&amd_pstate_driver_lock);
 	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
 		goto free_cpufreq_put;
-- 
2.43.0




