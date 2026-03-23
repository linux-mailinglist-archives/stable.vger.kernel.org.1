Return-Path: <stable+bounces-228483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPhmH59TwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FAB2F5541
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FED530EB776
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE23ACEFE;
	Mon, 23 Mar 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g68c/+/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D9199FAB;
	Mon, 23 Mar 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275253; cv=none; b=g5SFuvhlSgaKizTInactV0ocHA3f8IU2c7sQi78DJ9/QQBUd6272I7aAKVyj2+tprFKefnuRdWVvuct6svRs6QA1npXOd0vlpJMEZ57QbUPvkYi7sEEEehheUlMs+FW0jWQOEULP2/2tsbFRmxJ3W+1XbAYgwmeDN3MZaifE8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275253; c=relaxed/simple;
	bh=PAqoq83stBBSuaB5VlguMskqLb+xiyZKEdpXJLUOH08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3RBPsdcJG3CiQjiFGj7nfq+NgxisaR7BjGtr4mR38xJUwaKR1SoBXF9VJAcfLBZUKAPKHMkZQQog/Kt91cVuHvr/Mx3JAT8cE+jQSTfIavNcDW4V/Pvjo3DtvTSFNJ6GFNYiPu6Hq7sJevHPtMqsEEKPqCumIbxp/vdKbjEA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g68c/+/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B380DC4CEF7;
	Mon, 23 Mar 2026 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275253;
	bh=PAqoq83stBBSuaB5VlguMskqLb+xiyZKEdpXJLUOH08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g68c/+/+CJaY3Vul8GpRmneg1FE9HJzijYCBBZY0qY+/FF1o8dbfxrHOHI4c5BJ4F
	 xIUMRzoIozbIJ6P9c559Xtn3i8NXmCfsojE3KYi3fduP4slhDN2jwZ/G/zehrIvl2z
	 IPNDGFiPI32lSX8iVU+UPgLVohRUh+fedPwdL0lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 029/460] workqueue: Use POOL_BH instead of WQ_BH when checking pool flags
Date: Mon, 23 Mar 2026 14:40:25 +0100
Message-ID: <20260323134527.413672936@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228483-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 04FAB2F5541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f42f9091be9e5ff57567a3945cfcdd498f475348 ]

pr_cont_worker_id() checks pool->flags against WQ_BH, which is a
workqueue-level flag (defined in workqueue.h). Pool flags use a
separate namespace with POOL_* constants (defined in workqueue.c).
The correct constant is POOL_BH. Both WQ_BH and POOL_BH are defined
as (1 << 0) so this has no behavioral impact, but it is semantically
wrong and inconsistent with every other pool-level BH check in the
file.

Fixes: 4cb1ef64609f ("workqueue: Implement BH workqueues to eventually replace tasklets")
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3840d7ce9cda0..b2fdb8719a744 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6209,7 +6209,7 @@ static void pr_cont_worker_id(struct worker *worker)
 {
 	struct worker_pool *pool = worker->pool;
 
-	if (pool->flags & WQ_BH)
+	if (pool->flags & POOL_BH)
 		pr_cont("bh%s",
 			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
 	else
-- 
2.51.0




