Return-Path: <stable+bounces-263906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /QIkLxRrMWpoiwUAu9opvQ
	(envelope-from <stable+bounces-263906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:26:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FA669105B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:26:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=A70uoKiI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263906-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263906-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A79A830CD602
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A5B43E4B2;
	Tue, 16 Jun 2026 15:18:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5243E486;
	Tue, 16 Jun 2026 15:18:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623100; cv=none; b=t4kLm/Zno/2UnyuYoTNt7I/8liN1Tw9HnakOVjJ8GoscV0n3FmyZxtIP5UJxO2GNQBpvwMcQllAMe0clVW2vyKU9tu/cjuemS1Fi/iWMkHriStf2enqovjNLvcGqW2VsUmiKDVuzO5iBmopLmxpr4/zfNLy+GmqpQ0Ma0WIriIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623100; c=relaxed/simple;
	bh=ff/brXbi+0ERDd/3vv7hb42fLupraIEUV8SyUR48BYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzvInFueAVaUjgZq4Er7Hj4t8uMREQR30AHS6dUDMI3OIm6SLs2zyZKgbzTykri4LdNGr7DPWTaXgki481zaorKFpgh0bUWCx+siLjBn6SJ80QSQCOY17Hit0zKSIsNjqrL+u2DMAW4oxSShiUYzH/TTjJN70iipviNDH4GGq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A70uoKiI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A371F000E9;
	Tue, 16 Jun 2026 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623098;
	bh=Qb2tz8doJusTCmVM9/7SVYQLnSlPSu5K6WHG02IrPxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A70uoKiI41cbbFt0SHt2RT6XuBzSDXJrNOCIGug+BEAbH/A7Q8Or8B4K3bhj6Oaqh
	 StiH5mewnDHvGP91+f+T/Vqi0v/I8wbulGNu00VM3Iaz1pMewGPw/6BqZ2dKTpXZzL
	 bOjXLxg8nRAyvX5WHYyNmhmtfJwp+sW1ft2mzjxU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 088/378] cpufreq/amd-pstate: drop stale @epp_cached kdoc
Date: Tue, 16 Jun 2026 20:25:19 +0530
Message-ID: <20260616145114.886479692@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263906-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:superm1@kernel.org,m:zhanxusheng@xiaomi.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27FA669105B

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

[ Upstream commit 3cd07ee35a66038fd1a643632bfc057645e07c9a ]

Commit 4e16c1175238 ("cpufreq/amd-pstate: Stop caching EPP") removed
the epp_cached field from struct amd_cpudata in favour of always
reading from cppc_req_cached, but the kdoc above the struct still
documents @epp_cached.

Drop the now-stale @epp_cached entry.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Fixes: 4e16c1175238 ("cpufreq/amd-pstate: Stop caching EPP")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Link: https://lore.kernel.org/r/20260526022131.1302373-1-zhanxusheng@xiaomi.com
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cb45fdca27a6c7..75136d2250c1a5 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -76,7 +76,6 @@ struct amd_aperf_mperf {
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
  * 		  AMD P-State driver supports preferred core featue.
- * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
-- 
2.53.0




