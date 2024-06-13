Return-Path: <stable+bounces-51285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B16906F29
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880F61C235F1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21D14431C;
	Thu, 13 Jun 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KKM8HE/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233056458;
	Thu, 13 Jun 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280850; cv=none; b=PGGvz6oQNOvNimY+C1A+Pcsg+8Ycw6y/90PJJ0zyeY63Z6il+00zVvPP4WOZzi9JflSRi/phhAD+EyGvTIfkXIF1s9hBCrGvwiSMo29MXG2cl9ltaeD8vk6fTDlfvzZll3G5D/bv/YY0jo9f904UC4C18zNlass4pFlGkSLjHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280850; c=relaxed/simple;
	bh=+CouxHvetALSWOGNXZmsI2e5a7OTkaHGjKWHtU+oA1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtRWQhR3qNzUbwaHOphPHWSHcUCMG/ElGj8DUDb1TvsrAHlC1JMDlCIEhWTq4hqv8WHJIpnMIW5KVQ/sKZUqlwzv2sMEfsbV+ejonDHQZFz+FI1nVUQIvwEt/EsCyO3JF4B7ZpbLIAALwhKVkKQOLio7ID/ADnPoYknhBwX/zR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KKM8HE/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4FDC2BBFC;
	Thu, 13 Jun 2024 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280850;
	bh=+CouxHvetALSWOGNXZmsI2e5a7OTkaHGjKWHtU+oA1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKM8HE/UoUpv8D0ksxNVGMuffeTHl/yYIKd033tAlQryoV527AWWhieRSWBDACMii
	 d9Re8vNIzbWFLIXGF52snxcAc1tMDOLvzm4x25q5LDOXEl/Zzt3RN7E92i6rIQjpON
	 G3/hvQJMtf9NKwdfSJ+o29CEI2ezTZWOWivnZwoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lizhe <sensor1010@163.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 055/317] cpufreq: exit() callback is optional
Date: Thu, 13 Jun 2024 13:31:13 +0200
Message-ID: <20240613113249.676338626@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit b8f85833c05730d631576008daaa34096bc7f3ce ]

The exit() callback is optional and shouldn't be called without checking
a valid pointer first.

Also, we must clear freq_table pointer even if the exit() callback isn't
present.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Fixes: 91a12e91dc39 ("cpufreq: Allow light-weight tear down and bring up of CPUs")
Fixes: f339f3541701 ("cpufreq: Rearrange locking in cpufreq_remove_dev()")
Reported-by: Lizhe <sensor1010@163.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cbdea4fa600ab..162de402b1134 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1606,10 +1606,13 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	 */
 	if (cpufreq_driver->offline) {
 		cpufreq_driver->offline(policy);
-	} else if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
+		return;
 	}
+
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	policy->freq_table = NULL;
 }
 
 static int cpufreq_offline(unsigned int cpu)
@@ -1659,7 +1662,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	/* We did light-weight exit earlier, do full tear down now */
-	if (cpufreq_driver->offline)
+	if (cpufreq_driver->offline && cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
 	up_write(&policy->rwsem);
-- 
2.43.0




