Return-Path: <stable+bounces-235249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI5zDYum1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:03:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DE03C24B1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B673039CC3
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7561A3D8139;
	Wed,  8 Apr 2026 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fbjs8Iop"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385981A683C;
	Wed,  8 Apr 2026 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674954; cv=none; b=pqa6SQbvEEN2CMtVn6N/YjEZQPE7aKfWWmoxcSkkr2SzoJYSHM5nrVhitTcwppUo87QTGapvnx7lHHpNTsLtBj6R3QBVTv/aXFYx1FpdGtdeYjzs00W6adiJ6cZF8YphoPzzKzidL9jjhg3s01aSJ1vhHr+AW2D+hzUaGp/dLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674954; c=relaxed/simple;
	bh=utLumobUo32HvzDUF8ManzZuO3OJOst8tltMFJ0DiOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyyYNPV+89+kOl0jebQXxNz9aNn8dbYdC8gkhjK6FPzj4Kgo3ybmFwx0sfJtUMDqPNm4NfY/YiSEr+Bh5dAiSWHlmarDQvrRPPtMvPMgQAnP2ImhBcOzvsE3ACLO0tTUCxExYCXFABFXtZzkcFwfRVwZuYjj+n4AepNnNPF8G88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fbjs8Iop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEE1C2BC87;
	Wed,  8 Apr 2026 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674953;
	bh=utLumobUo32HvzDUF8ManzZuO3OJOst8tltMFJ0DiOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbjs8IopOrxCE7FpDkGmJX4zP9eeRl8T00kMRkVv/0pNSAwPj1G8vb60whW3Mj6Gv
	 R0lfIVpgFUq+drthSgBECRKOy4UaxzAZeLXd7fKWor1FcBagDG73r3WG0TlrcAlwKl
	 NzKqrs10nTaRGy5Tbu1Vy06Bh1ejN9BNrHg06ZEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.19 280/311] cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path
Date: Wed,  8 Apr 2026 20:04:40 +0200
Message-ID: <20260408175949.835204232@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,linaro.org,intel.com];
	TAGGED_FROM(0.00)[bounces-235249-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,linaro.org:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2DE03C24B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangshuo Li <lgs201920130244@gmail.com>

commit 6dcf9d0064ce2f3e3dfe5755f98b93abe6a98e1e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq_governor.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -468,13 +468,13 @@ int cpufreq_dbs_governor_init(struct cpu
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



