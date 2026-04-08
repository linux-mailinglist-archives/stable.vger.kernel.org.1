Return-Path: <stable+bounces-233895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AIaOVtR1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:00:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6293C3BC82C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA6B3303FAC1
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6D13C0639;
	Wed,  8 Apr 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrLRjBXp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC53BF695
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652953; cv=none; b=D3/AYZI1BHc6u501v35D4rx01rAB5X79ii8Vyv05fOGNHOm7ebUG+VsxRIc2piKvk1RyUuYwDe2O67HbfSsDXYzTvgT87qTObg1NArVO3uqK2PLwCsIVFlgC/TzdKLPUrj2l2dLzTaTiW91m7clbEcJfh0puxDLs3NuNmp3ahUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652953; c=relaxed/simple;
	bh=8qc92tFT2FL3hBacxeBHEX4TneVEcEC++KgrOrTjbg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMIwMOOmQwRJRqufiBCvlKDT4tKhgm9JSixf65OuRfhMWc3pRoqHYApzjl+/wVLzk8bioz0GSD8Q+RlxB/SStC/w62nj7QLR+7JzLW4YwMpC2SgfAOLnJcaP0+rS5D+Tbc2tS6kpfX4wcO4HHEtE34AxJlB5TNBqglSQPKoUuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrLRjBXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7BCC2BCB0;
	Wed,  8 Apr 2026 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652953;
	bh=8qc92tFT2FL3hBacxeBHEX4TneVEcEC++KgrOrTjbg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrLRjBXpyxPMlVHDLyNm0kWrVKZKWSZ21PeStGJ3/AtWsKcSWTZPuZgATMqjMQack
	 Npa6ExckLuzjnB5B+KiMjAitbdlH01AhKTPyTCC91Hx1cXCAjeg+bvU0rTCmH8f0O3
	 7VYaHi6kuvIVI6ue2Je/Hiklq3fneZCRJJ7WWOsDpr7kbJFdoiisDw0uwxpwqHbyyr
	 E9QEv32tDlaGP7jhhenUrHfCzTtLSkYh7Ph6yrspUVc3HpAGFxrLyrealOktE9Bn9S
	 nFShjTkt5AtVoTrnWrD0HBRrucdFKAmP8YcIHNd49AnGRGl9HRkruL1tCFderJtAoF
	 iCpJftOYVjoAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path
Date: Wed,  8 Apr 2026 08:55:50 -0400
Message-ID: <20260408125550.1049042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408125550.1049042-1-sashal@kernel.org>
References: <2026040816-flattop-footing-328d@gregkh>
 <20260408125550.1049042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,linaro.org,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233895-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6293C3BC82C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 6dcf9d0064ce2f3e3dfe5755f98b93abe6a98e1e ]

When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
kobject_put(&dbs_data->attr_set.kobj).

The kobject release callback cpufreq_dbs_data_release() calls
gov->exit(dbs_data) and kfree(dbs_data), but the current error path
then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
double free.

Keep the direct kfree(dbs_data) for the gov->init() failure path, but
after kobject_init_and_add() has been called, let kobject_put() handle
the cleanup through cpufreq_dbs_data_release().

Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260401024535.1395801-1-lgs201920130244@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq_governor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 3de5a2ca903ea..76f3fe790f1f8 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -468,13 +468,13 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	/* Failure, so roll back. */
 	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
 
-	kobject_put(&dbs_data->attr_set.kobj);
-
 	policy->governor_data = NULL;
 
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
-	gov->exit(dbs_data);
+
+	kobject_put(&dbs_data->attr_set.kobj);
+	goto free_policy_dbs_info;
 
 free_dbs_data:
 	kfree(dbs_data);
-- 
2.53.0


