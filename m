Return-Path: <stable+bounces-218157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDvlAAZRnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D2718EE33
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A45BA3043D9B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC024A06D;
	Wed, 25 Feb 2026 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J093RIB8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EC21D596;
	Wed, 25 Feb 2026 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982941; cv=none; b=tOSmN0kj1A3A5DQCo3SDiraNu4LE5/N2NH2pW3vwTDLB4bz6aNU+JDsAkLxXQiGm+6ZlmRV9rSzLXlxgWvXukuFvAMr8wt9e8r2s64RPQ7bkghMazjT2q17rjJ8dBui/5MfxyeBMGU/1spdo75wMnXTJkhvWixW9yC2+zKsq2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982941; c=relaxed/simple;
	bh=KtBmzHG/mp8gR8R4CleJHrol3IReU7gM0WrDhOyp1Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjOReACDjLQD1DohXiL7ytgz2e6WLCi3tA5M1eC5dS9ku20fprBQ6mXA02ETEh2lr4Wgnw53glMPf5zspjWv7BghpzQ7lVkwILVZHUvOV4UhPTdpaAOU9a+hPvKq+un8sMAGyVh80g+cALNQ4jqhXakmIoeXv4imrZjlUrDUbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J093RIB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6302C116D0;
	Wed, 25 Feb 2026 01:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982940;
	bh=KtBmzHG/mp8gR8R4CleJHrol3IReU7gM0WrDhOyp1Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J093RIB8u0kvIY0w3DMH/+RVQ2ZZA991kSBVWko24W/qxZw+4d6mzN6WoCX10g22l
	 pN2mYJwGozMIEGzXHLXbyCWTf78Eax7rssU+U6t6cfaOD+S3G+zddVmJBJeBgyidOr
	 ZbJuEs3SM8IVREu8MJpYE7sRbKpdesJTfNUq6e7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 064/781] cpufreq: intel_pstate: Enable asym capacity only when CPU SMT is not possible
Date: Tue, 24 Feb 2026 17:12:53 -0800
Message-ID: <20260225012401.274733255@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218157-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 36D2718EE33
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

[ Upstream commit 1fedbb589448bee9f20bb2ed9c850d1d2cf9963c ]

According to the description in the intel_pstate.rst documentation,
Capacity-Aware Scheduling and Energy-Aware Scheduling are only
supported on a hybrid processor without SMT. Previously, the system
used sched_smt_active() for judgment, which is not a strict condition
because users can switch it on or off via /sys at any time.

This could lead to incorrect driver settings in certain scenarios.
For example, on a CPU that supports SMT, a user can disable SMT
via the nosmt parameter to enable asym capacity, and then re-enable
SMT via /sys. In such cases, some settings in the driver would no
longer be correct.

To address this issue, replace sched_smt_active() with cpu_smt_possible(),
and only enable asym capacity when CPU SMT is not possible.

Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
[ rjw: Subject and changelog edits ]
Link: https://patch.msgid.link/20260203024852.301066-1-tianyaxiong@kylinos.cn
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec4abe3745736..1625ec2d0d06a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1161,7 +1161,7 @@ static void hybrid_init_cpu_capacity_scaling(bool refresh)
 	 * the capacity of SMT threads is not deterministic even approximately,
 	 * do not do that when SMT is in use.
 	 */
-	if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_capacity_scale()) {
+	if (hwp_is_hybrid && !cpu_smt_possible() && arch_enable_hybrid_capacity_scale()) {
 		hybrid_refresh_cpu_capacity_scaling();
 		/*
 		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
-- 
2.51.0




