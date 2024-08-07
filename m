Return-Path: <stable+bounces-65564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFD94A9B0
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072051F2A268
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDD78C89;
	Wed,  7 Aug 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQLbaHIx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2657CB1
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040074; cv=none; b=jBE1z7UB0wNE5/of+OT70boPtCrCJQRHS/qId0wubFsFvI67vKR933iae+RBXLbrahhU8D/61oa1j6wyaivOOiif5UnRE6AcG1FNIZ5IS/+sQZEArL/UE24NGMtjwIYioUTREpGGHNkjZZyHGtl9GDpub1gjzRWJWb0s5SDwIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040074; c=relaxed/simple;
	bh=QAK3iIdFRm+xwCgcXPf1e++qBXB/h5l20CKFSQ8sXoI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ESUhPPrlvez99w5KlVWxvT3kVtGMPJLyv9qimvCsXyi5PSB7QaM+Vrssabf7d8V2OTctsZ4IrCZJXFiVKNBogfcaUH/WTi+ghr7tdCdc3p0VROQAUzbIZvyoj1qMzrWo+MIOajjqxGMEa+saXoHbYYXiyftw5o7cSGbKnTMBuQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQLbaHIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA334C32781;
	Wed,  7 Aug 2024 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040074;
	bh=QAK3iIdFRm+xwCgcXPf1e++qBXB/h5l20CKFSQ8sXoI=;
	h=Subject:To:Cc:From:Date:From;
	b=FQLbaHIxUv+jgNv3q/WKyipWCLQVXFe5blwvO/+6nEmyrTj1bvxgTxceR6Ydi7jyE
	 zQ97TMbrV3Jeq5t5j+OL4/p0kXR2uhEzilK8YZ8K0DRUVydU9P+xnzt/QWRfi+/ApB
	 ak6U/RNjSRnz0eKBJegvj/K+7Jw4NdYRTukoisYY=
Subject: FAILED: patch "[PATCH] mptcp: mib: count MPJ with backup flag" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:14:22 +0200
Message-ID: <2024080722-glorify-rarity-f9bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4dde0d72ccec500c60c798e036b852e013d6e124
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080722-glorify-rarity-f9bb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4dde0d72ccec ("mptcp: mib: count MPJ with backup flag")
b3ea6b272d79 ("mptcp: consolidate initial ack seq generation")
f3589be0c420 ("mptcp: never shrink offered window")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4dde0d72ccec500c60c798e036b852e013d6e124 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:26 +0200
Subject: [PATCH] mptcp: mib: count MPJ with backup flag

Without such counters, it is difficult to easily debug issues with MPJ
not having the backup flags on production servers.

This is not strictly a fix, but it eases to validate the following
patches without requiring to take packet traces, to query ongoing
connections with Netlink with admin permissions, or to guess by looking
at the behaviour of the packet scheduler. Also, the modification is self
contained, isolated, well controlled, and the increments are done just
after others, there from the beginning. It looks then safe, and helpful
to backport this.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index c30405e76833..7884217f33eb 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -19,7 +19,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynBackupRx", MPTCP_MIB_JOINSYNBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckBackupRx", MPTCP_MIB_JOINSYNACKBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2704afd0dfe4..66aa67f49d03 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -14,7 +14,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNBACKUPRX,	/* Received a SYN + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKBACKUPRX,	/* Received a SYN/ACK + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a3778aee4e77..be406197b1c4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -168,6 +168,9 @@ static int subflow_check_req(struct request_sock *req,
 			return 0;
 	} else if (opt_mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {
@@ -577,6 +580,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
 
+		if (subflow->backup)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
+
 		if (subflow_use_different_dport(msk, sk)) {
 			pr_debug("synack inet_dport=%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),


