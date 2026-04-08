Return-Path: <stable+bounces-233887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEQkITBQ1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:55:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE3E3BC6FA
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A21FD3005332
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F783B582F;
	Wed,  8 Apr 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf0w2cZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679923BC66C
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652469; cv=none; b=WNz5Ma69V2Unfrp2DsYSsN20eA7rQkttToUxFbZbUkqYKb2WfRcry66adW3BFAq/FAAEbvnbt+LruUa3syee11ibOXLVWNg3FhQNY+LinEF+cOfaD+ADwdHGIpxxUqMlnKmJFuOI7BEPsqDaLWN2lgWGoHbEptyIeg9L2ZNaj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652469; c=relaxed/simple;
	bh=hXL9PSy2T9OidFXlN7I43y7vcFLJto4rSFdeRqMTNq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVAGXL6OHfKR8RWHr/FDfvbNPOZC0D1vkmo1ASlze1NPheiiUW8luiuX1drkGgdzr92ilekX5mCCC57hkNgK+n03GuRqqxSaQUXGkkkUuXKJPiXc1diBvnJ+lkVKcIIksUdFFd23z75sf7g9Xxrhg7ds6k+90CoVEYY9c3TRxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf0w2cZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5492C19421;
	Wed,  8 Apr 2026 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652469;
	bh=hXL9PSy2T9OidFXlN7I43y7vcFLJto4rSFdeRqMTNq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bf0w2cZ7hIDIzZp88y5oDUOv3cpl3tcFKWa6mvmMxhd/+E7W3lw+imfqxBW+8mFAr
	 zejZcKvoSUYo8aKaMHr6SXNhTzKPiJLf9zZf5AvcvLfgc4rkg3lWlFXy2iwbaEgPux
	 oVNf1iQ1hsCWnoJaQeEmxSVs3yam8I8y+S/n1K570+jqeKKu2iVmbOQGSHvb3Oa9zT
	 e/pqJIiDW076Uq1S7fwC8hwkbXpTSSqFWaMtjj/AE7ddvEWyjD16yWmIWP0mrTTg+1
	 myKyXTYLA/TC2c0VScwVmqwZOzJ6mPcAT08ryFilL+uvYUNx8Ibqt3Qd95LXpMrIyB
	 RDbCQ+hjSI4Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liao Chang <liaochang1@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] cpufreq: governor: Free dbs_data directly when gov->init() fails
Date: Wed,  8 Apr 2026 08:47:46 -0400
Message-ID: <20260408124747.1019894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040816-myth-cleft-0c71@gregkh>
References: <2026040816-myth-cleft-0c71@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233887-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 8CE3E3BC6FA
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
index c8bca3e77bcea..1a7fcaf39cc9b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -440,7 +440,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 
 	ret = gov->init(dbs_data);
 	if (ret)
-		goto free_policy_dbs_info;
+		goto free_dbs_data;
 
 	/*
 	 * The sampling interval should not be less than the transition latency
@@ -475,6 +475,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
 	gov->exit(dbs_data);
+
+free_dbs_data:
 	kfree(dbs_data);
 
 free_policy_dbs_info:
-- 
2.53.0


