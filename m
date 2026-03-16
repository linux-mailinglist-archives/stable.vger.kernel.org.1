Return-Path: <stable+bounces-225547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK/PJgwTuGk7YwEAu9opvQ
	(envelope-from <stable+bounces-225547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:26:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575029B4F1
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4550B3028E92
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03A32853FD;
	Mon, 16 Mar 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LtEEbJL8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3715284880
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671136; cv=none; b=SmjXJVtmPmWgCtgwuLBNcHRY01Qh1fNoq5UHBHShEznKy0NCRXE3hu3qaMsY67caEI+LEl8P2vt0EHkE6pqPYe3va3HGDKDYQwdzYnaO91RmdDi6PR2wQAThHJjp5io4F5lZxYDQfPTibELhe8WIzjAi8UN3MkXUpL6lMIaz3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671136; c=relaxed/simple;
	bh=5sSWvpml8A4r27zlB6LvIcknnZLEax/Q7GcMSC+ooXg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OPz+Me8A4OeKqeLzSnXU5PpVOL421ddK7P7nt2RP6qsQdCE/4gVJFzVbef3g5T0rCO+j3AmFUUr+iACnZ2d2TNuFnRVcQIlmR4nfat5rIT1wVnQdo7f7Q/sMAuG18hJya93SlBiLQRJntGraUbARYVWMAJpwhX2iY4O03mRxZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LtEEbJL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87459C19421;
	Mon, 16 Mar 2026 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773671136;
	bh=5sSWvpml8A4r27zlB6LvIcknnZLEax/Q7GcMSC+ooXg=;
	h=Subject:To:Cc:From:Date:From;
	b=LtEEbJL8zvgGWS5q9FpodDqM2vlpRi6Y/tIxXmkA4l1mJNaj5mRDJRnSS+rPUDcZY
	 /h9/1Hmqi96zqoGnmNNSTi7IQDJebj4+8u1+K2Oi0wonPFUqQ/QSC3I2nelxmMQw+K
	 9umYSDTAl5KVgWOlAOGgPrqikeOLEEL9muUEyTHY=
Subject: FAILED: patch "[PATCH] sched_ext: Remove redundant css_put() in scx_cgroup_init()" failed to apply to 6.12-stable tree
To: yphbchou0911@gmail.com,arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 15:25:30 +0100
Message-ID: <2026031630-character-subsector-36b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225547-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 0575029B4F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1336b579f6079fb8520be03624fcd9ba443c930b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031630-character-subsector-36b1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1336b579f6079fb8520be03624fcd9ba443c930b Mon Sep 17 00:00:00 2001
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
Date: Tue, 3 Mar 2026 22:35:30 +0800
Subject: [PATCH] sched_ext: Remove redundant css_put() in scx_cgroup_init()

The iterator css_for_each_descendant_pre() walks the cgroup hierarchy
under cgroup_lock(). It does not increment the reference counts on
yielded css structs.

According to the cgroup documentation, css_put() should only be used
to release a reference obtained via css_get() or css_tryget_online().
Since the iterator does not use either of these to acquire a reference,
calling css_put() in the error path of scx_cgroup_init() causes a
refcount underflow.

Remove the unbalanced css_put() to prevent a potential Use-After-Free
(UAF) vulnerability.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2ba69b302368..eab6e09b6442 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3589,7 +3589,6 @@ static int scx_cgroup_init(struct scx_sched *sch)
 		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init, NULL,
 				      css->cgroup, &args);
 		if (ret) {
-			css_put(css);
 			scx_error(sch, "ops.cgroup_init() failed (%d)", ret);
 			return ret;
 		}


