Return-Path: <stable+bounces-239676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEb+JHdO5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:04:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5778B42EE90
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1F70301BA73
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11F33F590;
	Mon, 20 Apr 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nx9+zh2z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BC2AE78;
	Mon, 20 Apr 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700934; cv=none; b=KZ3a84nHcpicizJQcLh8OG11xz+ufhFtRczSxcbs8UHqZYz+qWvNH3zZhe0vajV8BbeRXVFReLE/jjVETdd77U6DVX3Tso7On98lj4K4/Kd4+YFGQI6BPXBJzogx6STvayR6YSa8RMI676NH+QriRDMK/S3rKJCEN5+lmRzHdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700934; c=relaxed/simple;
	bh=QJD3cudOj3iq4usKcJj/U/3vrO4E7kE+Um2jn5r7KX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvgRdv2HwI7TmjiWwJHWVCQVbgbqPI+WauqSFe9r61f1QV9ss/yvBSmqmXnyu7ccAIXeKHzoIvCPm+OevLlH6rx+ZyicpOBAClukS3JYKxv9ZUgrQRSocguBZ1p0q3vpZkxCfJJRwidkdEsRF1UgQxWBD9naCqk9tf8Is5kTsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nx9+zh2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC54C19425;
	Mon, 20 Apr 2026 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700934;
	bh=QJD3cudOj3iq4usKcJj/U/3vrO4E7kE+Um2jn5r7KX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nx9+zh2z4WTA/oIn8G4i9BxGOK6e3hOxMztm2M++mDBFNF2EZIvchemHDChcywb+a
	 0c7IAbWBmcMzk4L0UNhTJkUuLYK992ig/avcVVfCLVqze5RJ4A2vHFdi4cp7foZ3+Y
	 Fpa+2TJA2ZCnjDAa/oh8/s1D1VIVISsEwU68C17o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Stultz <jstultz@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 117/198] sched/deadline: Use revised wakeup rule for dl_server
Date: Mon, 20 Apr 2026 17:41:36 +0200
Message-ID: <20260420153939.818399287@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239676-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5778B42EE90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 14a857056466be9d3d907a94e92a704ac1be149b ]

John noted that commit 115135422562 ("sched/deadline: Fix 'stuck' dl_server")
unfixed the issue from commit a3a70caf7906 ("sched/deadline: Fix dl_server
behaviour").

The issue in commit 115135422562 was for wakeups of the server after the
deadline; in which case you *have* to start a new period. The case for
a3a70caf7906 is wakeups before the deadline.

Now, because the server is effectively running a least-laxity policy, it means
that any wakeup during the runnable phase means dl_entity_overflow() will be
true. This means we need to adjust the runtime to allow it to still run until
the existing deadline expires.

Use the revised wakeup rule for dl_defer entities.

Fixes: 115135422562 ("sched/deadline: Fix 'stuck' dl_server")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: John Stultz <jstultz@google.com>
Link: https://patch.msgid.link/20260404102244.GB22575@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 72499cf2a1db5..d5052f238adf7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1036,7 +1036,7 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, rq_clock(rq))) {
 
-		if (unlikely(!dl_is_implicit(dl_se) &&
+		if (unlikely((!dl_is_implicit(dl_se) || dl_se->dl_defer) &&
 			     !dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 			     !is_dl_boosted(dl_se))) {
 			update_dl_revised_wakeup(dl_se, rq);
-- 
2.53.0




