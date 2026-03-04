Return-Path: <stable+bounces-222971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCwsE+Cdp2n0igAAu9opvQ
	(envelope-from <stable+bounces-222971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 03:50:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729C1FA0C0
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 03:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C2FB302CBD1
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 02:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D199351C32;
	Wed,  4 Mar 2026 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="KPFEeInt"
X-Original-To: stable@vger.kernel.org
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F983502A0
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592592; cv=none; b=Urv2cSzV8+w6mfzWVh1LQvVgE5kCBsTlCiUpyXuDWK43urDLJ0mEPe5ulq6syqEyNz+VV42ZSJX+rC2XBhlGU/zG8cTxLGfNK4ceeOxA3iQlNFGjVPc7oS3kXhfofD7wqKmkDHz1HxY8OpAjxEQ1gDwk+TxnSL0jy1PgvAv9cfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592592; c=relaxed/simple;
	bh=H70FKmd6xMQBDIFHkrijaB1YoLEtsVUcNOqcqI/LXPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MDC2SQo48nwaORpLvtXXdf0NVKq2L4S27+lYat1JaMmOnN1PPfm5taRmiZEJ1hG11vXDZetY+NNWKfjr0g1qWkIIkDeHjadNUBg4QYqqlhdG6hgpUIF6nsXkUkyEzw8O7nYBBxe8H62Fg2EdOkgajnTWIc5vSB1hki3FaKelPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=KPFEeInt; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1772592588;
	bh=pz66RA33n115wePk+1z6PHB25yLmCnUhJIHAE3UThro=;
	h=From:Subject:Date:Message-Id;
	b=KPFEeIntlSoa8W20mNzr0p9PGn+f7vZbUgr3AME1SRs5xJw9+z/NHDU3FXpF1QwOs
	 flAuKWpYPQTrQw76p5AuhYpzpGtnSN1xwBK8mWxWybAwL7ymgztcF2/k6ewjXJ1vBi
	 pCNSJvqM73t93a28ntbdxo+C438NKUVjF6MUzVJU=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.22) with ESMTP
	id 69A79DBE00005C83; Wed, 4 Mar 2026 10:49:37 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 790547602323
X-SMAIL-UIID: E1E0329692F345BC87094A53C08E7C58-20260304-104937-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	qiang.zhang1211@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	frederic@kernel.org,
	quic_neeraju@quicinc.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	rcu@vger.kernel.org,
	neeraj.upadhyay@kernel.org
Subject: [PATCH 6.1.y] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread pointer access
Date: Wed,  4 Mar 2026 10:49:34 +0800
Message-Id: <20260304024934.2364383-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3729C1FA0C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222971-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,quicinc.com,joshtriplett.org,goodmis.org,efficios.com,gmail.com,joelfernandes.org];
	DKIM_TRACE(0.00)[sina.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[sina.cn];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit 1bba3900ca18bdae28d1b9fa10f16a8f8cb2ada1 ]

In the preparation stage of CPU online, if the corresponding
the rdp's->nocb_cb_kthread does not exist, will be created,
there is a situation where the rdp's rcuop kthreads creation fails,
and then de-offload this CPU's rdp, does not assign this CPU's
rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
rdp's->rdp_gp->nocb_gp_kthread is still valid.

This will cause the subsequent re-offload operation of this offline
CPU, which will pass the conditional check and the kthread_unpark()
will access invalid rdp's->nocb_cb_kthread pointer.

This commit therefore use rdp's->nocb_gp_kthread instead of
rdp_gp's->nocb_gp_kthread for safety check.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
[ Minor conflict resolved. ]
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 kernel/rcu/tree_nocb.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 7c28d154b094..2f501de7bec9 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1112,7 +1112,6 @@ static long rcu_nocb_rdp_offload(void *arg)
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int wake_gp;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
 	/*
@@ -1122,7 +1121,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	if (!rdp->nocb_gp_rdp)
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
+	if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
 		return -EINVAL;
 
 	pr_info("Offloading %d\n", rdp->cpu);
@@ -1151,7 +1150,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 */
 	wake_gp = rdp_offload_toggle(rdp, true, flags);
 	if (wake_gp)
-		wake_up_process(rdp_gp->nocb_gp_kthread);
+		wake_up_process(rdp->nocb_gp_kthread);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
-- 
2.34.1


