Return-Path: <stable+bounces-247606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEcKHUHjBmrVogIAu9opvQ
	(envelope-from <stable+bounces-247606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:11:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D154C1D5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D171A3199FF9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20F305E1F;
	Fri, 15 May 2026 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xfiOw2uf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6992B9A4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834602; cv=none; b=JdwL47S1vzn6XYjJ1okKb/bLazLcQKHtF+iPpFpzN+E3zp95xSq9OxMGrvXKmTnF/HKwsP4GAypCfEirpVf85U/H3iwogGh2IIgfszLDFyyL56ysW7wBl0FftRH5SzbaZ/hCZ9dbhS0UKdlvMedO/4SoPnzczYMUXYwp9WMolNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834602; c=relaxed/simple;
	bh=5iIzBjp6QIZF6/+Rm1Ngwdv0f69ols5e2cNxcVV/AXA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XZIO5S+SDJYoQNGxm+bSIEKB4SSXiLbDkMGzqaaBKR+Pn4cD2XPvOYpWzLYs2dCCAgTEI87A89rZJhpyT52ByHE6Aj4qd0FZty5nrJPnJIwtD08bxmratFXbTOHK1ji0NfbsvG70kSUABdkxIY1mFx9G/2hZEIg6MeXY+/N5zSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xfiOw2uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D33C2BCB0;
	Fri, 15 May 2026 08:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834602;
	bh=5iIzBjp6QIZF6/+Rm1Ngwdv0f69ols5e2cNxcVV/AXA=;
	h=Subject:To:Cc:From:Date:From;
	b=xfiOw2ufX29mhu7HBuwPc8r4iw0hMU4AEg3Rl7P9PteYBE0ch0rVqZrrR0maiNst/
	 fw6QAlZK7PnGQwoOZKOKb+ncWIFh39hX29PRya2o5HJP/zMVhm6lws+sqzNs5yqni8
	 0oOSUILkXn2lUZ23YHlkEQCI6PRhB/xsRm9hQTu8=
Subject: FAILED: patch "[PATCH] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure" failed to apply to 7.0-stable tree
To: tj@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:43:26 +0200
Message-ID: <2026051526-prelude-boil-36f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB0D154C1D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247606-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 9a415cc53711f2238e0f0ca8a6bcc796c003b127
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051526-prelude-boil-36f5@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

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
 


