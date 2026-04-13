Return-Path: <stable+bounces-237582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ep0KAco3WmVaQkAu9opvQ
	(envelope-from <stable+bounces-237582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:29:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F345E3F1791
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37DCC312F3EF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394932F765;
	Mon, 13 Apr 2026 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H3eagT7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C67302146;
	Mon, 13 Apr 2026 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099829; cv=none; b=hOrHv2LuBnyMNAyR2NzcpYDSrICkhP9LlWcpBbIvcUZxUniYlutjB5IsfELWj47lOgeKqv0ejhvFSBCULwzZtkxgFjvRRlH2RbO9M44ejYTlFL7B6OeSuSKhMp+tcbWaWUeykAVYsXq7A795J+6i9/DKJ2eEwf9xV84nWR1M/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099829; c=relaxed/simple;
	bh=nwcDRFYt3iespTsLJVd49WMVc5n9Shur/oYaWc9dljI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxSJr2jKWIeigEJ2BKasEu3SqaIeavzveawkFYTWs58/Ape5zNNHfoAC1buGD1Jzhsp500dxGYU5YL+Zh+UThpQPqnmpD7ndwbxulautfAupyGvY5i2EdwjCLrtmFAGWEv1FlD6+66znTzAo1zTz5hsIBwO0CK4ZL8JP4ppTMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H3eagT7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9418C2BCAF;
	Mon, 13 Apr 2026 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099829;
	bh=nwcDRFYt3iespTsLJVd49WMVc5n9Shur/oYaWc9dljI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3eagT7qdsDiLVdKZ57ObooTYPzQOynH832xoiQtblS4O/bdK6wYVPHdGa7WCydcm
	 VZkdOBgagcctQfxzX0r838mFNiHIbbIYCqIqQlgM0aAI0HD8jgW1iWykeMjz5DoRU2
	 76Um3pH6nU2BIzAZWodt4XervUIQw+YfmsE+ynq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 458/491] cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path
Date: Mon, 13 Apr 2026 18:01:43 +0200
Message-ID: <20260413155836.182759221@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,linaro.org,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-237582-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linaro.org:email]
X-Rspamd-Queue-Id: F345E3F1791
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq_governor.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -457,13 +457,13 @@ int cpufreq_dbs_governor_init(struct cpu
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



