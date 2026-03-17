Return-Path: <stable+bounces-226806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG7qBn+VuWlcKwIAu9opvQ
	(envelope-from <stable+bounces-226806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:55:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5B2B059A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C17A3395D8C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676A36606E;
	Tue, 17 Mar 2026 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hK2qefQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB1363C74;
	Tue, 17 Mar 2026 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768264; cv=none; b=ZvXWbLlMo8VvXmfvDhTBhNBM6uMGL+BLN+kCHsMn02UyY2VF/aEkTZLUcSgYfMAnUrOMpX88RBePgdxz2XJJKKCbTTdcWSDI09cqms+NVrHCNkiFp4S2WFu5NdTnV4SU/3V/0QFWeA9NYKmxHAOCEXBtwaWfEPWvaK9QZXDKakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768264; c=relaxed/simple;
	bh=2B2/NunOo7PVNwiaaJjn0InVljN5NwKLrrx18SIWnKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESrldRrejjXKQsCPR2SuATh9qA/wz+ZSu4iF79gjtIZdR5Y89DWzUCbrM6mMgUC5N3HvGmH0LyEbn1caf7pLZ9qBeB+PIxZMKiroSSOtmvrIfl8rF74SvdYyjI0ohmGgjLof9AnoJJfq0ENLfiEMeq5LveRWOxTSpYjOrSoeuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hK2qefQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6AFC2BC86;
	Tue, 17 Mar 2026 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768264;
	bh=2B2/NunOo7PVNwiaaJjn0InVljN5NwKLrrx18SIWnKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hK2qefQVZr3K5IHtHngB2+/T6jlYuiZSZWpDcTYeO9RJpBC1fBPAboo825DnOcQrI
	 hPILclkvadI+XzR3hyB2GoprVqPsz30OyMa+c1BtCmIKUTvZ8Sbq5Nfblqqwy5G+UU
	 WLV/cAwjsZG0xulrgrDMRtZHIwQl3lAYR4pYxrOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.18 271/333] sched_ext: Fix enqueue_task_scx() truncation of upper enqueue flags
Date: Tue, 17 Mar 2026 17:35:00 +0100
Message-ID: <20260317163009.438566448@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226806-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 8EC5B2B059A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 57ccf5ccdc56954f2a91a7f66684fd31c566bde5 upstream.

enqueue_task_scx() takes int enq_flags from the sched_class interface.
SCX enqueue flags starting at bit 32 (SCX_ENQ_PREEMPT and above) are
silently truncated when passed through activate_task(). extra_enq_flags
was added as a workaround - storing high bits in rq->scx.extra_enq_flags
and OR-ing them back in enqueue_task_scx(). However, the OR target is
still the int parameter, so the high bits are lost anyway.

The current impact is limited as the only affected flag is SCX_ENQ_PREEMPT
which is informational to the BPF scheduler - its loss means the scheduler
doesn't know about preemption but doesn't cause incorrect behavior.

Fix by renaming the int parameter to core_enq_flags and introducing a
u64 enq_flags local that merges both sources. All downstream functions
already take u64 enq_flags.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1358,16 +1358,15 @@ static void clr_task_runnable(struct tas
 		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 }
 
-static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
+static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_flags)
 {
 	struct scx_sched *sch = scx_root;
 	int sticky_cpu = p->scx.sticky_cpu;
+	u64 enq_flags = core_enq_flags | rq->scx.extra_enq_flags;
 
 	if (enq_flags & ENQUEUE_WAKEUP)
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
 
-	enq_flags |= rq->scx.extra_enq_flags;
-
 	if (sticky_cpu >= 0)
 		p->scx.sticky_cpu = -1;
 



