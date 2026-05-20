Return-Path: <stable+bounces-250069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHgsDOriDWpF4gUAu9opvQ
	(envelope-from <stable+bounces-250069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:35:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1D5921DC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A38E2309995E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B739A05A;
	Wed, 20 May 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mHr7mkeH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF023F20FF;
	Wed, 20 May 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294462; cv=none; b=lLtEmlq0M0peC+R6A3xDryyJB7AAErSvIAuh/n6sAcakT3XrPoo+1YWUJm6dkfCQIO3VEo6bMqqUfBrs1LaUbd9LDOA6t2Q6ETJztBhJBs/ut72ZCB8/Uw3miCldLUxd8qEqjxyQHWsi27aSPIBkEAt/vjyecy+TK1Rb6e+ryr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294462; c=relaxed/simple;
	bh=BPhyCTxV6Vvkc3BE5H87EsyAZUo9jQd8V3aqbufv/as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpW7RfGS8Qj/85pZJKU6jZsqe6O3Y5L9226VMgxA5V1LW7epFil4FMjGkqSwhSP3V8bcTIjhppaHORGGI4a8iTpQJsoP/kvDAZJ4zHrJtH4Ioyy17TawG3WY3GZfrfYbvTXtOiULAJmo3nAqAsrS0Drc4auAcif38V7mj/A6+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mHr7mkeH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC99F1F000E9;
	Wed, 20 May 2026 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294461;
	bh=gg6xdKRTb08mvgzUt5S3EI+8gnubXdEDhax63NEK0Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mHr7mkeHpo3ZBGYKs7GVE4V2igcK1b2jQFupqycve6t1d3YHVKFMuopzpd9Icp5GI
	 89uFuugpMbWH/1pX6qecQ3TjLzTEJJ5nhEoQkwK3/hjduq6pS9Y6G5O0HEUGL5IpNs
	 +9duCsesrP8aXprW+hCmqykm5NejebvhocBPplN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0049/1146] signal: Fix the lock_task_sighand() annotation
Date: Wed, 20 May 2026 18:04:59 +0200
Message-ID: <20260520162149.486659036@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250069-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email,acm.org:email,msgid.link:url]
X-Rspamd-Queue-Id: C8A1D5921DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 39be7b21af24d1d2ed3b18caac57dd219fef226e ]

lock_task_sighand() may return NULL. Make this clear in its lock context
annotation.

Fixes: 04e49d926f43 ("sched: Enable context analysis for core.c and fair.c")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20260225183244.4035378-3-bvanassche@acm.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index a22248aebcf90..a4835a7de07ee 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -739,7 +739,7 @@ static inline int thread_group_empty(struct task_struct *p)
 
 extern struct sighand_struct *lock_task_sighand(struct task_struct *task,
 						unsigned long *flags)
-	__acquires(&task->sighand->siglock);
+	__cond_acquires(nonnull, &task->sighand->siglock);
 
 static inline void unlock_task_sighand(struct task_struct *task,
 						unsigned long *flags)
-- 
2.53.0




