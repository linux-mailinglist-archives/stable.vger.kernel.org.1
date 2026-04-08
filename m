Return-Path: <stable+bounces-234250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPKwFW+c1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:20:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BCC3C0746
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D570830206D2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F283D9035;
	Wed,  8 Apr 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbazVDIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6668B3A6B6B;
	Wed,  8 Apr 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672372; cv=none; b=pqurtJegEtCDOWIGq9bzlofUgAGgiKRkVZQpsw0WVF8nHt4wzVz8OZn9DTvl472JMvREJcGxrUbvgohm+lqDYzR4vH3Bx9XUACidQWGVpwInXGpJeNdu7pF7cbnEaEluLi0cLoxTsLAI3f938VsJQW3EGb4XcifN2U1j5pIAFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672372; c=relaxed/simple;
	bh=a7pgviiFu1u9oNlE4dpYotKLbChCYSUjS/DGc5+Ftk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEBHlCVnw7xCl8sPgqoZE2gfnUS4gAacYiB8pf1iM6i4zdLCOlJDJEUyC39xsSAycDRkviKecVD16bKM1ECiEFEe/wdsD+LO1Xima2BvvE0yKN08Lz551oAil3BLObquaAaT0Z2bLrE2JdkrSQ+709GJBMSFJjCjqmH2Rm7wrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbazVDIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B6CC2BC87;
	Wed,  8 Apr 2026 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672372;
	bh=a7pgviiFu1u9oNlE4dpYotKLbChCYSUjS/DGc5+Ftk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FbazVDIaEILEi/4kw6xFrRg8U6sB6ik98AIruyassofMW46jmFgg5mIt4M5vvmcU0
	 hMNhxBp3GZDbYF/FdT4LaZLDmSL1Xl9tW8Bxe0+yrf4jfkOYzdJ1zBTW65Do9zrQz2
	 AKBPDr55zF10IQ7WntVPtkHxnPu4fWdKbgoPNTto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Chang <liaochang1@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 293/312] cpufreq: governor: Free dbs_data directly when gov->init() fails
Date: Wed,  8 Apr 2026 20:03:30 +0200
Message-ID: <20260408175944.709973859@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234250-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,intel.com:email,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 45BCC3C0746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq_governor.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -440,7 +440,7 @@ int cpufreq_dbs_governor_init(struct cpu
 
 	ret = gov->init(dbs_data);
 	if (ret)
-		goto free_policy_dbs_info;
+		goto free_dbs_data;
 
 	/*
 	 * The sampling interval should not be less than the transition latency
@@ -475,6 +475,8 @@ int cpufreq_dbs_governor_init(struct cpu
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
 	gov->exit(dbs_data);
+
+free_dbs_data:
 	kfree(dbs_data);
 
 free_policy_dbs_info:



