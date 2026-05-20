Return-Path: <stable+bounces-251226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCfcIMfyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD2259465F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8514B3028431
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6535F619;
	Wed, 20 May 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sBJ9X02K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E23403F4;
	Wed, 20 May 2026 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297429; cv=none; b=aviEkeRMXTM8H2YWYNZfAtZ4z0th2tf/LqN/6sqkolrfCJQijvDf1Zu6Xpn+rYOpBH0n+ZyZmHUs1qnAJMe+J+AcosyXRrzWJ/ha+b6oDebTAHhumHw5YzZ8uf+zjasJ1tRpxeB3HxCDabhWC305v8gwLjpdlhz//xXNkFFIakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297429; c=relaxed/simple;
	bh=sDBmfbiN6VTR1fhiFbosQzaToVTTiJp3rUyhELPXlhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7btEbdKl9OJvJmSt48IJY9rSBOk2tx5yDCYVOocI/qeOaEmWi5rAH0GWyq9A/67bIRwNIbe+Ve/xvYgpAUAHBOG/r3jcwDhr1AbXICKbFhtvXmHQtlI9R7+f78SXIehdo2rLLEFlDUjcjOJ9D39wmY5RAs/YYJFEPjO6UbI004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sBJ9X02K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06A41F00893;
	Wed, 20 May 2026 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297428;
	bh=bkyF2W2SYVOUeFD7+UbpLNKqOxvbZJHW/N4KFZ5we3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sBJ9X02K9ydJQWOG+A60SGpgoBIAMaX+wccg1GlLm0rx7Sqx3Y8+EIMW/WrYd0mEi
	 I0CKO6XK9EHTkNPVpmhvWzBKfSnMmWS8ZBX3eJEuW0orz1wm2Qmqmzp/a77d+mcj+C
	 PqQSKtZcYUtT0tsPynUcST2M00AP//BTBSdCYXLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 028/957] amd-pstate: Update cppc_req_cached in fast_switch case
Date: Wed, 20 May 2026 18:08:31 +0200
Message-ID: <20260520162135.170648099@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251226-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6DD2259465F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gautham R. Shenoy <gautham.shenoy@amd.com>

[ Upstream commit fcc25a291fbdca2c06c2c6602532050873f0c9de ]

The function msr_update_perf() does not cache the new value that is
written to MSR_AMD_CPPC_REQ into the variable cpudata->cppc_req_cached
when the update is happening from the fast path.

Fix that by caching the value everytime the MSR_AMD_CPPC_REQ gets
updated.

This issue was discovered by Claude Opus 4.6 with the aid of Chris
Mason's AI review-prompts
(https://github.com/masoncl/review-prompts/tree/main/kernel).

Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Fixes: fff395796917 ("cpufreq/amd-pstate: Always write EPP value when updating perf")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 86d8762ac82c5..39681ad1606f6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -259,7 +259,6 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 
 	if (fast_switch) {
 		wrmsrq(MSR_AMD_CPPC_REQ, value);
-		return 0;
 	} else {
 		int ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 
-- 
2.53.0




