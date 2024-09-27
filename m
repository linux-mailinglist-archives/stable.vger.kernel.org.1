Return-Path: <stable+bounces-78027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C009884BA
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2115A1F22944
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217BF1802AB;
	Fri, 27 Sep 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aTxd/kYD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44393C3C;
	Fri, 27 Sep 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440220; cv=none; b=o9DJRWTKNNfr55DF1pQilgLdutrslL3/dAQGAMpQR3ImjO3LosYew4pbDScXemFYQtveQ0qTr9Lv8L8RsdeksgI1uhBS/Hb4WKt6mFgWiNEIVZKZYf6dKle/+32tTsEskWd+1m2JibS5UJqffqUO8H5mKa49k6cxjV1Nja92L04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440220; c=relaxed/simple;
	bh=wwXpkahE1se0ITZQiKkjM3/p1KshPmqJv/170WYS6mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr+/1HxlIKfLsLgDksbFzlsd+/NPMBUKlWhC+VfjsHFYzD3bl32S+gyuPUsmgPsFw7YKOCIgwumBdcva8UWZzjOOf0mGqB8rCwhVzfryBB0EmM+CpFbaNaXxxoWpz3G2hAQTfj3n3J6fI56zFmPgFMi9CSs0mVINFIxKrJBtgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aTxd/kYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7C3C4CEC6;
	Fri, 27 Sep 2024 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440220;
	bh=wwXpkahE1se0ITZQiKkjM3/p1KshPmqJv/170WYS6mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTxd/kYDHykofj5Y3l2cXGVBEEl0xiuHxE9ySfnTJIm2iT+Nxty1ltXi9dsw+lrmp
	 PT9zaU26vmq/d1aobptJEVKzKuONnr0NpiVTozJgHADSZ9YCr5ZLge/KpIgSPuurnF
	 KQhh15oFaC1KhAdgy6Pu8r3X9d2T78sH2exEnm5Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 06/12] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Date: Fri, 27 Sep 2024 14:24:09 +0200
Message-ID: <20240927121715.501920915@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
References: <20240927121715.213013166@linuxfoundation.org>
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

From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

[ Upstream commit 49243adc715e6ae34d6cc003827e63bcf5b3a21d ]

Fix the reference counting of cpufreq_policy object in amd_pstate_update()
function by adding the missing cpufreq_cpu_put().

Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 259a917da75f3..073ca9caf52ac 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -554,12 +554,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	}
 
 	if (value == prev)
-		return;
+		goto cpufreq_policy_put;
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	amd_pstate_update_perf(cpudata, min_perf, des_perf,
 			       max_perf, fast_switch);
+
+cpufreq_policy_put:
+	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_verify(struct cpufreq_policy_data *policy)
-- 
2.43.0




