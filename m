Return-Path: <stable+bounces-254851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBCAD3clGGqZeQgAu9opvQ
	(envelope-from <stable+bounces-254851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:22:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 588145F135C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8743B3006801
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB53E0C47;
	Thu, 28 May 2026 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKacScXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ACF3358BE
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967345; cv=none; b=cIxftN0mZaohS515CdpZ7rUyVUEiew5puC3WecLVRMekd9J0juFg+oOftpZUI7iA1a/Falvy+09RU72aer6aUnH46+Xm80Sd5hd8Q71i+lHjtxtXvCcYCyMkhd8CA1hhFl0vQBrMvArPkA596x731og/JOX1Y24RIyZmkqzo4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967345; c=relaxed/simple;
	bh=VH//m1Bk7DSjWckv0U5Vf68UE/VoqGh9VURufqOLR00=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DnzSxbfkvtUlZMGT+pFAuYZ2WDEggMidxJIWo1IrtIZ3H7td5OWmBlq2SbYuq1K2RWIIHb12ZE/bhprCO+B8Nk/gMvqWLnKQyU9cs7vIFa+Myn1G6261rJ7X17A3ehNH/sSXT60FUpTwlmNmJOG0Mktyn+2YEtsED6GtBe5qnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKacScXq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAEF1F000E9;
	Thu, 28 May 2026 11:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779967343;
	bh=J4Q+XR4lE18ayPNkLbA1wFzKZWH8+uS499yPEEljLQg=;
	h=Subject:To:Cc:From:Date;
	b=qKacScXqHhepUBplpQWLWH/z+jlodZP3iFb7XjAPSJ7O6B0/+sGRX6I+eqKIHBDLL
	 sNi7aYjudBPhvxsIa09alapL2CJONeiL7dBV3QNcC+fk/cQbNztPxKZGkdX6lKDhVC
	 eWzYxsi3yVX3ASLA8CCGQk1vyVJtGPnhjxXg6sHs=
Subject: FAILED: patch "[PATCH] mptcp: update window_clamp on subflows when SO_RCVBUF is set" failed to apply to 6.6-stable tree
To: yangang@kylinos.cn,matttbe@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:21:20 +0200
Message-ID: <2026052820-labored-unhinge-12d3@gregkh>
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
	TAGGED_FROM(0.00)[bounces-254851-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 588145F135C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3a543ae0e2092d5c2085d5f21f7a7dbafdffea3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052820-labored-unhinge-12d3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a543ae0e2092d5c2085d5f21f7a7dbafdffea3c Mon Sep 17 00:00:00 2001
From: Gang Yan <yangang@kylinos.cn>
Date: Fri, 15 May 2026 06:27:36 +0200
Subject: [PATCH] mptcp: update window_clamp on subflows when SO_RCVBUF is set

Add __mptcp_subflow_set_rcvbuf() helper to write the subflow sk_rcvbuf,
but also to call the recently added tcp_set_rcvbuf() helper to update
window_clamp. This is needed because the window clap is updated when
scaling_ratio changes, in tcp_measure_rcv_mss(). Until scaling_ratio
changes, the subflow is stuck with the old window clamp which may be
based on a small initial buffer.

Use this new helper in both mptcp_sol_socket_sync_intval() (setsockopt
path) and sync_socket_options() (new subflow creation path).

Note that this patch depends on commit b025461303d8 ("tcp: update
window_clamp when SO_RCVBUF is set"): it fixes the issue on TCP side,
but the same fix is needed on MPTCP side as well.

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/619
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-5-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1cf608e7357b..87b5796d0135 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -67,6 +67,12 @@ static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval,
 	return 0;
 }
 
+static void __mptcp_subflow_set_rcvbuf(struct sock *ssk, int val)
+{
+	WRITE_ONCE(ssk->sk_rcvbuf, val);
+	tcp_set_rcvbuf(ssk, val);
+}
+
 static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -100,7 +106,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		case SO_RCVBUF:
 		case SO_RCVBUFFORCE:
 			ssk->sk_userlocks |= SOCK_RCVBUF_LOCK;
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 			break;
 		case SO_MARK:
 			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
@@ -1560,7 +1566,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
 		}
 		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 	}
 
 	if (sock_flag(sk, SOCK_LINGER)) {


