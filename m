Return-Path: <stable+bounces-220134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAljELwro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4181C52EE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E15F93175D0D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A487481FC1;
	Sat, 28 Feb 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCq0tulH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1458481FB8;
	Sat, 28 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300043; cv=none; b=KllUHieYFtQdNlgwQTGPEBbC+AndSncOYQKGM6bPP2ZBXa4qdqcUqvXDpzla2+92CV5alCYcPpJhvash+ZgXTQ1gmG1GpSAV5xTuW/gKzdq2/HM/zaXkMJiEyDkL+bvPHv8xrYMToe3s+BIAZZoX4VGLrvls1A+WfcYNOb85z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300043; c=relaxed/simple;
	bh=7vVPGALmuNeLk8yGU4KurhELNTDP0geSF1U6fTA/0yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UR16s5sVoFnwbRJtCypHgTP5MgtaocV3lmmFENc5QgrAO5Thhlb6PmU51dRKIVJX/xVcTWkdMfYDbI2dMtfZYLlCF3xdqLJuMHrUL05+2BRqZI74+DIn3NUOCtZPtcGVs8fn0fS9NGw6iyYhXcCS0urF6lsVpohMbD36SUXTfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCq0tulH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FAEC19423;
	Sat, 28 Feb 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300043;
	bh=7vVPGALmuNeLk8yGU4KurhELNTDP0geSF1U6fTA/0yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCq0tulHXpFfScEQZ87Mn6mK52UoTXyTTTJO+zm8UKdXqc0mUN19jb8GdJKm9brh0
	 w2rwUMpQGXaNTZyD8o9GcvcI4dNSWBgWWUJXJ8TMh0c7JbM6UO40aYWGWHJKHCJJAX
	 AA7ynm/1jVn7yTmtDtNda+N3V3pw0BUjqIvNgr+JXRBjlOMK6VGVNHvUZBpD5cr/V3
	 KMVCIz6sLHVnA8K7SEReQEdM5Dqnh0RCdIYaexauzxc5TyKDLSstf6IQxZz5sT6B28
	 Iy4uMYiS/KKxvfz0/VZ31CoPg3o/KsBswQHIJAClbur+MU/d3db9Mtg4ECR1QlhEV0
	 s8ChhJsGLu89A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 056/844] tools/cpupower: Fix inverted APERF capability check
Date: Sat, 28 Feb 2026 12:19:29 -0500
Message-ID: <20260228173244.1509663-57-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220134-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: BF4181C52EE
X-Rspamd-Action: no action

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 24858a84163c8d04827166b3bcaed80612bb62fc ]

The capability check was inverted, causing the function to return
error when APERF support is available and proceed when it is not.

Negate the condition to return error only when APERF capability
is absent.

Link: https://lore.kernel.org/r/20251126091613.567480-1-kaushlendra.kumar@intel.com
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/utils/cpufreq-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 7d3732f5f2f6f..5fe01e516817e 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -270,7 +270,7 @@ static int get_freq_hardware(unsigned int cpu, unsigned int human)
 {
 	unsigned long freq;
 
-	if (cpupower_cpu_info.caps & CPUPOWER_CAP_APERF)
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_APERF))
 		return -EINVAL;
 
 	freq = cpufreq_get_freq_hardware(cpu);
-- 
2.51.0


