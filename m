Return-Path: <stable+bounces-123587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F6A5C62C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F207A1665EC
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027725E473;
	Tue, 11 Mar 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qXj4mcvX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95D1684AC;
	Tue, 11 Mar 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706386; cv=none; b=WsLUghEMVXKRDqFmLvmpPLHtGmv9BPidO2iIiKLT8lyd+yfD565UVHlTYnXpUDwP+R2LrUIPIIfOJOLXIclrFqRl37JGYgSoE/yJaAcXSDqXYiR3jwy7vv8TuJxfG6eumTfhJFX8AnJDuG5HNYbB6irWKtMslAsd2n/lQ/dtBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706386; c=relaxed/simple;
	bh=omAiMqsqypSDnXMBuq47weAXDXvyP0mYPu5geSy7sRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfjTLZzBvYoYuYUGgDnuhLS1cdek0v/u3X7oyIbGwRT/a44Hv7HaZM8w6Kgrx9YJahGdWlXDxL9pbjnqJBLd4kNwZamWwhpbCjRBR+ASNpZ8sXEDHKZZ7+vCL+uJoWkoHnJcps0JHu8YiXqIZ9w2w/0tp1LXJX0UBvLyHpB08pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qXj4mcvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379A0C4CEE9;
	Tue, 11 Mar 2025 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706386;
	bh=omAiMqsqypSDnXMBuq47weAXDXvyP0mYPu5geSy7sRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXj4mcvXNoycL91nRI8lic230eTy70qcDgsCfvqqTrpwMRQ6Ki8W3GGB+ccC39VHk
	 mT7fDBdxmXwXC/KIv2a9rTvJ5c9EgfcYa98yzGIVCZVEOzzMtxcGY1hYMpCMEQ9v8R
	 xvJmOmtmYttacSAMb6X2mpI8oBdH8pMuqHha0CyU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/462] cpufreq: schedutil: Simplify sugov_update_next_freq()
Date: Tue, 11 Mar 2025 15:54:56 +0100
Message-ID: <20250311145759.543560986@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 90ac908a418b836427d6eaf84fbc5062881747fd ]

Rearrange a conditional to make it more straightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Stable-dep-of: 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused by need_freq_update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5e39da0ae0868..04295212ab500 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -102,12 +102,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (!sg_policy->need_freq_update) {
-		if (sg_policy->next_freq == next_freq)
-			return false;
-	} else {
+	if (sg_policy->need_freq_update)
 		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
-	}
+	else if (sg_policy->next_freq == next_freq)
+		return false;
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
-- 
2.39.5




