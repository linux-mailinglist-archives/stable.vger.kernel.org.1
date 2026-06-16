Return-Path: <stable+bounces-264328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AnrhCXZyMWpQjgUAu9opvQ
	(envelope-from <stable+bounces-264328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A2F69190A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="kPt/Ktpc";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264328-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264328-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91A2318C5B4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8621D44DB7D;
	Tue, 16 Jun 2026 15:55:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7444CF44;
	Tue, 16 Jun 2026 15:55:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625330; cv=none; b=V4TeCAUo4yuyxkzeJ3tt2RGJ+P8gtS/eBbDl4c5yB1Nt7w5DhYzZjfyWckDqmTfyADhxK63kDtTnb5JFQi4asbyqdFSArVXqJCi3eutwXEmlo/9V0WA7UlLKEzyXH6GeOjib/tofgWJLnGggBDuvCkFr25aAHQXIE/6aHf7Qp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625330; c=relaxed/simple;
	bh=CqUS2OgRkIWS3edTfi89l89vcWGViUcxURjH89PPYc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNxYqEoFT1PmTmKwZp+URhWvHwNfI+hQG3JIb6p/5q0id4bgOl/zufbd3nwJHYeNLHJCWdS6jLo8ghe69+u/XVnoRxrFLLVFP+Ve+h+LQgrk0KR687U0OP9KK1JlCfwwt6wQWLXMBIkVHW+bgepzvGCtlxLckiYQmdmZ+bAuhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kPt/Ktpc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1282A1F000E9;
	Tue, 16 Jun 2026 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625329;
	bh=No6Pm4h5Pfsd5gp/Rxi4/EG17sLfouRxdCiSwxia3uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPt/Ktpc/4bq+lnlpNRKKWWkH4PeG9n/i+NHopxPk0u7yEM1vcWscqItWXCZ+BpAT
	 NIGcWsvsG69zGCaMcHCWBCVXz4zti5LouTtLPD1A9w6qW5l837IcfQWoFq04nnrtkV
	 mB0ZEovz7VtqD/QYEmh8E6mnxxIOlqCBNLWQUhCs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 078/325] cpufreq/amd-pstate: drop stale @epp_cached kdoc
Date: Tue, 16 Jun 2026 20:27:54 +0530
Message-ID: <20260616145101.618941989@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264328-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:superm1@kernel.org,m:zhanxusheng@xiaomi.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82A2F69190A

6.18-stable review patch.  If anyone has any objections, please let me know.

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




