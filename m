Return-Path: <stable+bounces-220136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIqDENQro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B91C530E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EACC3128993
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E248A2AC;
	Sat, 28 Feb 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/ECMo8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8C48A2A4;
	Sat, 28 Feb 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300045; cv=none; b=hFL9oXZW+UdQjIKSJ9ItB3hry6VO/PBP2kHJ9cmxuEmMZ35pt9kQKnn72lHdJNH0Dastz5t3t2tRcV7XGyudvVbNH69xFO/LrAnYUOn2kQQ+KUPqYyAFoOnepMmLh5+AWBXQ13K8c35/Ee0wfBpjRief3Y3JstenECJg5Ck92qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300045; c=relaxed/simple;
	bh=ANDSCPHjokIvXexJoyEmdLJh4bwF/OZdktQa/MDY09o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8duuelZknw/FNOF/VFirDs9+Tkx01WBaKUS3pA54bFduVEwRMB/VVwBAAs4W0Qg75l14ozI5x3t3FZrKPp8BezZQov7F0IKAyVkpIAP3xAHyJNhmjmY7DUHedLcF6PUm8fCJn5jrgQSMaTc7VVJU8xpcrU4a+rbEergq1t7k/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/ECMo8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14EBC2BCB1;
	Sat, 28 Feb 2026 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300045;
	bh=ANDSCPHjokIvXexJoyEmdLJh4bwF/OZdktQa/MDY09o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/ECMo8YVhM/ApM505rgK3WiCek+A+yyboxYdo72pbK08aUEyzh7U+1WUTEjV+pAe
	 XNxNunKgIEWR90M8wC1qKr/vWb8D0SOXURcue9/XwLb1t+0jP8betzMr2eshBW6edr
	 adaO3o75l/NWZqASC3GjaWys0jzpvlMsnPVQ/+xXYVfO9gRelRwVfltLQqteW4XZg1
	 7XNNINvmPY2Uh+r5+ajn3xf2gFtvigc4d74LWVb5UGqPJf62eY1pzs/Rtteq7xGl7Y
	 uvKwv2gL43KwR/OIgs1td2OEgEa/5zfvwWNJzTXRnBa1MOtCzG7X4pKYAf+oHdIPMD
	 XBX1xOPIpp64Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 058/844] tools/power cpupower: Reset errno before strtoull()
Date: Sat, 28 Feb 2026 12:19:31 -0500
Message-ID: <20260228173244.1509663-59-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220136-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: C50B91C530E
X-Rspamd-Action: no action

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit f9bd3762cf1bd0c2465f2e6121b340883471d1bf ]

cpuidle_state_get_one_value() never cleared errno before calling
strtoull(), so a prior ERANGE caused every cpuidle counter read to
return zero. Reset errno to 0 before the conversion so each sysfs read
is evaluated independently.

Link: https://lore.kernel.org/r/20251201121745.3776703-1-kaushlendra.kumar@intel.com
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/lib/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index f2c1139adf716..bd857ee7541a7 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -150,6 +150,7 @@ unsigned long long cpuidle_state_get_one_value(unsigned int cpu,
 	if (len == 0)
 		return 0;
 
+	errno = 0;
 	value = strtoull(linebuf, &endp, 0);
 
 	if (endp == linebuf || errno == ERANGE)
-- 
2.51.0


