Return-Path: <stable+bounces-245713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLJGCI83A2ow1wEAu9opvQ
	(envelope-from <stable+bounces-245713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:22:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E45224D7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23DD730EEE73
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19B3B1EE3;
	Tue, 12 May 2026 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pLmU4eAV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24443B1EDD
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595515; cv=none; b=Wy8zm2xPXsZH8qLLeMCoh7TAwwjnje4h5PFcRvLDbSsdMyfl39FdGm6LuhFh6ps5G2vnURskV9f6MmLdfoSQo102SmTucgb8vQfUZ654g5PUVvWb6wSVx/yCZY34nNwWbiuS5Vfn8KEKzk+m9HhxtWTrQ4e1KdjgQQzTQ4ITSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595515; c=relaxed/simple;
	bh=cfb/jOP64sChRIUzMK9dav2nN1DTpwNMg9RFAcQTv2Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LrfLSEtZyHGixfGepCbmaoHAlmwHfZOU5vYbsYHvUw1vwgYXTP7r5cbRfs/0xNur2wsBv5HDOSrBlXF5USZmKvflNJ3TS3bRacL2WmyEimKxv9R5dRPgcTG8yq8e8PCx77lUyi0OFMc1Kggu+6KeL4Y61zqv8fQOiEFg9PKjtjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pLmU4eAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AC7C2BCB0;
	Tue, 12 May 2026 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595515;
	bh=cfb/jOP64sChRIUzMK9dav2nN1DTpwNMg9RFAcQTv2Y=;
	h=Subject:To:Cc:From:Date:From;
	b=pLmU4eAVurSUqRiiDL74DkJh8fVqsgXLCiUeNX10pnxxfpePUmTlv/xlafLMiik0v
	 JDCJYJliiRYAZqQL1HroyCUTEnO5pKJ7tABj5+SPZtFHH7Nekqk6uto0tvOuCmc4Hj
	 jL3MDI5on2KAxXMi5h22mrokwF2e9/dCpWkwEY6I=
Subject: FAILED: patch "[PATCH] sched_ext: Guard scx_dsq_move() against NULL kit->dsq after" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:18:01 +0200
Message-ID: <2026051201-cupping-demotion-047d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 973E45224D7
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245713-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,meta.com:email,gregkh:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 4fda9f0e7c950da4fe03cedeb2ac818edf5d03e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051201-cupping-demotion-047d@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4fda9f0e7c950da4fe03cedeb2ac818edf5d03e9 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 24 Apr 2026 14:31:35 -1000
Subject: [PATCH] sched_ext: Guard scx_dsq_move() against NULL kit->dsq after
 failed iter_new

bpf_iter_scx_dsq_new() clears kit->dsq on failure and
bpf_iter_scx_dsq_{next,destroy}() guard against that. scx_dsq_move() doesn't -
it dereferences kit->dsq immediately, so a BPF program that calls
scx_bpf_dsq_move[_vtime]() after a failed iter_new oopses the kernel.

Return false if kit->dsq is NULL.

Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7f991ecb1398..68c67113204f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8076,12 +8076,22 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
-	struct scx_sched *sch = src_dsq->sched;
+	struct scx_sched *sch;
 	struct rq *this_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
 	bool in_balance;
 	unsigned long flags;
 
+	/*
+	 * The verifier considers an iterator slot initialized on any
+	 * KF_ITER_NEW return, so a BPF program may legally reach here after
+	 * bpf_iter_scx_dsq_new() failed and left @kit->dsq NULL.
+	 */
+	if (unlikely(!src_dsq))
+		return false;
+
+	sch = src_dsq->sched;
+
 	if (!scx_vet_enq_flags(sch, dsq_id, &enq_flags))
 		return false;
 


