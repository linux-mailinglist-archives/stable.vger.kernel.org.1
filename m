Return-Path: <stable+bounces-233897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMb4KzpT1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:08:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8233BC945
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45E88306C87A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897AD3C9EEE;
	Wed,  8 Apr 2026 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js9OuNWy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F73C9EC7
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653325; cv=none; b=EXhIAMbSdNQPzP/9XAagvrxl/DbpDcmYVX/HXHmR/WDBCNBOmGhkgRQjoDfK4fyFOHIVub9oZGo5fuMGl/ZqOegu8dbiOV6HfxnYH8I0gat5/4mtRaA2zlzWB1ojnPHMUeHnel0yJDRyk2QGN0SUi5ugpnBbvhB3XICDk3sF+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653325; c=relaxed/simple;
	bh=JMzA79DqBthvUMCgoVidnWVCb6W5OXwkegDl/6f8kJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1GlOhs/LB/OOTUVg7q6psVGSBF8o8Zgw6PeuNSAxHddnvShAoZFUjrwo8NNv/3NKfG7dBtGjmXoniUMUmX4D8SwTURNQBiYkpyHgZJQcmoYlWh+s5lT/Fl1MGQz5imvPkBFNfZ9jh8X7u/m+f66FGkPrhNUq/E7hdOAET1cynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js9OuNWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264DAC19421;
	Wed,  8 Apr 2026 13:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775653324;
	bh=JMzA79DqBthvUMCgoVidnWVCb6W5OXwkegDl/6f8kJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Js9OuNWyDXyLxLmmjUiIi5w0hi3HvGj8ezXRLlPIHiQ1z0VNrq5meUy4QlZAkrjPn
	 r04jQywtcV07pXWxAjosW/sk/5KG+Yz1uVp4SikDRSjHrvpiPy7OMlSqgDchnmXRLz
	 9tMXapjLCZXMxnTvNKrij7p9z7WmmkHZT8PLaerPmIlpQ5mnwRM6gWfuJ6EyUC54Ki
	 vdex4i4fZKiFjBfofHyf9VNu3J3OeE3Uc0EEPP09BOfKWg1lbbxL2RMfLCae9f2gbj
	 FiIDAGGWFJEyJQdEj+3l04j9gsPn2k4mOwbZW7DRQfzPRq88CADm/FFdaAy7tKui4N
	 tirxpMAclHztA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liao Chang <liaochang1@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] cpufreq: governor: Free dbs_data directly when gov->init() fails
Date: Wed,  8 Apr 2026 09:02:01 -0400
Message-ID: <20260408130202.1050557-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040817-dotted-shredder-9229@gregkh>
References: <2026040817-dotted-shredder-9229@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233897-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 2F8233BC945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Liao Chang <liaochang1@huawei.com>

[ Upstream commit 916f13884042f615cfbfc0b42cc68dadee826f2a ]

Due to the kobject embedded in the dbs_data doest not has a release()
method yet, it needs to use kfree() to free dbs_data directly when
governor fails to allocate the tunner field of dbs_data.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 6dcf9d0064ce ("cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq_governor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index d8b1a0d4cd21f..960dcd6384b02 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -430,7 +430,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 
 	ret = gov->init(dbs_data);
 	if (ret)
-		goto free_policy_dbs_info;
+		goto free_dbs_data;
 
 	/*
 	 * The sampling interval should not be less than the transition latency
@@ -464,6 +464,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
 	gov->exit(dbs_data);
+
+free_dbs_data:
 	kfree(dbs_data);
 
 free_policy_dbs_info:
-- 
2.53.0


