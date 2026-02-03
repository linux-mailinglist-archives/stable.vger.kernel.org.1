Return-Path: <stable+bounces-213214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHQGCW7ugWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:47:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2B1D946C
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66BAC3018F12
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4882154425;
	Tue,  3 Feb 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wIDOu0en"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869833F391
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122838; cv=none; b=VfcFbvgbO3jWnr1u4b6GoFxLTIB9O9Zb2DyrZ/pY3t0dMsu/Af32TCbBZYQLq/OO3O3tKQM9wu6f7ikWp8lREYSCzIbWa1RfvjFdGMuKd3+2p89ILii18WjRwKrKx1LijGuynmuBFOx2SNeA+qOjIzXXWHlfNikSPke3Nprvquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122838; c=relaxed/simple;
	bh=t0fUUAelKKfM0KPRfcGZckOUDQy+Y6R6ljHjWlFSxXE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XwTgAnzOFDAXWIhF54OLcE3hrGo8v/jVl4pRL3GkrKhRWUQhxJnflOlsdS9sGKtA3a+jNzqkGfYgWPhI4Y7xsQ1RDEltvhdNogQWvZos9YNx7ecRP58AQ2njd4diF2He/1H3nI5Csz1FaPtzDk90oIYwhpX9Im9iICuLiM+ka8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wIDOu0en; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE69C116D0;
	Tue,  3 Feb 2026 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122838;
	bh=t0fUUAelKKfM0KPRfcGZckOUDQy+Y6R6ljHjWlFSxXE=;
	h=Subject:To:Cc:From:Date:From;
	b=wIDOu0en5ST5iPatAzLfu501A0SyE5kMgXgqEVZ+dzSOP27IpUm7D87G1kR0eNvvQ
	 Iczwyk8JelU96ugoCv+gtOBOuC7pUYjzPyB+yydP3jQt/Ja+9DU8Ofnha0ls8CkEim
	 hEz+UJ1qwI+PddUR96o92B/lMH4Si7z+b7V2IMHc=
Subject: FAILED: patch "[PATCH] mptcp: avoid dup SUB_CLOSED events after disconnect" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org,marco.angaroni@italtel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:47:01 +0100
Message-ID: <2026020301-griminess-trespass-07fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213214-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA2B1D946C
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 280d654324e33f8e6e3641f76764694c7b64c5db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020301-griminess-trespass-07fe@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 280d654324e33f8e6e3641f76764694c7b64c5db Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Jan 2026 20:27:23 +0100
Subject: [PATCH] mptcp: avoid dup SUB_CLOSED events after disconnect

In case of subflow disconnect(), which can also happen with the first
subflow in case of errors like timeout or reset, mptcp_subflow_ctx_reset
will reset most fields from the mptcp_subflow_context structure,
including close_event_done. Then, when another subflow is closed, yet
another SUB_CLOSED event for the disconnected initial subflow is sent.
Because of the previous reset, there are no source address and
destination port.

A solution is then to also check the subflow's local id: it shouldn't be
negative anyway.

Another solution would be not to reset subflow->close_event_done at
disconnect time, but when reused. But then, probably the whole reset
could be done when being reused. Let's not change this logic, similar
to TCP with tcp_disconnect().

Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Cc: stable@vger.kernel.org
Reported-by: Marco Angaroni <marco.angaroni@italtel.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/603
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260127-net-mptcp-dup-nl-events-v1-1-7f71e1bc4feb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f505b780f713..e32ae594b4ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2598,8 +2598,8 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
 
-	/* The first subflow can already be closed and still in the list */
-	if (subflow->close_event_done)
+	/* The first subflow can already be closed or disconnected */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
 
 	subflow->close_event_done = true;


