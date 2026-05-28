Return-Path: <stable+bounces-254796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFWTMEIVGGprcwgAu9opvQ
	(envelope-from <stable+bounces-254796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:13:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A55F0577
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68C3A3065A3A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADCB39FCC4;
	Thu, 28 May 2026 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zD6jCXub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB013B52E9
	for <stable@vger.kernel.org>; Thu, 28 May 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962403; cv=none; b=LPjeL+UDs8MIbRm9bytS3nUUOeOF4uWltFWz8fHYuaNCwaZnh+m/+64zzHJktndrrvms7lsC8Vt5zfMKAz3TT1bin7AqA+nLJ32SkDx6mksLjJfMhGUHzMIHLUa2FZZd4fohx9quo9mco3xpbPBqD9qLTTFxF/AzAz+yfjVAck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962403; c=relaxed/simple;
	bh=Zc0yKPiUcO4rGHRaEGdMSjb3GeW7d/H/FsJ3p7RdPnc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SsAzJq/Pih9Vw7Un7aWPHyzOBUQn7G5phgAZ1GmCXK3JMfnZVoG4u13nrut7uhCAO49COfrJk024XmhUrMvxoFrRco8E0Jw0X01bICDtIhUJx4+6tc4eEXUYnPsI8IQQh5nOxu2tzqXYSgSLqA9dVQWerEaipQ2Y1hDdqjqwnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zD6jCXub; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B444E1F000E9;
	Thu, 28 May 2026 10:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962402;
	bh=FrhsORZt80UuhvPLbrnFUv7ROdhbxnEjlqykXerkEX8=;
	h=Subject:To:Cc:From:Date;
	b=zD6jCXub7+1Z++lSPsyRFfeNWe17ghgG9De6q3J7Pn46+dKTWIjb+9SZglZg+mzkD
	 l//VQMZH6BDf+cFE98X9JCdxi1fknvbxi7qPcOtIjusg4ObfCVOMYPc9a2aNy0M7iN
	 fonCvhJtho870rrkO5CffW6cKQCfH+Gc6F/oCqXc=
Subject: FAILED: patch "[PATCH] mptcp: pm: fix ADD_ADDR timer infinite retry on option space" failed to apply to 6.6-stable tree
To: lixiasong1@huawei.com,matttbe@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 11:59:06 +0200
Message-ID: <2026052806-ungloved-feminist-6956@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254796-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email,msgid.link:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 829A55F0577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 51e398a3b8961b26a8c0a4ba9a777c5339791707
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052806-ungloved-feminist-6956@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51e398a3b8961b26a8c0a4ba9a777c5339791707 Mon Sep 17 00:00:00 2001
From: Li Xiasong <lixiasong1@huawei.com>
Date: Fri, 15 May 2026 06:27:33 +0200
Subject: [PATCH] mptcp: pm: fix ADD_ADDR timer infinite retry on option space
 insufficient

When TCP option space is insufficient (e.g., when sending ADD_ADDR with an
IPv6 address and port while tcp_timestamps is enabled), the original code
jumped to out_unlock without clearing the addr_signal flag. This caused
mptcp_pm_add_timer to keep rescheduling indefinitely, not sending ADD_ADDR,
preventing subsequent addresses in the endpoint list from being announced.

Handle this case by clearing the ADD_ADDR signal and skipping the matching
ADD_ADDR retransmission entry. The skip path cancels the matching timer
(with id check) and advances PM state progression, preserving forward
progress to subsequent PM work.

This cancellation is inherently best-effort. A concurrent add_timer
callback may already be running and may acquire pm.lock before the
cancel path updates entry state. In that case, one final ADD_ADDR
transmit attempt can still be executed.

Once the cancel path sets entry->retrans_times to ADD_ADDR_RETRANS_MAX,
the callback-side retrans_times check suppresses further ADD_ADDR
retransmissions.

Note that when an ADD_ADDR is being prepared, a pure-ACK is queued. On
the output side, it means that it is fine to skip non-pure-ACK packets,
when drop_other_suboptions is set: a pure-ACK will be processed soon
after.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-2-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3c152bf66cd5..3e770c7407e1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -364,7 +364,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	if (!mptcp_pm_should_add_signal_addr(msk)) {
+	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	 * callback. Once cancel updates retrans_times to MAX, suppress further
+	 * retransmissions here. If this callback acquires pm.lock first, one
+	 * final transmit attempt is still possible.
+	 */
+	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX &&
+	    !mptcp_pm_should_add_signal_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
@@ -414,8 +420,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
-	if (stop_timer)
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	if (stop_timer) {
+		if (check_id)
+			sk_stop_timer(sk, &entry->add_timer);
+		else
+			sk_stop_timer_sync(sk, &entry->add_timer);
+	}
 
 	rcu_read_unlock();
 	return entry;
@@ -882,6 +892,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions)
 {
+	bool skip_add_addr = false;
 	int ret = false;
 	u8 add_addr;
 	u8 family;
@@ -903,24 +914,49 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	}
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
-	port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
-
-	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
-	if (remaining < mptcp_add_addr_len(family, *echo, port))
-		goto out_unlock;
-
 	if (*echo) {
 		*addr = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
+		port = !!msk->pm.remote.port;
+		family = msk->pm.remote.family;
 	} else {
 		*addr = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+		port = !!msk->pm.local.port;
+		family = msk->pm.local.family;
 	}
-	WRITE_ONCE(msk->pm.addr_signal, add_addr);
+
+	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+		struct net *net = sock_net((struct sock *)msk);
+
+		if (!*drop_other_suboptions)
+			goto out_unlock;
+
+		if (*echo) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
+		} else {
+			skip_add_addr = true;
+			MPTCP_INC_STATS(net, MPTCP_MIB_ADDADDRTXDROP);
+		}
+		goto drop_signal_mark;
+	}
+
 	ret = true;
 
+drop_signal_mark:
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
+
 out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
+
+	/* On pure-ACK option-space exhaustion, stop retrying this ADD_ADDR:
+	 * clear the signal bit, cancel the matching retransmission timer, and
+	 * let the PM state machine progress.
+	 */
+	if (skip_add_addr) {
+		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_subflow_established(msk);
+	}
 	return ret;
 }
 


