Return-Path: <stable+bounces-233894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NbXCFZR1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:00:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FBE3BC81C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4243C303A6F3
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B12EC0A4;
	Wed,  8 Apr 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVtQp+5a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC940DFB6
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652952; cv=none; b=alDVR1j08FqzRt9gGhhNkfGJ2p96+qKjQILoOkBm6aJ9STzIY8NToVoWhnVE8x9QBiOe2vHGxV4qG/bLLbIRr92UdOb3nvcvBoNoxWNhLh5kFI+GtDy43bAXBLlWyw6KDBnsjWXcy/bUlAhEGMBWUk8+uZHadIy+iDoanfQpKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652952; c=relaxed/simple;
	bh=1xfFKSAGAfqauHcCnaoyYy9g+jD/sZHy8E6gmswRtg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/eEw37I9lxH6erH0Aa2JAncxV8JxIdFwNcnnXGZS6pvmOMjx+W7OGS+jn5l8czw90pvAn1pSEWQI9EwnZ9B9ehH63TeFPPrGHV2Vs+k4KK592bnd3AUyJGHn2XvJU4kJAjOJ1cZXEmCoY//z8gWEvte60b9lzkY81tXx9b7xts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVtQp+5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CF8C19421;
	Wed,  8 Apr 2026 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652952;
	bh=1xfFKSAGAfqauHcCnaoyYy9g+jD/sZHy8E6gmswRtg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVtQp+5aNZVj7bzqG22Wofznq+PgAYIeBIe/8OyAlIRdRa6OGWfhjJ+4Tvd51j/q7
	 4aXE1lvwlkItYrGkwDgtuQFAy5t/jDydpc8PAueo06vHawi6LL/awjfwrDciS6Ch7F
	 sG5FqXTogkYxIL60jsoOTyKiUSx5/w/Ss4WdHorJc6kt3sokJcqskGKMsYdXz11sah
	 RY0Oz5Dn08iZru7n3Nv4fLYsNv78ThNkaymhXFL7sBMJ6JzrWTY69NcC+xjJXev1ZT
	 T9/EQ4qQWK3VpCiG+zo9cdoQfY8nUmfNr4oUgEvFGunuAWhCVu490GfrSrMU8Pzhw0
	 pEPdfPeRjMT6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liao Chang <liaochang1@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] cpufreq: governor: Free dbs_data directly when gov->init() fails
Date: Wed,  8 Apr 2026 08:55:49 -0400
Message-ID: <20260408125550.1049042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040816-flattop-footing-328d@gregkh>
References: <2026040816-flattop-footing-328d@gregkh>
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
	TAGGED_FROM(0.00)[bounces-233894-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,intel.com:email]
X-Rspamd-Queue-Id: 83FBE3BC81C
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
index 5981e3ef9ce0e..3de5a2ca903ea 100644
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


