Return-Path: <stable+bounces-218880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLEZLzdWnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A919020D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D4032BB6BA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B0288CA3;
	Wed, 25 Feb 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t15NZrcW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC127FD72;
	Wed, 25 Feb 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983767; cv=none; b=vGBdJOfrhzctphCP6OC8L8rM5Vj8qsPn/MIwzpASzv8jc7qX08CP/YwbBFqUh6f92Vt7T73JcmkXTc0CRyiaaQ4cTCQmeGnEJg2H/vsmrttzX9K4+Rg2oj+09zE/P2T9Gq/4aNT+f2fC1eSKp7jyDHeZAWF2h2ZNaWs/WC9pbdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983767; c=relaxed/simple;
	bh=XQCfY+07BCFluTE2khbwGaaec+VbGfOK4vqk0cOngHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaNnPmM/U9TsUZyrJieK7P2m/12e7piTFcTefrB8RZFpR+DQ0yK5MY6tG13UBjDXt7sH9TVgVu/K3MgbKHqHwLPQhcXjKwT71fRCWHpY3mq53/hDqMq76HFt8dqch3irt7RgvCHaAW4MmZMFBmVeRqXLTwFXhh27bYpPl0uYVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t15NZrcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E20C116D0;
	Wed, 25 Feb 2026 01:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983767;
	bh=XQCfY+07BCFluTE2khbwGaaec+VbGfOK4vqk0cOngHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t15NZrcWMOc+xJjzNqEe1edsD/CWbR54/NdouJ3nsxXcKOdyDJvoxGIqvAAiA29OO
	 YoPdOuuqsQcs6Ip1f6YRFu+/myZ96+QylUP6TVJxSWMOIAbMyHjVIiPBYMfAdimkqB
	 +rFak0EhTSzI4WXyQRNHtBGsBzY5YkL36nwacqMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 059/641] cpufreq: intel_pstate: Enable asym capacity only when CPU SMT is not possible
Date: Tue, 24 Feb 2026 17:16:25 -0800
Message-ID: <20260225012350.478666515@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218880-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,kylinos.cn:email]
X-Rspamd-Queue-Id: 2C4A919020D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 492a10f1bdbfa..38333f7da40db 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1152,7 +1152,7 @@ static void hybrid_init_cpu_capacity_scaling(bool refresh)
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




