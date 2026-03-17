Return-Path: <stable+bounces-226194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIttLpKFuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD4C2AE698
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D59B30C63D9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4BD3ECBFC;
	Tue, 17 Mar 2026 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wt3+F3eq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B78376BCA;
	Tue, 17 Mar 2026 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765667; cv=none; b=BWixwktecfkYF0F8h53158rIR0j7m3la403Jpypjyg5fF+zi/2kLPSlynBD9yubPmBbCRg62b+Oy/MVbkdrTEM8mzhn1FhRzHSsWbjreUMgDPCzhEdpxtf/wtmGtCEElF017nkpWrPkUfvY6yA1iBx8Rz3/ydMtTl+/N3is5dbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765667; c=relaxed/simple;
	bh=Cf19yAnF1pnwfmxLVEam1zfo7PUHPzEseFCycSDoA/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqJNukCSFPKImLVl7UEGJPri9gOcBUlJOSdZQ/iU53H1mWPt0c4PMrujAIGu5kquTxKY7dFdHDEnT6maF8CEJ8wODL1z5rh4KOXKFHcqbfvgymTugKrwTQ8mWiP5vy79DaL7b7zT0a8+4uGSKu3sJYgEWq1s4qotrMBCfAdBp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wt3+F3eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB47C2BCAF;
	Tue, 17 Mar 2026 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765667;
	bh=Cf19yAnF1pnwfmxLVEam1zfo7PUHPzEseFCycSDoA/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wt3+F3eqIYghSx9SP9gXP99fZBn7Ji22l+g2gL/0JBQPA2+xdnabJpWTCem0LcQx7
	 fQnT34x3Clchb0p1u7jUJmzsHh00bqCsTxfpYled3ynP+g001NezYxxoz2xeJ9hD9S
	 YMydL4z0VZIdg0+y2HnZWXKOPNc3vbD/oabX/0vc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 032/378] workqueue: Use POOL_BH instead of WQ_BH when checking pool flags
Date: Tue, 17 Mar 2026 17:29:49 +0100
Message-ID: <20260317163008.162250841@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226194-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 4FD4C2AE698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
index 2909c19540ed1..a4574c1e276aa 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6254,7 +6254,7 @@ static void pr_cont_worker_id(struct worker *worker)
 {
 	struct worker_pool *pool = worker->pool;
 
-	if (pool->flags & WQ_BH)
+	if (pool->flags & POOL_BH)
 		pr_cont("bh%s",
 			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
 	else
-- 
2.51.0




