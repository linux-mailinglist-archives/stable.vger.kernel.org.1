Return-Path: <stable+bounces-253588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLGHFBMpD2paHQYAu9opvQ
	(envelope-from <stable+bounces-253588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:47:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E95A89DA
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2BC530B1B59
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6D3368AA;
	Thu, 21 May 2026 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIv9h6d6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BED33A9CB
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375135; cv=none; b=sssaF8HEZvwL/qWE2h2EN+4e48Rf5WMbQhKcDLYRnl/Pq8EopHRBeH/AsFadzZh80dzpevELcA93TNR1k1/oirzi2rs1djvFW0/3n4eJ+OEWQzqGjDEj59NFdP+o22Zm8RyauP9OAHjLoG2JuBgIdArrV7Decv1/Cs+6jQZMPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375135; c=relaxed/simple;
	bh=g5MB9b9V64F2MzPGAoOP3hNO7TQQDB6DNrn8hpPw8LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdnrvA7Bo8Oj6FHlPf+FDiobBJ7F2P7X4Q1B5Egyl7v/NkM0YK0+cFAhmjeYGD9S2aK1aVN6HEoHG+uu6ko7ISvmnvHjxvgJg/ybpXCYAs2dJJ6HzSIxtChUEnYqXHF/4vWOe4tVSXNSTgbJz43WM4vO0GGHOu5mwIkkAaTIFeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIv9h6d6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662851F000E9;
	Thu, 21 May 2026 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375134;
	bh=eQDMPm8APc71Ypyx5iwusVkGKrZg1WV6xqZ/TDWzEws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dIv9h6d6kmkbjEistJziUlvwNVMvkt2kDWxgud0bzTBN26XVUXr6EYVD6TPW/mRKu
	 c0YVEq8BjywNlOySCWW316pJQJVpxrMoyU1P3IAI7oZTrYtS3ZtJcogRLMbqZc2ZCv
	 9dth6QGd1SIir1cmAahvPIHPfzKWg7ZYUBhI1uXO/C5VRKAqbwgjIqUNf9koN3xZtn
	 GM3tQMs4Jmm5XabE8luLhEsXvlftudtYJUs7vqwBPdnFZqSIGJa22UAOlA38s155Uw
	 O4ISwUPMQWUguWSHyPNgVqvWvcUnzMl/dKUtJqSNUm+w39R39I7pj5OgYbEi3sfd4R
	 3EIF7RTENx8BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuele Mariotti <smariotti@disroot.org>,
	Paolo Valente <paolo.valente@unimore.it>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] sched_ext: Fix missing warning in scx_set_task_state() default case
Date: Thu, 21 May 2026 10:52:10 -0400
Message-ID: <20260521145211.1316611-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051527-snort-dawn-9645@gregkh>
References: <2026051527-snort-dawn-9645@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253588-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,unimore.it:email]
X-Rspamd-Queue-Id: F18E95A89DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Samuele Mariotti <smariotti@disroot.org>

[ Upstream commit b905ee77d5f557a83a485b4146210f54f13365fc ]

In scx_set_task_state(), the default case was setting the
warn flag, but then returning immediately. This is problematic
because the only purpose of the warn flag is to trigger
WARN_ONCE, but the early return prevented it from ever firing,
leaving invalid task states undetected and untraced.

To fix this, a WARN_ONCE call is now added directly in the
default case.

The fix addresses two aspects:

 - Guarantees the invalid task states are properly logged
   and traced.

 - Provides a distinct warning message
   ("sched_ext: Invalid task state") specifically for
   states outside the defined scx_task_state enum values,
   making it easier to distinguish from other transition
   warnings.

This ensures proper detection and reporting of invalid states.

Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 9a415cc53711 ("sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 25df16aed142a..e55e0db83400f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3637,7 +3637,8 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 		warn = prev_state != SCX_TASK_READY;
 		break;
 	default:
-		warn = true;
+		WARN_ONCE(1, "sched_ext: Invalid task state %d -> %d for %s[%d]",
+			  prev_state, state, p->comm, p->pid);
 		return;
 	}
 
-- 
2.53.0


