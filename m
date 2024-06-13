Return-Path: <stable+bounces-51624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B89070C7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474522848A8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625320ED;
	Thu, 13 Jun 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OxSGLWxk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65BA1EB25;
	Thu, 13 Jun 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281842; cv=none; b=Lt4b10PvX6imfsrE7Tz+KCYDwQMLCGIqaAz0/XBLx1TLAPJMF0ILfLHgn0Q8S0VodT1KcAD+kEN/GwPmS6ctwl4r7KUg9mt1XT6dIgA2/ZwI/ZyOfKuxG63z0qJNaJNYgj6v0NNVncDPwGSL1F5eh1taDSekfFiT8zoSD95B5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281842; c=relaxed/simple;
	bh=HIRkVunJ6kYEXeVyMhRE71LT8pPf+U4aKnpp05V9NVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ls+sam4ZabY2+kiwRmAw+fUHm4QB4J+5XQtqv8bqqvizHyZlmQCLTLl68ncBoJ+alzLCoj9TtVnmGhO0smje+iZszRJm14ciG/cl9oa+WHWYnO+a8tsOrnL4QEq/KUzh2dJ71vo8af+7uveeMnG24b/7ZwqG1xcyWPUOmzbh7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OxSGLWxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A9BC4AF1D;
	Thu, 13 Jun 2024 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281842;
	bh=HIRkVunJ6kYEXeVyMhRE71LT8pPf+U4aKnpp05V9NVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxSGLWxkdh/d0Z7nu3/fnRONy83ZiWrCwwmRRt40B20zTukEVteTeUcb3quKWn4Xh
	 b7NzwsRpDVz/yt0w8PMMaJQVdsK2chSPRi8ckl6mNmUlRaRoWtogN1Hya+XJg+vcSz
	 Rd+S4Ak3+RObOhim2krFGNu6EJ4tG2JGBi6lMRHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/402] cpufreq: Rearrange locking in cpufreq_remove_dev()
Date: Thu, 13 Jun 2024 13:30:31 +0200
Message-ID: <20240613113305.023906506@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit f339f3541701d824a0256ad4bf14c26ceb6d79c3 ]

Currently, cpufreq_remove_dev() invokes the ->exit() driver callback
without holding the policy rwsem which is inconsistent with what
happens if ->exit() is invoked directly from cpufreq_offline().

It also manipulates the real_cpus mask and removes the CPU device
symlink without holding the policy rwsem, but cpufreq_offline() holds
the rwsem around the modifications thereof.

For consistency, modify cpufreq_remove_dev() to hold the policy rwsem
until the ->exit() callback has been called (or it has been determined
that it is not necessary to call it).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Stable-dep-of: b8f85833c057 ("cpufreq: exit() callback is optional")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ce7d718bdfced..a8b469094cd3d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1655,19 +1655,26 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	if (!policy)
 		return;
 
+	down_write(&policy->rwsem);
+
 	if (cpu_online(cpu))
-		cpufreq_offline(cpu);
+		__cpufreq_offline(cpu, policy);
 
 	cpumask_clear_cpu(cpu, policy->real_cpus);
 	remove_cpu_dev_symlink(policy, dev);
 
-	if (cpumask_empty(policy->real_cpus)) {
-		/* We did light-weight exit earlier, do full tear down now */
-		if (cpufreq_driver->offline)
-			cpufreq_driver->exit(policy);
-
-		cpufreq_policy_free(policy);
+	if (!cpumask_empty(policy->real_cpus)) {
+		up_write(&policy->rwsem);
+		return;
 	}
+
+	/* We did light-weight exit earlier, do full tear down now */
+	if (cpufreq_driver->offline)
+		cpufreq_driver->exit(policy);
+
+	up_write(&policy->rwsem);
+
+	cpufreq_policy_free(policy);
 }
 
 /**
-- 
2.43.0




