Return-Path: <stable+bounces-245742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGaSMbY+A2qr2AEAu9opvQ
	(envelope-from <stable+bounces-245742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:52:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19E1522FB3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E77DD31DF319
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD13AFAED;
	Tue, 12 May 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4zLmVHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489783ABD80
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595686; cv=none; b=Jy5zGyFCesC1+4++in46yLZmrFRPPGU/B0RATRrpdg3vE8Mb3/totYtHnX/p4ysJw89g8Xgf41P1GiDhnc1ZEQWouvXTqOLqdg+JeQBPK0Lbhapj1q6bOe2kcUdUhkjrvcmjD+974VN1b3O6KTc23yG6igPlErOAWQ2kC0XH1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595686; c=relaxed/simple;
	bh=zG8UNPKjPO4VeCe9Y1fyEqwxWqjaZPwadZ0UahUA0Ns=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f61b7gHqNW26Td5oYNMQw1sGIBb0Ay7hiH+DYo7XMCdFxaDUG/NLZFj0q2Ct28yuEtTK9cR7DocAwsQoBxIInOKIgOzMdC0R5/nsK8WBPeNQeqIASyl+kyBDQ7tff923MAWOmeMx+WIHHn9mv8hDdedGV7ZLIBRig8ev1UC78Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n4zLmVHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A5CC2BCF6;
	Tue, 12 May 2026 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595686;
	bh=zG8UNPKjPO4VeCe9Y1fyEqwxWqjaZPwadZ0UahUA0Ns=;
	h=Subject:To:Cc:From:Date:From;
	b=n4zLmVHin0NlztoeY6LazbkE4oukxbT80ztS590hvtzfb4xx7aJSupkPS8bJV1h8j
	 PDxKtEH8QiANFztJ95iar1CKLENz0XPVw+UavaOB2uY9D72AwV0cidBFx+zFlsAihE
	 akYdJmarhgVQVFH6kPJZL82Azo4X1IwbXr2bQsMo=
Subject: FAILED: patch "[PATCH] mptcp: pm: ADD_ADDR rtx: fix potential data-race" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:21:16 +0200
Message-ID: <2026051216-clanking-corroding-5130@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C19E1522FB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245742-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5cd6e0ad79d2615264f63929f8b457ad97ae550d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051216-clanking-corroding-5130@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5cd6e0ad79d2615264f63929f8b457ad97ae550d Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 5 May 2026 17:00:51 +0200
Subject: [PATCH] mptcp: pm: ADD_ADDR rtx: fix potential data-race

This mptcp_pm_add_timer() helper is executed as a timer callback in
softirq context. To avoid any data races, the socket lock needs to be
held with bh_lock_sock().

If the socket is in use, retry again soon after, similar to what is done
with the keepalive timer.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-3-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5056eb8db24e..3912128d9b86 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -337,6 +337,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		/* Try again later. */
+		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		goto out;
+	}
+
 	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
@@ -365,6 +372,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	bh_unlock_sock(sk);
 	__sock_put(sk);
 }
 


