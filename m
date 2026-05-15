Return-Path: <stable+bounces-247608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCTUE0TjBmrVogIAu9opvQ
	(envelope-from <stable+bounces-247608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:11:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C739154C1E3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 300AA319B9F1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B63351C22;
	Fri, 15 May 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MPMlLWgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EC31A56C
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834613; cv=none; b=G2M+Q9TU2NSZ4Vi02IfiPJ6FpPXpdUVqNIXJg+q/ak8Eqx7VALwjBbJSHwYHHymC7o9gUk0Z/foeFm566Y0Zm6Mbz0Bcir63Z210Ot5bX3E3+15rgXxrzS6KzqbTbSpLD1laSa2du9AwWhQF10zF+cnQgPRtn6pZG+bLITzZK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834613; c=relaxed/simple;
	bh=PBBPwnlBs6mb4HFdT9vny+KI0GIc8FoEu3bduc4jl/8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oHmQ9kprZil5MxznOfY94tAyr4DteOI8RkerXUhhoNH7noLR88IO2IG8edpKw0OA3WpQuhlhA05IBF+EAAqcCKj45bIRFIg5K3fPdctZM9x/ifsKNBtw61JUF5Pk/UHK3B/o1315MHetbV+McrnEthqZYz9WlBs7XlAt+drwUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MPMlLWgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F212C2BCB0;
	Fri, 15 May 2026 08:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834613;
	bh=PBBPwnlBs6mb4HFdT9vny+KI0GIc8FoEu3bduc4jl/8=;
	h=Subject:To:Cc:From:Date:From;
	b=MPMlLWguLLqLdAT2NE06/xxGI5poOY/4QwWshf+OzIOk1BsyJrJWmfROS7zEvvAn5
	 iorf6k6nkN2O0RI36JEWVxmpc0FQlyKr3Z1doERnGu3apZdzCvock708ZS6NF+Y4kW
	 Pen9zeb0H0bJ0fDG+kJM6wf3rp/1f4FOI8ghDgbM=
Subject: FAILED: patch "[PATCH] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure" failed to apply to 6.12-stable tree
To: tj@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:43:27 +0200
Message-ID: <2026051527-snort-dawn-9645@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C739154C1E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247608-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9a415cc53711f2238e0f0ca8a6bcc796c003b127
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051527-snort-dawn-9645@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a415cc53711f2238e0f0ca8a6bcc796c003b127 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 11 May 2026 12:05:48 -1000
Subject: [PATCH] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure
 path

In scx_root_enable_workfn(), put_task_struct(p) is called before scx_error()
dereferences p->comm and p->pid. If the iterator's reference is the last
drop, the task is freed synchronously and the deref becomes a UAF.

Move put_task_struct() past scx_error().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260511214031.AF5E9C2BCB0@smtp.kernel.org/
Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>

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
 


