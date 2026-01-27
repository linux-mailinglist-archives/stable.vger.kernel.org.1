Return-Path: <stable+bounces-211889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J1LGaoSeWkcvAEAu9opvQ
	(envelope-from <stable+bounces-211889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:31:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFC99E47
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E39F3038FFA
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF7337105D;
	Tue, 27 Jan 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyNdXxPW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C236EAAE;
	Tue, 27 Jan 2026 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542066; cv=none; b=j1UxLIMR4V1bH1NS18x2+PTDY1Nv5d3RdcX2GT2ICUzzns+MC/3bnCDMQe2FEZhFEaUXJYpNhjEVOlz3Pu0VguCt9DmIPXPtQDXn40m4fFVT6ggZYix3neMInBS7dwofKqgt17AhkcLHkumm9VBlVtx7pP/wo9XfXHmiYQy9L1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542066; c=relaxed/simple;
	bh=aw/CHZDe8DyoCTO7QmyWPlYRdrEo0GFEKZQuPAfPWn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPx6rykIZeDGlZkYCnQA0eJE/9J+azZWNNUJLG+CQqVVAqdGAZHhnr4glOFVG9fh07DzbU5W0S8fWG3rg5kzVrR2XmCKjLNTwWtMtfh0OvPljgw3gH+p/l2/sc737hQful4+SGF5zSQ9kgr1knYw4IB7b2GfZtp8aKWlmggn1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyNdXxPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FF6C19425;
	Tue, 27 Jan 2026 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542066;
	bh=aw/CHZDe8DyoCTO7QmyWPlYRdrEo0GFEKZQuPAfPWn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lyNdXxPWU4xmaLLPDx+yPFWBDrE3O/T9xJhS6c7kmEB3NuvRE54Uz1vy0VVRxSKRv
	 c2ytRdDCPHFnCI/ndwlFcAYI7K/pJkUscKf2vufFfBdPa5JP1EJUrwTLm595+uaPLJ
	 jvjxjNLVICdu9wtxOfmGg95OIo4LJsA3eEMQDY5VibTmpVFXekjdWwfERpxQsfFLh/
	 HDzmMxOqtZCabMF/Gzk8l6cGoJ9eM+8rL23w/jQzHZmF8SgmADatwMAUT5r6uh8hcQ
	 h2Auw+P8oIyENmpeuOpYwL31Igk/q1HMrYGy9W8Marn/lNrcwimM29cm/H4MItZ+qW
	 6Kfc+Y+9M0sbQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Jan 2026 20:27:25 +0100
Subject: [PATCH net 3/5] mptcp: only reset subflow errors when propagated
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-net-mptcp-dup-nl-events-v1-3-7f71e1bc4feb@kernel.org>
References: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
In-Reply-To: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aw/CHZDe8DyoCTO7QmyWPlYRdrEo0GFEKZQuPAfPWn8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIrBZf17v7w+tAbO5XTuurbuo65FcWZbVh1wUM+567+l
 jtBQk41HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPJLWZkuPf0LkvGtl0L/l2d
 rTr31hwzSYW4tISjrEYnPh/I+v8pmZfhf4664bwYTWEp60ynjkzDtqM5uqvY6mNqz82cEMW+zmQ
 KPwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211889-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E3DFC99E47
X-Rspamd-Action: no action

Some subflow socket errors need to be reported to the MPTCP socket: the
initial subflow connect (MP_CAPABLE), and the ones from the fallback
sockets. The others are not propagated.

The issue is that sock_error() was used to retrieve the error, which was
also resetting the sk_err field. Because of that, when notifying the
userspace about subflow close events later on from the MPTCP worker, the
ssk->sk_err field was always 0.

Now, the error (sk_err) is only reset when propagating it to the msk.

Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e32ae594b4ef..8d3233667418 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -821,11 +821,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
-	int err = sock_error(ssk);
 	int ssk_state;
-
-	if (!err)
-		return false;
+	int err;
 
 	/* only propagate errors on fallen-back sockets or
 	 * on MPC connect
@@ -833,6 +830,10 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
 		return false;
 
+	err = sock_error(ssk);
+	if (!err)
+		return false;
+
 	/* We need to propagate only transition to CLOSE state.
 	 * Orphaned socket will see such state change via
 	 * subflow_sched_work_if_closed() and that path will properly

-- 
2.51.0


