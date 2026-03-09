Return-Path: <stable+bounces-223580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNPUGAKhrmm2GwIAu9opvQ
	(envelope-from <stable+bounces-223580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:29:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED923711C
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4021E30185C2
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA337649D;
	Mon,  9 Mar 2026 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ntevrp6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193981732
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052159; cv=none; b=AQTNHFMxNNWnfmZsGLmFUQ1McPpVJ+6IiporZFeWDIGm3xHwesT/qD2/TbhhO41JIruHgPT5GV5ssjEtq+k65swe1Vs1aRLJigTjfba62cqyzkmGaZ2xX9SFMWE9ZpzmXEdNno0llkzNQgmIMvLuzuO34NhWyBpNZRTURRXM+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052159; c=relaxed/simple;
	bh=zoDbwJDjJP5yMZmsrvROU62ZBv2unzMhtpN4kHpSJo4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EgWr/01tsnVCiVO50Are199+v7aveTf1kZScfea9QiNoHHarZmGT77cYaTrmt5ba4UiP3iIt1BYi+bl4mgFCg3ZdCOVCaIEZIGchxwcJnd4WY5la2fmyKDfkB8F4c4kTbqlhjDxpYAFpKAzbryA5RmIDnD7LmTfiJmYPiSgZH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ntevrp6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82303C4CEF7;
	Mon,  9 Mar 2026 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773052158;
	bh=zoDbwJDjJP5yMZmsrvROU62ZBv2unzMhtpN4kHpSJo4=;
	h=Subject:To:Cc:From:Date:From;
	b=ntevrp6UCu296BaxGMajGaneZOXY3MPpcfqWJKQaCjRoxO8Tu/gM90axiIpmd7hjc
	 lGFJRTXP8d/MUTyWIZrMSbJ4BRlQ4OVL0LYLvzAYrV2k5U/NZ0DXloxmfh9iHGxIAY
	 /4Iue+H7XwmGdzfhfDdXHOY8w9FzD/xHxxzL5V94=
Subject: FAILED: patch "[PATCH] mptcp: pm: avoid sending RM_ADDR over same subflow" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org,lorenz-frank@web.de,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:29:06 +0100
Message-ID: <2026030906-bullish-enjoying-edba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7ED923711C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223580-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,web.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.370];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,gregkh:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fb8d0bccb221080630efcd9660c9f9349e53cc9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030906-bullish-enjoying-edba@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb8d0bccb221080630efcd9660c9f9349e53cc9e Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 3 Mar 2026 11:56:03 +0100
Subject: [PATCH] mptcp: pm: avoid sending RM_ADDR over same subflow

RM_ADDR are sent over an active subflow, the first one in the subflows
list. There is then a high chance the initial subflow is picked. With
the in-kernel PM, when an endpoint is removed, a RM_ADDR is sent, then
linked subflows are closed. This is done for each active MPTCP
connection.

MPTCP endpoints are likely removed because the attached network is no
longer available or usable. In this case, it is better to avoid sending
this RM_ADDR over the subflow that is going to be removed, but prefer
sending it over another active and non stale subflow, if any.

This modification avoids situations where the other end is not notified
when a subflow is no longer usable: typically when the endpoint linked
to the initial subflow is removed, especially on the server side.

Fixes: 8dd5efb1f91b ("mptcp: send ack for rm_addr")
Cc: stable@vger.kernel.org
Reported-by: Frank Lorenz <lorenz-frank@web.de>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/612
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260303-net-mptcp-misc-fixes-7-0-rc2-v1-2-4b5462b6f016@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7298836469b3..57a456690406 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -212,9 +212,24 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 }
 
-void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
+			       const struct mptcp_rm_list *rm_list)
 {
-	struct mptcp_subflow_context *subflow, *alt = NULL;
+	u8 i, id = subflow_get_local_id(subflow);
+
+	for (i = 0; i < rm_list->nr; i++) {
+		if (rm_list->ids[i] == id)
+			return true;
+	}
+
+	return false;
+}
+
+static void
+mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
+				  const struct mptcp_rm_list *rm_list)
+{
+	struct mptcp_subflow_context *subflow, *stale = NULL, *same_id = NULL;
 
 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
@@ -224,19 +239,35 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	mptcp_for_each_subflow(msk, subflow) {
-		if (__mptcp_subflow_active(subflow)) {
-			if (!subflow->stale) {
-				mptcp_pm_send_ack(msk, subflow, false, false);
-				return;
-			}
+		if (!__mptcp_subflow_active(subflow))
+			continue;
 
-			if (!alt)
-				alt = subflow;
+		if (unlikely(subflow->stale)) {
+			if (!stale)
+				stale = subflow;
+		} else if (unlikely(rm_list &&
+				    subflow_in_rm_list(subflow, rm_list))) {
+			if (!same_id)
+				same_id = subflow;
+		} else {
+			goto send_ack;
 		}
 	}
 
-	if (alt)
-		mptcp_pm_send_ack(msk, alt, false, false);
+	if (same_id)
+		subflow = same_id;
+	else if (stale)
+		subflow = stale;
+	else
+		return;
+
+send_ack:
+	mptcp_pm_send_ack(msk, subflow, false, false);
+}
+
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+{
+	mptcp_pm_addr_send_ack_avoid_list(msk, NULL);
 }
 
 int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
@@ -470,7 +501,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
 	return 0;
 }
 


