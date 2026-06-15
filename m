Return-Path: <stable+bounces-263244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YT9aAIwMMGoPMgUAu9opvQ
	(envelope-from <stable+bounces-263244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:30:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5660D6872FC
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:30:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pSSwMCBK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263244-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263244-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5CF3303FF1D
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F453F5BF8;
	Mon, 15 Jun 2026 14:26:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A83F9F35
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:26:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533596; cv=none; b=PW81hfyq5FVfMxfe9I6ermeVa7vjePNl1eF0983l0F/BOf/J256vQM9iBbJ4jhMVFKPipCKxxTDfN6N4lhDmsSIWWlOyWQToWKzrK07NJH8ZMPzC5FgO8Q7KpyliWNeqpXaznP1u2+jYoc0elOWmQOWDxrGOrS/gLPKS3uk5lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533596; c=relaxed/simple;
	bh=TC+XM1Gw0Rf1VTWCADBdlpZ2xWlNFTx2WUGlHtB4rBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uok6/fABquuMwCv9+Xr2KKBmErghrw0kx72ShEy/kVZ3M6pLrv3/HorGjo4p1CWFmjNmSunwxk/q4tuktjY7FuLOzMuH6696Xl7h7l8L+pjMmperhvbMIBLfS3TDRb7xJGqZzfqisb8qUZEcy58v/QjzfeFxZDNSFLF6boS4p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSSwMCBK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D43A1F000E9;
	Mon, 15 Jun 2026 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533592;
	bh=+aiXy7Esc3Lbs2ODa4XD8eRmzaM+E7V72z3i7HCwIDs=;
	h=Subject:To:Cc:From:Date;
	b=pSSwMCBKlEhxTz8WZDMtS6uEAvMpk6WenJr6vXV68bNVt64tQb2Tyv1T5l0k81a83
	 dBMFtVtCV/9UQxUnd8D8d50qpYzDOgTg5LMWnGJgnjAFwVgKbKjd9s2nQsOtTdToSb
	 9CQqiPQpxPeS4JXTtTEvHNc3GD1KFqJEv8/f1ibs=
Subject: FAILED: patch "[PATCH] mptcp: pm: fix extra_subflows underflow on userspace PM" failed to apply to 6.6-stable tree
To: cuitao@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:24:55 +0200
Message-ID: <2026061555-garland-jailbird-8f3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263244-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cuitao@kylinos.cn,m:kuba@kernel.org,m:matttbe@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5660D6872FC


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 14e9fea30b68fc75b2b3d97396a7e6adb544bd2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061555-garland-jailbird-8f3c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14e9fea30b68fc75b2b3d97396a7e6adb544bd2a Mon Sep 17 00:00:00 2001
From: Tao Cui <cuitao@kylinos.cn>
Date: Tue, 2 Jun 2026 22:14:12 +1000
Subject: [PATCH] mptcp: pm: fix extra_subflows underflow on userspace PM
 subflow creation

The userspace PM increments extra_subflows after __mptcp_subflow_connect()
succeeds, but __mptcp_subflow_connect() calls mptcp_pm_close_subflow()
on failure to roll back the pre-increment done by the kernel PM's fill_*()
helpers. Because the userspace PM hasn't incremented yet at that point,
this decrement is spurious and causes extra_subflows to underflow.

Fix it by aligning the userspace PM with the kernel PM: increment
extra_subflows before calling __mptcp_subflow_connect(), so the existing
error path in subflow.c correctly rolls it back on failure. Also simplify
the error handling by taking pm.lock only when needed for cleanup.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-5-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8cbc1920afb4..0d3a95e676f1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -408,19 +408,21 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	local.flags = entry.flags;
 	local.ifindex = entry.ifindex;
 
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.extra_subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
-	if (err)
+	if (err) {
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
-	spin_lock_bh(&msk->pm.lock);
-	if (err)
+		spin_lock_bh(&msk->pm.lock);
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.extra_subflows++;
-	spin_unlock_bh(&msk->pm.lock);
+		spin_unlock_bh(&msk->pm.lock);
+	}
 
  create_err:
 	sock_put(sk);


