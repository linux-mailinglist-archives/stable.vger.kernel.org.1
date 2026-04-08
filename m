Return-Path: <stable+bounces-233787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKCzIMr91Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:03:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D33B7D54
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC90F302D944
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689D036F415;
	Wed,  8 Apr 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vzW4r/yd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92B3624B0
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631627; cv=none; b=rUbLfJoCCVpZTa4cXfK6sxpeq9yjL5k/64NYWHk6pavtmA1qDiBtM9RTKcFjjk2swYSN3JPw3C3YPLKtSMvERSyKIqsk1Nxf8MhH28Fb7KunX+46s/DMRDAZG65zjRzdbbQdOt1SXfSqhQla8V5JMC+UEzcsV1f6p6z+1+b+f5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631627; c=relaxed/simple;
	bh=T8hFOWAxWuASiKQKd5iMJLHzixkHJBjxLbMouM9tmeU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jentsGVQ+ovW2N9zruK3UTFGBZs3EekaWOubfR+AnDuNXEeAnUfauYEBJYM+FGbA6un3Ngwh+KAPJTxIeOsM5ChwZHJye7P3w26Jyjwg7z0AaJ5e7mflEE/7XirIGHwUPNqmi6KzrPtQGWGeUtujsGiTfa9+MyaVl5Mo3JtDz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vzW4r/yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A17C19424;
	Wed,  8 Apr 2026 07:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775631627;
	bh=T8hFOWAxWuASiKQKd5iMJLHzixkHJBjxLbMouM9tmeU=;
	h=Subject:To:Cc:From:Date:From;
	b=vzW4r/ydObHYORw++09e9PxfrQqJL1OoS3+BxXX74k3eYT1ZR8y1fVFg4Sf/jG5Wl
	 BLU/O2OJOvjRmow3ZNKl3DrvtWsPo1rTw2QlaTV+5m+FAEnUaUgDEntsHpzftgPreS
	 3Vghq5VVSTZ/H2WqH0y/sAoyAU9HUeXnJLVftN7c=
Subject: FAILED: patch "[PATCH] cpufreq: governor: fix double free in" failed to apply to 5.15-stable tree
To: lgs201920130244@gmail.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org,viresh.kumar@linaro.org,zhongqiu.han@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 09:00:16 +0200
Message-ID: <2026040816-flattop-footing-328d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233787-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,vger.kernel.org,linaro.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,gregkh:email,msgid.link:url,linaro.org:email,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D0D33B7D54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6dcf9d0064ce2f3e3dfe5755f98b93abe6a98e1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040816-flattop-footing-328d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6dcf9d0064ce2f3e3dfe5755f98b93abe6a98e1e Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 1 Apr 2026 10:45:35 +0800
Subject: [PATCH] cpufreq: governor: fix double free in
 cpufreq_dbs_governor_init() error path

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

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index acf101878733..86f35e451914 100644
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


