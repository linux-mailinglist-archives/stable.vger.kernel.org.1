Return-Path: <stable+bounces-249535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fm7JEJKDGpUdgUAu9opvQ
	(envelope-from <stable+bounces-249535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:32:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A6E57DAB7
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87838301227D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FF35F611;
	Tue, 19 May 2026 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ipWtNNc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02017405C5F
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185996; cv=none; b=pKZjx3CUybKYzHlo7ixajTpr7a5JBVn4Jpm8Mx/PWznvn642tFcT3tyeVZjj/NPCt1o+UyFljxHQRZ/Vk6DRjdj1hK2LD1Lwa/gbBmnqgTRwnA6hR6R+ntMe1FioeOAc8VVs6e+c9avqYoiboIsDw2OoQiZZatY8cHdH9sU0H78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185996; c=relaxed/simple;
	bh=7b8VJ0wlnxp3zfHCpNq4mly3+UIHNIU3pddBWni3kGg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cScqTVDCnpWC8yqlL37vRdXeOxH8pas+Jv32b+cc3M8vuFA2toNkjR9lBmS7kTDY8poUDlx6F3Iz+2jFTQonwZhCaJyQOC4CpRKw2EVRCQTJxLezZNiT9pJtTThQFf/B2/Hr2HrkjOjv6Wavt9elchIcKE4U2NeQ1++3eRT/hq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ipWtNNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C324C2BCB3;
	Tue, 19 May 2026 10:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779185995;
	bh=7b8VJ0wlnxp3zfHCpNq4mly3+UIHNIU3pddBWni3kGg=;
	h=Subject:To:Cc:From:Date:From;
	b=0ipWtNNc8axzzXv2BWd6K2PA9c0Sj0F1tiNhn5qr/GkFd9zoSWFMGBHE/Mcr/5h/2
	 QtYSP5vYx7+DK306kUTBRdAFt/R/6bRQAZTnh1nzXeJcsvGLkXouu5xbirpg+cpoqD
	 PQ1so/cxIxhKJqb7iBfGp6aNXTw9x8QA4I5BvFF0=
Subject: FAILED: patch "[PATCH] cgroup/cpuset: Reset DL migration state on can_attach()" failed to apply to 6.1-stable tree
To: zhangguopeng@kylinos.cn,chenridong@huaweicloud.com,longman@redhat.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 May 2026 12:18:52 +0200
Message-ID: <2026051952-bunkbed-preschool-73aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [7.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249535-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,kylinos.cn:email,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 02A6E57DAB7
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4a39eda5fdd867fc39f3c039714dd432cee00268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051952-bunkbed-preschool-73aa@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a39eda5fdd867fc39f3c039714dd432cee00268 Mon Sep 17 00:00:00 2001
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
Date: Sat, 9 May 2026 18:20:30 +0800
Subject: [PATCH] cgroup/cpuset: Reset DL migration state on can_attach()
 failure

cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
state in the destination cpuset while walking the taskset.

If a later task_can_attach() or security_task_setscheduler() check
fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
and does not call cpuset_cancel_attach() for it. The partially
accumulated state is then left behind and can be consumed by a later
attach, corrupting cpuset DL task accounting and pending DL bandwidth
accounting.

Reset the pending DL migration state from the common error exit when
ret is non-zero. Successful can_attach() keeps the state for
cpuset_attach() or cpuset_cancel_attach().

Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Reviewed-by: Waiman Long <longman@redhat.com>

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a48901a0416a..3fbf6e7f68c3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3050,16 +3050,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
 
 		if (unlikely(cpu >= nr_cpu_ids)) {
-			reset_migrate_dl_data(cs);
 			ret = -EINVAL;
 			goto out_unlock;
 		}
 
 		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-		if (ret) {
-			reset_migrate_dl_data(cs);
+		if (ret)
 			goto out_unlock;
-		}
 
 		cs->dl_bw_cpu = cpu;
 	}
@@ -3070,7 +3067,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * changes which zero cpus/mems_allowed.
 	 */
 	cs->attach_in_progress++;
+
 out_unlock:
+	if (ret)
+		reset_migrate_dl_data(cs);
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }


