Return-Path: <stable+bounces-245325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fNLjI0JSAmpvrQEAu9opvQ
	(envelope-from <stable+bounces-245325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:03:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1BE516937
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB8A9300E4B4
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345D53BFE44;
	Mon, 11 May 2026 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE+KjpMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908537DEBA;
	Mon, 11 May 2026 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537017; cv=none; b=WVKLpMp0HRNy+qVuDwMHZUSrhjc2y9yH+GjYHmL6PVdRCZp6yeYqAu8tG6f2JPGGJ/Sf6RJOUCD1rOyNzqjyFAdHbygtdY5Zs1/vLmvpeaqavmCESaXDRrBHKEAHKTQB/ZxwSzEzLnScZMkHVuI5FfcJfzm12arFXCDRXtsjKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537017; c=relaxed/simple;
	bh=KyEdPWkVvJVcl3kwEFMfGF/vIvoJQ1RgxyA8hNrUA4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJTRisOz3ggnh8H+3WeMaFZgoQfACdQ9o0P2Q8zayJuwHuZ09W+P8kqjJgt9ene5WgBaEUdru20C1Oa9tLt9TjNNjQ06c428zP6b1i+PZbfhXqHH1WFL/4mrUiIoIHn2ZtofYgg2eJgU+TJ3rGDi+2RTrebDXzQkoNxnWhinO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE+KjpMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818EBC2BCB0;
	Mon, 11 May 2026 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778537016;
	bh=KyEdPWkVvJVcl3kwEFMfGF/vIvoJQ1RgxyA8hNrUA4c=;
	h=From:To:Cc:Subject:Date:From;
	b=VE+KjpMvPO6vnI7xcSvmeadyzHaP6L8qb20Qwuj16DTc78YSIS4TUTp3hsYpKPtX+
	 CW5xWJfmNtOF+uK9b8iwImE+P0g9je51DWvqhu8aI33ONjCj5yRyck2hz6XEnbOAkt
	 Hwya+3puOaHFPTdG7sMEsqcv3yZZr98ZKS2onfNZSC2Kwrf5JDC7Sritij1woIdNd3
	 uSeYU1rZAdrwlGvz7NURRSK99Hs9NqHbUwEGlrFh9XCPPBjBWC0yuZsvOE6v6rl6RN
	 KWVBE90gRQdC/cxY5J846GTcD4VdcUpWwGnslsvfs1Pa9ThLPwYwWxgfEcSVyg9FCI
	 0aSLaS1K7enrQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path
Date: Mon, 11 May 2026 12:03:35 -1000
Message-ID: <20260511220335.144621-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C1BE516937
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245325-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In scx_root_enable_workfn(), put_task_struct(p) is called before scx_error()
dereferences p->comm and p->pid. If the iterator's reference is the last
drop, the task is freed synchronously and the deref becomes a UAF.

Move put_task_struct() past scx_error().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260511214031.AF5E9C2BCB0@smtp.kernel.org/
Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1efd5d82b08b..9354da79e162 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6973,10 +6973,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			if (scx_get_task_state(p) != SCX_TASK_DEAD)
 				scx_set_task_state(p, SCX_TASK_NONE);
 			task_rq_unlock(rq, p, &rf);
-			put_task_struct(p);
 			scx_task_iter_stop(&sti);
 			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
 				  ret, p->comm, p->pid);
+			put_task_struct(p);
 			goto err_disable_unlock_all;
 		}

--
2.49.1

