Return-Path: <stable+bounces-253531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GgpCroJD2rREQYAu9opvQ
	(envelope-from <stable+bounces-253531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:33:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9F5A5EF5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 538EB30EB131
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B063C76B8;
	Thu, 21 May 2026 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWDCTwtG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22322D7DC8
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368277; cv=none; b=DOT5hhw4Em/gPPVBWftEaa9KSkPnBbXubkK2z4W/2a+mhn6VHXOJM+hUtj/mog0OruyWIUlAHz7Xx+raJKBi+bsjVvhCF77kT4SfQp16xX++OMfj7srQzStqUtEJqri4qgw503/p71UqwW3r9oIiOvPM+WK3GSb6lMp0k9fwZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368277; c=relaxed/simple;
	bh=mTRt4Ay6G5x1WhvAubbyL6qcd2BAEh7I3yG9LzPsWCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf+Wjy2JTg0QD+jY8d0gsASWW+34zYQvtc7I1HZ7ruolFrtjUhfe/BnN4M6MPj372WNnq+hcVU+wcR/XsUOtIrFey0mWyUQtS/Rmgg0kY5Uq6MLQWdi7qR/qz46CYpeebQBUza4gBQHa2EW2vzcnUcTRT5/2J2FsWEC5LgHoMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWDCTwtG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E618D1F000E9;
	Thu, 21 May 2026 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368275;
	bh=WKKnEgMM/J2o93DYjBDo0V6/Fmw4CGk7EjjMRwET7tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWDCTwtGpbEcU/HyEcE1+SOGlEgrKxxsUkhmGGB9kZTffr7SI0wftGG+dpJQdmS1B
	 YGe9rUsgBVAAaGYhE843mrBUsJGn1+iB3G9wRQp6l/X+wwU98h0Gxh/253FrHgWr8d
	 Bayu1k8ei/FeGbBgZv2u0KWxAw1J459ZO0Dwr2AsPGbXdw5R/bOV3pEYRj55NZxcFH
	 a+wA8Z7WQdCvUoWVZd1fYPIba8ZznWUeB2oabnUi1SnjfSjSVksWXxAnwYQFGWAxo2
	 pQ0OcdCdLLi3oFzwpjHMsw2yypcO7C6SKvhkbDgf9icS6SVLPrBM42skCcQP8oiQS5
	 XxR5w4lbyz3wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuele Mariotti <smariotti@disroot.org>,
	Paolo Valente <paolo.valente@unimore.it>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] sched_ext: Fix missing warning in scx_set_task_state() default case
Date: Thu, 21 May 2026 08:57:52 -0400
Message-ID: <20260521125753.1164691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051526-prelude-boil-36f5@gregkh>
References: <2026051526-prelude-boil-36f5@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253531-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: ADB9F5A5EF5
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
index 9c7ff5179e4f1..ec4a1d754d211 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2936,7 +2936,8 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
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


